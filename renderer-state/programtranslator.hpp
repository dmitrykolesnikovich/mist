#pragma once

#include <common/ref.hpp>
#include <common/databuffer.hpp>
#include <common.hpp>

namespace graphics
{
	R_ENUM()
	enum class programtoken
	{
		// 0x000..0x0ff - generators
		// 0x100..0x2ff - swizzles (one input, one output)
		// 0x300..0x3ff - unary functions
		// 0x400..0x4ff - binary functions
		// 0x500..0x5ff - ternary functions
		// 0x600..0x6ff - literals, bits 4-7: length of literal in words minus one
		// 0x700..0x7ff - constructors
		// 0x800..0x8ff - special operations

		// get an attribute and push it on the stack as float4
		attribute_0 = 0x10,
		attribute_1 = 0x11,
		attribute_2 = 0x12,
		attribute_3 = 0x13,
		attribute_4 = 0x14,
		attribute_5 = 0x15,
		attribute_6 = 0x16,
		attribute_7 = 0x17,

		// get a texture and push in on the stack as sampler2D
		texture_0 = 0x20,
		texture_1 = 0x21,
		texture_2 = 0x22,
		texture_3 = 0x23,
		texture_4 = 0x24,
		texture_5 = 0x25,
		texture_6 = 0x26,
		texture_7 = 0x27,

		// swizzles
		swizzle_0 = 0x100,
		swizzle_1 = 0x101,
		swizzle_2 = 0x102,
		swizzle_3 = 0x103,
		swizzle_00 = 0x104,
		swizzle_01 = 0x105,
		swizzle_02 = 0x106,
		swizzle_03 = 0x107,
		swizzle_10 = 0x108,
		swizzle_11 = 0x109,
		swizzle_12 = 0x10a,
		swizzle_13 = 0x10b,
		swizzle_20 = 0x10c,
		swizzle_21 = 0x10d,
		swizzle_22 = 0x10e,
		swizzle_23 = 0x10f,
		swizzle_30 = 0x110,
		swizzle_31 = 0x111,
		swizzle_32 = 0x112,
		swizzle_33 = 0x113,
		swizzle_000 = 0x114,
		swizzle_001 = 0x115,
		swizzle_002 = 0x116,
		swizzle_003 = 0x117,
		swizzle_010 = 0x118,
		swizzle_011 = 0x119,
		swizzle_012 = 0x11a,
		swizzle_013 = 0x11b,
		swizzle_020 = 0x11c,
		swizzle_021 = 0x11d,
		swizzle_022 = 0x11e,
		swizzle_023 = 0x11f,
		swizzle_030 = 0x120,
		swizzle_031 = 0x121,
		swizzle_032 = 0x122,
		swizzle_033 = 0x123,
		swizzle_100 = 0x124,
		swizzle_101 = 0x125,
		swizzle_102 = 0x126,
		swizzle_103 = 0x127,
		swizzle_110 = 0x128,
		swizzle_111 = 0x129,
		swizzle_112 = 0x12a,
		swizzle_113 = 0x12b,
		swizzle_120 = 0x12c,
		swizzle_121 = 0x12d,
		swizzle_122 = 0x12e,
		swizzle_123 = 0x12f,
		swizzle_130 = 0x130,
		swizzle_131 = 0x131,
		swizzle_132 = 0x132,
		swizzle_133 = 0x133,
		swizzle_200 = 0x134,
		swizzle_201 = 0x135,
		swizzle_202 = 0x136,
		swizzle_203 = 0x137,
		swizzle_210 = 0x138,
		swizzle_211 = 0x139,
		swizzle_212 = 0x13a,
		swizzle_213 = 0x13b,
		swizzle_220 = 0x13c,
		swizzle_221 = 0x13d,
		swizzle_222 = 0x13e,
		swizzle_223 = 0x13f,
		swizzle_230 = 0x140,
		swizzle_231 = 0x141,
		swizzle_232 = 0x142,
		swizzle_233 = 0x143,
		swizzle_300 = 0x144,
		swizzle_301 = 0x145,
		swizzle_302 = 0x146,
		swizzle_303 = 0x147,
		swizzle_310 = 0x148,
		swizzle_311 = 0x149,
		swizzle_312 = 0x14a,
		swizzle_313 = 0x14b,
		swizzle_320 = 0x14c,
		swizzle_321 = 0x14d,
		swizzle_322 = 0x14e,
		swizzle_323 = 0x14f,
		swizzle_330 = 0x150,
		swizzle_331 = 0x151,
		swizzle_332 = 0x152,
		swizzle_333 = 0x153,
		swizzle_0000 = 0x154,
		swizzle_0001 = 0x155,
		swizzle_0002 = 0x156,
		swizzle_0003 = 0x157,
		swizzle_0010 = 0x158,
		swizzle_0011 = 0x159,
		swizzle_0012 = 0x15a,
		swizzle_0013 = 0x15b,
		swizzle_0020 = 0x15c,
		swizzle_0021 = 0x15d,
		swizzle_0022 = 0x15e,
		swizzle_0023 = 0x15f,
		swizzle_0030 = 0x160,
		swizzle_0031 = 0x161,
		swizzle_0032 = 0x162,
		swizzle_0033 = 0x163,
		swizzle_0100 = 0x164,
		swizzle_0101 = 0x165,
		swizzle_0102 = 0x166,
		swizzle_0103 = 0x167,
		swizzle_0110 = 0x168,
		swizzle_0111 = 0x169,
		swizzle_0112 = 0x16a,
		swizzle_0113 = 0x16b,
		swizzle_0120 = 0x16c,
		swizzle_0121 = 0x16d,
		swizzle_0122 = 0x16e,
		swizzle_0123 = 0x16f,
		swizzle_0130 = 0x170,
		swizzle_0131 = 0x171,
		swizzle_0132 = 0x172,
		swizzle_0133 = 0x173,
		swizzle_0200 = 0x174,
		swizzle_0201 = 0x175,
		swizzle_0202 = 0x176,
		swizzle_0203 = 0x177,
		swizzle_0210 = 0x178,
		swizzle_0211 = 0x179,
		swizzle_0212 = 0x17a,
		swizzle_0213 = 0x17b,
		swizzle_0220 = 0x17c,
		swizzle_0221 = 0x17d,
		swizzle_0222 = 0x17e,
		swizzle_0223 = 0x17f,
		swizzle_0230 = 0x180,
		swizzle_0231 = 0x181,
		swizzle_0232 = 0x182,
		swizzle_0233 = 0x183,
		swizzle_0300 = 0x184,
		swizzle_0301 = 0x185,
		swizzle_0302 = 0x186,
		swizzle_0303 = 0x187,
		swizzle_0310 = 0x188,
		swizzle_0311 = 0x189,
		swizzle_0312 = 0x18a,
		swizzle_0313 = 0x18b,
		swizzle_0320 = 0x18c,
		swizzle_0321 = 0x18d,
		swizzle_0322 = 0x18e,
		swizzle_0323 = 0x18f,
		swizzle_0330 = 0x190,
		swizzle_0331 = 0x191,
		swizzle_0332 = 0x192,
		swizzle_0333 = 0x193,
		swizzle_1000 = 0x194,
		swizzle_1001 = 0x195,
		swizzle_1002 = 0x196,
		swizzle_1003 = 0x197,
		swizzle_1010 = 0x198,
		swizzle_1011 = 0x199,
		swizzle_1012 = 0x19a,
		swizzle_1013 = 0x19b,
		swizzle_1020 = 0x19c,
		swizzle_1021 = 0x19d,
		swizzle_1022 = 0x19e,
		swizzle_1023 = 0x19f,
		swizzle_1030 = 0x1a0,
		swizzle_1031 = 0x1a1,
		swizzle_1032 = 0x1a2,
		swizzle_1033 = 0x1a3,
		swizzle_1100 = 0x1a4,
		swizzle_1101 = 0x1a5,
		swizzle_1102 = 0x1a6,
		swizzle_1103 = 0x1a7,
		swizzle_1110 = 0x1a8,
		swizzle_1111 = 0x1a9,
		swizzle_1112 = 0x1aa,
		swizzle_1113 = 0x1ab,
		swizzle_1120 = 0x1ac,
		swizzle_1121 = 0x1ad,
		swizzle_1122 = 0x1ae,
		swizzle_1123 = 0x1af,
		swizzle_1130 = 0x1b0,
		swizzle_1131 = 0x1b1,
		swizzle_1132 = 0x1b2,
		swizzle_1133 = 0x1b3,
		swizzle_1200 = 0x1b4,
		swizzle_1201 = 0x1b5,
		swizzle_1202 = 0x1b6,
		swizzle_1203 = 0x1b7,
		swizzle_1210 = 0x1b8,
		swizzle_1211 = 0x1b9,
		swizzle_1212 = 0x1ba,
		swizzle_1213 = 0x1bb,
		swizzle_1220 = 0x1bc,
		swizzle_1221 = 0x1bd,
		swizzle_1222 = 0x1be,
		swizzle_1223 = 0x1bf,
		swizzle_1230 = 0x1c0,
		swizzle_1231 = 0x1c1,
		swizzle_1232 = 0x1c2,
		swizzle_1233 = 0x1c3,
		swizzle_1300 = 0x1c4,
		swizzle_1301 = 0x1c5,
		swizzle_1302 = 0x1c6,
		swizzle_1303 = 0x1c7,
		swizzle_1310 = 0x1c8,
		swizzle_1311 = 0x1c9,
		swizzle_1312 = 0x1ca,
		swizzle_1313 = 0x1cb,
		swizzle_1320 = 0x1cc,
		swizzle_1321 = 0x1cd,
		swizzle_1322 = 0x1ce,
		swizzle_1323 = 0x1cf,
		swizzle_1330 = 0x1d0,
		swizzle_1331 = 0x1d1,
		swizzle_1332 = 0x1d2,
		swizzle_1333 = 0x1d3,
		swizzle_2000 = 0x1d4,
		swizzle_2001 = 0x1d5,
		swizzle_2002 = 0x1d6,
		swizzle_2003 = 0x1d7,
		swizzle_2010 = 0x1d8,
		swizzle_2011 = 0x1d9,
		swizzle_2012 = 0x1da,
		swizzle_2013 = 0x1db,
		swizzle_2020 = 0x1dc,
		swizzle_2021 = 0x1dd,
		swizzle_2022 = 0x1de,
		swizzle_2023 = 0x1df,
		swizzle_2030 = 0x1e0,
		swizzle_2031 = 0x1e1,
		swizzle_2032 = 0x1e2,
		swizzle_2033 = 0x1e3,
		swizzle_2100 = 0x1e4,
		swizzle_2101 = 0x1e5,
		swizzle_2102 = 0x1e6,
		swizzle_2103 = 0x1e7,
		swizzle_2110 = 0x1e8,
		swizzle_2111 = 0x1e9,
		swizzle_2112 = 0x1ea,
		swizzle_2113 = 0x1eb,
		swizzle_2120 = 0x1ec,
		swizzle_2121 = 0x1ed,
		swizzle_2122 = 0x1ee,
		swizzle_2123 = 0x1ef,
		swizzle_2130 = 0x1f0,
		swizzle_2131 = 0x1f1,
		swizzle_2132 = 0x1f2,
		swizzle_2133 = 0x1f3,
		swizzle_2200 = 0x1f4,
		swizzle_2201 = 0x1f5,
		swizzle_2202 = 0x1f6,
		swizzle_2203 = 0x1f7,
		swizzle_2210 = 0x1f8,
		swizzle_2211 = 0x1f9,
		swizzle_2212 = 0x1fa,
		swizzle_2213 = 0x1fb,
		swizzle_2220 = 0x1fc,
		swizzle_2221 = 0x1fd,
		swizzle_2222 = 0x1fe,
		swizzle_2223 = 0x1ff,
		swizzle_2230 = 0x200,
		swizzle_2231 = 0x201,
		swizzle_2232 = 0x202,
		swizzle_2233 = 0x203,
		swizzle_2300 = 0x204,
		swizzle_2301 = 0x205,
		swizzle_2302 = 0x206,
		swizzle_2303 = 0x207,
		swizzle_2310 = 0x208,
		swizzle_2311 = 0x209,
		swizzle_2312 = 0x20a,
		swizzle_2313 = 0x20b,
		swizzle_2320 = 0x20c,
		swizzle_2321 = 0x20d,
		swizzle_2322 = 0x20e,
		swizzle_2323 = 0x20f,
		swizzle_2330 = 0x210,
		swizzle_2331 = 0x211,
		swizzle_2332 = 0x212,
		swizzle_2333 = 0x213,
		swizzle_3000 = 0x214,
		swizzle_3001 = 0x215,
		swizzle_3002 = 0x216,
		swizzle_3003 = 0x217,
		swizzle_3010 = 0x218,
		swizzle_3011 = 0x219,
		swizzle_3012 = 0x21a,
		swizzle_3013 = 0x21b,
		swizzle_3020 = 0x21c,
		swizzle_3021 = 0x21d,
		swizzle_3022 = 0x21e,
		swizzle_3023 = 0x21f,
		swizzle_3030 = 0x220,
		swizzle_3031 = 0x221,
		swizzle_3032 = 0x222,
		swizzle_3033 = 0x223,
		swizzle_3100 = 0x224,
		swizzle_3101 = 0x225,
		swizzle_3102 = 0x226,
		swizzle_3103 = 0x227,
		swizzle_3110 = 0x228,
		swizzle_3111 = 0x229,
		swizzle_3112 = 0x22a,
		swizzle_3113 = 0x22b,
		swizzle_3120 = 0x22c,
		swizzle_3121 = 0x22d,
		swizzle_3122 = 0x22e,
		swizzle_3123 = 0x22f,
		swizzle_3130 = 0x230,
		swizzle_3131 = 0x231,
		swizzle_3132 = 0x232,
		swizzle_3133 = 0x233,
		swizzle_3200 = 0x234,
		swizzle_3201 = 0x235,
		swizzle_3202 = 0x236,
		swizzle_3203 = 0x237,
		swizzle_3210 = 0x238,
		swizzle_3211 = 0x239,
		swizzle_3212 = 0x23a,
		swizzle_3213 = 0x23b,
		swizzle_3220 = 0x23c,
		swizzle_3221 = 0x23d,
		swizzle_3222 = 0x23e,
		swizzle_3223 = 0x23f,
		swizzle_3230 = 0x240,
		swizzle_3231 = 0x241,
		swizzle_3232 = 0x242,
		swizzle_3233 = 0x243,
		swizzle_3300 = 0x244,
		swizzle_3301 = 0x245,
		swizzle_3302 = 0x246,
		swizzle_3303 = 0x247,
		swizzle_3310 = 0x248,
		swizzle_3311 = 0x249,
		swizzle_3312 = 0x24a,
		swizzle_3313 = 0x24b,
		swizzle_3320 = 0x24c,
		swizzle_3321 = 0x24d,
		swizzle_3322 = 0x24e,
		swizzle_3323 = 0x24f,
		swizzle_3330 = 0x250,
		swizzle_3331 = 0x251,
		swizzle_3332 = 0x252,
		swizzle_3333 = 0x253,

		// simple unary functions
		negate = 0x300,

		// simple binary functions
		// the left-hand operand is the one deeper in the stack
		// arithmetic functions:
		// op(S,S) => S
		// op(Vi,Vi) => Vi
		// op(Mij, Mij) => Mij
		add = 0x400,
		subtract = 0x401,
		multiply = 0x402,
		divide = 0x403,
		modulus = 0x404,
		power = 0x405,
		// additional overloads for multiplication:
		// S*Vi => Vi
		// S*Mij => Mij
		// Vi*S => Vi
		// Mij*S => Mij

		// algebraic multiplication
		// dot(Vi,Vi) => S
		// dot(Vi,Mij) => Vi
		// dot(Mij,Vi) => Vi
		// dot(Mij,Mij) => Mij
		dot = 0x410,
		// cross(V2,V2) => S
		// cross(V3,V3) => V3
		cross = 0x411,

		// sample(S2D,V2) => V4
		sample = 0x420,

		// push a literal
		literal_float1 = 0x600,
		literal_float2 = 0x610,
		literal_float3 = 0x620,
		literal_float4 = 0x630,
		literal_float2x2 = 0x631,
		literal_float3x3 = 0x680,
		literal_float4x4 = 0x6f0,

		// combine values into vectors and matrices
		create_float2_1 = 0x700,
		create_float2_2 = 0x701,
		create_float3_1 = 0x702,
		create_float3_2 = 0x703,
		create_float3_3 = 0x704,
		create_float4_1 = 0x705,
		create_float4_2 = 0x706,
		create_float4_3 = 0x707,
		create_float4_4 = 0x708,
		create_float2x2_1 = 0x709,
		create_float2x2_2 = 0x70a,
		create_float2x2_3 = 0x70b,
		create_float2x2_4 = 0x70c,
		create_float3x3_1 = 0x70d,
		create_float3x3_2 = 0x70e,
		create_float3x3_3 = 0x70f,
		create_float3x3_4 = 0x710,
		create_float3x3_5 = 0x711,
		create_float3x3_6 = 0x712,
		create_float3x3_7 = 0x713,
		create_float3x3_8 = 0x714,
		create_float3x3_9 = 0x715,
		create_float4x4_1 = 0x716,
		create_float4x4_2 = 0x717,
		create_float4x4_3 = 0x718,
		create_float4x4_4 = 0x719,
		create_float4x4_5 = 0x71a,
		create_float4x4_6 = 0x71b,
		create_float4x4_7 = 0x71c,
		create_float4x4_8 = 0x71d,
		create_float4x4_9 = 0x71e,
		create_float4x4_a = 0x71f,
		create_float4x4_b = 0x720,
		create_float4x4_c = 0x721,
		create_float4x4_d = 0x722,
		create_float4x4_e = 0x723,
		create_float4x4_f = 0x724,
		create_float4x4_g = 0x725,

		// read a value deeper in the stack and duplicate in on top
		extract_0 = 0x800,
		extract_1 = 0x801,
		extract_2 = 0x802,
		extract_3 = 0x803,
		extract_4 = 0x804,
		extract_5 = 0x805,
		extract_6 = 0x806,
		extract_7 = 0x807,
		extract_8 = 0x808,
		extract_9 = 0x809,
		extract_a = 0x80a,
		extract_b = 0x80b,
		extract_c = 0x80c,
		extract_d = 0x80d,
		extract_e = 0x80e,
		extract_f = 0x80f,

		// remove values from the top
		discard_1 = 0x820,
		discard_2 = 0x821,
		discard_3 = 0x822,
		discard_4 = 0x823,
		discard_5 = 0x824,
		discard_6 = 0x825,
		discard_7 = 0x826,
	};

	void translateprogram(
		DataBuffer* source, Ref< DataBuffer >* vsrc, Ref< DataBuffer >* fsrc );
}
