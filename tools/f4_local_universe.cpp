// Exhaustive local-universe audit for the 48-vertex S4 reduction.
//
// For each of the two S3 doubly-regular tournaments of order 23 (McKay rows 35/36),
// enumerate ALL 2^23 masks W.  A mask is admissible exactly when
//   |W| <= 12 and |W ∩ N^-(h)| <= 6 for every h in H,
// matching Erdos902F4Step / Erdos902Capacity.
//
// Repair capacity R(W) is the number of internally-undominated 4-sets contained in W.
// Rather than recomputing R for each mask, seed the bad 4-sets and perform an in-place
// subset-zeta transform on 2^23 uint16_t entries.  This computes R(W) for every W at once.
//
// The primary kill-check is the envelope used by Erdos902Capacity.envelope_arithmetic:
//   R(W) <= 66 + 72 * (12 - |W|)
// for every admissible W.
//
// This program is a finite computation / discovery certificate, not a formal proof.

#include <algorithm>
#include <array>
#include <bit>
#include <chrono>
#include <cstdint>
#include <cstdlib>
#include <iomanip>
#include <iostream>
#include <limits>
#include <set>
#include <string>
#include <vector>
#include <omp.h>

using u32 = std::uint32_t;
using u64 = std::uint64_t;
using u16 = std::uint16_t;

static constexpr int N = 23;
static constexpr u32 SPACE = (1u << N);
static constexpr u32 FULL = SPACE - 1;

struct RowData {
    int row;
    std::array<u32, N> om;
    std::array<u32, N> im;
    int expected_bad4;
};

static const RowData ROW35 = {
    35,
    {4094,258172,7674200,3901232,5860064,5152324,6483336,7643694,2939058,3700038,5185942,1529482,1877209,1984813,6886573,2453013,2503649,5297045,6963803,3377351,4572515,5389363,637707},
    {8384512,8130433,714403,4487367,2528527,3236251,1905207,744785,5449293,4688057,3201641,6857077,6507302,6395602,1485650,5902826,5819422,2960490,1162660,4486968,2767516,902092,3556596},
    2475
};

static const RowData ROW36 = {
    36,
    {4094,258172,8062168,6728160,5847848,6872644,1560336,3953010,3089958,3512462,5038746,5404038,1877325,5587685,6689565,2714005,941225,3192497,5933111,3304011,6407467,4537427,758723},
    {8384512,8130433,326435,1660439,2540743,1515931,6828207,4435469,5298393,4875633,3348837,2982521,6507186,2792730,1682658,5641834,7381846,5065038,2193352,4560308,932564,1754028,3435580},
    2530
};

static const std::array<u32, 33> EXCEPTIONAL35 = {
    258676,528374,1195067,1529730,1942737,2017573,2444829,2499561,2734851,2937018,3114800,
    3376945,3377358,3700044,3786544,3839792,3876656,3900336,3900722,3901204,3901280,3903024,
    4310379,5152328,5185822,5280669,5860008,5998384,6483344,7017637,7644710,7674224,8012371
};

struct LocalStats {
    std::array<u64, 13> count{};
    std::array<u16, 13> max_repair{};
    std::array<u32, 13> argmax{};
    u64 envelope_violations = 0;
    int max_excess = std::numeric_limits<int>::min();
    u32 max_excess_mask = 0;
    int max_excess_size = 0;
    u16 max_excess_repair = 0;
};

static inline int pc(u32 x) { return std::popcount(x); }

static bool admissible(u32 m, const RowData& R) {
    if (pc(m) > 12) return false;
    for (int h = 0; h < N; ++h) {
        if (pc(m & R.im[h]) > 6) return false;
    }
    return true;
}

static std::array<u32, N> closed_outs(const RowData& R) {
    std::array<u32, N> c{};
    for (int a = 0; a < N; ++a) c[a] = R.om[a] | (1u << a);
    return c;
}

static bool contained_in_any_closed_out(u32 m, const std::array<u32, N>& c) {
    for (u32 x : c) if ((m & x) == m) return true;
    return false;
}

static std::vector<u16> repair_zeta(const RowData& R, int& bad4_count) {
    std::vector<u16> zeta(SPACE, 0);
    bad4_count = 0;
    for (int a = 0; a < N; ++a)
        for (int b = a + 1; b < N; ++b)
            for (int c = b + 1; c < N; ++c)
                for (int d = c + 1; d < N; ++d) {
                    if ((R.im[a] & R.im[b] & R.im[c] & R.im[d]) == 0) {
                        u32 m = (1u << a) | (1u << b) | (1u << c) | (1u << d);
                        zeta[m] = 1;
                        ++bad4_count;
                    }
                }

    // Subset zeta transform: after bit b, each entry contains the sum over subsets
    // differing only in processed bits.  Final zeta[m] = # bad 4-sets B ⊆ m.
    for (int b = 0; b < N; ++b) {
        const u32 half = (1u << b);
        const u32 block = half << 1;
        #pragma omp parallel for schedule(static)
        for (std::int64_t base = 0; base < static_cast<std::int64_t>(SPACE); base += block) {
            for (u32 i = 0; i < half; ++i) {
                const u32 lo = static_cast<u32>(base) + i;
                const u32 hi = lo + half;
                zeta[hi] = static_cast<u16>(zeta[hi] + zeta[lo]);
            }
        }
    }
    return zeta;
}

static void merge_stats(LocalStats& a, const LocalStats& b) {
    for (int s = 0; s <= 12; ++s) {
        a.count[s] += b.count[s];
        if (b.max_repair[s] > a.max_repair[s]) {
            a.max_repair[s] = b.max_repair[s];
            a.argmax[s] = b.argmax[s];
        }
    }
    a.envelope_violations += b.envelope_violations;
    if (b.max_excess > a.max_excess) {
        a.max_excess = b.max_excess;
        a.max_excess_mask = b.max_excess_mask;
        a.max_excess_size = b.max_excess_size;
        a.max_excess_repair = b.max_excess_repair;
    }
}

static void print_u64_array(const std::array<u64,13>& a) {
    std::cout << "[";
    for (int i=0;i<=12;++i) { if (i) std::cout << ","; std::cout << a[i]; }
    std::cout << "]";
}
static void print_u16_array(const std::array<u16,13>& a) {
    std::cout << "[";
    for (int i=0;i<=12;++i) { if (i) std::cout << ","; std::cout << a[i]; }
    std::cout << "]";
}
static void print_u32_array(const std::array<u32,13>& a) {
    std::cout << "[";
    for (int i=0;i<=12;++i) { if (i) std::cout << ","; std::cout << a[i]; }
    std::cout << "]";
}
static void print_vec(const std::vector<u32>& v) {
    std::cout << "[";
    for (std::size_t i=0;i<v.size();++i) { if (i) std::cout << ","; std::cout << v[i]; }
    std::cout << "]";
}

static int run_row(const RowData& R) {
    const auto t0 = std::chrono::steady_clock::now();
    int bad4_count = 0;
    auto repair = repair_zeta(R, bad4_count);
    if (bad4_count != R.expected_bad4) {
        std::cerr << "bad4 control failed for row " << R.row << ": got " << bad4_count
                  << " expected " << R.expected_bad4 << "\n";
        return 3;
    }

    std::vector<std::uint8_t> adm(SPACE, 0);
    const int nt = omp_get_max_threads();
    std::vector<LocalStats> locals(nt);

    #pragma omp parallel
    {
        const int tid = omp_get_thread_num();
        auto& st = locals[tid];
        #pragma omp for schedule(static)
        for (std::int64_t mi = 0; mi < static_cast<std::int64_t>(SPACE); ++mi) {
            const u32 m = static_cast<u32>(mi);
            const int s = pc(m);
            if (s > 12 || !admissible(m, R)) continue;
            adm[m] = 1;
            const u16 cap = repair[m];
            st.count[s]++;
            if (cap > st.max_repair[s]) {
                st.max_repair[s] = cap;
                st.argmax[s] = m;
            }
            const int bound = 66 + 72 * (12 - s);
            const int excess = static_cast<int>(cap) - bound;
            if (excess > 0) st.envelope_violations++;
            if (excess > st.max_excess) {
                st.max_excess = excess;
                st.max_excess_mask = m;
                st.max_excess_size = s;
                st.max_excess_repair = cap;
            }
        }
    }

    LocalStats total;
    total.max_excess = std::numeric_limits<int>::min();
    for (const auto& s : locals) merge_stats(total, s);

    // Maximal admissible masks under inclusion.  Any pure repair-cover relaxation can
    // restrict to these without losing coverage power.
    std::array<u64,13> maximal_by_size{};
    std::vector<u32> maximal_sample;
    #pragma omp parallel
    {
        std::array<u64,13> local{};
        std::vector<u32> sample;
        #pragma omp for schedule(static)
        for (std::int64_t mi = 0; mi < static_cast<std::int64_t>(SPACE); ++mi) {
            const u32 m = static_cast<u32>(mi);
            if (!adm[m]) continue;
            bool maximal = true;
            const u32 missing = FULL ^ m;
            for (u32 bits = missing; bits; bits &= (bits - 1)) {
                const u32 bit = bits & (~bits + 1u);
                if (adm[m | bit]) { maximal = false; break; }
            }
            if (maximal) {
                local[pc(m)]++;
                if (sample.size() < 16) sample.push_back(m);
            }
        }
        #pragma omp critical
        {
            for (int s=0;s<=12;++s) maximal_by_size[s] += local[s];
            for (u32 m : sample) if (maximal_sample.size() < 64) maximal_sample.push_back(m);
        }
    }
    std::sort(maximal_sample.begin(), maximal_sample.end());
    maximal_sample.erase(std::unique(maximal_sample.begin(), maximal_sample.end()), maximal_sample.end());
    if (maximal_sample.size() > 32) maximal_sample.resize(32);

    const auto co = closed_outs(R);
    u64 size12_not_closed = 0;
    u64 missing_closed = 0;
    for (u32 m=0; m<SPACE; ++m) {
        if (adm[m] && pc(m)==12) {
            bool eq=false; for (u32 c:co) if (m==c) {eq=true;break;}
            if (!eq) ++size12_not_closed;
        }
    }
    for (u32 c : co) if (!adm[c]) ++missing_closed;

    std::vector<u32> exceptional11;
    for (u32 m=0; m<SPACE; ++m) {
        if (adm[m] && pc(m)==11 && !contained_in_any_closed_out(m, co)) exceptional11.push_back(m);
    }

    bool exceptional_exact = true;
    if (R.row == 35) {
        std::vector<u32> expected(EXCEPTIONAL35.begin(), EXCEPTIONAL35.end());
        std::sort(expected.begin(), expected.end());
        exceptional_exact = (exceptional11 == expected);
    } else {
        exceptional_exact = exceptional11.empty();
    }

    bool closedout_capacity_control = true;
    u16 closedout_max = 0;
    u16 closedout_min = std::numeric_limits<u16>::max();
    for (u32 c: co) {
        closedout_max = std::max(closedout_max, repair[c]);
        closedout_min = std::min(closedout_min, repair[c]);
        if (R.row==36 && repair[c] != 66) closedout_capacity_control=false;
        if (R.row==35 && repair[c] > 65) closedout_capacity_control=false;
    }

    const auto t1 = std::chrono::steady_clock::now();
    const double secs = std::chrono::duration<double>(t1-t0).count();

    std::cout << "{\n";
    std::cout << "  \"schema\":\"erdos902.f4-local-universe.v1\",\n";
    std::cout << "  \"row\":" << R.row << ",\n";
    std::cout << "  \"threads\":" << nt << ",\n";
    std::cout << "  \"masks_total\":" << SPACE << ",\n";
    std::cout << "  \"bad4_count\":" << bad4_count << ",\n";
    std::cout << "  \"bad4_control_pass\":true,\n";
    std::cout << "  \"admissible_count_by_size_0_to_12\":"; print_u64_array(total.count); std::cout << ",\n";
    std::cout << "  \"max_repair_by_size_0_to_12\":"; print_u16_array(total.max_repair); std::cout << ",\n";
    std::cout << "  \"argmax_mask_by_size_0_to_12\":"; print_u32_array(total.argmax); std::cout << ",\n";
    std::cout << "  \"envelope_formula\":\"R(W) <= 66 + 72*(12-|W|)\",\n";
    std::cout << "  \"envelope_violations\":" << total.envelope_violations << ",\n";
    std::cout << "  \"envelope_pass\":" << (total.envelope_violations==0 ? "true":"false") << ",\n";
    std::cout << "  \"worst_excess_over_envelope\":" << total.max_excess << ",\n";
    std::cout << "  \"worst_excess_mask\":" << total.max_excess_mask << ",\n";
    std::cout << "  \"worst_excess_size\":" << total.max_excess_size << ",\n";
    std::cout << "  \"worst_excess_repair\":" << total.max_excess_repair << ",\n";
    std::cout << "  \"maximal_admissible_count_by_size_0_to_12\":"; print_u64_array(maximal_by_size); std::cout << ",\n";
    std::cout << "  \"maximal_admissible_sample\":"; print_vec(maximal_sample); std::cout << ",\n";
    std::cout << "  \"size12_not_closed_out_count\":" << size12_not_closed << ",\n";
    std::cout << "  \"closed_out_missing_or_inadmissible_count\":" << missing_closed << ",\n";
    std::cout << "  \"size12_rigidity_control_pass\":" << ((size12_not_closed==0 && missing_closed==0) ? "true":"false") << ",\n";
    std::cout << "  \"closed_out_repair_min\":" << closedout_min << ",\n";
    std::cout << "  \"closed_out_repair_max\":" << closedout_max << ",\n";
    std::cout << "  \"closed_out_capacity_control_pass\":" << (closedout_capacity_control?"true":"false") << ",\n";
    std::cout << "  \"exceptional_size11_not_in_closed_out_count\":" << exceptional11.size() << ",\n";
    std::cout << "  \"exceptional_size11_exact_control_pass\":" << (exceptional_exact?"true":"false") << ",\n";
    std::cout << "  \"exceptional_size11_masks\":"; print_vec(exceptional11); std::cout << ",\n";
    std::cout << "  \"elapsed_seconds\":" << std::fixed << std::setprecision(6) << secs << "\n";
    std::cout << "}\n";

    if (size12_not_closed || missing_closed || !closedout_capacity_control || !exceptional_exact) return 4;
    return 0;
}

int main(int argc, char** argv) {
    int row = 0;
    for (int i=1;i<argc;++i) {
        std::string a=argv[i];
        if (a=="--row" && i+1<argc) row=std::atoi(argv[++i]);
    }
    if (row!=35 && row!=36) {
        std::cerr << "usage: f4_local_universe --row 35|36\n";
        return 2;
    }
    return run_row(row==35 ? ROW35 : ROW36);
}
