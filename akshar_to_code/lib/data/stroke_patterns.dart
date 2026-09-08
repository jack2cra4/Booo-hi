import 'dart:ui' show Offset;

/// A guided handwriting movement pattern (normalized 0..1 space).
class StrokePattern {
  final String id;
  final String label;
  final String sample;
  final String hint;
  final List<List<Offset>> guides;

  const StrokePattern({
    required this.id,
    required this.label,
    required this.sample,
    required this.hint,
    required this.guides,
  });
}

/// All basic hand-movement & memory stroke patterns.
class StrokePatterns {
  static const List<StrokePattern> all = [
    StrokePattern(id: 'standing', label: 'खड़ी रेखाएँ', sample: '| | | |', hint: 'सीधी खड़ी रेखाएँ - ऊपर से नीचे', guides: [
      [Offset(0.18,0.15), Offset(0.18,0.5), Offset(0.18,0.85)],
      [Offset(0.5,0.15), Offset(0.5,0.5), Offset(0.5,0.85)],
      [Offset(0.82,0.15), Offset(0.82,0.5), Offset(0.82,0.85)],
    ]),
    StrokePattern(id: 'sleeping', label: 'लेटी रेखाएँ', sample: '— — — —', hint: 'सीधी लेटी रेखाएँ - बाएँ से दाएँ', guides: [
      [Offset(0.1,0.27), Offset(0.5,0.27), Offset(0.9,0.27)],
      [Offset(0.1,0.5), Offset(0.5,0.5), Offset(0.9,0.5)],
      [Offset(0.1,0.73), Offset(0.5,0.73), Offset(0.9,0.73)],
    ]),
    StrokePattern(id: 'slant_right', label: 'दायाँ तिरछा', sample: '/ / / /', hint: 'दाएँ की ओर झुकी रेखाएँ', guides: [
      [Offset(0.16,0.82), Offset(0.26,0.5), Offset(0.36,0.18)],
      [Offset(0.42,0.82), Offset(0.52,0.5), Offset(0.62,0.18)],
      [Offset(0.68,0.82), Offset(0.78,0.5), Offset(0.88,0.18)],
    ]),
    StrokePattern(id: 'slant_left', label: 'बायाँ तिरछा', sample: '\\ \\ \\ \\', hint: 'बाएँ की ओर झुकी रेखाएँ', guides: [
      [Offset(0.36,0.82), Offset(0.26,0.5), Offset(0.16,0.18)],
      [Offset(0.62,0.82), Offset(0.52,0.5), Offset(0.42,0.18)],
      [Offset(0.88,0.82), Offset(0.78,0.5), Offset(0.68,0.18)],
    ]),
    StrokePattern(id: 'c_curve', label: 'गोल अर्धचंद्र', sample: 'c c c c', hint: 'दाएँ खुला गोल वक्र', guides: [
      [Offset(0.18,0.2), Offset(0.1588,0.2314), Offset(0.1408,0.2629), Offset(0.1261,0.2943), Offset(0.1147,0.3257), Offset(0.1065,0.3571), Offset(0.1016,0.3886), Offset(0.1,0.42), Offset(0.1016,0.4514), Offset(0.1065,0.4829), Offset(0.1147,0.5143), Offset(0.1261,0.5457), Offset(0.1408,0.5771), Offset(0.1588,0.6086), Offset(0.18,0.64)],
      [Offset(0.5,0.2), Offset(0.4788,0.2314), Offset(0.4608,0.2629), Offset(0.4461,0.2943), Offset(0.4347,0.3257), Offset(0.4265,0.3571), Offset(0.4216,0.3886), Offset(0.42,0.42), Offset(0.4216,0.4514), Offset(0.4265,0.4829), Offset(0.4347,0.5143), Offset(0.4461,0.5457), Offset(0.4608,0.5771), Offset(0.4788,0.6086), Offset(0.5,0.64)],
      [Offset(0.82,0.2), Offset(0.7988,0.2314), Offset(0.7808,0.2629), Offset(0.7661,0.2943), Offset(0.7547,0.3257), Offset(0.7465,0.3571), Offset(0.7416,0.3886), Offset(0.74,0.42), Offset(0.7416,0.4514), Offset(0.7465,0.4829), Offset(0.7547,0.5143), Offset(0.7661,0.5457), Offset(0.7808,0.5771), Offset(0.7988,0.6086), Offset(0.82,0.64)],
    ]),
    StrokePattern(id: 'o_curve', label: 'उल्टा अर्धचंद्र', sample: 'ɔ ɔ ɔ ɔ', hint: 'बाएँ खुला गोल वक्र', guides: [
      [Offset(0.18,0.2), Offset(0.2012,0.2314), Offset(0.2192,0.2629), Offset(0.2339,0.2943), Offset(0.2453,0.3257), Offset(0.2535,0.3571), Offset(0.2584,0.3886), Offset(0.26,0.42), Offset(0.2584,0.4514), Offset(0.2535,0.4829), Offset(0.2453,0.5143), Offset(0.2339,0.5457), Offset(0.2192,0.5771), Offset(0.2012,0.6086), Offset(0.18,0.64)],
      [Offset(0.5,0.2), Offset(0.5212,0.2314), Offset(0.5392,0.2629), Offset(0.5539,0.2943), Offset(0.5653,0.3257), Offset(0.5735,0.3571), Offset(0.5784,0.3886), Offset(0.58,0.42), Offset(0.5784,0.4514), Offset(0.5735,0.4829), Offset(0.5653,0.5143), Offset(0.5539,0.5457), Offset(0.5392,0.5771), Offset(0.5212,0.6086), Offset(0.5,0.64)],
      [Offset(0.82,0.2), Offset(0.8412,0.2314), Offset(0.8592,0.2629), Offset(0.8739,0.2943), Offset(0.8853,0.3257), Offset(0.8935,0.3571), Offset(0.8984,0.3886), Offset(0.9,0.42), Offset(0.8984,0.4514), Offset(0.8935,0.4829), Offset(0.8853,0.5143), Offset(0.8739,0.5457), Offset(0.8592,0.5771), Offset(0.8412,0.6086), Offset(0.82,0.64)],
    ]),
    StrokePattern(id: 'u_wave', label: 'u लहर', sample: 'u u u u', hint: 'बर्तन जैसी लहर (नीचे की ओर)', guides: [
      [Offset(0.08,0.68), Offset(0.1,0.611), Offset(0.12,0.5527), Offset(0.14,0.5049), Offset(0.16,0.4678), Offset(0.18,0.4412), Offset(0.2,0.4253), Offset(0.22,0.42), Offset(0.24,0.4253), Offset(0.26,0.4412), Offset(0.28,0.4678), Offset(0.3,0.5049), Offset(0.32,0.5527), Offset(0.34,0.611), Offset(0.36,0.68), Offset(0.36,0.68), Offset(0.38,0.611), Offset(0.4,0.5527), Offset(0.42,0.5049), Offset(0.44,0.4678), Offset(0.46,0.4412), Offset(0.48,0.4253), Offset(0.5,0.42), Offset(0.52,0.4253), Offset(0.54,0.4412), Offset(0.56,0.4678), Offset(0.58,0.5049), Offset(0.6,0.5527), Offset(0.62,0.611), Offset(0.64,0.68), Offset(0.64,0.68), Offset(0.66,0.611), Offset(0.68,0.5527), Offset(0.7,0.5049), Offset(0.72,0.4678), Offset(0.74,0.4412), Offset(0.76,0.4253), Offset(0.78,0.42), Offset(0.8,0.4253), Offset(0.82,0.4412), Offset(0.84,0.4678), Offset(0.86,0.5049), Offset(0.88,0.5527), Offset(0.9,0.611), Offset(0.92,0.68)],
    ]),
    StrokePattern(id: 'm_wave', label: 'm तरंग', sample: 'm m m m', hint: 'उभरी हुई तरंग (ऊपर की ओर)', guides: [
      [Offset(0.08,0.32), Offset(0.1,0.389), Offset(0.12,0.4473), Offset(0.14,0.4951), Offset(0.16,0.5322), Offset(0.18,0.5588), Offset(0.2,0.5747), Offset(0.22,0.58), Offset(0.24,0.5747), Offset(0.26,0.5588), Offset(0.28,0.5322), Offset(0.3,0.4951), Offset(0.32,0.4473), Offset(0.34,0.389), Offset(0.36,0.32), Offset(0.36,0.32), Offset(0.38,0.389), Offset(0.4,0.4473), Offset(0.42,0.4951), Offset(0.44,0.5322), Offset(0.46,0.5588), Offset(0.48,0.5747), Offset(0.5,0.58), Offset(0.52,0.5747), Offset(0.54,0.5588), Offset(0.56,0.5322), Offset(0.58,0.4951), Offset(0.6,0.4473), Offset(0.62,0.389), Offset(0.64,0.32), Offset(0.64,0.32), Offset(0.66,0.389), Offset(0.68,0.4473), Offset(0.7,0.4951), Offset(0.72,0.5322), Offset(0.74,0.5588), Offset(0.76,0.5747), Offset(0.78,0.58), Offset(0.8,0.5747), Offset(0.82,0.5588), Offset(0.84,0.5322), Offset(0.86,0.4951), Offset(0.88,0.4473), Offset(0.9,0.389), Offset(0.92,0.32)],
    ]),
    StrokePattern(id: 'w_wave', label: 'w तरंग', sample: 'w w w w', hint: 'टेढ़ी-मेढ़ी ऊपर-नीचे तरंग', guides: [
      [Offset(0.08,0.2), Offset(0.0962,0.2923), Offset(0.1123,0.3846), Offset(0.1285,0.4769), Offset(0.1446,0.5692), Offset(0.1608,0.6615), Offset(0.1769,0.7538), Offset(0.1931,0.7538), Offset(0.2092,0.6615), Offset(0.2254,0.5692), Offset(0.2415,0.4769), Offset(0.2577,0.3846), Offset(0.2738,0.2923), Offset(0.29,0.2), Offset(0.3062,0.2923), Offset(0.3223,0.3846), Offset(0.3385,0.4769), Offset(0.3546,0.5692), Offset(0.3708,0.6615), Offset(0.3869,0.7538), Offset(0.4031,0.7538), Offset(0.4192,0.6615), Offset(0.4354,0.5692), Offset(0.4515,0.4769), Offset(0.4677,0.3846), Offset(0.4838,0.2923), Offset(0.5,0.2), Offset(0.5162,0.2923), Offset(0.5323,0.3846), Offset(0.5485,0.4769), Offset(0.5646,0.5692), Offset(0.5808,0.6615), Offset(0.5969,0.7538), Offset(0.6131,0.7538), Offset(0.6292,0.6615), Offset(0.6454,0.5692), Offset(0.6615,0.4769), Offset(0.6777,0.3846), Offset(0.6938,0.2923), Offset(0.71,0.2), Offset(0.7262,0.2923), Offset(0.7423,0.3846), Offset(0.7585,0.4769), Offset(0.7746,0.5692), Offset(0.7908,0.6615), Offset(0.8069,0.7538), Offset(0.8231,0.7538), Offset(0.8392,0.6615), Offset(0.8554,0.5692), Offset(0.8715,0.4769), Offset(0.8877,0.3846), Offset(0.9038,0.2923), Offset(0.92,0.2)],
    ]),
    StrokePattern(id: 'n_bridge', label: 'n पुल', sample: 'n n n n', hint: 'छोटे उभरे पुल (over-under)', guides: [
      [Offset(0.08,0.27), Offset(0.11,0.3443), Offset(0.14,0.4071), Offset(0.17,0.4586), Offset(0.2,0.4986), Offset(0.23,0.5271), Offset(0.26,0.5443), Offset(0.29,0.55), Offset(0.32,0.5443), Offset(0.35,0.5271), Offset(0.38,0.4986), Offset(0.41,0.4586), Offset(0.44,0.4071), Offset(0.47,0.3443), Offset(0.5,0.27), Offset(0.5,0.27), Offset(0.53,0.3443), Offset(0.56,0.4071), Offset(0.59,0.4586), Offset(0.62,0.4986), Offset(0.65,0.5271), Offset(0.68,0.5443), Offset(0.71,0.55), Offset(0.74,0.5443), Offset(0.77,0.5271), Offset(0.8,0.4986), Offset(0.83,0.4586), Offset(0.86,0.4071), Offset(0.89,0.3443), Offset(0.92,0.27)],
    ]),
    StrokePattern(id: 'l_loop', label: 'l लूप', sample: 'l l l l', hint: 'कर्सिव लूप के साथ खड़ी', guides: [
      [Offset(0.22,0.18), Offset(0.22,0.45), Offset(0.22,0.72), Offset(0.15,0.72), Offset(0.1527,0.7007), Offset(0.1606,0.6829), Offset(0.1732,0.668), Offset(0.1893,0.6571), Offset(0.2078,0.6511), Offset(0.2273,0.6504), Offset(0.2462,0.6551), Offset(0.2631,0.6648), Offset(0.2766,0.6789), Offset(0.2858,0.6961), Offset(0.2898,0.7151), Offset(0.2885,0.7346), Offset(0.2818,0.7529), Offset(0.2704,0.7686), Offset(0.255,0.7806), Offset(0.2369,0.7879), Offset(0.2176,0.79), Offset(0.1984,0.7866)],
      [Offset(0.5,0.18), Offset(0.5,0.45), Offset(0.5,0.72), Offset(0.43,0.72), Offset(0.4327,0.7007), Offset(0.4406,0.6829), Offset(0.4532,0.668), Offset(0.4693,0.6571), Offset(0.4878,0.6511), Offset(0.5073,0.6504), Offset(0.5262,0.6551), Offset(0.5431,0.6648), Offset(0.5566,0.6789), Offset(0.5658,0.6961), Offset(0.5698,0.7151), Offset(0.5685,0.7346), Offset(0.5618,0.7529), Offset(0.5504,0.7686), Offset(0.535,0.7806), Offset(0.5169,0.7879), Offset(0.4976,0.79), Offset(0.4784,0.7866)],
      [Offset(0.78,0.18), Offset(0.78,0.45), Offset(0.78,0.72), Offset(0.71,0.72), Offset(0.7127,0.7007), Offset(0.7206,0.6829), Offset(0.7332,0.668), Offset(0.7493,0.6571), Offset(0.7678,0.6511), Offset(0.7873,0.6504), Offset(0.8062,0.6551), Offset(0.8231,0.6648), Offset(0.8366,0.6789), Offset(0.8458,0.6961), Offset(0.8498,0.7151), Offset(0.8485,0.7346), Offset(0.8418,0.7529), Offset(0.8304,0.7686), Offset(0.815,0.7806), Offset(0.7969,0.7879), Offset(0.7776,0.79), Offset(0.7584,0.7866)],
    ]),
    StrokePattern(id: 'e_loop', label: 'e लूप', sample: 'e e e e', hint: 'छोटा गोल ई-लूप', guides: [
      [Offset(0.2461,0.4395), Offset(0.235,0.4558), Offset(0.2184,0.4665), Offset(0.199,0.47), Offset(0.1798,0.4657), Offset(0.1637,0.4544), Offset(0.1532,0.4377), Offset(0.15,0.4183), Offset(0.1546,0.3991), Offset(0.1662,0.3832), Offset(0.1831,0.373), Offset(0.2025,0.3701), Offset(0.2216,0.3749), Offset(0.2374,0.3868), Offset(0.2473,0.4038), Offset(0.2499,0.4233), Offset(0.2447,0.4423), Offset(0.2326,0.4579), Offset(0.2155,0.4676), Offset(0.18,0.47), Offset(0.24,0.47), Offset(0.3,0.47)],
      [Offset(0.5461,0.4395), Offset(0.535,0.4558), Offset(0.5184,0.4665), Offset(0.499,0.47), Offset(0.4798,0.4657), Offset(0.4637,0.4544), Offset(0.4532,0.4377), Offset(0.45,0.4183), Offset(0.4546,0.3991), Offset(0.4662,0.3832), Offset(0.4831,0.373), Offset(0.5025,0.3701), Offset(0.5216,0.3749), Offset(0.5374,0.3868), Offset(0.5473,0.4038), Offset(0.5499,0.4233), Offset(0.5447,0.4423), Offset(0.5326,0.4579), Offset(0.5155,0.4676), Offset(0.48,0.47), Offset(0.54,0.47), Offset(0.6,0.47)],
      [Offset(0.8461,0.4395), Offset(0.835,0.4558), Offset(0.8184,0.4665), Offset(0.799,0.47), Offset(0.7798,0.4657), Offset(0.7637,0.4544), Offset(0.7532,0.4377), Offset(0.75,0.4183), Offset(0.7546,0.3991), Offset(0.7662,0.3832), Offset(0.7831,0.373), Offset(0.8025,0.3701), Offset(0.8216,0.3749), Offset(0.8374,0.3868), Offset(0.8473,0.4038), Offset(0.8499,0.4233), Offset(0.8447,0.4423), Offset(0.8326,0.4579), Offset(0.8155,0.4676), Offset(0.78,0.47), Offset(0.84,0.47), Offset(0.9,0.47)],
    ]),
    StrokePattern(id: 'figure8', label: 'आठ का आकार', sample: '8 ∞ 8 ∞', hint: 'दोनों ओर मुड़ते हुए कोइल', guides: [
      [Offset(0.45,0.5), Offset(0.441,0.5513), Offset(0.4149,0.5964), Offset(0.375,0.6299), Offset(0.326,0.6477), Offset(0.274,0.6477), Offset(0.225,0.6299), Offset(0.1851,0.5964), Offset(0.159,0.5513), Offset(0.15,0.5), Offset(0.159,0.4487), Offset(0.1851,0.4036), Offset(0.225,0.3701), Offset(0.274,0.3523), Offset(0.326,0.3523), Offset(0.375,0.3701), Offset(0.4149,0.4036), Offset(0.441,0.4487), Offset(0.45,0.5), Offset(0.55,0.5), Offset(0.559,0.4487), Offset(0.5851,0.4036), Offset(0.625,0.3701), Offset(0.674,0.3523), Offset(0.726,0.3523), Offset(0.775,0.3701), Offset(0.8149,0.4036), Offset(0.841,0.4487), Offset(0.85,0.5), Offset(0.841,0.5513), Offset(0.8149,0.5964), Offset(0.775,0.6299), Offset(0.726,0.6477), Offset(0.674,0.6477), Offset(0.625,0.6299), Offset(0.5851,0.5964), Offset(0.559,0.5513), Offset(0.55,0.5)],
    ]),
    StrokePattern(id: 'spiral', label: 'सर्पिल लूप', sample: '🌀 spiral', hint: 'बढ़ता हुआ गोलाकार चक्र', guides: [
      [Offset(0.57,0.5), Offset(0.5715,0.5184), Offset(0.5681,0.5374), Offset(0.5594,0.5558), Offset(0.5457,0.572), Offset(0.5276,0.5848), Offset(0.5058,0.5928), Offset(0.4819,0.5951), Offset(0.4571,0.5911), Offset(0.4334,0.5805), Offset(0.4124,0.5637), Offset(0.3957,0.5413), Offset(0.3849,0.5145), Offset(0.3811,0.485), Offset(0.385,0.4545), Offset(0.3969,0.4251), Offset(0.4163,0.3988), Offset(0.4424,0.3777), Offset(0.474,0.3635), Offset(0.509,0.3574), Offset(0.5453,0.3605), Offset(0.5806,0.3729), Offset(0.6125,0.3944), Offset(0.6386,0.4238), Offset(0.6569,0.4597), Offset(0.6658,0.5), Offset(0.6643,0.5422), Offset(0.652,0.5836), Offset(0.6293,0.6214), Offset(0.5971,0.653), Offset(0.5572,0.6759), Offset(0.5119,0.6885), Offset(0.4639,0.6893), Offset(0.4163,0.6778), Offset(0.3723,0.6544), Offset(0.3348,0.62), Offset(0.3066,0.5766), Offset(0.2898,0.5265), Offset(0.286,0.473), Offset(0.2959,0.4192), Offset(0.3193,0.3687), Offset(0.3552,0.325), Offset(0.4016,0.291), Offset(0.456,0.2693), Offset(0.515,0.2618), Offset(0.5749,0.2694), Offset(0.632,0.292), Offset(0.6824,0.3287), Offset(0.7226,0.3776), Offset(0.7497,0.4359), Offset(0.7617,0.5), Offset(0.7572,0.566), Offset(0.736,0.6298), Offset(0.6991,0.687), Offset(0.6484,0.7339), Offset(0.5868,0.7671), Offset(0.5179,0.7841), Offset(0.4459,0.7834), Offset(0.3755,0.7645), Offset(0.3112,0.7282), Offset(0.2573,0.6763)],
    ]),
  ];
}