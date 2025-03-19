; ModuleID = 'png.c'
source_filename = "png.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.png_struct_def = type { [1 x %struct.__jmp_buf_tag], void (%struct.__jmp_buf_tag*, i32)*, [1 x %struct.__jmp_buf_tag]*, i64, void (%struct.png_struct_def*, i8*)*, void (%struct.png_struct_def*, i8*)*, i8*, void (%struct.png_struct_def*, i8*, i64)*, void (%struct.png_struct_def*, i8*, i64)*, i8*, void (%struct.png_struct_def*, %struct.png_row_info_struct*, i8*)*, void (%struct.png_struct_def*, %struct.png_row_info_struct*, i8*)*, i8*, i8, i8, i32, i32, i32, i32, %struct.z_stream_s, %struct.png_compression_buffer*, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, i32, i32, i32, i8*, i8*, i8*, i8*, i64, i32, i32, %struct.png_color_struct*, i16, i32, i16, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i16, i8, i32, %struct.png_color_16_struct, %struct.png_color_16_struct, void (%struct.png_struct_def*)*, i32, i32, %struct.png_xy, i32, i32, i32, i32, i32, i8*, i16**, i8*, i8*, i16**, i16**, %struct.png_color_8_struct, %struct.png_color_8_struct, i8*, %struct.png_color_16_struct, void (%struct.png_struct_def*, i32, i32)*, void (%struct.png_struct_def*, i32, i32)*, void (%struct.png_struct_def*, %struct.png_info_def*)*, void (%struct.png_struct_def*, i8*, i32, i32)*, void (%struct.png_struct_def*, %struct.png_info_def*)*, i8*, i8*, i8*, i8*, i32, i32, i64, i64, i64, i64, i32, i32, i8*, i8*, i32, [29 x i8], i32, i8*, i32 (%struct.png_struct_def*, %struct.png_unknown_chunk_t*)*, i32, i32, i8*, i8, i8, i16, i16, i8*, i32, i8, i8*, i8* (%struct.png_struct_def*, i64)*, void (%struct.png_struct_def*, i8*)*, i8*, i8*, i8*, i8*, i8, i32, i32, i32, i64, %struct.png_unknown_chunk_t, i64, i8*, i64, i32, i32, i8*, [4 x void (%struct.png_row_info_struct*, i8*, i8*)*] }
%struct.__jmp_buf_tag = type { [8 x i64], i32, %struct.__sigset_t }
%struct.__sigset_t = type { [16 x i64] }
%struct.png_row_info_struct = type { i32, i64, i8, i8, i8, i8 }
%struct.z_stream_s = type { i8*, i32, i64, i8*, i32, i64, i8*, %struct.internal_state*, i8* (i8*, i32, i32)*, void (i8*, i8*)*, i8*, i32, i64, i64 }
%struct.internal_state = type opaque
%struct.png_compression_buffer = type { %struct.png_compression_buffer*, [1 x i8] }
%struct.png_color_struct = type { i8, i8, i8 }
%struct.png_xy = type { i32, i32, i32, i32, i32, i32, i32, i32 }
%struct.png_color_8_struct = type { i8, i8, i8, i8, i8 }
%struct.png_color_16_struct = type { i8, i16, i16, i16, i16 }
%struct.png_info_def = type { i32, i32, i32, i64, %struct.png_color_struct*, i16, i16, i8, i8, i8, i8, i8, i8, i8, i8, [8 x i8], i8*, i8*, i32, i32, i32, %struct.png_text_struct*, %struct.png_time_struct, %struct.png_color_8_struct, i8*, %struct.png_color_16_struct, %struct.png_color_16_struct, i32, i32, i8, i32, i32, i8, i32, i8*, i16*, i8*, i32, i32, i8*, i8**, i8, i8, i32, %struct.png_unknown_chunk_t*, i32, %struct.png_sPLT_struct*, i32, i8, i8*, i8*, i8**, %struct.png_xy, i32, i32 }
%struct.png_text_struct = type { i32, i8*, i8*, i64, i64, i8*, i8* }
%struct.png_time_struct = type { i16, i8, i8, i8, i8, i8 }
%struct.png_sPLT_struct = type { i8*, i8, %struct.png_sPLT_entry_struct*, i32 }
%struct.png_sPLT_entry_struct = type { i16, i16, i16, i16, i16 }
%struct.png_unknown_chunk_t = type { [5 x i8], i8*, i64, i8 }
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, %struct._IO_codecvt*, %struct._IO_wide_data*, %struct._IO_FILE*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type opaque
%struct._IO_codecvt = type opaque
%struct._IO_wide_data = type opaque
%struct.png_XYZ = type { i32, i32, i32, i32, i32, i32, i32, i32, i32 }
%struct.png_image = type { %struct.png_control*, i32, i32, i32, i32, i32, i32, i32, [64 x i8] }
%struct.png_control = type { %struct.png_struct_def*, %struct.png_info_def*, i8*, i8*, i64, i8 }

@.str = private unnamed_addr constant [33 x i8] c"Too many bytes for PNG signature\00", align 1
@png_sig_cmp.png_signature = internal constant [8 x i8] c"\89PNG\0D\0A\1A\0A", align 1
@.str.1 = private unnamed_addr constant [35 x i8] c"Potential overflow in png_zalloc()\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"1.6.48.git\00", align 1
@.str.3 = private unnamed_addr constant [31 x i8] c"Application built with libpng-\00", align 1
@.str.4 = private unnamed_addr constant [19 x i8] c" but running with \00", align 1
@.str.5 = private unnamed_addr constant [42 x i8] c"Unknown freer parameter in png_data_freer\00", align 1
@png_convert_to_rfc1123_buffer.short_months = internal constant [12 x [4 x i8]] [[4 x i8] c"Jan\00", [4 x i8] c"Feb\00", [4 x i8] c"Mar\00", [4 x i8] c"Apr\00", [4 x i8] c"May\00", [4 x i8] c"Jun\00", [4 x i8] c"Jul\00", [4 x i8] c"Aug\00", [4 x i8] c"Sep\00", [4 x i8] c"Oct\00", [4 x i8] c"Nov\00", [4 x i8] c"Dec\00"], align 16
@.str.6 = private unnamed_addr constant [7 x i8] c" +0000\00", align 1
@.str.7 = private unnamed_addr constant [28 x i8] c"Ignoring invalid time value\00", align 1
@.str.8 = private unnamed_addr constant [223 x i8] c"\0Alibpng version 1.6.48.git\0ACopyright (c) 2018-2025 Cosmin Truta\0ACopyright (c) 1998-2002,2004,2006-2018 Glenn Randers-Pehrson\0ACopyright (c) 1996-1997 Andreas Dilger\0ACopyright (c) 1995-1996 Guy Eric Schalnat, Group 42, Inc.\0A\00", align 1
@.str.9 = private unnamed_addr constant [29 x i8] c" libpng version 1.6.48.git\0A\0A\00", align 1
@.str.10 = private unnamed_addr constant [28 x i8] c"unexpected zlib return code\00", align 1
@.str.11 = private unnamed_addr constant [28 x i8] c"unexpected end of LZ stream\00", align 1
@.str.12 = private unnamed_addr constant [22 x i8] c"missing LZ dictionary\00", align 1
@.str.13 = private unnamed_addr constant [14 x i8] c"zlib IO error\00", align 1
@.str.14 = private unnamed_addr constant [23 x i8] c"bad parameters to zlib\00", align 1
@.str.15 = private unnamed_addr constant [18 x i8] c"damaged LZ stream\00", align 1
@.str.16 = private unnamed_addr constant [20 x i8] c"insufficient memory\00", align 1
@.str.17 = private unnamed_addr constant [10 x i8] c"truncated\00", align 1
@.str.18 = private unnamed_addr constant [25 x i8] c"unsupported zlib version\00", align 1
@.str.19 = private unnamed_addr constant [23 x i8] c"unexpected zlib return\00", align 1
@.str.20 = private unnamed_addr constant [17 x i8] c"profile too long\00", align 1
@.str.21 = private unnamed_addr constant [30 x i8] c"length does not match profile\00", align 1
@.str.22 = private unnamed_addr constant [15 x i8] c"invalid length\00", align 1
@.str.23 = private unnamed_addr constant [20 x i8] c"tag count too large\00", align 1
@.str.24 = private unnamed_addr constant [25 x i8] c"invalid rendering intent\00", align 1
@.str.25 = private unnamed_addr constant [29 x i8] c"intent outside defined range\00", align 1
@.str.26 = private unnamed_addr constant [18 x i8] c"invalid signature\00", align 1
@D50_nCIEXYZ = internal constant [12 x i8] c"\00\00\F6\D6\00\01\00\00\00\00\D3-", align 1
@.str.27 = private unnamed_addr constant [26 x i8] c"PCS illuminant is not D50\00", align 1
@.str.28 = private unnamed_addr constant [47 x i8] c"RGB color space not permitted on grayscale PNG\00", align 1
@.str.29 = private unnamed_addr constant [42 x i8] c"Gray color space not permitted on RGB PNG\00", align 1
@.str.30 = private unnamed_addr constant [32 x i8] c"invalid ICC profile color space\00", align 1
@.str.31 = private unnamed_addr constant [38 x i8] c"invalid embedded Abstract ICC profile\00", align 1
@.str.32 = private unnamed_addr constant [40 x i8] c"unexpected DeviceLink ICC profile class\00", align 1
@.str.33 = private unnamed_addr constant [40 x i8] c"unexpected NamedColor ICC profile class\00", align 1
@.str.34 = private unnamed_addr constant [31 x i8] c"unrecognized ICC profile class\00", align 1
@.str.35 = private unnamed_addr constant [28 x i8] c"unexpected ICC PCS encoding\00", align 1
@.str.36 = private unnamed_addr constant [32 x i8] c"ICC profile tag outside profile\00", align 1
@.str.37 = private unnamed_addr constant [42 x i8] c"ICC profile tag start not a multiple of 4\00", align 1
@.str.38 = private unnamed_addr constant [42 x i8] c"internal error handling cHRM coefficients\00", align 1
@.str.39 = private unnamed_addr constant [28 x i8] c"Image width is zero in IHDR\00", align 1
@.str.40 = private unnamed_addr constant [28 x i8] c"Invalid image width in IHDR\00", align 1
@.str.41 = private unnamed_addr constant [47 x i8] c"Image width is too large for this architecture\00", align 1
@.str.42 = private unnamed_addr constant [39 x i8] c"Image width exceeds user limit in IHDR\00", align 1
@.str.43 = private unnamed_addr constant [29 x i8] c"Image height is zero in IHDR\00", align 1
@.str.44 = private unnamed_addr constant [29 x i8] c"Invalid image height in IHDR\00", align 1
@.str.45 = private unnamed_addr constant [40 x i8] c"Image height exceeds user limit in IHDR\00", align 1
@.str.46 = private unnamed_addr constant [26 x i8] c"Invalid bit depth in IHDR\00", align 1
@.str.47 = private unnamed_addr constant [27 x i8] c"Invalid color type in IHDR\00", align 1
@.str.48 = private unnamed_addr constant [49 x i8] c"Invalid color type/bit depth combination in IHDR\00", align 1
@.str.49 = private unnamed_addr constant [33 x i8] c"Unknown interlace method in IHDR\00", align 1
@.str.50 = private unnamed_addr constant [35 x i8] c"Unknown compression method in IHDR\00", align 1
@.str.51 = private unnamed_addr constant [49 x i8] c"MNG features are not allowed in a PNG datastream\00", align 1
@.str.52 = private unnamed_addr constant [30 x i8] c"Unknown filter method in IHDR\00", align 1
@.str.53 = private unnamed_addr constant [30 x i8] c"Invalid filter method in IHDR\00", align 1
@.str.54 = private unnamed_addr constant [18 x i8] c"Invalid IHDR data\00", align 1
@.str.55 = private unnamed_addr constant [34 x i8] c"ASCII conversion buffer too small\00", align 1
@.str.56 = private unnamed_addr constant [26 x i8] c"gamma table being rebuilt\00", align 1
@png_sRGB_table = dso_local constant [256 x i16] [i16 0, i16 20, i16 40, i16 60, i16 80, i16 99, i16 119, i16 139, i16 159, i16 179, i16 199, i16 219, i16 241, i16 264, i16 288, i16 313, i16 340, i16 367, i16 396, i16 427, i16 458, i16 491, i16 526, i16 562, i16 599, i16 637, i16 677, i16 718, i16 761, i16 805, i16 851, i16 898, i16 947, i16 997, i16 1048, i16 1101, i16 1156, i16 1212, i16 1270, i16 1330, i16 1391, i16 1453, i16 1517, i16 1583, i16 1651, i16 1720, i16 1790, i16 1863, i16 1937, i16 2013, i16 2090, i16 2170, i16 2250, i16 2333, i16 2418, i16 2504, i16 2592, i16 2681, i16 2773, i16 2866, i16 2961, i16 3058, i16 3157, i16 3258, i16 3360, i16 3464, i16 3570, i16 3678, i16 3788, i16 3900, i16 4014, i16 4129, i16 4247, i16 4366, i16 4488, i16 4611, i16 4736, i16 4864, i16 4993, i16 5124, i16 5257, i16 5392, i16 5530, i16 5669, i16 5810, i16 5953, i16 6099, i16 6246, i16 6395, i16 6547, i16 6700, i16 6856, i16 7014, i16 7174, i16 7335, i16 7500, i16 7666, i16 7834, i16 8004, i16 8177, i16 8352, i16 8528, i16 8708, i16 8889, i16 9072, i16 9258, i16 9445, i16 9635, i16 9828, i16 10022, i16 10219, i16 10417, i16 10619, i16 10822, i16 11028, i16 11235, i16 11446, i16 11658, i16 11873, i16 12090, i16 12309, i16 12530, i16 12754, i16 12980, i16 13209, i16 13440, i16 13673, i16 13909, i16 14146, i16 14387, i16 14629, i16 14874, i16 15122, i16 15371, i16 15623, i16 15878, i16 16135, i16 16394, i16 16656, i16 16920, i16 17187, i16 17456, i16 17727, i16 18001, i16 18277, i16 18556, i16 18837, i16 19121, i16 19407, i16 19696, i16 19987, i16 20281, i16 20577, i16 20876, i16 21177, i16 21481, i16 21787, i16 22096, i16 22407, i16 22721, i16 23038, i16 23357, i16 23678, i16 24002, i16 24329, i16 24658, i16 24990, i16 25325, i16 25662, i16 26001, i16 26344, i16 26688, i16 27036, i16 27386, i16 27739, i16 28094, i16 28452, i16 28813, i16 29176, i16 29542, i16 29911, i16 30282, i16 30656, i16 31033, i16 31412, i16 31794, i16 32179, i16 32567, i16 -32579, i16 -32186, i16 -31791, i16 -31393, i16 -30992, i16 -30588, i16 -30181, i16 -29772, i16 -29360, i16 -28945, i16 -28528, i16 -28107, i16 -27684, i16 -27258, i16 -26830, i16 -26398, i16 -25964, i16 -25527, i16 -25087, i16 -24645, i16 -24199, i16 -23751, i16 -23300, i16 -22846, i16 -22389, i16 -21930, i16 -21467, i16 -21002, i16 -20534, i16 -20063, i16 -19589, i16 -19113, i16 -18633, i16 -18151, i16 -17665, i16 -17177, i16 -16686, i16 -16192, i16 -15695, i16 -15195, i16 -14692, i16 -14187, i16 -13678, i16 -13167, i16 -12652, i16 -12135, i16 -11615, i16 -11091, i16 -10565, i16 -10036, i16 -9504, i16 -8969, i16 -8431, i16 -7890, i16 -7346, i16 -6799, i16 -6249, i16 -5696, i16 -5140, i16 -4581, i16 -4019, i16 -3454, i16 -2886, i16 -2315, i16 -1741, i16 -1164, i16 -584, i16 -1], align 16
@png_sRGB_base = dso_local constant [512 x i16] [i16 128, i16 1782, i16 3383, i16 4644, i16 5675, i16 6564, i16 7357, i16 8074, i16 8732, i16 9346, i16 9921, i16 10463, i16 10977, i16 11466, i16 11935, i16 12384, i16 12816, i16 13233, i16 13634, i16 14024, i16 14402, i16 14769, i16 15125, i16 15473, i16 15812, i16 16142, i16 16466, i16 16781, i16 17090, i16 17393, i16 17690, i16 17981, i16 18266, i16 18546, i16 18822, i16 19093, i16 19359, i16 19621, i16 19879, i16 20133, i16 20383, i16 20630, i16 20873, i16 21113, i16 21349, i16 21583, i16 21813, i16 22041, i16 22265, i16 22487, i16 22707, i16 22923, i16 23138, i16 23350, i16 23559, i16 23767, i16 23972, i16 24175, i16 24376, i16 24575, i16 24772, i16 24967, i16 25160, i16 25352, i16 25542, i16 25730, i16 25916, i16 26101, i16 26284, i16 26465, i16 26645, i16 26823, i16 27000, i16 27176, i16 27350, i16 27523, i16 27695, i16 27865, i16 28034, i16 28201, i16 28368, i16 28533, i16 28697, i16 28860, i16 29021, i16 29182, i16 29341, i16 29500, i16 29657, i16 29813, i16 29969, i16 30123, i16 30276, i16 30429, i16 30580, i16 30730, i16 30880, i16 31028, i16 31176, i16 31323, i16 31469, i16 31614, i16 31758, i16 31902, i16 32045, i16 32186, i16 32327, i16 32468, i16 32607, i16 32746, i16 -32652, i16 -32515, i16 -32378, i16 -32242, i16 -32107, i16 -31972, i16 -31839, i16 -31705, i16 -31573, i16 -31441, i16 -31310, i16 -31179, i16 -31050, i16 -30920, i16 -30792, i16 -30663, i16 -30536, i16 -30409, i16 -30283, i16 -30157, i16 -30032, i16 -29907, i16 -29783, i16 -29660, i16 -29537, i16 -29414, i16 -29292, i16 -29171, i16 -29050, i16 -28930, i16 -28810, i16 -28691, i16 -28572, i16 -28453, i16 -28335, i16 -28218, i16 -28101, i16 -27985, i16 -27868, i16 -27753, i16 -27638, i16 -27523, i16 -27409, i16 -27295, i16 -27182, i16 -27069, i16 -26956, i16 -26844, i16 -26733, i16 -26621, i16 -26510, i16 -26400, i16 -26290, i16 -26180, i16 -26071, i16 -25962, i16 -25854, i16 -25746, i16 -25638, i16 -25531, i16 -25424, i16 -25317, i16 -25211, i16 -25105, i16 -24999, i16 -24894, i16 -24789, i16 -24685, i16 -24581, i16 -24477, i16 -24373, i16 -24270, i16 -24167, i16 -24065, i16 -23963, i16 -23861, i16 -23759, i16 -23658, i16 -23557, i16 -23457, i16 -23357, i16 -23257, i16 -23157, i16 -23058, i16 -22959, i16 -22860, i16 -22761, i16 -22663, i16 -22565, i16 -22468, i16 -22371, i16 -22274, i16 -22177, i16 -22080, i16 -21984, i16 -21888, i16 -21793, i16 -21697, i16 -21602, i16 -21508, i16 -21413, i16 -21319, i16 -21225, i16 -21131, i16 -21037, i16 -20944, i16 -20851, i16 -20758, i16 -20666, i16 -20574, i16 -20482, i16 -20390, i16 -20298, i16 -20207, i16 -20116, i16 -20025, i16 -19935, i16 -19844, i16 -19754, i16 -19664, i16 -19575, i16 -19485, i16 -19396, i16 -19307, i16 -19218, i16 -19130, i16 -19042, i16 -18953, i16 -18866, i16 -18778, i16 -18690, i16 -18603, i16 -18516, i16 -18429, i16 -18343, i16 -18256, i16 -18170, i16 -18084, i16 -17998, i16 -17913, i16 -17827, i16 -17742, i16 -17657, i16 -17572, i16 -17488, i16 -17403, i16 -17319, i16 -17235, i16 -17151, i16 -17068, i16 -16984, i16 -16901, i16 -16818, i16 -16735, i16 -16652, i16 -16570, i16 -16488, i16 -16405, i16 -16323, i16 -16242, i16 -16160, i16 -16078, i16 -15997, i16 -15916, i16 -15835, i16 -15754, i16 -15674, i16 -15593, i16 -15513, i16 -15433, i16 -15353, i16 -15273, i16 -15194, i16 -15114, i16 -15035, i16 -14956, i16 -14877, i16 -14798, i16 -14720, i16 -14641, i16 -14563, i16 -14485, i16 -14407, i16 -14329, i16 -14251, i16 -14174, i16 -14097, i16 -14019, i16 -13942, i16 -13865, i16 -13789, i16 -13712, i16 -13636, i16 -13559, i16 -13483, i16 -13407, i16 -13331, i16 -13256, i16 -13180, i16 -13104, i16 -13029, i16 -12954, i16 -12879, i16 -12804, i16 -12729, i16 -12655, i16 -12580, i16 -12506, i16 -12432, i16 -12358, i16 -12284, i16 -12210, i16 -12136, i16 -12063, i16 -11990, i16 -11916, i16 -11843, i16 -11770, i16 -11697, i16 -11625, i16 -11552, i16 -11480, i16 -11407, i16 -11335, i16 -11263, i16 -11191, i16 -11119, i16 -11047, i16 -10976, i16 -10904, i16 -10833, i16 -10762, i16 -10691, i16 -10620, i16 -10549, i16 -10478, i16 -10407, i16 -10337, i16 -10267, i16 -10196, i16 -10126, i16 -10056, i16 -9986, i16 -9916, i16 -9847, i16 -9777, i16 -9708, i16 -9638, i16 -9569, i16 -9500, i16 -9431, i16 -9362, i16 -9293, i16 -9225, i16 -9156, i16 -9088, i16 -9019, i16 -8951, i16 -8883, i16 -8815, i16 -8747, i16 -8679, i16 -8612, i16 -8544, i16 -8477, i16 -8409, i16 -8342, i16 -8275, i16 -8208, i16 -8141, i16 -8074, i16 -8007, i16 -7941, i16 -7874, i16 -7808, i16 -7741, i16 -7675, i16 -7609, i16 -7543, i16 -7477, i16 -7411, i16 -7345, i16 -7280, i16 -7214, i16 -7149, i16 -7083, i16 -7018, i16 -6953, i16 -6888, i16 -6823, i16 -6758, i16 -6693, i16 -6628, i16 -6564, i16 -6499, i16 -6435, i16 -6371, i16 -6306, i16 -6242, i16 -6178, i16 -6114, i16 -6050, i16 -5987, i16 -5923, i16 -5859, i16 -5796, i16 -5732, i16 -5669, i16 -5606, i16 -5543, i16 -5480, i16 -5417, i16 -5354, i16 -5291, i16 -5228, i16 -5166, i16 -5103, i16 -5041, i16 -4978, i16 -4916, i16 -4854, i16 -4792, i16 -4730, i16 -4668, i16 -4606, i16 -4544, i16 -4482, i16 -4421, i16 -4359, i16 -4298, i16 -4236, i16 -4175, i16 -4114, i16 -4053, i16 -3992, i16 -3931, i16 -3870, i16 -3809, i16 -3748, i16 -3688, i16 -3627, i16 -3567, i16 -3506, i16 -3446, i16 -3386, i16 -3325, i16 -3265, i16 -3205, i16 -3145, i16 -3086, i16 -3026, i16 -2966, i16 -2906, i16 -2847, i16 -2787, i16 -2728, i16 -2669, i16 -2609, i16 -2550, i16 -2491, i16 -2432, i16 -2373, i16 -2314, i16 -2255, i16 -2196, i16 -2138, i16 -2079, i16 -2021, i16 -1962, i16 -1904, i16 -1845, i16 -1787, i16 -1729, i16 -1671, i16 -1613, i16 -1555, i16 -1497, i16 -1439, i16 -1381, i16 -1324, i16 -1266, i16 -1208, i16 -1151, i16 -1093, i16 -1036, i16 -979, i16 -922, i16 -864, i16 -807, i16 -750, i16 -693, i16 -636, i16 -580, i16 -523, i16 -466, i16 -410, i16 -353, i16 -297, i16 -240, i16 -184, i16 -127, i16 -71], align 16
@png_sRGB_delta = dso_local constant [512 x i8] c"\CF\C9\9E\81qdZRMHD@=;86421/.-+*)(''&%$$#\22\22!!  \1F\1F\1E\1E\1E\1D\1D\1C\1C\1C\1B\1B\1B\1B\1A\1A\1A\19\19\19\19\18\18\18\18\17\17\17\17\17\16\16\16\16\16\16\15\15\15\15\15\15\14\14\14\14\14\14\14\14\13\13\13\13\13\13\13\13\12\12\12\12\12\12\12\12\12\12\11\11\11\11\11\11\11\11\11\11\11\10\10\10\10\10\10\10\10\10\10\10\10\10\10\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0F\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0E\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0D\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0C\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0B\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\0A\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\09\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07", align 16
@.str.57 = private unnamed_addr constant [10 x i8] c"too short\00", align 1
@.str.58 = private unnamed_addr constant [10 x i8] c"profile '\00", align 1
@.str.59 = private unnamed_addr constant [4 x i8] c"': \00", align 1
@.str.60 = private unnamed_addr constant [4 x i8] c"h: \00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_set_sig_bytes(%struct.png_struct_def* noalias noundef %0, i32 noundef %1) #0 {
  %3 = alloca %struct.png_struct_def*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %3, align 8
  store i32 %1, i32* %4, align 4
  %6 = load i32, i32* %4, align 4
  store i32 %6, i32* %5, align 4
  %7 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %8 = icmp eq %struct.png_struct_def* %7, null
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  br label %24

10:                                               ; preds = %2
  %11 = load i32, i32* %4, align 4
  %12 = icmp slt i32 %11, 0
  br i1 %12, label %13, label %14

13:                                               ; preds = %10
  store i32 0, i32* %5, align 4
  br label %14

14:                                               ; preds = %13, %10
  %15 = load i32, i32* %5, align 4
  %16 = icmp ugt i32 %15, 8
  br i1 %16, label %17, label %19

17:                                               ; preds = %14
  %18 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  call void @png_error(%struct.png_struct_def* noundef %18, i8* noundef getelementptr inbounds ([33 x i8], [33 x i8]* @.str, i64 0, i64 0)) #10
  unreachable

19:                                               ; preds = %14
  %20 = load i32, i32* %5, align 4
  %21 = trunc i32 %20 to i8
  %22 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %23 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %22, i32 0, i32 68
  store i8 %21, i8* %23, align 1
  br label %24

24:                                               ; preds = %19, %9
  ret void
}

; Function Attrs: noreturn
declare void @png_error(%struct.png_struct_def* noundef, i8* noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_sig_cmp(i8* noundef %0, i64 noundef %1, i64 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  store i8* %0, i8** %5, align 8
  store i64 %1, i64* %6, align 8
  store i64 %2, i64* %7, align 8
  %8 = load i64, i64* %7, align 8
  %9 = icmp ugt i64 %8, 8
  br i1 %9, label %10, label %11

10:                                               ; preds = %3
  store i64 8, i64* %7, align 8
  br label %16

11:                                               ; preds = %3
  %12 = load i64, i64* %7, align 8
  %13 = icmp ult i64 %12, 1
  br i1 %13, label %14, label %15

14:                                               ; preds = %11
  store i32 -1, i32* %4, align 4
  br label %36

15:                                               ; preds = %11
  br label %16

16:                                               ; preds = %15, %10
  %17 = load i64, i64* %6, align 8
  %18 = icmp ugt i64 %17, 7
  br i1 %18, label %19, label %20

19:                                               ; preds = %16
  store i32 -1, i32* %4, align 4
  br label %36

20:                                               ; preds = %16
  %21 = load i64, i64* %6, align 8
  %22 = load i64, i64* %7, align 8
  %23 = add i64 %21, %22
  %24 = icmp ugt i64 %23, 8
  br i1 %24, label %25, label %28

25:                                               ; preds = %20
  %26 = load i64, i64* %6, align 8
  %27 = sub i64 8, %26
  store i64 %27, i64* %7, align 8
  br label %28

28:                                               ; preds = %25, %20
  %29 = load i8*, i8** %5, align 8
  %30 = load i64, i64* %6, align 8
  %31 = getelementptr inbounds i8, i8* %29, i64 %30
  %32 = load i64, i64* %6, align 8
  %33 = getelementptr inbounds [8 x i8], [8 x i8]* @png_sig_cmp.png_signature, i64 0, i64 %32
  %34 = load i64, i64* %7, align 8
  %35 = call i32 @memcmp(i8* noundef %31, i8* noundef %33, i64 noundef %34) #11
  store i32 %35, i32* %4, align 4
  br label %36

36:                                               ; preds = %28, %19, %14
  %37 = load i32, i32* %4, align 4
  ret i32 %37
}

; Function Attrs: nounwind readonly willreturn
declare i32 @memcmp(i8* noundef, i8* noundef, i64 noundef) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local noalias i8* @png_zalloc(i8* noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i64, align 8
  store i8* %0, i8** %5, align 8
  store i32 %1, i32* %6, align 4
  store i32 %2, i32* %7, align 4
  %9 = load i32, i32* %7, align 4
  %10 = zext i32 %9 to i64
  store i64 %10, i64* %8, align 8
  %11 = load i8*, i8** %5, align 8
  %12 = icmp eq i8* %11, null
  br i1 %12, label %13, label %14

13:                                               ; preds = %3
  store i8* null, i8** %4, align 8
  br label %33

14:                                               ; preds = %3
  %15 = load i32, i32* %6, align 4
  %16 = zext i32 %15 to i64
  %17 = load i32, i32* %7, align 4
  %18 = zext i32 %17 to i64
  %19 = udiv i64 -1, %18
  %20 = icmp uge i64 %16, %19
  br i1 %20, label %21, label %24

21:                                               ; preds = %14
  %22 = load i8*, i8** %5, align 8
  %23 = bitcast i8* %22 to %struct.png_struct_def*
  call void @png_warning(%struct.png_struct_def* noundef %23, i8* noundef getelementptr inbounds ([35 x i8], [35 x i8]* @.str.1, i64 0, i64 0))
  store i8* null, i8** %4, align 8
  br label %33

24:                                               ; preds = %14
  %25 = load i32, i32* %6, align 4
  %26 = zext i32 %25 to i64
  %27 = load i64, i64* %8, align 8
  %28 = mul i64 %27, %26
  store i64 %28, i64* %8, align 8
  %29 = load i8*, i8** %5, align 8
  %30 = bitcast i8* %29 to %struct.png_struct_def*
  %31 = load i64, i64* %8, align 8
  %32 = call noalias i8* @png_malloc_warn(%struct.png_struct_def* noundef %30, i64 noundef %31)
  store i8* %32, i8** %4, align 8
  br label %33

33:                                               ; preds = %24, %21, %13
  %34 = load i8*, i8** %4, align 8
  ret i8* %34
}

declare void @png_warning(%struct.png_struct_def* noundef, i8* noundef) #3

declare noalias i8* @png_malloc_warn(%struct.png_struct_def* noundef, i64 noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_zfree(i8* noundef %0, i8* noundef %1) #0 {
  %3 = alloca i8*, align 8
  %4 = alloca i8*, align 8
  store i8* %0, i8** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load i8*, i8** %3, align 8
  %6 = bitcast i8* %5 to %struct.png_struct_def*
  %7 = load i8*, i8** %4, align 8
  call void @png_free(%struct.png_struct_def* noundef %6, i8* noundef %7)
  ret void
}

declare void @png_free(%struct.png_struct_def* noundef, i8* noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_reset_crc(%struct.png_struct_def* noalias noundef %0) #0 {
  %2 = alloca %struct.png_struct_def*, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %2, align 8
  %3 = call i64 @crc32(i64 noundef 0, i8* noundef null, i32 noundef 0)
  %4 = trunc i64 %3 to i32
  %5 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %6 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %5, i32 0, i32 52
  store i32 %4, i32* %6, align 4
  ret void
}

declare i64 @crc32(i64 noundef, i8* noundef, i32 noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_calculate_crc(%struct.png_struct_def* noalias noundef %0, i8* noundef %1, i64 noundef %2) #0 {
  %4 = alloca %struct.png_struct_def*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i32, align 4
  %8 = alloca i64, align 8
  %9 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %4, align 8
  store i8* %1, i8** %5, align 8
  store i64 %2, i64* %6, align 8
  store i32 1, i32* %7, align 4
  %10 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %11 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %10, i32 0, i32 45
  %12 = load i32, i32* %11, align 8
  %13 = lshr i32 %12, 29
  %14 = and i32 1, %13
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %16, label %24

16:                                               ; preds = %3
  %17 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %18 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %17, i32 0, i32 16
  %19 = load i32, i32* %18, align 8
  %20 = and i32 %19, 768
  %21 = icmp eq i32 %20, 768
  br i1 %21, label %22, label %23

22:                                               ; preds = %16
  store i32 0, i32* %7, align 4
  br label %23

23:                                               ; preds = %22, %16
  br label %32

24:                                               ; preds = %3
  %25 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %26 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %25, i32 0, i32 16
  %27 = load i32, i32* %26, align 8
  %28 = and i32 %27, 2048
  %29 = icmp ne i32 %28, 0
  br i1 %29, label %30, label %31

30:                                               ; preds = %24
  store i32 0, i32* %7, align 4
  br label %31

31:                                               ; preds = %30, %24
  br label %32

32:                                               ; preds = %31, %23
  %33 = load i32, i32* %7, align 4
  %34 = icmp ne i32 %33, 0
  br i1 %34, label %35, label %70

35:                                               ; preds = %32
  %36 = load i64, i64* %6, align 8
  %37 = icmp ugt i64 %36, 0
  br i1 %37, label %38, label %70

38:                                               ; preds = %35
  %39 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %40 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %39, i32 0, i32 52
  %41 = load i32, i32* %40, align 4
  %42 = zext i32 %41 to i64
  store i64 %42, i64* %8, align 8
  br label %43

43:                                               ; preds = %62, %38
  %44 = load i64, i64* %6, align 8
  %45 = trunc i64 %44 to i32
  store i32 %45, i32* %9, align 4
  %46 = load i32, i32* %9, align 4
  %47 = icmp eq i32 %46, 0
  br i1 %47, label %48, label %49

48:                                               ; preds = %43
  store i32 -1, i32* %9, align 4
  br label %49

49:                                               ; preds = %48, %43
  %50 = load i64, i64* %8, align 8
  %51 = load i8*, i8** %5, align 8
  %52 = load i32, i32* %9, align 4
  %53 = call i64 @crc32(i64 noundef %50, i8* noundef %51, i32 noundef %52)
  store i64 %53, i64* %8, align 8
  %54 = load i32, i32* %9, align 4
  %55 = load i8*, i8** %5, align 8
  %56 = zext i32 %54 to i64
  %57 = getelementptr inbounds i8, i8* %55, i64 %56
  store i8* %57, i8** %5, align 8
  %58 = load i32, i32* %9, align 4
  %59 = zext i32 %58 to i64
  %60 = load i64, i64* %6, align 8
  %61 = sub i64 %60, %59
  store i64 %61, i64* %6, align 8
  br label %62

62:                                               ; preds = %49
  %63 = load i64, i64* %6, align 8
  %64 = icmp ugt i64 %63, 0
  br i1 %64, label %43, label %65, !llvm.loop !6

65:                                               ; preds = %62
  %66 = load i64, i64* %8, align 8
  %67 = trunc i64 %66 to i32
  %68 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %69 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %68, i32 0, i32 52
  store i32 %67, i32* %69, align 4
  br label %70

70:                                               ; preds = %65, %35, %32
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_user_version_check(%struct.png_struct_def* noalias noundef %0, i8* noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca %struct.png_struct_def*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i64, align 8
  %9 = alloca [128 x i8], align 16
  store %struct.png_struct_def* %0, %struct.png_struct_def** %4, align 8
  store i8* %1, i8** %5, align 8
  %10 = load i8*, i8** %5, align 8
  %11 = icmp ne i8* %10, null
  br i1 %11, label %12, label %66

12:                                               ; preds = %2
  store i32 -1, i32* %6, align 4
  store i32 0, i32* %7, align 4
  br label %13

13:                                               ; preds = %63, %12
  %14 = load i32, i32* %6, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, i32* %6, align 4
  %16 = load i8*, i8** %5, align 8
  %17 = load i32, i32* %6, align 4
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds i8, i8* %16, i64 %18
  %20 = load i8, i8* %19, align 1
  %21 = sext i8 %20 to i32
  %22 = load i32, i32* %6, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.2, i64 0, i64 %23
  %25 = load i8, i8* %24, align 1
  %26 = sext i8 %25 to i32
  %27 = icmp ne i32 %21, %26
  br i1 %27, label %28, label %33

28:                                               ; preds = %13
  %29 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %30 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %29, i32 0, i32 16
  %31 = load i32, i32* %30, align 8
  %32 = or i32 %31, 131072
  store i32 %32, i32* %30, align 8
  br label %33

33:                                               ; preds = %28, %13
  %34 = load i8*, i8** %5, align 8
  %35 = load i32, i32* %6, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds i8, i8* %34, i64 %36
  %38 = load i8, i8* %37, align 1
  %39 = sext i8 %38 to i32
  %40 = icmp eq i32 %39, 46
  br i1 %40, label %41, label %44

41:                                               ; preds = %33
  %42 = load i32, i32* %7, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, i32* %7, align 4
  br label %44

44:                                               ; preds = %41, %33
  br label %45

45:                                               ; preds = %44
  %46 = load i32, i32* %7, align 4
  %47 = icmp slt i32 %46, 2
  br i1 %47, label %48, label %63

48:                                               ; preds = %45
  %49 = load i8*, i8** %5, align 8
  %50 = load i32, i32* %6, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds i8, i8* %49, i64 %51
  %53 = load i8, i8* %52, align 1
  %54 = sext i8 %53 to i32
  %55 = icmp ne i32 %54, 0
  br i1 %55, label %56, label %63

56:                                               ; preds = %48
  %57 = load i32, i32* %6, align 4
  %58 = sext i32 %57 to i64
  %59 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.2, i64 0, i64 %58
  %60 = load i8, i8* %59, align 1
  %61 = sext i8 %60 to i32
  %62 = icmp ne i32 %61, 0
  br label %63

63:                                               ; preds = %56, %48, %45
  %64 = phi i1 [ false, %48 ], [ false, %45 ], [ %62, %56 ]
  br i1 %64, label %13, label %65, !llvm.loop !8

65:                                               ; preds = %63
  br label %71

66:                                               ; preds = %2
  %67 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %68 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %67, i32 0, i32 16
  %69 = load i32, i32* %68, align 8
  %70 = or i32 %69, 131072
  store i32 %70, i32* %68, align 8
  br label %71

71:                                               ; preds = %66, %65
  %72 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %73 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %72, i32 0, i32 16
  %74 = load i32, i32* %73, align 8
  %75 = and i32 %74, 131072
  %76 = icmp ne i32 %75, 0
  br i1 %76, label %77, label %94

77:                                               ; preds = %71
  store i64 0, i64* %8, align 8
  %78 = getelementptr inbounds [128 x i8], [128 x i8]* %9, i64 0, i64 0
  %79 = load i64, i64* %8, align 8
  %80 = call i64 @png_safecat(i8* noundef %78, i64 noundef 128, i64 noundef %79, i8* noundef getelementptr inbounds ([31 x i8], [31 x i8]* @.str.3, i64 0, i64 0))
  store i64 %80, i64* %8, align 8
  %81 = getelementptr inbounds [128 x i8], [128 x i8]* %9, i64 0, i64 0
  %82 = load i64, i64* %8, align 8
  %83 = load i8*, i8** %5, align 8
  %84 = call i64 @png_safecat(i8* noundef %81, i64 noundef 128, i64 noundef %82, i8* noundef %83)
  store i64 %84, i64* %8, align 8
  %85 = getelementptr inbounds [128 x i8], [128 x i8]* %9, i64 0, i64 0
  %86 = load i64, i64* %8, align 8
  %87 = call i64 @png_safecat(i8* noundef %85, i64 noundef 128, i64 noundef %86, i8* noundef getelementptr inbounds ([19 x i8], [19 x i8]* @.str.4, i64 0, i64 0))
  store i64 %87, i64* %8, align 8
  %88 = getelementptr inbounds [128 x i8], [128 x i8]* %9, i64 0, i64 0
  %89 = load i64, i64* %8, align 8
  %90 = call i64 @png_safecat(i8* noundef %88, i64 noundef 128, i64 noundef %89, i8* noundef getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i64 0, i64 0))
  store i64 %90, i64* %8, align 8
  %91 = load i64, i64* %8, align 8
  %92 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %93 = getelementptr inbounds [128 x i8], [128 x i8]* %9, i64 0, i64 0
  call void @png_warning(%struct.png_struct_def* noundef %92, i8* noundef %93)
  store i32 0, i32* %3, align 4
  br label %95

94:                                               ; preds = %71
  store i32 1, i32* %3, align 4
  br label %95

95:                                               ; preds = %94, %77
  %96 = load i32, i32* %3, align 4
  ret i32 %96
}

declare i64 @png_safecat(i8* noundef, i64 noundef, i64 noundef, i8* noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local noalias %struct.png_struct_def* @png_create_png_struct(i8* noundef %0, i8* noundef %1, void (%struct.png_struct_def*, i8*)* noundef %2, void (%struct.png_struct_def*, i8*)* noundef %3, i8* noundef %4, i8* (%struct.png_struct_def*, i64)* noundef %5, void (%struct.png_struct_def*, i8*)* noundef %6) #0 {
  %8 = alloca %struct.png_struct_def*, align 8
  %9 = alloca i8*, align 8
  %10 = alloca i8*, align 8
  %11 = alloca void (%struct.png_struct_def*, i8*)*, align 8
  %12 = alloca void (%struct.png_struct_def*, i8*)*, align 8
  %13 = alloca i8*, align 8
  %14 = alloca i8* (%struct.png_struct_def*, i64)*, align 8
  %15 = alloca void (%struct.png_struct_def*, i8*)*, align 8
  %16 = alloca %struct.png_struct_def, align 8
  %17 = alloca [1 x %struct.__jmp_buf_tag], align 16
  %18 = alloca %struct.png_struct_def*, align 8
  store i8* %0, i8** %9, align 8
  store i8* %1, i8** %10, align 8
  store void (%struct.png_struct_def*, i8*)* %2, void (%struct.png_struct_def*, i8*)** %11, align 8
  store void (%struct.png_struct_def*, i8*)* %3, void (%struct.png_struct_def*, i8*)** %12, align 8
  store i8* %4, i8** %13, align 8
  store i8* (%struct.png_struct_def*, i64)* %5, i8* (%struct.png_struct_def*, i64)** %14, align 8
  store void (%struct.png_struct_def*, i8*)* %6, void (%struct.png_struct_def*, i8*)** %15, align 8
  %19 = bitcast %struct.png_struct_def* %16 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %19, i8 0, i64 1240, i1 false)
  %20 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %16, i32 0, i32 138
  store i32 1000000, i32* %20, align 4
  %21 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %16, i32 0, i32 139
  store i32 1000000, i32* %21, align 8
  %22 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %16, i32 0, i32 140
  store i32 1000, i32* %22, align 4
  %23 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %16, i32 0, i32 141
  store i64 8000000, i64* %23, align 8
  %24 = load i8*, i8** %13, align 8
  %25 = load i8* (%struct.png_struct_def*, i64)*, i8* (%struct.png_struct_def*, i64)** %14, align 8
  %26 = load void (%struct.png_struct_def*, i8*)*, void (%struct.png_struct_def*, i8*)** %15, align 8
  call void @png_set_mem_fn(%struct.png_struct_def* noundef %16, i8* noundef %24, i8* (%struct.png_struct_def*, i64)* noundef %25, void (%struct.png_struct_def*, i8*)* noundef %26)
  %27 = load i8*, i8** %10, align 8
  %28 = load void (%struct.png_struct_def*, i8*)*, void (%struct.png_struct_def*, i8*)** %11, align 8
  %29 = load void (%struct.png_struct_def*, i8*)*, void (%struct.png_struct_def*, i8*)** %12, align 8
  call void @png_set_error_fn(%struct.png_struct_def* noundef %16, i8* noundef %27, void (%struct.png_struct_def*, i8*)* noundef %28, void (%struct.png_struct_def*, i8*)* noundef %29)
  %30 = getelementptr inbounds [1 x %struct.__jmp_buf_tag], [1 x %struct.__jmp_buf_tag]* %17, i64 0, i64 0
  %31 = call i32 @_setjmp(%struct.__jmp_buf_tag* noundef %30) #12
  %32 = icmp ne i32 %31, 0
  br i1 %32, label %63, label %33

33:                                               ; preds = %7
  %34 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %16, i32 0, i32 2
  store [1 x %struct.__jmp_buf_tag]* %17, [1 x %struct.__jmp_buf_tag]** %34, align 8
  %35 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %16, i32 0, i32 3
  store i64 0, i64* %35, align 8
  %36 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %16, i32 0, i32 1
  store void (%struct.__jmp_buf_tag*, i32)* @longjmp, void (%struct.__jmp_buf_tag*, i32)** %36, align 8
  %37 = load i8*, i8** %9, align 8
  %38 = call i32 @png_user_version_check(%struct.png_struct_def* noundef %16, i8* noundef %37)
  %39 = icmp ne i32 %38, 0
  br i1 %39, label %40, label %62

40:                                               ; preds = %33
  %41 = call noalias i8* @png_malloc_warn(%struct.png_struct_def* noundef %16, i64 noundef 1240)
  %42 = bitcast i8* %41 to %struct.png_struct_def*
  store %struct.png_struct_def* %42, %struct.png_struct_def** %18, align 8
  %43 = load %struct.png_struct_def*, %struct.png_struct_def** %18, align 8
  %44 = icmp ne %struct.png_struct_def* %43, null
  br i1 %44, label %45, label %61

45:                                               ; preds = %40
  %46 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %16, i32 0, i32 19
  %47 = getelementptr inbounds %struct.z_stream_s, %struct.z_stream_s* %46, i32 0, i32 8
  store i8* (i8*, i32, i32)* @png_zalloc, i8* (i8*, i32, i32)** %47, align 8
  %48 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %16, i32 0, i32 19
  %49 = getelementptr inbounds %struct.z_stream_s, %struct.z_stream_s* %48, i32 0, i32 9
  store void (i8*, i8*)* @png_zfree, void (i8*, i8*)** %49, align 8
  %50 = load %struct.png_struct_def*, %struct.png_struct_def** %18, align 8
  %51 = bitcast %struct.png_struct_def* %50 to i8*
  %52 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %16, i32 0, i32 19
  %53 = getelementptr inbounds %struct.z_stream_s, %struct.z_stream_s* %52, i32 0, i32 10
  store i8* %51, i8** %53, align 8
  %54 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %16, i32 0, i32 2
  store [1 x %struct.__jmp_buf_tag]* null, [1 x %struct.__jmp_buf_tag]** %54, align 8
  %55 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %16, i32 0, i32 3
  store i64 0, i64* %55, align 8
  %56 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %16, i32 0, i32 1
  store void (%struct.__jmp_buf_tag*, i32)* null, void (%struct.__jmp_buf_tag*, i32)** %56, align 8
  %57 = load %struct.png_struct_def*, %struct.png_struct_def** %18, align 8
  %58 = bitcast %struct.png_struct_def* %57 to i8*
  %59 = bitcast %struct.png_struct_def* %16 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %58, i8* align 8 %59, i64 1240, i1 false)
  %60 = load %struct.png_struct_def*, %struct.png_struct_def** %18, align 8
  store %struct.png_struct_def* %60, %struct.png_struct_def** %8, align 8
  br label %64

61:                                               ; preds = %40
  br label %62

62:                                               ; preds = %61, %33
  br label %63

63:                                               ; preds = %62, %7
  store %struct.png_struct_def* null, %struct.png_struct_def** %8, align 8
  br label %64

64:                                               ; preds = %63, %45
  %65 = load %struct.png_struct_def*, %struct.png_struct_def** %8, align 8
  ret %struct.png_struct_def* %65
}

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #4

declare void @png_set_mem_fn(%struct.png_struct_def* noundef, i8* noundef, i8* (%struct.png_struct_def*, i64)* noundef, void (%struct.png_struct_def*, i8*)* noundef) #3

declare void @png_set_error_fn(%struct.png_struct_def* noundef, i8* noundef, void (%struct.png_struct_def*, i8*)* noundef, void (%struct.png_struct_def*, i8*)* noundef) #3

; Function Attrs: nounwind returns_twice
declare i32 @_setjmp(%struct.__jmp_buf_tag* noundef) #5

; Function Attrs: noreturn nounwind
declare void @longjmp(%struct.__jmp_buf_tag* noundef, i32 noundef) #6

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #7

; Function Attrs: noinline nounwind optnone uwtable
define dso_local noalias %struct.png_info_def* @png_create_info_struct(%struct.png_struct_def* noalias noundef %0) #0 {
  %2 = alloca %struct.png_info_def*, align 8
  %3 = alloca %struct.png_struct_def*, align 8
  %4 = alloca %struct.png_info_def*, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %3, align 8
  %5 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %6 = icmp eq %struct.png_struct_def* %5, null
  br i1 %6, label %7, label %8

7:                                                ; preds = %1
  store %struct.png_info_def* null, %struct.png_info_def** %2, align 8
  br label %19

8:                                                ; preds = %1
  %9 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %10 = call noalias i8* @png_malloc_base(%struct.png_struct_def* noundef %9, i64 noundef 320)
  %11 = bitcast i8* %10 to %struct.png_info_def*
  store %struct.png_info_def* %11, %struct.png_info_def** %4, align 8
  %12 = load %struct.png_info_def*, %struct.png_info_def** %4, align 8
  %13 = icmp ne %struct.png_info_def* %12, null
  br i1 %13, label %14, label %17

14:                                               ; preds = %8
  %15 = load %struct.png_info_def*, %struct.png_info_def** %4, align 8
  %16 = bitcast %struct.png_info_def* %15 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %16, i8 0, i64 320, i1 false)
  br label %17

17:                                               ; preds = %14, %8
  %18 = load %struct.png_info_def*, %struct.png_info_def** %4, align 8
  store %struct.png_info_def* %18, %struct.png_info_def** %2, align 8
  br label %19

19:                                               ; preds = %17, %7
  %20 = load %struct.png_info_def*, %struct.png_info_def** %2, align 8
  ret %struct.png_info_def* %20
}

declare noalias i8* @png_malloc_base(%struct.png_struct_def* noundef, i64 noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_destroy_info_struct(%struct.png_struct_def* noalias noundef %0, %struct.png_info_def** noundef %1) #0 {
  %3 = alloca %struct.png_struct_def*, align 8
  %4 = alloca %struct.png_info_def**, align 8
  %5 = alloca %struct.png_info_def*, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %3, align 8
  store %struct.png_info_def** %1, %struct.png_info_def*** %4, align 8
  store %struct.png_info_def* null, %struct.png_info_def** %5, align 8
  %6 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %7 = icmp eq %struct.png_struct_def* %6, null
  br i1 %7, label %8, label %9

8:                                                ; preds = %2
  br label %27

9:                                                ; preds = %2
  %10 = load %struct.png_info_def**, %struct.png_info_def*** %4, align 8
  %11 = icmp ne %struct.png_info_def** %10, null
  br i1 %11, label %12, label %15

12:                                               ; preds = %9
  %13 = load %struct.png_info_def**, %struct.png_info_def*** %4, align 8
  %14 = load %struct.png_info_def*, %struct.png_info_def** %13, align 8
  store %struct.png_info_def* %14, %struct.png_info_def** %5, align 8
  br label %15

15:                                               ; preds = %12, %9
  %16 = load %struct.png_info_def*, %struct.png_info_def** %5, align 8
  %17 = icmp ne %struct.png_info_def* %16, null
  br i1 %17, label %18, label %27

18:                                               ; preds = %15
  %19 = load %struct.png_info_def**, %struct.png_info_def*** %4, align 8
  store %struct.png_info_def* null, %struct.png_info_def** %19, align 8
  %20 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %21 = load %struct.png_info_def*, %struct.png_info_def** %5, align 8
  call void @png_free_data(%struct.png_struct_def* noundef %20, %struct.png_info_def* noundef %21, i32 noundef 65535, i32 noundef -1)
  %22 = load %struct.png_info_def*, %struct.png_info_def** %5, align 8
  %23 = bitcast %struct.png_info_def* %22 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %23, i8 0, i64 320, i1 false)
  %24 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %25 = load %struct.png_info_def*, %struct.png_info_def** %5, align 8
  %26 = bitcast %struct.png_info_def* %25 to i8*
  call void @png_free(%struct.png_struct_def* noundef %24, i8* noundef %26)
  br label %27

27:                                               ; preds = %8, %18, %15
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_free_data(%struct.png_struct_def* noalias noundef %0, %struct.png_info_def* noalias noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca %struct.png_struct_def*, align 8
  %6 = alloca %struct.png_info_def*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %5, align 8
  store %struct.png_info_def* %1, %struct.png_info_def** %6, align 8
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  %14 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %15 = icmp eq %struct.png_struct_def* %14, null
  br i1 %15, label %19, label %16

16:                                               ; preds = %4
  %17 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %18 = icmp eq %struct.png_info_def* %17, null
  br i1 %18, label %19, label %20

19:                                               ; preds = %16, %4
  br label %499

20:                                               ; preds = %16
  %21 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %22 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %21, i32 0, i32 21
  %23 = load %struct.png_text_struct*, %struct.png_text_struct** %22, align 8
  %24 = icmp ne %struct.png_text_struct* %23, null
  br i1 %24, label %25, label %86

25:                                               ; preds = %20
  %26 = load i32, i32* %7, align 4
  %27 = and i32 %26, 16384
  %28 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %29 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %28, i32 0, i32 43
  %30 = load i32, i32* %29, align 4
  %31 = and i32 %27, %30
  %32 = icmp ne i32 %31, 0
  br i1 %32, label %33, label %86

33:                                               ; preds = %25
  %34 = load i32, i32* %8, align 4
  %35 = icmp ne i32 %34, -1
  br i1 %35, label %36, label %53

36:                                               ; preds = %33
  %37 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %38 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %39 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %38, i32 0, i32 21
  %40 = load %struct.png_text_struct*, %struct.png_text_struct** %39, align 8
  %41 = load i32, i32* %8, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds %struct.png_text_struct, %struct.png_text_struct* %40, i64 %42
  %44 = getelementptr inbounds %struct.png_text_struct, %struct.png_text_struct* %43, i32 0, i32 1
  %45 = load i8*, i8** %44, align 8
  call void @png_free(%struct.png_struct_def* noundef %37, i8* noundef %45)
  %46 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %47 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %46, i32 0, i32 21
  %48 = load %struct.png_text_struct*, %struct.png_text_struct** %47, align 8
  %49 = load i32, i32* %8, align 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds %struct.png_text_struct, %struct.png_text_struct* %48, i64 %50
  %52 = getelementptr inbounds %struct.png_text_struct, %struct.png_text_struct* %51, i32 0, i32 1
  store i8* null, i8** %52, align 8
  br label %85

53:                                               ; preds = %33
  store i32 0, i32* %9, align 4
  br label %54

54:                                               ; preds = %70, %53
  %55 = load i32, i32* %9, align 4
  %56 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %57 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %56, i32 0, i32 19
  %58 = load i32, i32* %57, align 4
  %59 = icmp slt i32 %55, %58
  br i1 %59, label %60, label %73

60:                                               ; preds = %54
  %61 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %62 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %63 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %62, i32 0, i32 21
  %64 = load %struct.png_text_struct*, %struct.png_text_struct** %63, align 8
  %65 = load i32, i32* %9, align 4
  %66 = sext i32 %65 to i64
  %67 = getelementptr inbounds %struct.png_text_struct, %struct.png_text_struct* %64, i64 %66
  %68 = getelementptr inbounds %struct.png_text_struct, %struct.png_text_struct* %67, i32 0, i32 1
  %69 = load i8*, i8** %68, align 8
  call void @png_free(%struct.png_struct_def* noundef %61, i8* noundef %69)
  br label %70

70:                                               ; preds = %60
  %71 = load i32, i32* %9, align 4
  %72 = add nsw i32 %71, 1
  store i32 %72, i32* %9, align 4
  br label %54, !llvm.loop !9

73:                                               ; preds = %54
  %74 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %75 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %76 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %75, i32 0, i32 21
  %77 = load %struct.png_text_struct*, %struct.png_text_struct** %76, align 8
  %78 = bitcast %struct.png_text_struct* %77 to i8*
  call void @png_free(%struct.png_struct_def* noundef %74, i8* noundef %78)
  %79 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %80 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %79, i32 0, i32 21
  store %struct.png_text_struct* null, %struct.png_text_struct** %80, align 8
  %81 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %82 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %81, i32 0, i32 19
  store i32 0, i32* %82, align 4
  %83 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %84 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %83, i32 0, i32 20
  store i32 0, i32* %84, align 8
  br label %85

85:                                               ; preds = %73, %36
  br label %86

86:                                               ; preds = %85, %25, %20
  %87 = load i32, i32* %7, align 4
  %88 = and i32 %87, 8192
  %89 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %90 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %89, i32 0, i32 43
  %91 = load i32, i32* %90, align 4
  %92 = and i32 %88, %91
  %93 = icmp ne i32 %92, 0
  br i1 %93, label %94, label %107

94:                                               ; preds = %86
  %95 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %96 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %95, i32 0, i32 2
  %97 = load i32, i32* %96, align 8
  %98 = and i32 %97, -17
  store i32 %98, i32* %96, align 8
  %99 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %100 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %101 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %100, i32 0, i32 24
  %102 = load i8*, i8** %101, align 8
  call void @png_free(%struct.png_struct_def* noundef %99, i8* noundef %102)
  %103 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %104 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %103, i32 0, i32 24
  store i8* null, i8** %104, align 8
  %105 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %106 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %105, i32 0, i32 6
  store i16 0, i16* %106, align 2
  br label %107

107:                                              ; preds = %94, %86
  %108 = load i32, i32* %7, align 4
  %109 = and i32 %108, 256
  %110 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %111 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %110, i32 0, i32 43
  %112 = load i32, i32* %111, align 4
  %113 = and i32 %109, %112
  %114 = icmp ne i32 %113, 0
  br i1 %114, label %115, label %132

115:                                              ; preds = %107
  %116 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %117 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %118 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %117, i32 0, i32 49
  %119 = load i8*, i8** %118, align 8
  call void @png_free(%struct.png_struct_def* noundef %116, i8* noundef %119)
  %120 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %121 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %122 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %121, i32 0, i32 50
  %123 = load i8*, i8** %122, align 8
  call void @png_free(%struct.png_struct_def* noundef %120, i8* noundef %123)
  %124 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %125 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %124, i32 0, i32 49
  store i8* null, i8** %125, align 8
  %126 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %127 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %126, i32 0, i32 50
  store i8* null, i8** %127, align 8
  %128 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %129 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %128, i32 0, i32 2
  %130 = load i32, i32* %129, align 8
  %131 = and i32 %130, -16385
  store i32 %131, i32* %129, align 8
  br label %132

132:                                              ; preds = %115, %107
  %133 = load i32, i32* %7, align 4
  %134 = and i32 %133, 128
  %135 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %136 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %135, i32 0, i32 43
  %137 = load i32, i32* %136, align 4
  %138 = and i32 %134, %137
  %139 = icmp ne i32 %138, 0
  br i1 %139, label %140, label %190

140:                                              ; preds = %132
  %141 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %142 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %143 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %142, i32 0, i32 36
  %144 = load i8*, i8** %143, align 8
  call void @png_free(%struct.png_struct_def* noundef %141, i8* noundef %144)
  %145 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %146 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %147 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %146, i32 0, i32 39
  %148 = load i8*, i8** %147, align 8
  call void @png_free(%struct.png_struct_def* noundef %145, i8* noundef %148)
  %149 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %150 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %149, i32 0, i32 36
  store i8* null, i8** %150, align 8
  %151 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %152 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %151, i32 0, i32 39
  store i8* null, i8** %152, align 8
  %153 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %154 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %153, i32 0, i32 40
  %155 = load i8**, i8*** %154, align 8
  %156 = icmp ne i8** %155, null
  br i1 %156, label %157, label %185

157:                                              ; preds = %140
  store i32 0, i32* %10, align 4
  br label %158

158:                                              ; preds = %174, %157
  %159 = load i32, i32* %10, align 4
  %160 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %161 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %160, i32 0, i32 42
  %162 = load i8, i8* %161, align 1
  %163 = zext i8 %162 to i32
  %164 = icmp slt i32 %159, %163
  br i1 %164, label %165, label %177

165:                                              ; preds = %158
  %166 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %167 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %168 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %167, i32 0, i32 40
  %169 = load i8**, i8*** %168, align 8
  %170 = load i32, i32* %10, align 4
  %171 = sext i32 %170 to i64
  %172 = getelementptr inbounds i8*, i8** %169, i64 %171
  %173 = load i8*, i8** %172, align 8
  call void @png_free(%struct.png_struct_def* noundef %166, i8* noundef %173)
  br label %174

174:                                              ; preds = %165
  %175 = load i32, i32* %10, align 4
  %176 = add nsw i32 %175, 1
  store i32 %176, i32* %10, align 4
  br label %158, !llvm.loop !10

177:                                              ; preds = %158
  %178 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %179 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %180 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %179, i32 0, i32 40
  %181 = load i8**, i8*** %180, align 8
  %182 = bitcast i8** %181 to i8*
  call void @png_free(%struct.png_struct_def* noundef %178, i8* noundef %182)
  %183 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %184 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %183, i32 0, i32 40
  store i8** null, i8*** %184, align 8
  br label %185

185:                                              ; preds = %177, %140
  %186 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %187 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %186, i32 0, i32 2
  %188 = load i32, i32* %187, align 8
  %189 = and i32 %188, -1025
  store i32 %189, i32* %187, align 8
  br label %190

190:                                              ; preds = %185, %132
  %191 = load i32, i32* %7, align 4
  %192 = and i32 %191, 16
  %193 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %194 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %193, i32 0, i32 43
  %195 = load i32, i32* %194, align 4
  %196 = and i32 %192, %195
  %197 = icmp ne i32 %196, 0
  br i1 %197, label %198, label %215

198:                                              ; preds = %190
  %199 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %200 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %201 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %200, i32 0, i32 16
  %202 = load i8*, i8** %201, align 8
  call void @png_free(%struct.png_struct_def* noundef %199, i8* noundef %202)
  %203 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %204 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %205 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %204, i32 0, i32 17
  %206 = load i8*, i8** %205, align 8
  call void @png_free(%struct.png_struct_def* noundef %203, i8* noundef %206)
  %207 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %208 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %207, i32 0, i32 16
  store i8* null, i8** %208, align 8
  %209 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %210 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %209, i32 0, i32 17
  store i8* null, i8** %210, align 8
  %211 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %212 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %211, i32 0, i32 2
  %213 = load i32, i32* %212, align 8
  %214 = and i32 %213, -4097
  store i32 %214, i32* %212, align 8
  br label %215

215:                                              ; preds = %198, %190
  %216 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %217 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %216, i32 0, i32 46
  %218 = load %struct.png_sPLT_struct*, %struct.png_sPLT_struct** %217, align 8
  %219 = icmp ne %struct.png_sPLT_struct* %218, null
  br i1 %219, label %220, label %310

220:                                              ; preds = %215
  %221 = load i32, i32* %7, align 4
  %222 = and i32 %221, 32
  %223 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %224 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %223, i32 0, i32 43
  %225 = load i32, i32* %224, align 4
  %226 = and i32 %222, %225
  %227 = icmp ne i32 %226, 0
  br i1 %227, label %228, label %310

228:                                              ; preds = %220
  %229 = load i32, i32* %8, align 4
  %230 = icmp ne i32 %229, -1
  br i1 %230, label %231, label %265

231:                                              ; preds = %228
  %232 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %233 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %234 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %233, i32 0, i32 46
  %235 = load %struct.png_sPLT_struct*, %struct.png_sPLT_struct** %234, align 8
  %236 = load i32, i32* %8, align 4
  %237 = sext i32 %236 to i64
  %238 = getelementptr inbounds %struct.png_sPLT_struct, %struct.png_sPLT_struct* %235, i64 %237
  %239 = getelementptr inbounds %struct.png_sPLT_struct, %struct.png_sPLT_struct* %238, i32 0, i32 0
  %240 = load i8*, i8** %239, align 8
  call void @png_free(%struct.png_struct_def* noundef %232, i8* noundef %240)
  %241 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %242 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %243 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %242, i32 0, i32 46
  %244 = load %struct.png_sPLT_struct*, %struct.png_sPLT_struct** %243, align 8
  %245 = load i32, i32* %8, align 4
  %246 = sext i32 %245 to i64
  %247 = getelementptr inbounds %struct.png_sPLT_struct, %struct.png_sPLT_struct* %244, i64 %246
  %248 = getelementptr inbounds %struct.png_sPLT_struct, %struct.png_sPLT_struct* %247, i32 0, i32 2
  %249 = load %struct.png_sPLT_entry_struct*, %struct.png_sPLT_entry_struct** %248, align 8
  %250 = bitcast %struct.png_sPLT_entry_struct* %249 to i8*
  call void @png_free(%struct.png_struct_def* noundef %241, i8* noundef %250)
  %251 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %252 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %251, i32 0, i32 46
  %253 = load %struct.png_sPLT_struct*, %struct.png_sPLT_struct** %252, align 8
  %254 = load i32, i32* %8, align 4
  %255 = sext i32 %254 to i64
  %256 = getelementptr inbounds %struct.png_sPLT_struct, %struct.png_sPLT_struct* %253, i64 %255
  %257 = getelementptr inbounds %struct.png_sPLT_struct, %struct.png_sPLT_struct* %256, i32 0, i32 0
  store i8* null, i8** %257, align 8
  %258 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %259 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %258, i32 0, i32 46
  %260 = load %struct.png_sPLT_struct*, %struct.png_sPLT_struct** %259, align 8
  %261 = load i32, i32* %8, align 4
  %262 = sext i32 %261 to i64
  %263 = getelementptr inbounds %struct.png_sPLT_struct, %struct.png_sPLT_struct* %260, i64 %262
  %264 = getelementptr inbounds %struct.png_sPLT_struct, %struct.png_sPLT_struct* %263, i32 0, i32 2
  store %struct.png_sPLT_entry_struct* null, %struct.png_sPLT_entry_struct** %264, align 8
  br label %309

265:                                              ; preds = %228
  store i32 0, i32* %11, align 4
  br label %266

266:                                              ; preds = %292, %265
  %267 = load i32, i32* %11, align 4
  %268 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %269 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %268, i32 0, i32 47
  %270 = load i32, i32* %269, align 8
  %271 = icmp slt i32 %267, %270
  br i1 %271, label %272, label %295

272:                                              ; preds = %266
  %273 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %274 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %275 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %274, i32 0, i32 46
  %276 = load %struct.png_sPLT_struct*, %struct.png_sPLT_struct** %275, align 8
  %277 = load i32, i32* %11, align 4
  %278 = sext i32 %277 to i64
  %279 = getelementptr inbounds %struct.png_sPLT_struct, %struct.png_sPLT_struct* %276, i64 %278
  %280 = getelementptr inbounds %struct.png_sPLT_struct, %struct.png_sPLT_struct* %279, i32 0, i32 0
  %281 = load i8*, i8** %280, align 8
  call void @png_free(%struct.png_struct_def* noundef %273, i8* noundef %281)
  %282 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %283 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %284 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %283, i32 0, i32 46
  %285 = load %struct.png_sPLT_struct*, %struct.png_sPLT_struct** %284, align 8
  %286 = load i32, i32* %11, align 4
  %287 = sext i32 %286 to i64
  %288 = getelementptr inbounds %struct.png_sPLT_struct, %struct.png_sPLT_struct* %285, i64 %287
  %289 = getelementptr inbounds %struct.png_sPLT_struct, %struct.png_sPLT_struct* %288, i32 0, i32 2
  %290 = load %struct.png_sPLT_entry_struct*, %struct.png_sPLT_entry_struct** %289, align 8
  %291 = bitcast %struct.png_sPLT_entry_struct* %290 to i8*
  call void @png_free(%struct.png_struct_def* noundef %282, i8* noundef %291)
  br label %292

292:                                              ; preds = %272
  %293 = load i32, i32* %11, align 4
  %294 = add nsw i32 %293, 1
  store i32 %294, i32* %11, align 4
  br label %266, !llvm.loop !11

295:                                              ; preds = %266
  %296 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %297 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %298 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %297, i32 0, i32 46
  %299 = load %struct.png_sPLT_struct*, %struct.png_sPLT_struct** %298, align 8
  %300 = bitcast %struct.png_sPLT_struct* %299 to i8*
  call void @png_free(%struct.png_struct_def* noundef %296, i8* noundef %300)
  %301 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %302 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %301, i32 0, i32 46
  store %struct.png_sPLT_struct* null, %struct.png_sPLT_struct** %302, align 8
  %303 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %304 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %303, i32 0, i32 47
  store i32 0, i32* %304, align 8
  %305 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %306 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %305, i32 0, i32 2
  %307 = load i32, i32* %306, align 8
  %308 = and i32 %307, -8193
  store i32 %308, i32* %306, align 8
  br label %309

309:                                              ; preds = %295, %231
  br label %310

310:                                              ; preds = %309, %220, %215
  %311 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %312 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %311, i32 0, i32 44
  %313 = load %struct.png_unknown_chunk_t*, %struct.png_unknown_chunk_t** %312, align 8
  %314 = icmp ne %struct.png_unknown_chunk_t* %313, null
  br i1 %314, label %315, label %374

315:                                              ; preds = %310
  %316 = load i32, i32* %7, align 4
  %317 = and i32 %316, 512
  %318 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %319 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %318, i32 0, i32 43
  %320 = load i32, i32* %319, align 4
  %321 = and i32 %317, %320
  %322 = icmp ne i32 %321, 0
  br i1 %322, label %323, label %374

323:                                              ; preds = %315
  %324 = load i32, i32* %8, align 4
  %325 = icmp ne i32 %324, -1
  br i1 %325, label %326, label %343

326:                                              ; preds = %323
  %327 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %328 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %329 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %328, i32 0, i32 44
  %330 = load %struct.png_unknown_chunk_t*, %struct.png_unknown_chunk_t** %329, align 8
  %331 = load i32, i32* %8, align 4
  %332 = sext i32 %331 to i64
  %333 = getelementptr inbounds %struct.png_unknown_chunk_t, %struct.png_unknown_chunk_t* %330, i64 %332
  %334 = getelementptr inbounds %struct.png_unknown_chunk_t, %struct.png_unknown_chunk_t* %333, i32 0, i32 1
  %335 = load i8*, i8** %334, align 8
  call void @png_free(%struct.png_struct_def* noundef %327, i8* noundef %335)
  %336 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %337 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %336, i32 0, i32 44
  %338 = load %struct.png_unknown_chunk_t*, %struct.png_unknown_chunk_t** %337, align 8
  %339 = load i32, i32* %8, align 4
  %340 = sext i32 %339 to i64
  %341 = getelementptr inbounds %struct.png_unknown_chunk_t, %struct.png_unknown_chunk_t* %338, i64 %340
  %342 = getelementptr inbounds %struct.png_unknown_chunk_t, %struct.png_unknown_chunk_t* %341, i32 0, i32 1
  store i8* null, i8** %342, align 8
  br label %373

343:                                              ; preds = %323
  store i32 0, i32* %12, align 4
  br label %344

344:                                              ; preds = %360, %343
  %345 = load i32, i32* %12, align 4
  %346 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %347 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %346, i32 0, i32 45
  %348 = load i32, i32* %347, align 8
  %349 = icmp slt i32 %345, %348
  br i1 %349, label %350, label %363

350:                                              ; preds = %344
  %351 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %352 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %353 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %352, i32 0, i32 44
  %354 = load %struct.png_unknown_chunk_t*, %struct.png_unknown_chunk_t** %353, align 8
  %355 = load i32, i32* %12, align 4
  %356 = sext i32 %355 to i64
  %357 = getelementptr inbounds %struct.png_unknown_chunk_t, %struct.png_unknown_chunk_t* %354, i64 %356
  %358 = getelementptr inbounds %struct.png_unknown_chunk_t, %struct.png_unknown_chunk_t* %357, i32 0, i32 1
  %359 = load i8*, i8** %358, align 8
  call void @png_free(%struct.png_struct_def* noundef %351, i8* noundef %359)
  br label %360

360:                                              ; preds = %350
  %361 = load i32, i32* %12, align 4
  %362 = add nsw i32 %361, 1
  store i32 %362, i32* %12, align 4
  br label %344, !llvm.loop !12

363:                                              ; preds = %344
  %364 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %365 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %366 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %365, i32 0, i32 44
  %367 = load %struct.png_unknown_chunk_t*, %struct.png_unknown_chunk_t** %366, align 8
  %368 = bitcast %struct.png_unknown_chunk_t* %367 to i8*
  call void @png_free(%struct.png_struct_def* noundef %364, i8* noundef %368)
  %369 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %370 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %369, i32 0, i32 44
  store %struct.png_unknown_chunk_t* null, %struct.png_unknown_chunk_t** %370, align 8
  %371 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %372 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %371, i32 0, i32 45
  store i32 0, i32* %372, align 8
  br label %373

373:                                              ; preds = %363, %326
  br label %374

374:                                              ; preds = %373, %315, %310
  %375 = load i32, i32* %7, align 4
  %376 = and i32 %375, 32768
  %377 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %378 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %377, i32 0, i32 43
  %379 = load i32, i32* %378, align 4
  %380 = and i32 %376, %379
  %381 = icmp ne i32 %380, 0
  br i1 %381, label %382, label %399

382:                                              ; preds = %374
  %383 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %384 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %383, i32 0, i32 34
  %385 = load i8*, i8** %384, align 8
  %386 = icmp ne i8* %385, null
  br i1 %386, label %387, label %394

387:                                              ; preds = %382
  %388 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %389 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %390 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %389, i32 0, i32 34
  %391 = load i8*, i8** %390, align 8
  call void @png_free(%struct.png_struct_def* noundef %388, i8* noundef %391)
  %392 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %393 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %392, i32 0, i32 34
  store i8* null, i8** %393, align 8
  br label %394

394:                                              ; preds = %387, %382
  %395 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %396 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %395, i32 0, i32 2
  %397 = load i32, i32* %396, align 8
  %398 = and i32 %397, -65537
  store i32 %398, i32* %396, align 8
  br label %399

399:                                              ; preds = %394, %374
  %400 = load i32, i32* %7, align 4
  %401 = and i32 %400, 8
  %402 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %403 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %402, i32 0, i32 43
  %404 = load i32, i32* %403, align 4
  %405 = and i32 %401, %404
  %406 = icmp ne i32 %405, 0
  br i1 %406, label %407, label %419

407:                                              ; preds = %399
  %408 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %409 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %410 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %409, i32 0, i32 35
  %411 = load i16*, i16** %410, align 8
  %412 = bitcast i16* %411 to i8*
  call void @png_free(%struct.png_struct_def* noundef %408, i8* noundef %412)
  %413 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %414 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %413, i32 0, i32 35
  store i16* null, i16** %414, align 8
  %415 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %416 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %415, i32 0, i32 2
  %417 = load i32, i32* %416, align 8
  %418 = and i32 %417, -65
  store i32 %418, i32* %416, align 8
  br label %419

419:                                              ; preds = %407, %399
  %420 = load i32, i32* %7, align 4
  %421 = and i32 %420, 4096
  %422 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %423 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %422, i32 0, i32 43
  %424 = load i32, i32* %423, align 4
  %425 = and i32 %421, %424
  %426 = icmp ne i32 %425, 0
  br i1 %426, label %427, label %441

427:                                              ; preds = %419
  %428 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %429 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %430 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %429, i32 0, i32 4
  %431 = load %struct.png_color_struct*, %struct.png_color_struct** %430, align 8
  %432 = bitcast %struct.png_color_struct* %431 to i8*
  call void @png_free(%struct.png_struct_def* noundef %428, i8* noundef %432)
  %433 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %434 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %433, i32 0, i32 4
  store %struct.png_color_struct* null, %struct.png_color_struct** %434, align 8
  %435 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %436 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %435, i32 0, i32 2
  %437 = load i32, i32* %436, align 8
  %438 = and i32 %437, -9
  store i32 %438, i32* %436, align 8
  %439 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %440 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %439, i32 0, i32 5
  store i16 0, i16* %440, align 8
  br label %441

441:                                              ; preds = %427, %419
  %442 = load i32, i32* %7, align 4
  %443 = and i32 %442, 64
  %444 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %445 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %444, i32 0, i32 43
  %446 = load i32, i32* %445, align 4
  %447 = and i32 %443, %446
  %448 = icmp ne i32 %447, 0
  br i1 %448, label %449, label %486

449:                                              ; preds = %441
  %450 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %451 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %450, i32 0, i32 51
  %452 = load i8**, i8*** %451, align 8
  %453 = icmp ne i8** %452, null
  br i1 %453, label %454, label %481

454:                                              ; preds = %449
  store i32 0, i32* %13, align 4
  br label %455

455:                                              ; preds = %470, %454
  %456 = load i32, i32* %13, align 4
  %457 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %458 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %457, i32 0, i32 1
  %459 = load i32, i32* %458, align 4
  %460 = icmp ult i32 %456, %459
  br i1 %460, label %461, label %473

461:                                              ; preds = %455
  %462 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %463 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %464 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %463, i32 0, i32 51
  %465 = load i8**, i8*** %464, align 8
  %466 = load i32, i32* %13, align 4
  %467 = zext i32 %466 to i64
  %468 = getelementptr inbounds i8*, i8** %465, i64 %467
  %469 = load i8*, i8** %468, align 8
  call void @png_free(%struct.png_struct_def* noundef %462, i8* noundef %469)
  br label %470

470:                                              ; preds = %461
  %471 = load i32, i32* %13, align 4
  %472 = add i32 %471, 1
  store i32 %472, i32* %13, align 4
  br label %455, !llvm.loop !13

473:                                              ; preds = %455
  %474 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %475 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %476 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %475, i32 0, i32 51
  %477 = load i8**, i8*** %476, align 8
  %478 = bitcast i8** %477 to i8*
  call void @png_free(%struct.png_struct_def* noundef %474, i8* noundef %478)
  %479 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %480 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %479, i32 0, i32 51
  store i8** null, i8*** %480, align 8
  br label %481

481:                                              ; preds = %473, %449
  %482 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %483 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %482, i32 0, i32 2
  %484 = load i32, i32* %483, align 8
  %485 = and i32 %484, -32769
  store i32 %485, i32* %483, align 8
  br label %486

486:                                              ; preds = %481, %441
  %487 = load i32, i32* %8, align 4
  %488 = icmp ne i32 %487, -1
  br i1 %488, label %489, label %492

489:                                              ; preds = %486
  %490 = load i32, i32* %7, align 4
  %491 = and i32 %490, -16929
  store i32 %491, i32* %7, align 4
  br label %492

492:                                              ; preds = %489, %486
  %493 = load i32, i32* %7, align 4
  %494 = xor i32 %493, -1
  %495 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %496 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %495, i32 0, i32 43
  %497 = load i32, i32* %496, align 4
  %498 = and i32 %497, %494
  store i32 %498, i32* %496, align 4
  br label %499

499:                                              ; preds = %492, %19
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_info_init_3(%struct.png_info_def** noundef %0, i64 noundef %1) #0 {
  %3 = alloca %struct.png_info_def**, align 8
  %4 = alloca i64, align 8
  %5 = alloca %struct.png_info_def*, align 8
  store %struct.png_info_def** %0, %struct.png_info_def*** %3, align 8
  store i64 %1, i64* %4, align 8
  %6 = load %struct.png_info_def**, %struct.png_info_def*** %3, align 8
  %7 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  store %struct.png_info_def* %7, %struct.png_info_def** %5, align 8
  %8 = load %struct.png_info_def*, %struct.png_info_def** %5, align 8
  %9 = icmp eq %struct.png_info_def* %8, null
  br i1 %9, label %10, label %11

10:                                               ; preds = %2
  br label %29

11:                                               ; preds = %2
  %12 = load i64, i64* %4, align 8
  %13 = icmp ugt i64 320, %12
  br i1 %13, label %14, label %26

14:                                               ; preds = %11
  %15 = load %struct.png_info_def**, %struct.png_info_def*** %3, align 8
  store %struct.png_info_def* null, %struct.png_info_def** %15, align 8
  %16 = load %struct.png_info_def*, %struct.png_info_def** %5, align 8
  %17 = bitcast %struct.png_info_def* %16 to i8*
  call void @free(i8* noundef %17) #13
  %18 = call noalias i8* @png_malloc_base(%struct.png_struct_def* noundef null, i64 noundef 320)
  %19 = bitcast i8* %18 to %struct.png_info_def*
  store %struct.png_info_def* %19, %struct.png_info_def** %5, align 8
  %20 = load %struct.png_info_def*, %struct.png_info_def** %5, align 8
  %21 = icmp eq %struct.png_info_def* %20, null
  br i1 %21, label %22, label %23

22:                                               ; preds = %14
  br label %29

23:                                               ; preds = %14
  %24 = load %struct.png_info_def*, %struct.png_info_def** %5, align 8
  %25 = load %struct.png_info_def**, %struct.png_info_def*** %3, align 8
  store %struct.png_info_def* %24, %struct.png_info_def** %25, align 8
  br label %26

26:                                               ; preds = %23, %11
  %27 = load %struct.png_info_def*, %struct.png_info_def** %5, align 8
  %28 = bitcast %struct.png_info_def* %27 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %28, i8 0, i64 320, i1 false)
  br label %29

29:                                               ; preds = %26, %22, %10
  ret void
}

; Function Attrs: nounwind
declare void @free(i8* noundef) #8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_data_freer(%struct.png_struct_def* noalias noundef %0, %struct.png_info_def* noalias noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca %struct.png_struct_def*, align 8
  %6 = alloca %struct.png_info_def*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %5, align 8
  store %struct.png_info_def* %1, %struct.png_info_def** %6, align 8
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  %9 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %10 = icmp eq %struct.png_struct_def* %9, null
  br i1 %10, label %14, label %11

11:                                               ; preds = %4
  %12 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %13 = icmp eq %struct.png_info_def* %12, null
  br i1 %13, label %14, label %15

14:                                               ; preds = %11, %4
  br label %37

15:                                               ; preds = %11
  %16 = load i32, i32* %7, align 4
  %17 = icmp eq i32 %16, 1
  br i1 %17, label %18, label %24

18:                                               ; preds = %15
  %19 = load i32, i32* %8, align 4
  %20 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %21 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %20, i32 0, i32 43
  %22 = load i32, i32* %21, align 4
  %23 = or i32 %22, %19
  store i32 %23, i32* %21, align 4
  br label %37

24:                                               ; preds = %15
  %25 = load i32, i32* %7, align 4
  %26 = icmp eq i32 %25, 2
  br i1 %26, label %27, label %34

27:                                               ; preds = %24
  %28 = load i32, i32* %8, align 4
  %29 = xor i32 %28, -1
  %30 = load %struct.png_info_def*, %struct.png_info_def** %6, align 8
  %31 = getelementptr inbounds %struct.png_info_def, %struct.png_info_def* %30, i32 0, i32 43
  %32 = load i32, i32* %31, align 4
  %33 = and i32 %32, %29
  store i32 %33, i32* %31, align 4
  br label %36

34:                                               ; preds = %24
  %35 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  call void @png_error(%struct.png_struct_def* noundef %35, i8* noundef getelementptr inbounds ([42 x i8], [42 x i8]* @.str.5, i64 0, i64 0)) #10
  unreachable

36:                                               ; preds = %27
  br label %37

37:                                               ; preds = %14, %36, %18
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @png_get_io_ptr(%struct.png_struct_def* noalias noundef %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca %struct.png_struct_def*, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %3, align 8
  %4 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %5 = icmp eq %struct.png_struct_def* %4, null
  br i1 %5, label %6, label %7

6:                                                ; preds = %1
  store i8* null, i8** %2, align 8
  br label %11

7:                                                ; preds = %1
  %8 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %9 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %8, i32 0, i32 9
  %10 = load i8*, i8** %9, align 8
  store i8* %10, i8** %2, align 8
  br label %11

11:                                               ; preds = %7, %6
  %12 = load i8*, i8** %2, align 8
  ret i8* %12
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_init_io(%struct.png_struct_def* noalias noundef %0, %struct._IO_FILE* noundef %1) #0 {
  %3 = alloca %struct.png_struct_def*, align 8
  %4 = alloca %struct._IO_FILE*, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %3, align 8
  store %struct._IO_FILE* %1, %struct._IO_FILE** %4, align 8
  %5 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %6 = icmp eq %struct.png_struct_def* %5, null
  br i1 %6, label %7, label %8

7:                                                ; preds = %2
  br label %13

8:                                                ; preds = %2
  %9 = load %struct._IO_FILE*, %struct._IO_FILE** %4, align 8
  %10 = bitcast %struct._IO_FILE* %9 to i8*
  %11 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %12 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %11, i32 0, i32 9
  store i8* %10, i8** %12, align 8
  br label %13

13:                                               ; preds = %8, %7
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_save_int_32(i8* noundef %0, i32 noundef %1) #0 {
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i8*, i8** %3, align 8
  %6 = load i32, i32* %4, align 4
  call void @png_save_uint_32(i8* noundef %5, i32 noundef %6)
  ret void
}

declare void @png_save_uint_32(i8* noundef, i32 noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_convert_to_rfc1123_buffer(i8* noundef %0, %struct.png_time_struct* noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i8*, align 8
  %5 = alloca %struct.png_time_struct*, align 8
  %6 = alloca i64, align 8
  %7 = alloca [5 x i8], align 1
  store i8* %0, i8** %4, align 8
  store %struct.png_time_struct* %1, %struct.png_time_struct** %5, align 8
  %8 = load i8*, i8** %4, align 8
  %9 = icmp eq i8* %8, null
  br i1 %9, label %10, label %11

10:                                               ; preds = %2
  store i32 0, i32* %3, align 4
  br label %176

11:                                               ; preds = %2
  %12 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %13 = getelementptr inbounds %struct.png_time_struct, %struct.png_time_struct* %12, i32 0, i32 0
  %14 = load i16, i16* %13, align 2
  %15 = zext i16 %14 to i32
  %16 = icmp sgt i32 %15, 9999
  br i1 %16, label %59, label %17

17:                                               ; preds = %11
  %18 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %19 = getelementptr inbounds %struct.png_time_struct, %struct.png_time_struct* %18, i32 0, i32 1
  %20 = load i8, i8* %19, align 2
  %21 = zext i8 %20 to i32
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %59, label %23

23:                                               ; preds = %17
  %24 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %25 = getelementptr inbounds %struct.png_time_struct, %struct.png_time_struct* %24, i32 0, i32 1
  %26 = load i8, i8* %25, align 2
  %27 = zext i8 %26 to i32
  %28 = icmp sgt i32 %27, 12
  br i1 %28, label %59, label %29

29:                                               ; preds = %23
  %30 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %31 = getelementptr inbounds %struct.png_time_struct, %struct.png_time_struct* %30, i32 0, i32 2
  %32 = load i8, i8* %31, align 1
  %33 = zext i8 %32 to i32
  %34 = icmp eq i32 %33, 0
  br i1 %34, label %59, label %35

35:                                               ; preds = %29
  %36 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %37 = getelementptr inbounds %struct.png_time_struct, %struct.png_time_struct* %36, i32 0, i32 2
  %38 = load i8, i8* %37, align 1
  %39 = zext i8 %38 to i32
  %40 = icmp sgt i32 %39, 31
  br i1 %40, label %59, label %41

41:                                               ; preds = %35
  %42 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %43 = getelementptr inbounds %struct.png_time_struct, %struct.png_time_struct* %42, i32 0, i32 3
  %44 = load i8, i8* %43, align 2
  %45 = zext i8 %44 to i32
  %46 = icmp sgt i32 %45, 23
  br i1 %46, label %59, label %47

47:                                               ; preds = %41
  %48 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %49 = getelementptr inbounds %struct.png_time_struct, %struct.png_time_struct* %48, i32 0, i32 4
  %50 = load i8, i8* %49, align 1
  %51 = zext i8 %50 to i32
  %52 = icmp sgt i32 %51, 59
  br i1 %52, label %59, label %53

53:                                               ; preds = %47
  %54 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %55 = getelementptr inbounds %struct.png_time_struct, %struct.png_time_struct* %54, i32 0, i32 5
  %56 = load i8, i8* %55, align 2
  %57 = zext i8 %56 to i32
  %58 = icmp sgt i32 %57, 60
  br i1 %58, label %59, label %60

59:                                               ; preds = %53, %47, %41, %35, %29, %23, %17, %11
  store i32 0, i32* %3, align 4
  br label %176

60:                                               ; preds = %53
  store i64 0, i64* %6, align 8
  %61 = bitcast [5 x i8]* %7 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %61, i8 0, i64 5, i1 false)
  %62 = load i8*, i8** %4, align 8
  %63 = load i64, i64* %6, align 8
  %64 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i64 0, i64 0
  %65 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i64 0, i64 0
  %66 = getelementptr inbounds i8, i8* %65, i64 5
  %67 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %68 = getelementptr inbounds %struct.png_time_struct, %struct.png_time_struct* %67, i32 0, i32 2
  %69 = load i8, i8* %68, align 1
  %70 = zext i8 %69 to i32
  %71 = zext i32 %70 to i64
  %72 = call i8* @png_format_number(i8* noundef %64, i8* noundef %66, i32 noundef 1, i64 noundef %71)
  %73 = call i64 @png_safecat(i8* noundef %62, i64 noundef 29, i64 noundef %63, i8* noundef %72)
  store i64 %73, i64* %6, align 8
  %74 = load i64, i64* %6, align 8
  %75 = icmp ult i64 %74, 28
  br i1 %75, label %76, label %81

76:                                               ; preds = %60
  %77 = load i8*, i8** %4, align 8
  %78 = load i64, i64* %6, align 8
  %79 = add i64 %78, 1
  store i64 %79, i64* %6, align 8
  %80 = getelementptr inbounds i8, i8* %77, i64 %78
  store i8 32, i8* %80, align 1
  br label %81

81:                                               ; preds = %76, %60
  %82 = load i8*, i8** %4, align 8
  %83 = load i64, i64* %6, align 8
  %84 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %85 = getelementptr inbounds %struct.png_time_struct, %struct.png_time_struct* %84, i32 0, i32 1
  %86 = load i8, i8* %85, align 2
  %87 = zext i8 %86 to i32
  %88 = sub nsw i32 %87, 1
  %89 = sext i32 %88 to i64
  %90 = getelementptr inbounds [12 x [4 x i8]], [12 x [4 x i8]]* @png_convert_to_rfc1123_buffer.short_months, i64 0, i64 %89
  %91 = getelementptr inbounds [4 x i8], [4 x i8]* %90, i64 0, i64 0
  %92 = call i64 @png_safecat(i8* noundef %82, i64 noundef 29, i64 noundef %83, i8* noundef %91)
  store i64 %92, i64* %6, align 8
  %93 = load i64, i64* %6, align 8
  %94 = icmp ult i64 %93, 28
  br i1 %94, label %95, label %100

95:                                               ; preds = %81
  %96 = load i8*, i8** %4, align 8
  %97 = load i64, i64* %6, align 8
  %98 = add i64 %97, 1
  store i64 %98, i64* %6, align 8
  %99 = getelementptr inbounds i8, i8* %96, i64 %97
  store i8 32, i8* %99, align 1
  br label %100

100:                                              ; preds = %95, %81
  %101 = load i8*, i8** %4, align 8
  %102 = load i64, i64* %6, align 8
  %103 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i64 0, i64 0
  %104 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i64 0, i64 0
  %105 = getelementptr inbounds i8, i8* %104, i64 5
  %106 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %107 = getelementptr inbounds %struct.png_time_struct, %struct.png_time_struct* %106, i32 0, i32 0
  %108 = load i16, i16* %107, align 2
  %109 = zext i16 %108 to i64
  %110 = call i8* @png_format_number(i8* noundef %103, i8* noundef %105, i32 noundef 1, i64 noundef %109)
  %111 = call i64 @png_safecat(i8* noundef %101, i64 noundef 29, i64 noundef %102, i8* noundef %110)
  store i64 %111, i64* %6, align 8
  %112 = load i64, i64* %6, align 8
  %113 = icmp ult i64 %112, 28
  br i1 %113, label %114, label %119

114:                                              ; preds = %100
  %115 = load i8*, i8** %4, align 8
  %116 = load i64, i64* %6, align 8
  %117 = add i64 %116, 1
  store i64 %117, i64* %6, align 8
  %118 = getelementptr inbounds i8, i8* %115, i64 %116
  store i8 32, i8* %118, align 1
  br label %119

119:                                              ; preds = %114, %100
  %120 = load i8*, i8** %4, align 8
  %121 = load i64, i64* %6, align 8
  %122 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i64 0, i64 0
  %123 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i64 0, i64 0
  %124 = getelementptr inbounds i8, i8* %123, i64 5
  %125 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %126 = getelementptr inbounds %struct.png_time_struct, %struct.png_time_struct* %125, i32 0, i32 3
  %127 = load i8, i8* %126, align 2
  %128 = zext i8 %127 to i32
  %129 = zext i32 %128 to i64
  %130 = call i8* @png_format_number(i8* noundef %122, i8* noundef %124, i32 noundef 2, i64 noundef %129)
  %131 = call i64 @png_safecat(i8* noundef %120, i64 noundef 29, i64 noundef %121, i8* noundef %130)
  store i64 %131, i64* %6, align 8
  %132 = load i64, i64* %6, align 8
  %133 = icmp ult i64 %132, 28
  br i1 %133, label %134, label %139

134:                                              ; preds = %119
  %135 = load i8*, i8** %4, align 8
  %136 = load i64, i64* %6, align 8
  %137 = add i64 %136, 1
  store i64 %137, i64* %6, align 8
  %138 = getelementptr inbounds i8, i8* %135, i64 %136
  store i8 58, i8* %138, align 1
  br label %139

139:                                              ; preds = %134, %119
  %140 = load i8*, i8** %4, align 8
  %141 = load i64, i64* %6, align 8
  %142 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i64 0, i64 0
  %143 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i64 0, i64 0
  %144 = getelementptr inbounds i8, i8* %143, i64 5
  %145 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %146 = getelementptr inbounds %struct.png_time_struct, %struct.png_time_struct* %145, i32 0, i32 4
  %147 = load i8, i8* %146, align 1
  %148 = zext i8 %147 to i32
  %149 = zext i32 %148 to i64
  %150 = call i8* @png_format_number(i8* noundef %142, i8* noundef %144, i32 noundef 2, i64 noundef %149)
  %151 = call i64 @png_safecat(i8* noundef %140, i64 noundef 29, i64 noundef %141, i8* noundef %150)
  store i64 %151, i64* %6, align 8
  %152 = load i64, i64* %6, align 8
  %153 = icmp ult i64 %152, 28
  br i1 %153, label %154, label %159

154:                                              ; preds = %139
  %155 = load i8*, i8** %4, align 8
  %156 = load i64, i64* %6, align 8
  %157 = add i64 %156, 1
  store i64 %157, i64* %6, align 8
  %158 = getelementptr inbounds i8, i8* %155, i64 %156
  store i8 58, i8* %158, align 1
  br label %159

159:                                              ; preds = %154, %139
  %160 = load i8*, i8** %4, align 8
  %161 = load i64, i64* %6, align 8
  %162 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i64 0, i64 0
  %163 = getelementptr inbounds [5 x i8], [5 x i8]* %7, i64 0, i64 0
  %164 = getelementptr inbounds i8, i8* %163, i64 5
  %165 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %166 = getelementptr inbounds %struct.png_time_struct, %struct.png_time_struct* %165, i32 0, i32 5
  %167 = load i8, i8* %166, align 2
  %168 = zext i8 %167 to i32
  %169 = zext i32 %168 to i64
  %170 = call i8* @png_format_number(i8* noundef %162, i8* noundef %164, i32 noundef 2, i64 noundef %169)
  %171 = call i64 @png_safecat(i8* noundef %160, i64 noundef 29, i64 noundef %161, i8* noundef %170)
  store i64 %171, i64* %6, align 8
  %172 = load i8*, i8** %4, align 8
  %173 = load i64, i64* %6, align 8
  %174 = call i64 @png_safecat(i8* noundef %172, i64 noundef 29, i64 noundef %173, i8* noundef getelementptr inbounds ([7 x i8], [7 x i8]* @.str.6, i64 0, i64 0))
  store i64 %174, i64* %6, align 8
  %175 = load i64, i64* %6, align 8
  store i32 1, i32* %3, align 4
  br label %176

176:                                              ; preds = %159, %59, %10
  %177 = load i32, i32* %3, align 4
  ret i32 %177
}

declare i8* @png_format_number(i8* noundef, i8* noundef, i32 noundef, i64 noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @png_convert_to_rfc1123(%struct.png_struct_def* noalias noundef %0, %struct.png_time_struct* noundef %1) #0 {
  %3 = alloca i8*, align 8
  %4 = alloca %struct.png_struct_def*, align 8
  %5 = alloca %struct.png_time_struct*, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %4, align 8
  store %struct.png_time_struct* %1, %struct.png_time_struct** %5, align 8
  %6 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %7 = icmp ne %struct.png_struct_def* %6, null
  br i1 %7, label %8, label %22

8:                                                ; preds = %2
  %9 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %10 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %9, i32 0, i32 116
  %11 = getelementptr inbounds [29 x i8], [29 x i8]* %10, i64 0, i64 0
  %12 = load %struct.png_time_struct*, %struct.png_time_struct** %5, align 8
  %13 = call i32 @png_convert_to_rfc1123_buffer(i8* noundef %11, %struct.png_time_struct* noundef %12)
  %14 = icmp eq i32 %13, 0
  br i1 %14, label %15, label %17

15:                                               ; preds = %8
  %16 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  call void @png_warning(%struct.png_struct_def* noundef %16, i8* noundef getelementptr inbounds ([28 x i8], [28 x i8]* @.str.7, i64 0, i64 0))
  br label %21

17:                                               ; preds = %8
  %18 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %19 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %18, i32 0, i32 116
  %20 = getelementptr inbounds [29 x i8], [29 x i8]* %19, i64 0, i64 0
  store i8* %20, i8** %3, align 8
  br label %23

21:                                               ; preds = %15
  br label %22

22:                                               ; preds = %21, %2
  store i8* null, i8** %3, align 8
  br label %23

23:                                               ; preds = %22, %17
  %24 = load i8*, i8** %3, align 8
  ret i8* %24
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @png_get_copyright(%struct.png_struct_def* noalias noundef %0) #0 {
  %2 = alloca %struct.png_struct_def*, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %2, align 8
  %3 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  ret i8* getelementptr inbounds ([223 x i8], [223 x i8]* @.str.8, i64 0, i64 0)
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @png_get_libpng_ver(%struct.png_struct_def* noalias noundef %0) #0 {
  %2 = alloca %struct.png_struct_def*, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %2, align 8
  %3 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %4 = call i8* @png_get_header_ver(%struct.png_struct_def* noundef %3)
  ret i8* %4
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @png_get_header_ver(%struct.png_struct_def* noalias noundef %0) #0 {
  %2 = alloca %struct.png_struct_def*, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %2, align 8
  %3 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  ret i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i64 0, i64 0)
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i8* @png_get_header_version(%struct.png_struct_def* noalias noundef %0) #0 {
  %2 = alloca %struct.png_struct_def*, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %2, align 8
  %3 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  ret i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.9, i64 0, i64 0)
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_build_grayscale_palette(i32 noundef %0, %struct.png_color_struct* noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca %struct.png_color_struct*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store %struct.png_color_struct* %1, %struct.png_color_struct** %4, align 8
  %9 = load %struct.png_color_struct*, %struct.png_color_struct** %4, align 8
  %10 = icmp eq %struct.png_color_struct* %9, null
  br i1 %10, label %11, label %12

11:                                               ; preds = %2
  br label %55

12:                                               ; preds = %2
  %13 = load i32, i32* %3, align 4
  switch i32 %13, label %18 [
    i32 1, label %14
    i32 2, label %15
    i32 4, label %16
    i32 8, label %17
  ]

14:                                               ; preds = %12
  store i32 2, i32* %5, align 4
  store i32 255, i32* %6, align 4
  br label %19

15:                                               ; preds = %12
  store i32 4, i32* %5, align 4
  store i32 85, i32* %6, align 4
  br label %19

16:                                               ; preds = %12
  store i32 16, i32* %5, align 4
  store i32 17, i32* %6, align 4
  br label %19

17:                                               ; preds = %12
  store i32 256, i32* %5, align 4
  store i32 1, i32* %6, align 4
  br label %19

18:                                               ; preds = %12
  store i32 0, i32* %5, align 4
  store i32 0, i32* %6, align 4
  br label %19

19:                                               ; preds = %18, %17, %16, %15, %14
  store i32 0, i32* %7, align 4
  store i32 0, i32* %8, align 4
  br label %20

20:                                               ; preds = %49, %19
  %21 = load i32, i32* %7, align 4
  %22 = load i32, i32* %5, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %55

24:                                               ; preds = %20
  %25 = load i32, i32* %8, align 4
  %26 = and i32 %25, 255
  %27 = trunc i32 %26 to i8
  %28 = load %struct.png_color_struct*, %struct.png_color_struct** %4, align 8
  %29 = load i32, i32* %7, align 4
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds %struct.png_color_struct, %struct.png_color_struct* %28, i64 %30
  %32 = getelementptr inbounds %struct.png_color_struct, %struct.png_color_struct* %31, i32 0, i32 0
  store i8 %27, i8* %32, align 1
  %33 = load i32, i32* %8, align 4
  %34 = and i32 %33, 255
  %35 = trunc i32 %34 to i8
  %36 = load %struct.png_color_struct*, %struct.png_color_struct** %4, align 8
  %37 = load i32, i32* %7, align 4
  %38 = sext i32 %37 to i64
  %39 = getelementptr inbounds %struct.png_color_struct, %struct.png_color_struct* %36, i64 %38
  %40 = getelementptr inbounds %struct.png_color_struct, %struct.png_color_struct* %39, i32 0, i32 1
  store i8 %35, i8* %40, align 1
  %41 = load i32, i32* %8, align 4
  %42 = and i32 %41, 255
  %43 = trunc i32 %42 to i8
  %44 = load %struct.png_color_struct*, %struct.png_color_struct** %4, align 8
  %45 = load i32, i32* %7, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds %struct.png_color_struct, %struct.png_color_struct* %44, i64 %46
  %48 = getelementptr inbounds %struct.png_color_struct, %struct.png_color_struct* %47, i32 0, i32 2
  store i8 %43, i8* %48, align 1
  br label %49

49:                                               ; preds = %24
  %50 = load i32, i32* %7, align 4
  %51 = add nsw i32 %50, 1
  store i32 %51, i32* %7, align 4
  %52 = load i32, i32* %6, align 4
  %53 = load i32, i32* %8, align 4
  %54 = add nsw i32 %53, %52
  store i32 %54, i32* %8, align 4
  br label %20, !llvm.loop !14

55:                                               ; preds = %11, %20
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_handle_as_unknown(%struct.png_struct_def* noalias noundef %0, i8* noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca %struct.png_struct_def*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %4, align 8
  store i8* %1, i8** %5, align 8
  %8 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %9 = icmp eq %struct.png_struct_def* %8, null
  br i1 %9, label %18, label %10

10:                                               ; preds = %2
  %11 = load i8*, i8** %5, align 8
  %12 = icmp eq i8* %11, null
  br i1 %12, label %18, label %13

13:                                               ; preds = %10
  %14 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %15 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %14, i32 0, i32 121
  %16 = load i32, i32* %15, align 4
  %17 = icmp eq i32 %16, 0
  br i1 %17, label %18, label %19

18:                                               ; preds = %13, %10, %2
  store i32 0, i32* %3, align 4
  br label %48

19:                                               ; preds = %13
  %20 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %21 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %20, i32 0, i32 122
  %22 = load i8*, i8** %21, align 8
  store i8* %22, i8** %7, align 8
  %23 = load i8*, i8** %7, align 8
  %24 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %25 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %24, i32 0, i32 121
  %26 = load i32, i32* %25, align 4
  %27 = mul i32 %26, 5
  %28 = zext i32 %27 to i64
  %29 = getelementptr inbounds i8, i8* %23, i64 %28
  store i8* %29, i8** %6, align 8
  br label %30

30:                                               ; preds = %43, %19
  %31 = load i8*, i8** %6, align 8
  %32 = getelementptr inbounds i8, i8* %31, i64 -5
  store i8* %32, i8** %6, align 8
  %33 = load i8*, i8** %5, align 8
  %34 = load i8*, i8** %6, align 8
  %35 = call i32 @memcmp(i8* noundef %33, i8* noundef %34, i64 noundef 4) #11
  %36 = icmp eq i32 %35, 0
  br i1 %36, label %37, label %42

37:                                               ; preds = %30
  %38 = load i8*, i8** %6, align 8
  %39 = getelementptr inbounds i8, i8* %38, i64 4
  %40 = load i8, i8* %39, align 1
  %41 = zext i8 %40 to i32
  store i32 %41, i32* %3, align 4
  br label %48

42:                                               ; preds = %30
  br label %43

43:                                               ; preds = %42
  %44 = load i8*, i8** %6, align 8
  %45 = load i8*, i8** %7, align 8
  %46 = icmp ugt i8* %44, %45
  br i1 %46, label %30, label %47, !llvm.loop !15

47:                                               ; preds = %43
  store i32 0, i32* %3, align 4
  br label %48

48:                                               ; preds = %47, %37, %18
  %49 = load i32, i32* %3, align 4
  ret i32 %49
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_chunk_unknown_handling(%struct.png_struct_def* noalias noundef %0, i32 noundef %1) #0 {
  %3 = alloca %struct.png_struct_def*, align 8
  %4 = alloca i32, align 4
  %5 = alloca [5 x i8], align 1
  store %struct.png_struct_def* %0, %struct.png_struct_def** %3, align 8
  store i32 %1, i32* %4, align 4
  %6 = load i32, i32* %4, align 4
  %7 = lshr i32 %6, 24
  %8 = and i32 %7, 255
  %9 = trunc i32 %8 to i8
  %10 = getelementptr inbounds [5 x i8], [5 x i8]* %5, i64 0, i64 0
  %11 = getelementptr inbounds i8, i8* %10, i64 0
  store i8 %9, i8* %11, align 1
  %12 = load i32, i32* %4, align 4
  %13 = lshr i32 %12, 16
  %14 = and i32 %13, 255
  %15 = trunc i32 %14 to i8
  %16 = getelementptr inbounds [5 x i8], [5 x i8]* %5, i64 0, i64 0
  %17 = getelementptr inbounds i8, i8* %16, i64 1
  store i8 %15, i8* %17, align 1
  %18 = load i32, i32* %4, align 4
  %19 = lshr i32 %18, 8
  %20 = and i32 %19, 255
  %21 = trunc i32 %20 to i8
  %22 = getelementptr inbounds [5 x i8], [5 x i8]* %5, i64 0, i64 0
  %23 = getelementptr inbounds i8, i8* %22, i64 2
  store i8 %21, i8* %23, align 1
  %24 = load i32, i32* %4, align 4
  %25 = and i32 %24, 255
  %26 = trunc i32 %25 to i8
  %27 = getelementptr inbounds [5 x i8], [5 x i8]* %5, i64 0, i64 0
  %28 = getelementptr inbounds i8, i8* %27, i64 3
  store i8 %26, i8* %28, align 1
  %29 = getelementptr inbounds [5 x i8], [5 x i8]* %5, i64 0, i64 0
  %30 = getelementptr inbounds i8, i8* %29, i64 4
  store i8 0, i8* %30, align 1
  %31 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %32 = getelementptr inbounds [5 x i8], [5 x i8]* %5, i64 0, i64 0
  %33 = call i32 @png_handle_as_unknown(%struct.png_struct_def* noundef %31, i8* noundef %32)
  ret i32 %33
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_reset_zstream(%struct.png_struct_def* noalias noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.png_struct_def*, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %3, align 8
  %4 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %5 = icmp eq %struct.png_struct_def* %4, null
  br i1 %5, label %6, label %7

6:                                                ; preds = %1
  store i32 -2, i32* %2, align 4
  br label %11

7:                                                ; preds = %1
  %8 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %9 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %8, i32 0, i32 19
  %10 = call i32 @inflateReset(%struct.z_stream_s* noundef %9)
  store i32 %10, i32* %2, align 4
  br label %11

11:                                               ; preds = %7, %6
  %12 = load i32, i32* %2, align 4
  ret i32 %12
}

declare i32 @inflateReset(%struct.z_stream_s* noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_access_version_number() #0 {
  ret i32 10648
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_zstream_error(%struct.png_struct_def* noalias noundef %0, i32 noundef %1) #0 {
  %3 = alloca %struct.png_struct_def*, align 8
  %4 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %6 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %5, i32 0, i32 19
  %7 = getelementptr inbounds %struct.z_stream_s, %struct.z_stream_s* %6, i32 0, i32 6
  %8 = load i8*, i8** %7, align 8
  %9 = icmp eq i8* %8, null
  br i1 %9, label %10, label %54

10:                                               ; preds = %2
  %11 = load i32, i32* %4, align 4
  switch i32 %11, label %12 [
    i32 0, label %13
    i32 1, label %17
    i32 2, label %21
    i32 -1, label %25
    i32 -2, label %29
    i32 -3, label %33
    i32 -4, label %37
    i32 -5, label %41
    i32 -6, label %45
    i32 -7, label %49
  ]

12:                                               ; preds = %10
  br label %13

13:                                               ; preds = %10, %12
  %14 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %15 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %14, i32 0, i32 19
  %16 = getelementptr inbounds %struct.z_stream_s, %struct.z_stream_s* %15, i32 0, i32 6
  store i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.10, i64 0, i64 0), i8** %16, align 8
  br label %53

17:                                               ; preds = %10
  %18 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %19 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %18, i32 0, i32 19
  %20 = getelementptr inbounds %struct.z_stream_s, %struct.z_stream_s* %19, i32 0, i32 6
  store i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.11, i64 0, i64 0), i8** %20, align 8
  br label %53

21:                                               ; preds = %10
  %22 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %23 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %22, i32 0, i32 19
  %24 = getelementptr inbounds %struct.z_stream_s, %struct.z_stream_s* %23, i32 0, i32 6
  store i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.12, i64 0, i64 0), i8** %24, align 8
  br label %53

25:                                               ; preds = %10
  %26 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %27 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %26, i32 0, i32 19
  %28 = getelementptr inbounds %struct.z_stream_s, %struct.z_stream_s* %27, i32 0, i32 6
  store i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.13, i64 0, i64 0), i8** %28, align 8
  br label %53

29:                                               ; preds = %10
  %30 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %31 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %30, i32 0, i32 19
  %32 = getelementptr inbounds %struct.z_stream_s, %struct.z_stream_s* %31, i32 0, i32 6
  store i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.14, i64 0, i64 0), i8** %32, align 8
  br label %53

33:                                               ; preds = %10
  %34 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %35 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %34, i32 0, i32 19
  %36 = getelementptr inbounds %struct.z_stream_s, %struct.z_stream_s* %35, i32 0, i32 6
  store i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.15, i64 0, i64 0), i8** %36, align 8
  br label %53

37:                                               ; preds = %10
  %38 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %39 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %38, i32 0, i32 19
  %40 = getelementptr inbounds %struct.z_stream_s, %struct.z_stream_s* %39, i32 0, i32 6
  store i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.16, i64 0, i64 0), i8** %40, align 8
  br label %53

41:                                               ; preds = %10
  %42 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %43 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %42, i32 0, i32 19
  %44 = getelementptr inbounds %struct.z_stream_s, %struct.z_stream_s* %43, i32 0, i32 6
  store i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.17, i64 0, i64 0), i8** %44, align 8
  br label %53

45:                                               ; preds = %10
  %46 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %47 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %46, i32 0, i32 19
  %48 = getelementptr inbounds %struct.z_stream_s, %struct.z_stream_s* %47, i32 0, i32 6
  store i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.18, i64 0, i64 0), i8** %48, align 8
  br label %53

49:                                               ; preds = %10
  %50 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %51 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %50, i32 0, i32 19
  %52 = getelementptr inbounds %struct.z_stream_s, %struct.z_stream_s* %51, i32 0, i32 6
  store i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.19, i64 0, i64 0), i8** %52, align 8
  br label %53

53:                                               ; preds = %49, %45, %41, %37, %33, %29, %25, %21, %17, %13
  br label %54

54:                                               ; preds = %53, %2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_xy_from_XYZ(%struct.png_xy* noundef %0, %struct.png_XYZ* noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca %struct.png_xy*, align 8
  %5 = alloca %struct.png_XYZ*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store %struct.png_xy* %0, %struct.png_xy** %4, align 8
  store %struct.png_XYZ* %1, %struct.png_XYZ** %5, align 8
  %13 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %14 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %13, i32 0, i32 0
  %15 = load i32, i32* %14, align 4
  store i32 %15, i32* %6, align 4
  %16 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %17 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %16, i32 0, i32 1
  %18 = load i32, i32* %17, align 4
  %19 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %20 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %19, i32 0, i32 2
  %21 = load i32, i32* %20, align 4
  %22 = call i32 @png_safe_add(i32* noundef %6, i32 noundef %18, i32 noundef %21)
  %23 = icmp ne i32 %22, 0
  br i1 %23, label %24, label %25

24:                                               ; preds = %2
  store i32 1, i32* %3, align 4
  br label %167

25:                                               ; preds = %2
  %26 = load i32, i32* %6, align 4
  store i32 %26, i32* %7, align 4
  %27 = load %struct.png_xy*, %struct.png_xy** %4, align 8
  %28 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %27, i32 0, i32 0
  %29 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %30 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %29, i32 0, i32 0
  %31 = load i32, i32* %30, align 4
  %32 = load i32, i32* %7, align 4
  %33 = call i32 @png_muldiv(i32* noundef %28, i32 noundef %31, i32 noundef 100000, i32 noundef %32)
  %34 = icmp eq i32 %33, 0
  br i1 %34, label %35, label %36

35:                                               ; preds = %25
  store i32 1, i32* %3, align 4
  br label %167

36:                                               ; preds = %25
  %37 = load %struct.png_xy*, %struct.png_xy** %4, align 8
  %38 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %37, i32 0, i32 1
  %39 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %40 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %39, i32 0, i32 1
  %41 = load i32, i32* %40, align 4
  %42 = load i32, i32* %7, align 4
  %43 = call i32 @png_muldiv(i32* noundef %38, i32 noundef %41, i32 noundef 100000, i32 noundef %42)
  %44 = icmp eq i32 %43, 0
  br i1 %44, label %45, label %46

45:                                               ; preds = %36
  store i32 1, i32* %3, align 4
  br label %167

46:                                               ; preds = %36
  %47 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %48 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %47, i32 0, i32 3
  %49 = load i32, i32* %48, align 4
  store i32 %49, i32* %6, align 4
  %50 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %51 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %50, i32 0, i32 4
  %52 = load i32, i32* %51, align 4
  %53 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %54 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %53, i32 0, i32 5
  %55 = load i32, i32* %54, align 4
  %56 = call i32 @png_safe_add(i32* noundef %6, i32 noundef %52, i32 noundef %55)
  %57 = icmp ne i32 %56, 0
  br i1 %57, label %58, label %59

58:                                               ; preds = %46
  store i32 1, i32* %3, align 4
  br label %167

59:                                               ; preds = %46
  %60 = load i32, i32* %6, align 4
  store i32 %60, i32* %8, align 4
  %61 = load %struct.png_xy*, %struct.png_xy** %4, align 8
  %62 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %61, i32 0, i32 2
  %63 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %64 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %63, i32 0, i32 3
  %65 = load i32, i32* %64, align 4
  %66 = load i32, i32* %8, align 4
  %67 = call i32 @png_muldiv(i32* noundef %62, i32 noundef %65, i32 noundef 100000, i32 noundef %66)
  %68 = icmp eq i32 %67, 0
  br i1 %68, label %69, label %70

69:                                               ; preds = %59
  store i32 1, i32* %3, align 4
  br label %167

70:                                               ; preds = %59
  %71 = load %struct.png_xy*, %struct.png_xy** %4, align 8
  %72 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %71, i32 0, i32 3
  %73 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %74 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %73, i32 0, i32 4
  %75 = load i32, i32* %74, align 4
  %76 = load i32, i32* %8, align 4
  %77 = call i32 @png_muldiv(i32* noundef %72, i32 noundef %75, i32 noundef 100000, i32 noundef %76)
  %78 = icmp eq i32 %77, 0
  br i1 %78, label %79, label %80

79:                                               ; preds = %70
  store i32 1, i32* %3, align 4
  br label %167

80:                                               ; preds = %70
  %81 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %82 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %81, i32 0, i32 6
  %83 = load i32, i32* %82, align 4
  store i32 %83, i32* %6, align 4
  %84 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %85 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %84, i32 0, i32 7
  %86 = load i32, i32* %85, align 4
  %87 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %88 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %87, i32 0, i32 8
  %89 = load i32, i32* %88, align 4
  %90 = call i32 @png_safe_add(i32* noundef %6, i32 noundef %86, i32 noundef %89)
  %91 = icmp ne i32 %90, 0
  br i1 %91, label %92, label %93

92:                                               ; preds = %80
  store i32 1, i32* %3, align 4
  br label %167

93:                                               ; preds = %80
  %94 = load i32, i32* %6, align 4
  store i32 %94, i32* %9, align 4
  %95 = load %struct.png_xy*, %struct.png_xy** %4, align 8
  %96 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %95, i32 0, i32 4
  %97 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %98 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %97, i32 0, i32 6
  %99 = load i32, i32* %98, align 4
  %100 = load i32, i32* %9, align 4
  %101 = call i32 @png_muldiv(i32* noundef %96, i32 noundef %99, i32 noundef 100000, i32 noundef %100)
  %102 = icmp eq i32 %101, 0
  br i1 %102, label %103, label %104

103:                                              ; preds = %93
  store i32 1, i32* %3, align 4
  br label %167

104:                                              ; preds = %93
  %105 = load %struct.png_xy*, %struct.png_xy** %4, align 8
  %106 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %105, i32 0, i32 5
  %107 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %108 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %107, i32 0, i32 7
  %109 = load i32, i32* %108, align 4
  %110 = load i32, i32* %9, align 4
  %111 = call i32 @png_muldiv(i32* noundef %106, i32 noundef %109, i32 noundef 100000, i32 noundef %110)
  %112 = icmp eq i32 %111, 0
  br i1 %112, label %113, label %114

113:                                              ; preds = %104
  store i32 1, i32* %3, align 4
  br label %167

114:                                              ; preds = %104
  %115 = load i32, i32* %9, align 4
  store i32 %115, i32* %6, align 4
  %116 = load i32, i32* %7, align 4
  %117 = load i32, i32* %8, align 4
  %118 = call i32 @png_safe_add(i32* noundef %6, i32 noundef %116, i32 noundef %117)
  %119 = icmp ne i32 %118, 0
  br i1 %119, label %120, label %121

120:                                              ; preds = %114
  store i32 1, i32* %3, align 4
  br label %167

121:                                              ; preds = %114
  %122 = load i32, i32* %6, align 4
  store i32 %122, i32* %10, align 4
  %123 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %124 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %123, i32 0, i32 0
  %125 = load i32, i32* %124, align 4
  store i32 %125, i32* %6, align 4
  %126 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %127 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %126, i32 0, i32 3
  %128 = load i32, i32* %127, align 4
  %129 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %130 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %129, i32 0, i32 6
  %131 = load i32, i32* %130, align 4
  %132 = call i32 @png_safe_add(i32* noundef %6, i32 noundef %128, i32 noundef %131)
  %133 = icmp ne i32 %132, 0
  br i1 %133, label %134, label %135

134:                                              ; preds = %121
  store i32 1, i32* %3, align 4
  br label %167

135:                                              ; preds = %121
  %136 = load i32, i32* %6, align 4
  store i32 %136, i32* %11, align 4
  %137 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %138 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %137, i32 0, i32 1
  %139 = load i32, i32* %138, align 4
  store i32 %139, i32* %6, align 4
  %140 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %141 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %140, i32 0, i32 4
  %142 = load i32, i32* %141, align 4
  %143 = load %struct.png_XYZ*, %struct.png_XYZ** %5, align 8
  %144 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %143, i32 0, i32 7
  %145 = load i32, i32* %144, align 4
  %146 = call i32 @png_safe_add(i32* noundef %6, i32 noundef %142, i32 noundef %145)
  %147 = icmp ne i32 %146, 0
  br i1 %147, label %148, label %149

148:                                              ; preds = %135
  store i32 1, i32* %3, align 4
  br label %167

149:                                              ; preds = %135
  %150 = load i32, i32* %6, align 4
  store i32 %150, i32* %12, align 4
  %151 = load %struct.png_xy*, %struct.png_xy** %4, align 8
  %152 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %151, i32 0, i32 6
  %153 = load i32, i32* %11, align 4
  %154 = load i32, i32* %10, align 4
  %155 = call i32 @png_muldiv(i32* noundef %152, i32 noundef %153, i32 noundef 100000, i32 noundef %154)
  %156 = icmp eq i32 %155, 0
  br i1 %156, label %157, label %158

157:                                              ; preds = %149
  store i32 1, i32* %3, align 4
  br label %167

158:                                              ; preds = %149
  %159 = load %struct.png_xy*, %struct.png_xy** %4, align 8
  %160 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %159, i32 0, i32 7
  %161 = load i32, i32* %12, align 4
  %162 = load i32, i32* %10, align 4
  %163 = call i32 @png_muldiv(i32* noundef %160, i32 noundef %161, i32 noundef 100000, i32 noundef %162)
  %164 = icmp eq i32 %163, 0
  br i1 %164, label %165, label %166

165:                                              ; preds = %158
  store i32 1, i32* %3, align 4
  br label %167

166:                                              ; preds = %158
  store i32 0, i32* %3, align 4
  br label %167

167:                                              ; preds = %166, %165, %157, %148, %134, %120, %113, %103, %92, %79, %69, %58, %45, %35, %24
  %168 = load i32, i32* %3, align 4
  ret i32 %168
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @png_safe_add(i32* noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32* %0, i32** %4, align 8
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  store i32 0, i32* %7, align 4
  %9 = load i32*, i32** %4, align 8
  %10 = load i32, i32* %9, align 4
  %11 = load i32, i32* %5, align 4
  %12 = load i32, i32* %6, align 4
  %13 = call i32 @png_fp_add(i32 noundef %11, i32 noundef %12, i32* noundef %7)
  %14 = call i32 @png_fp_add(i32 noundef %10, i32 noundef %13, i32* noundef %7)
  store i32 %14, i32* %8, align 4
  %15 = load i32, i32* %7, align 4
  %16 = icmp ne i32 %15, 0
  br i1 %16, label %20, label %17

17:                                               ; preds = %3
  %18 = load i32, i32* %8, align 4
  %19 = load i32*, i32** %4, align 8
  store i32 %18, i32* %19, align 4
  br label %20

20:                                               ; preds = %17, %3
  %21 = load i32, i32* %7, align 4
  ret i32 %21
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_muldiv(i32* noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca double, align 8
  store i32* %0, i32** %6, align 8
  store i32 %1, i32* %7, align 4
  store i32 %2, i32* %8, align 4
  store i32 %3, i32* %9, align 4
  %11 = load i32, i32* %9, align 4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %46

13:                                               ; preds = %4
  %14 = load i32, i32* %7, align 4
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %19, label %16

16:                                               ; preds = %13
  %17 = load i32, i32* %8, align 4
  %18 = icmp eq i32 %17, 0
  br i1 %18, label %19, label %21

19:                                               ; preds = %16, %13
  %20 = load i32*, i32** %6, align 8
  store i32 0, i32* %20, align 4
  store i32 1, i32* %5, align 4
  br label %47

21:                                               ; preds = %16
  %22 = load i32, i32* %7, align 4
  %23 = sitofp i32 %22 to double
  store double %23, double* %10, align 8
  %24 = load i32, i32* %8, align 4
  %25 = sitofp i32 %24 to double
  %26 = load double, double* %10, align 8
  %27 = fmul double %26, %25
  store double %27, double* %10, align 8
  %28 = load i32, i32* %9, align 4
  %29 = sitofp i32 %28 to double
  %30 = load double, double* %10, align 8
  %31 = fdiv double %30, %29
  store double %31, double* %10, align 8
  %32 = load double, double* %10, align 8
  %33 = fadd double %32, 5.000000e-01
  %34 = call double @llvm.floor.f64(double %33)
  store double %34, double* %10, align 8
  %35 = load double, double* %10, align 8
  %36 = fcmp ole double %35, 0x41DFFFFFFFC00000
  br i1 %36, label %37, label %44

37:                                               ; preds = %21
  %38 = load double, double* %10, align 8
  %39 = fcmp oge double %38, 0xC1E0000000000000
  br i1 %39, label %40, label %44

40:                                               ; preds = %37
  %41 = load double, double* %10, align 8
  %42 = fptosi double %41 to i32
  %43 = load i32*, i32** %6, align 8
  store i32 %42, i32* %43, align 4
  store i32 1, i32* %5, align 4
  br label %47

44:                                               ; preds = %37, %21
  br label %45

45:                                               ; preds = %44
  br label %46

46:                                               ; preds = %45, %4
  store i32 0, i32* %5, align 4
  br label %47

47:                                               ; preds = %46, %40, %19
  %48 = load i32, i32* %5, align 4
  ret i32 %48
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_XYZ_from_xy(%struct.png_XYZ* noundef %0, %struct.png_xy* noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca %struct.png_XYZ*, align 8
  %5 = alloca %struct.png_xy*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store %struct.png_XYZ* %0, %struct.png_XYZ** %4, align 8
  store %struct.png_xy* %1, %struct.png_xy** %5, align 8
  store i32 110000, i32* %12, align 4
  %14 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %15 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %14, i32 0, i32 0
  %16 = load i32, i32* %15, align 4
  %17 = icmp slt i32 %16, 0
  br i1 %17, label %23, label %18

18:                                               ; preds = %2
  %19 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %20 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %19, i32 0, i32 0
  %21 = load i32, i32* %20, align 4
  %22 = icmp sgt i32 %21, 110000
  br i1 %22, label %23, label %24

23:                                               ; preds = %18, %2
  store i32 1, i32* %3, align 4
  br label %395

24:                                               ; preds = %18
  %25 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %26 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %25, i32 0, i32 1
  %27 = load i32, i32* %26, align 4
  %28 = icmp slt i32 %27, 0
  br i1 %28, label %38, label %29

29:                                               ; preds = %24
  %30 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %31 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %30, i32 0, i32 1
  %32 = load i32, i32* %31, align 4
  %33 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %34 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %33, i32 0, i32 0
  %35 = load i32, i32* %34, align 4
  %36 = sub nsw i32 110000, %35
  %37 = icmp sgt i32 %32, %36
  br i1 %37, label %38, label %39

38:                                               ; preds = %29, %24
  store i32 1, i32* %3, align 4
  br label %395

39:                                               ; preds = %29
  %40 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %41 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %40, i32 0, i32 2
  %42 = load i32, i32* %41, align 4
  %43 = icmp slt i32 %42, 0
  br i1 %43, label %49, label %44

44:                                               ; preds = %39
  %45 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %46 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %45, i32 0, i32 2
  %47 = load i32, i32* %46, align 4
  %48 = icmp sgt i32 %47, 110000
  br i1 %48, label %49, label %50

49:                                               ; preds = %44, %39
  store i32 1, i32* %3, align 4
  br label %395

50:                                               ; preds = %44
  %51 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %52 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %51, i32 0, i32 3
  %53 = load i32, i32* %52, align 4
  %54 = icmp slt i32 %53, 0
  br i1 %54, label %64, label %55

55:                                               ; preds = %50
  %56 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %57 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %56, i32 0, i32 3
  %58 = load i32, i32* %57, align 4
  %59 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %60 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %59, i32 0, i32 2
  %61 = load i32, i32* %60, align 4
  %62 = sub nsw i32 110000, %61
  %63 = icmp sgt i32 %58, %62
  br i1 %63, label %64, label %65

64:                                               ; preds = %55, %50
  store i32 1, i32* %3, align 4
  br label %395

65:                                               ; preds = %55
  %66 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %67 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %66, i32 0, i32 4
  %68 = load i32, i32* %67, align 4
  %69 = icmp slt i32 %68, 0
  br i1 %69, label %75, label %70

70:                                               ; preds = %65
  %71 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %72 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %71, i32 0, i32 4
  %73 = load i32, i32* %72, align 4
  %74 = icmp sgt i32 %73, 110000
  br i1 %74, label %75, label %76

75:                                               ; preds = %70, %65
  store i32 1, i32* %3, align 4
  br label %395

76:                                               ; preds = %70
  %77 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %78 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %77, i32 0, i32 5
  %79 = load i32, i32* %78, align 4
  %80 = icmp slt i32 %79, 0
  br i1 %80, label %90, label %81

81:                                               ; preds = %76
  %82 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %83 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %82, i32 0, i32 5
  %84 = load i32, i32* %83, align 4
  %85 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %86 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %85, i32 0, i32 4
  %87 = load i32, i32* %86, align 4
  %88 = sub nsw i32 110000, %87
  %89 = icmp sgt i32 %84, %88
  br i1 %89, label %90, label %91

90:                                               ; preds = %81, %76
  store i32 1, i32* %3, align 4
  br label %395

91:                                               ; preds = %81
  %92 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %93 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %92, i32 0, i32 6
  %94 = load i32, i32* %93, align 4
  %95 = icmp slt i32 %94, 0
  br i1 %95, label %101, label %96

96:                                               ; preds = %91
  %97 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %98 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %97, i32 0, i32 6
  %99 = load i32, i32* %98, align 4
  %100 = icmp sgt i32 %99, 110000
  br i1 %100, label %101, label %102

101:                                              ; preds = %96, %91
  store i32 1, i32* %3, align 4
  br label %395

102:                                              ; preds = %96
  %103 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %104 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %103, i32 0, i32 7
  %105 = load i32, i32* %104, align 4
  %106 = icmp slt i32 %105, 5
  br i1 %106, label %116, label %107

107:                                              ; preds = %102
  %108 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %109 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %108, i32 0, i32 7
  %110 = load i32, i32* %109, align 4
  %111 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %112 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %111, i32 0, i32 6
  %113 = load i32, i32* %112, align 4
  %114 = sub nsw i32 110000, %113
  %115 = icmp sgt i32 %110, %114
  br i1 %115, label %116, label %117

116:                                              ; preds = %107, %102
  store i32 1, i32* %3, align 4
  br label %395

117:                                              ; preds = %107
  store i32 0, i32* %13, align 4
  %118 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %119 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %118, i32 0, i32 2
  %120 = load i32, i32* %119, align 4
  %121 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %122 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %121, i32 0, i32 4
  %123 = load i32, i32* %122, align 4
  %124 = sub nsw i32 %120, %123
  %125 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %126 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %125, i32 0, i32 1
  %127 = load i32, i32* %126, align 4
  %128 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %129 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %128, i32 0, i32 5
  %130 = load i32, i32* %129, align 4
  %131 = sub nsw i32 %127, %130
  %132 = call i32 @png_muldiv(i32* noundef %9, i32 noundef %124, i32 noundef %131, i32 noundef 8)
  %133 = icmp eq i32 %132, 0
  br i1 %133, label %134, label %135

134:                                              ; preds = %117
  store i32 1, i32* %3, align 4
  br label %395

135:                                              ; preds = %117
  %136 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %137 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %136, i32 0, i32 3
  %138 = load i32, i32* %137, align 4
  %139 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %140 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %139, i32 0, i32 5
  %141 = load i32, i32* %140, align 4
  %142 = sub nsw i32 %138, %141
  %143 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %144 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %143, i32 0, i32 0
  %145 = load i32, i32* %144, align 4
  %146 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %147 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %146, i32 0, i32 4
  %148 = load i32, i32* %147, align 4
  %149 = sub nsw i32 %145, %148
  %150 = call i32 @png_muldiv(i32* noundef %10, i32 noundef %142, i32 noundef %149, i32 noundef 8)
  %151 = icmp eq i32 %150, 0
  br i1 %151, label %152, label %153

152:                                              ; preds = %135
  store i32 1, i32* %3, align 4
  br label %395

153:                                              ; preds = %135
  %154 = load i32, i32* %9, align 4
  %155 = load i32, i32* %10, align 4
  %156 = call i32 @png_fp_sub(i32 noundef %154, i32 noundef %155, i32* noundef %13)
  store i32 %156, i32* %11, align 4
  %157 = load i32, i32* %13, align 4
  %158 = icmp ne i32 %157, 0
  br i1 %158, label %159, label %160

159:                                              ; preds = %153
  store i32 1, i32* %3, align 4
  br label %395

160:                                              ; preds = %153
  %161 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %162 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %161, i32 0, i32 2
  %163 = load i32, i32* %162, align 4
  %164 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %165 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %164, i32 0, i32 4
  %166 = load i32, i32* %165, align 4
  %167 = sub nsw i32 %163, %166
  %168 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %169 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %168, i32 0, i32 7
  %170 = load i32, i32* %169, align 4
  %171 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %172 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %171, i32 0, i32 5
  %173 = load i32, i32* %172, align 4
  %174 = sub nsw i32 %170, %173
  %175 = call i32 @png_muldiv(i32* noundef %9, i32 noundef %167, i32 noundef %174, i32 noundef 8)
  %176 = icmp eq i32 %175, 0
  br i1 %176, label %177, label %178

177:                                              ; preds = %160
  store i32 1, i32* %3, align 4
  br label %395

178:                                              ; preds = %160
  %179 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %180 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %179, i32 0, i32 3
  %181 = load i32, i32* %180, align 4
  %182 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %183 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %182, i32 0, i32 5
  %184 = load i32, i32* %183, align 4
  %185 = sub nsw i32 %181, %184
  %186 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %187 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %186, i32 0, i32 6
  %188 = load i32, i32* %187, align 4
  %189 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %190 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %189, i32 0, i32 4
  %191 = load i32, i32* %190, align 4
  %192 = sub nsw i32 %188, %191
  %193 = call i32 @png_muldiv(i32* noundef %10, i32 noundef %185, i32 noundef %192, i32 noundef 8)
  %194 = icmp eq i32 %193, 0
  br i1 %194, label %195, label %196

195:                                              ; preds = %178
  store i32 1, i32* %3, align 4
  br label %395

196:                                              ; preds = %178
  %197 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %198 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %197, i32 0, i32 7
  %199 = load i32, i32* %198, align 4
  %200 = load i32, i32* %11, align 4
  %201 = load i32, i32* %9, align 4
  %202 = load i32, i32* %10, align 4
  %203 = call i32 @png_fp_sub(i32 noundef %201, i32 noundef %202, i32* noundef %13)
  %204 = call i32 @png_muldiv(i32* noundef %6, i32 noundef %199, i32 noundef %200, i32 noundef %203)
  %205 = icmp eq i32 %204, 0
  br i1 %205, label %215, label %206

206:                                              ; preds = %196
  %207 = load i32, i32* %13, align 4
  %208 = icmp ne i32 %207, 0
  br i1 %208, label %215, label %209

209:                                              ; preds = %206
  %210 = load i32, i32* %6, align 4
  %211 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %212 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %211, i32 0, i32 7
  %213 = load i32, i32* %212, align 4
  %214 = icmp sle i32 %210, %213
  br i1 %214, label %215, label %216

215:                                              ; preds = %209, %206, %196
  store i32 1, i32* %3, align 4
  br label %395

216:                                              ; preds = %209
  %217 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %218 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %217, i32 0, i32 1
  %219 = load i32, i32* %218, align 4
  %220 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %221 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %220, i32 0, i32 5
  %222 = load i32, i32* %221, align 4
  %223 = sub nsw i32 %219, %222
  %224 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %225 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %224, i32 0, i32 6
  %226 = load i32, i32* %225, align 4
  %227 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %228 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %227, i32 0, i32 4
  %229 = load i32, i32* %228, align 4
  %230 = sub nsw i32 %226, %229
  %231 = call i32 @png_muldiv(i32* noundef %9, i32 noundef %223, i32 noundef %230, i32 noundef 8)
  %232 = icmp eq i32 %231, 0
  br i1 %232, label %233, label %234

233:                                              ; preds = %216
  store i32 1, i32* %3, align 4
  br label %395

234:                                              ; preds = %216
  %235 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %236 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %235, i32 0, i32 0
  %237 = load i32, i32* %236, align 4
  %238 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %239 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %238, i32 0, i32 4
  %240 = load i32, i32* %239, align 4
  %241 = sub nsw i32 %237, %240
  %242 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %243 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %242, i32 0, i32 7
  %244 = load i32, i32* %243, align 4
  %245 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %246 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %245, i32 0, i32 5
  %247 = load i32, i32* %246, align 4
  %248 = sub nsw i32 %244, %247
  %249 = call i32 @png_muldiv(i32* noundef %10, i32 noundef %241, i32 noundef %248, i32 noundef 8)
  %250 = icmp eq i32 %249, 0
  br i1 %250, label %251, label %252

251:                                              ; preds = %234
  store i32 1, i32* %3, align 4
  br label %395

252:                                              ; preds = %234
  %253 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %254 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %253, i32 0, i32 7
  %255 = load i32, i32* %254, align 4
  %256 = load i32, i32* %11, align 4
  %257 = load i32, i32* %9, align 4
  %258 = load i32, i32* %10, align 4
  %259 = call i32 @png_fp_sub(i32 noundef %257, i32 noundef %258, i32* noundef %13)
  %260 = call i32 @png_muldiv(i32* noundef %7, i32 noundef %255, i32 noundef %256, i32 noundef %259)
  %261 = icmp eq i32 %260, 0
  br i1 %261, label %271, label %262

262:                                              ; preds = %252
  %263 = load i32, i32* %13, align 4
  %264 = icmp ne i32 %263, 0
  br i1 %264, label %271, label %265

265:                                              ; preds = %262
  %266 = load i32, i32* %7, align 4
  %267 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %268 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %267, i32 0, i32 7
  %269 = load i32, i32* %268, align 4
  %270 = icmp sle i32 %266, %269
  br i1 %270, label %271, label %272

271:                                              ; preds = %265, %262, %252
  store i32 1, i32* %3, align 4
  br label %395

272:                                              ; preds = %265
  %273 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %274 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %273, i32 0, i32 7
  %275 = load i32, i32* %274, align 4
  %276 = call i32 @png_reciprocal(i32 noundef %275)
  %277 = load i32, i32* %6, align 4
  %278 = call i32 @png_reciprocal(i32 noundef %277)
  %279 = call i32 @png_fp_sub(i32 noundef %276, i32 noundef %278, i32* noundef %13)
  %280 = load i32, i32* %7, align 4
  %281 = call i32 @png_reciprocal(i32 noundef %280)
  %282 = call i32 @png_fp_sub(i32 noundef %279, i32 noundef %281, i32* noundef %13)
  store i32 %282, i32* %8, align 4
  %283 = load i32, i32* %13, align 4
  %284 = icmp ne i32 %283, 0
  br i1 %284, label %288, label %285

285:                                              ; preds = %272
  %286 = load i32, i32* %8, align 4
  %287 = icmp sle i32 %286, 0
  br i1 %287, label %288, label %289

288:                                              ; preds = %285, %272
  store i32 1, i32* %3, align 4
  br label %395

289:                                              ; preds = %285
  %290 = load %struct.png_XYZ*, %struct.png_XYZ** %4, align 8
  %291 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %290, i32 0, i32 0
  %292 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %293 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %292, i32 0, i32 0
  %294 = load i32, i32* %293, align 4
  %295 = load i32, i32* %6, align 4
  %296 = call i32 @png_muldiv(i32* noundef %291, i32 noundef %294, i32 noundef 100000, i32 noundef %295)
  %297 = icmp eq i32 %296, 0
  br i1 %297, label %298, label %299

298:                                              ; preds = %289
  store i32 1, i32* %3, align 4
  br label %395

299:                                              ; preds = %289
  %300 = load %struct.png_XYZ*, %struct.png_XYZ** %4, align 8
  %301 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %300, i32 0, i32 1
  %302 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %303 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %302, i32 0, i32 1
  %304 = load i32, i32* %303, align 4
  %305 = load i32, i32* %6, align 4
  %306 = call i32 @png_muldiv(i32* noundef %301, i32 noundef %304, i32 noundef 100000, i32 noundef %305)
  %307 = icmp eq i32 %306, 0
  br i1 %307, label %308, label %309

308:                                              ; preds = %299
  store i32 1, i32* %3, align 4
  br label %395

309:                                              ; preds = %299
  %310 = load %struct.png_XYZ*, %struct.png_XYZ** %4, align 8
  %311 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %310, i32 0, i32 2
  %312 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %313 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %312, i32 0, i32 0
  %314 = load i32, i32* %313, align 4
  %315 = sub nsw i32 100000, %314
  %316 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %317 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %316, i32 0, i32 1
  %318 = load i32, i32* %317, align 4
  %319 = sub nsw i32 %315, %318
  %320 = load i32, i32* %6, align 4
  %321 = call i32 @png_muldiv(i32* noundef %311, i32 noundef %319, i32 noundef 100000, i32 noundef %320)
  %322 = icmp eq i32 %321, 0
  br i1 %322, label %323, label %324

323:                                              ; preds = %309
  store i32 1, i32* %3, align 4
  br label %395

324:                                              ; preds = %309
  %325 = load %struct.png_XYZ*, %struct.png_XYZ** %4, align 8
  %326 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %325, i32 0, i32 3
  %327 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %328 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %327, i32 0, i32 2
  %329 = load i32, i32* %328, align 4
  %330 = load i32, i32* %7, align 4
  %331 = call i32 @png_muldiv(i32* noundef %326, i32 noundef %329, i32 noundef 100000, i32 noundef %330)
  %332 = icmp eq i32 %331, 0
  br i1 %332, label %333, label %334

333:                                              ; preds = %324
  store i32 1, i32* %3, align 4
  br label %395

334:                                              ; preds = %324
  %335 = load %struct.png_XYZ*, %struct.png_XYZ** %4, align 8
  %336 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %335, i32 0, i32 4
  %337 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %338 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %337, i32 0, i32 3
  %339 = load i32, i32* %338, align 4
  %340 = load i32, i32* %7, align 4
  %341 = call i32 @png_muldiv(i32* noundef %336, i32 noundef %339, i32 noundef 100000, i32 noundef %340)
  %342 = icmp eq i32 %341, 0
  br i1 %342, label %343, label %344

343:                                              ; preds = %334
  store i32 1, i32* %3, align 4
  br label %395

344:                                              ; preds = %334
  %345 = load %struct.png_XYZ*, %struct.png_XYZ** %4, align 8
  %346 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %345, i32 0, i32 5
  %347 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %348 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %347, i32 0, i32 2
  %349 = load i32, i32* %348, align 4
  %350 = sub nsw i32 100000, %349
  %351 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %352 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %351, i32 0, i32 3
  %353 = load i32, i32* %352, align 4
  %354 = sub nsw i32 %350, %353
  %355 = load i32, i32* %7, align 4
  %356 = call i32 @png_muldiv(i32* noundef %346, i32 noundef %354, i32 noundef 100000, i32 noundef %355)
  %357 = icmp eq i32 %356, 0
  br i1 %357, label %358, label %359

358:                                              ; preds = %344
  store i32 1, i32* %3, align 4
  br label %395

359:                                              ; preds = %344
  %360 = load %struct.png_XYZ*, %struct.png_XYZ** %4, align 8
  %361 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %360, i32 0, i32 6
  %362 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %363 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %362, i32 0, i32 4
  %364 = load i32, i32* %363, align 4
  %365 = load i32, i32* %8, align 4
  %366 = call i32 @png_muldiv(i32* noundef %361, i32 noundef %364, i32 noundef %365, i32 noundef 100000)
  %367 = icmp eq i32 %366, 0
  br i1 %367, label %368, label %369

368:                                              ; preds = %359
  store i32 1, i32* %3, align 4
  br label %395

369:                                              ; preds = %359
  %370 = load %struct.png_XYZ*, %struct.png_XYZ** %4, align 8
  %371 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %370, i32 0, i32 7
  %372 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %373 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %372, i32 0, i32 5
  %374 = load i32, i32* %373, align 4
  %375 = load i32, i32* %8, align 4
  %376 = call i32 @png_muldiv(i32* noundef %371, i32 noundef %374, i32 noundef %375, i32 noundef 100000)
  %377 = icmp eq i32 %376, 0
  br i1 %377, label %378, label %379

378:                                              ; preds = %369
  store i32 1, i32* %3, align 4
  br label %395

379:                                              ; preds = %369
  %380 = load %struct.png_XYZ*, %struct.png_XYZ** %4, align 8
  %381 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %380, i32 0, i32 8
  %382 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %383 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %382, i32 0, i32 4
  %384 = load i32, i32* %383, align 4
  %385 = sub nsw i32 100000, %384
  %386 = load %struct.png_xy*, %struct.png_xy** %5, align 8
  %387 = getelementptr inbounds %struct.png_xy, %struct.png_xy* %386, i32 0, i32 5
  %388 = load i32, i32* %387, align 4
  %389 = sub nsw i32 %385, %388
  %390 = load i32, i32* %8, align 4
  %391 = call i32 @png_muldiv(i32* noundef %381, i32 noundef %389, i32 noundef %390, i32 noundef 100000)
  %392 = icmp eq i32 %391, 0
  br i1 %392, label %393, label %394

393:                                              ; preds = %379
  store i32 1, i32* %3, align 4
  br label %395

394:                                              ; preds = %379
  store i32 0, i32* %3, align 4
  br label %395

395:                                              ; preds = %394, %393, %378, %368, %358, %343, %333, %323, %308, %298, %288, %271, %251, %233, %215, %195, %177, %159, %152, %134, %116, %101, %90, %75, %64, %49, %38, %23
  %396 = load i32, i32* %3, align 4
  ret i32 %396
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @png_fp_sub(i32 noundef %0, i32 noundef %1, i32* noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32*, align 8
  store i32 %0, i32* %5, align 4
  store i32 %1, i32* %6, align 4
  store i32* %2, i32** %7, align 8
  %8 = load i32, i32* %6, align 4
  %9 = icmp sgt i32 %8, 0
  br i1 %9, label %10, label %20

10:                                               ; preds = %3
  %11 = load i32, i32* %6, align 4
  %12 = add nsw i32 -2147483647, %11
  %13 = load i32, i32* %5, align 4
  %14 = icmp sle i32 %12, %13
  br i1 %14, label %15, label %19

15:                                               ; preds = %10
  %16 = load i32, i32* %5, align 4
  %17 = load i32, i32* %6, align 4
  %18 = sub nsw i32 %16, %17
  store i32 %18, i32* %4, align 4
  br label %38

19:                                               ; preds = %10
  br label %36

20:                                               ; preds = %3
  %21 = load i32, i32* %6, align 4
  %22 = icmp slt i32 %21, 0
  br i1 %22, label %23, label %33

23:                                               ; preds = %20
  %24 = load i32, i32* %6, align 4
  %25 = add nsw i32 2147483647, %24
  %26 = load i32, i32* %5, align 4
  %27 = icmp sge i32 %25, %26
  br i1 %27, label %28, label %32

28:                                               ; preds = %23
  %29 = load i32, i32* %5, align 4
  %30 = load i32, i32* %6, align 4
  %31 = sub nsw i32 %29, %30
  store i32 %31, i32* %4, align 4
  br label %38

32:                                               ; preds = %23
  br label %35

33:                                               ; preds = %20
  %34 = load i32, i32* %5, align 4
  store i32 %34, i32* %4, align 4
  br label %38

35:                                               ; preds = %32
  br label %36

36:                                               ; preds = %35, %19
  %37 = load i32*, i32** %7, align 8
  store i32 1, i32* %37, align 4
  store i32 50000, i32* %4, align 4
  br label %38

38:                                               ; preds = %36, %33, %28, %15
  %39 = load i32, i32* %4, align 4
  ret i32 %39
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_reciprocal(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca double, align 8
  store i32 %0, i32* %3, align 4
  %5 = load i32, i32* %3, align 4
  %6 = sitofp i32 %5 to double
  %7 = fdiv double 1.000000e+10, %6
  %8 = fadd double %7, 5.000000e-01
  %9 = call double @llvm.floor.f64(double %8)
  store double %9, double* %4, align 8
  %10 = load double, double* %4, align 8
  %11 = fcmp ole double %10, 0x41DFFFFFFFC00000
  br i1 %11, label %12, label %18

12:                                               ; preds = %1
  %13 = load double, double* %4, align 8
  %14 = fcmp oge double %13, 0xC1E0000000000000
  br i1 %14, label %15, label %18

15:                                               ; preds = %12
  %16 = load double, double* %4, align 8
  %17 = fptosi double %16 to i32
  store i32 %17, i32* %2, align 4
  br label %19

18:                                               ; preds = %12, %1
  store i32 0, i32* %2, align 4
  br label %19

19:                                               ; preds = %18, %15
  %20 = load i32, i32* %2, align 4
  ret i32 %20
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_icc_check_length(%struct.png_struct_def* noalias noundef %0, i8* noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca %struct.png_struct_def*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %5, align 8
  store i8* %1, i8** %6, align 8
  store i32 %2, i32* %7, align 4
  %8 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %9 = load i8*, i8** %6, align 8
  %10 = load i32, i32* %7, align 4
  %11 = call i32 @icc_check_length(%struct.png_struct_def* noundef %8, i8* noundef %9, i32 noundef %10)
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %14, label %13

13:                                               ; preds = %3
  store i32 0, i32* %4, align 4
  br label %28

14:                                               ; preds = %3
  %15 = load i32, i32* %7, align 4
  %16 = zext i32 %15 to i64
  %17 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %18 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %17, i32 0, i32 141
  %19 = load i64, i64* %18, align 8
  %20 = icmp ugt i64 %16, %19
  br i1 %20, label %21, label %27

21:                                               ; preds = %14
  %22 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %23 = load i8*, i8** %6, align 8
  %24 = load i32, i32* %7, align 4
  %25 = zext i32 %24 to i64
  %26 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %22, i8* noundef %23, i64 noundef %25, i8* noundef getelementptr inbounds ([17 x i8], [17 x i8]* @.str.20, i64 0, i64 0))
  store i32 %26, i32* %4, align 4
  br label %28

27:                                               ; preds = %14
  store i32 1, i32* %4, align 4
  br label %28

28:                                               ; preds = %27, %21, %13
  %29 = load i32, i32* %4, align 4
  ret i32 %29
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @icc_check_length(%struct.png_struct_def* noalias noundef %0, i8* noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca %struct.png_struct_def*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %5, align 8
  store i8* %1, i8** %6, align 8
  store i32 %2, i32* %7, align 4
  %8 = load i32, i32* %7, align 4
  %9 = icmp ult i32 %8, 132
  br i1 %9, label %10, label %16

10:                                               ; preds = %3
  %11 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %12 = load i8*, i8** %6, align 8
  %13 = load i32, i32* %7, align 4
  %14 = zext i32 %13 to i64
  %15 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %11, i8* noundef %12, i64 noundef %14, i8* noundef getelementptr inbounds ([10 x i8], [10 x i8]* @.str.57, i64 0, i64 0))
  store i32 %15, i32* %4, align 4
  br label %17

16:                                               ; preds = %3
  store i32 1, i32* %4, align 4
  br label %17

17:                                               ; preds = %16, %10
  %18 = load i32, i32* %4, align 4
  ret i32 %18
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @png_icc_profile_error(%struct.png_struct_def* noalias noundef %0, i8* noundef %1, i64 noundef %2, i8* noundef %3) #0 {
  %5 = alloca %struct.png_struct_def*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i8*, align 8
  %9 = alloca i64, align 8
  %10 = alloca [196 x i8], align 16
  %11 = alloca [24 x i8], align 16
  store %struct.png_struct_def* %0, %struct.png_struct_def** %5, align 8
  store i8* %1, i8** %6, align 8
  store i64 %2, i64* %7, align 8
  store i8* %3, i8** %8, align 8
  %12 = getelementptr inbounds [196 x i8], [196 x i8]* %10, i64 0, i64 0
  %13 = call i64 @png_safecat(i8* noundef %12, i64 noundef 196, i64 noundef 0, i8* noundef getelementptr inbounds ([10 x i8], [10 x i8]* @.str.58, i64 0, i64 0))
  store i64 %13, i64* %9, align 8
  %14 = getelementptr inbounds [196 x i8], [196 x i8]* %10, i64 0, i64 0
  %15 = load i64, i64* %9, align 8
  %16 = add i64 %15, 79
  %17 = load i64, i64* %9, align 8
  %18 = load i8*, i8** %6, align 8
  %19 = call i64 @png_safecat(i8* noundef %14, i64 noundef %16, i64 noundef %17, i8* noundef %18)
  store i64 %19, i64* %9, align 8
  %20 = getelementptr inbounds [196 x i8], [196 x i8]* %10, i64 0, i64 0
  %21 = load i64, i64* %9, align 8
  %22 = call i64 @png_safecat(i8* noundef %20, i64 noundef 196, i64 noundef %21, i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.59, i64 0, i64 0))
  store i64 %22, i64* %9, align 8
  %23 = load i64, i64* %7, align 8
  %24 = call i32 @is_ICC_signature(i64 noundef %23)
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %26, label %40

26:                                               ; preds = %4
  %27 = getelementptr inbounds [196 x i8], [196 x i8]* %10, i64 0, i64 0
  %28 = load i64, i64* %9, align 8
  %29 = getelementptr inbounds i8, i8* %27, i64 %28
  %30 = load i64, i64* %7, align 8
  %31 = trunc i64 %30 to i32
  call void @png_icc_tag_name(i8* noundef %29, i32 noundef %31)
  %32 = load i64, i64* %9, align 8
  %33 = add i64 %32, 6
  store i64 %33, i64* %9, align 8
  %34 = load i64, i64* %9, align 8
  %35 = add i64 %34, 1
  store i64 %35, i64* %9, align 8
  %36 = getelementptr inbounds [196 x i8], [196 x i8]* %10, i64 0, i64 %34
  store i8 58, i8* %36, align 1
  %37 = load i64, i64* %9, align 8
  %38 = add i64 %37, 1
  store i64 %38, i64* %9, align 8
  %39 = getelementptr inbounds [196 x i8], [196 x i8]* %10, i64 0, i64 %37
  store i8 32, i8* %39, align 1
  br label %52

40:                                               ; preds = %4
  %41 = getelementptr inbounds [196 x i8], [196 x i8]* %10, i64 0, i64 0
  %42 = load i64, i64* %9, align 8
  %43 = getelementptr inbounds [24 x i8], [24 x i8]* %11, i64 0, i64 0
  %44 = getelementptr inbounds [24 x i8], [24 x i8]* %11, i64 0, i64 0
  %45 = getelementptr inbounds i8, i8* %44, i64 24
  %46 = load i64, i64* %7, align 8
  %47 = call i8* @png_format_number(i8* noundef %43, i8* noundef %45, i32 noundef 3, i64 noundef %46)
  %48 = call i64 @png_safecat(i8* noundef %41, i64 noundef 196, i64 noundef %42, i8* noundef %47)
  store i64 %48, i64* %9, align 8
  %49 = getelementptr inbounds [196 x i8], [196 x i8]* %10, i64 0, i64 0
  %50 = load i64, i64* %9, align 8
  %51 = call i64 @png_safecat(i8* noundef %49, i64 noundef 196, i64 noundef %50, i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.60, i64 0, i64 0))
  store i64 %51, i64* %9, align 8
  br label %52

52:                                               ; preds = %40, %26
  %53 = getelementptr inbounds [196 x i8], [196 x i8]* %10, i64 0, i64 0
  %54 = load i64, i64* %9, align 8
  %55 = load i8*, i8** %8, align 8
  %56 = call i64 @png_safecat(i8* noundef %53, i64 noundef 196, i64 noundef %54, i8* noundef %55)
  store i64 %56, i64* %9, align 8
  %57 = load i64, i64* %9, align 8
  %58 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %59 = getelementptr inbounds [196 x i8], [196 x i8]* %10, i64 0, i64 0
  call void @png_chunk_benign_error(%struct.png_struct_def* noundef %58, i8* noundef %59)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_icc_check_header(%struct.png_struct_def* noalias noundef %0, i8* noundef %1, i32 noundef %2, i8* noundef %3, i32 noundef %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca %struct.png_struct_def*, align 8
  %8 = alloca i8*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i8*, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %7, align 8
  store i8* %1, i8** %8, align 8
  store i32 %2, i32* %9, align 4
  store i8* %3, i8** %10, align 8
  store i32 %4, i32* %11, align 4
  %13 = load i8*, i8** %10, align 8
  %14 = load i8, i8* %13, align 1
  %15 = zext i8 %14 to i32
  %16 = shl i32 %15, 24
  %17 = load i8*, i8** %10, align 8
  %18 = getelementptr inbounds i8, i8* %17, i64 1
  %19 = load i8, i8* %18, align 1
  %20 = zext i8 %19 to i32
  %21 = shl i32 %20, 16
  %22 = add i32 %16, %21
  %23 = load i8*, i8** %10, align 8
  %24 = getelementptr inbounds i8, i8* %23, i64 2
  %25 = load i8, i8* %24, align 1
  %26 = zext i8 %25 to i32
  %27 = shl i32 %26, 8
  %28 = add i32 %22, %27
  %29 = load i8*, i8** %10, align 8
  %30 = getelementptr inbounds i8, i8* %29, i64 3
  %31 = load i8, i8* %30, align 1
  %32 = zext i8 %31 to i32
  %33 = add i32 %28, %32
  store i32 %33, i32* %12, align 4
  %34 = load i32, i32* %12, align 4
  %35 = load i32, i32* %9, align 4
  %36 = icmp ne i32 %34, %35
  br i1 %36, label %37, label %43

37:                                               ; preds = %5
  %38 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %39 = load i8*, i8** %8, align 8
  %40 = load i32, i32* %12, align 4
  %41 = zext i32 %40 to i64
  %42 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %38, i8* noundef %39, i64 noundef %41, i8* noundef getelementptr inbounds ([30 x i8], [30 x i8]* @.str.21, i64 0, i64 0))
  store i32 %42, i32* %6, align 4
  br label %328

43:                                               ; preds = %5
  %44 = load i8*, i8** %10, align 8
  %45 = getelementptr inbounds i8, i8* %44, i64 8
  %46 = load i8, i8* %45, align 1
  %47 = zext i8 %46 to i32
  store i32 %47, i32* %12, align 4
  %48 = load i32, i32* %12, align 4
  %49 = icmp ugt i32 %48, 3
  br i1 %49, label %50, label %60

50:                                               ; preds = %43
  %51 = load i32, i32* %9, align 4
  %52 = and i32 %51, 3
  %53 = icmp ne i32 %52, 0
  br i1 %53, label %54, label %60

54:                                               ; preds = %50
  %55 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %56 = load i8*, i8** %8, align 8
  %57 = load i32, i32* %9, align 4
  %58 = zext i32 %57 to i64
  %59 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %55, i8* noundef %56, i64 noundef %58, i8* noundef getelementptr inbounds ([15 x i8], [15 x i8]* @.str.22, i64 0, i64 0))
  store i32 %59, i32* %6, align 4
  br label %328

60:                                               ; preds = %50, %43
  %61 = load i8*, i8** %10, align 8
  %62 = getelementptr inbounds i8, i8* %61, i64 128
  %63 = load i8, i8* %62, align 1
  %64 = zext i8 %63 to i32
  %65 = shl i32 %64, 24
  %66 = load i8*, i8** %10, align 8
  %67 = getelementptr inbounds i8, i8* %66, i64 128
  %68 = getelementptr inbounds i8, i8* %67, i64 1
  %69 = load i8, i8* %68, align 1
  %70 = zext i8 %69 to i32
  %71 = shl i32 %70, 16
  %72 = add i32 %65, %71
  %73 = load i8*, i8** %10, align 8
  %74 = getelementptr inbounds i8, i8* %73, i64 128
  %75 = getelementptr inbounds i8, i8* %74, i64 2
  %76 = load i8, i8* %75, align 1
  %77 = zext i8 %76 to i32
  %78 = shl i32 %77, 8
  %79 = add i32 %72, %78
  %80 = load i8*, i8** %10, align 8
  %81 = getelementptr inbounds i8, i8* %80, i64 128
  %82 = getelementptr inbounds i8, i8* %81, i64 3
  %83 = load i8, i8* %82, align 1
  %84 = zext i8 %83 to i32
  %85 = add i32 %79, %84
  store i32 %85, i32* %12, align 4
  %86 = load i32, i32* %12, align 4
  %87 = icmp ugt i32 %86, 357913930
  br i1 %87, label %94, label %88

88:                                               ; preds = %60
  %89 = load i32, i32* %9, align 4
  %90 = load i32, i32* %12, align 4
  %91 = mul i32 12, %90
  %92 = add i32 132, %91
  %93 = icmp ult i32 %89, %92
  br i1 %93, label %94, label %100

94:                                               ; preds = %88, %60
  %95 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %96 = load i8*, i8** %8, align 8
  %97 = load i32, i32* %12, align 4
  %98 = zext i32 %97 to i64
  %99 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %95, i8* noundef %96, i64 noundef %98, i8* noundef getelementptr inbounds ([20 x i8], [20 x i8]* @.str.23, i64 0, i64 0))
  store i32 %99, i32* %6, align 4
  br label %328

100:                                              ; preds = %88
  %101 = load i8*, i8** %10, align 8
  %102 = getelementptr inbounds i8, i8* %101, i64 64
  %103 = load i8, i8* %102, align 1
  %104 = zext i8 %103 to i32
  %105 = shl i32 %104, 24
  %106 = load i8*, i8** %10, align 8
  %107 = getelementptr inbounds i8, i8* %106, i64 64
  %108 = getelementptr inbounds i8, i8* %107, i64 1
  %109 = load i8, i8* %108, align 1
  %110 = zext i8 %109 to i32
  %111 = shl i32 %110, 16
  %112 = add i32 %105, %111
  %113 = load i8*, i8** %10, align 8
  %114 = getelementptr inbounds i8, i8* %113, i64 64
  %115 = getelementptr inbounds i8, i8* %114, i64 2
  %116 = load i8, i8* %115, align 1
  %117 = zext i8 %116 to i32
  %118 = shl i32 %117, 8
  %119 = add i32 %112, %118
  %120 = load i8*, i8** %10, align 8
  %121 = getelementptr inbounds i8, i8* %120, i64 64
  %122 = getelementptr inbounds i8, i8* %121, i64 3
  %123 = load i8, i8* %122, align 1
  %124 = zext i8 %123 to i32
  %125 = add i32 %119, %124
  store i32 %125, i32* %12, align 4
  %126 = load i32, i32* %12, align 4
  %127 = icmp uge i32 %126, 65535
  br i1 %127, label %128, label %134

128:                                              ; preds = %100
  %129 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %130 = load i8*, i8** %8, align 8
  %131 = load i32, i32* %12, align 4
  %132 = zext i32 %131 to i64
  %133 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %129, i8* noundef %130, i64 noundef %132, i8* noundef getelementptr inbounds ([25 x i8], [25 x i8]* @.str.24, i64 0, i64 0))
  store i32 %133, i32* %6, align 4
  br label %328

134:                                              ; preds = %100
  %135 = load i32, i32* %12, align 4
  %136 = icmp uge i32 %135, 4
  br i1 %136, label %137, label %143

137:                                              ; preds = %134
  %138 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %139 = load i8*, i8** %8, align 8
  %140 = load i32, i32* %12, align 4
  %141 = zext i32 %140 to i64
  %142 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %138, i8* noundef %139, i64 noundef %141, i8* noundef getelementptr inbounds ([29 x i8], [29 x i8]* @.str.25, i64 0, i64 0))
  br label %143

143:                                              ; preds = %137, %134
  %144 = load i8*, i8** %10, align 8
  %145 = getelementptr inbounds i8, i8* %144, i64 36
  %146 = load i8, i8* %145, align 1
  %147 = zext i8 %146 to i32
  %148 = shl i32 %147, 24
  %149 = load i8*, i8** %10, align 8
  %150 = getelementptr inbounds i8, i8* %149, i64 36
  %151 = getelementptr inbounds i8, i8* %150, i64 1
  %152 = load i8, i8* %151, align 1
  %153 = zext i8 %152 to i32
  %154 = shl i32 %153, 16
  %155 = add i32 %148, %154
  %156 = load i8*, i8** %10, align 8
  %157 = getelementptr inbounds i8, i8* %156, i64 36
  %158 = getelementptr inbounds i8, i8* %157, i64 2
  %159 = load i8, i8* %158, align 1
  %160 = zext i8 %159 to i32
  %161 = shl i32 %160, 8
  %162 = add i32 %155, %161
  %163 = load i8*, i8** %10, align 8
  %164 = getelementptr inbounds i8, i8* %163, i64 36
  %165 = getelementptr inbounds i8, i8* %164, i64 3
  %166 = load i8, i8* %165, align 1
  %167 = zext i8 %166 to i32
  %168 = add i32 %162, %167
  store i32 %168, i32* %12, align 4
  %169 = load i32, i32* %12, align 4
  %170 = icmp ne i32 %169, 1633907568
  br i1 %170, label %171, label %177

171:                                              ; preds = %143
  %172 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %173 = load i8*, i8** %8, align 8
  %174 = load i32, i32* %12, align 4
  %175 = zext i32 %174 to i64
  %176 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %172, i8* noundef %173, i64 noundef %175, i8* noundef getelementptr inbounds ([18 x i8], [18 x i8]* @.str.26, i64 0, i64 0))
  store i32 %176, i32* %6, align 4
  br label %328

177:                                              ; preds = %143
  %178 = load i8*, i8** %10, align 8
  %179 = getelementptr inbounds i8, i8* %178, i64 68
  %180 = call i32 @memcmp(i8* noundef %179, i8* noundef getelementptr inbounds ([12 x i8], [12 x i8]* @D50_nCIEXYZ, i64 0, i64 0), i64 noundef 12) #11
  %181 = icmp ne i32 %180, 0
  br i1 %181, label %182, label %186

182:                                              ; preds = %177
  %183 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %184 = load i8*, i8** %8, align 8
  %185 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %183, i8* noundef %184, i64 noundef 0, i8* noundef getelementptr inbounds ([26 x i8], [26 x i8]* @.str.27, i64 0, i64 0))
  br label %186

186:                                              ; preds = %182, %177
  %187 = load i8*, i8** %10, align 8
  %188 = getelementptr inbounds i8, i8* %187, i64 16
  %189 = load i8, i8* %188, align 1
  %190 = zext i8 %189 to i32
  %191 = shl i32 %190, 24
  %192 = load i8*, i8** %10, align 8
  %193 = getelementptr inbounds i8, i8* %192, i64 16
  %194 = getelementptr inbounds i8, i8* %193, i64 1
  %195 = load i8, i8* %194, align 1
  %196 = zext i8 %195 to i32
  %197 = shl i32 %196, 16
  %198 = add i32 %191, %197
  %199 = load i8*, i8** %10, align 8
  %200 = getelementptr inbounds i8, i8* %199, i64 16
  %201 = getelementptr inbounds i8, i8* %200, i64 2
  %202 = load i8, i8* %201, align 1
  %203 = zext i8 %202 to i32
  %204 = shl i32 %203, 8
  %205 = add i32 %198, %204
  %206 = load i8*, i8** %10, align 8
  %207 = getelementptr inbounds i8, i8* %206, i64 16
  %208 = getelementptr inbounds i8, i8* %207, i64 3
  %209 = load i8, i8* %208, align 1
  %210 = zext i8 %209 to i32
  %211 = add i32 %205, %210
  store i32 %211, i32* %12, align 4
  %212 = load i32, i32* %12, align 4
  switch i32 %212, label %235 [
    i32 1380401696, label %213
    i32 1196573017, label %224
  ]

213:                                              ; preds = %186
  %214 = load i32, i32* %11, align 4
  %215 = and i32 %214, 2
  %216 = icmp eq i32 %215, 0
  br i1 %216, label %217, label %223

217:                                              ; preds = %213
  %218 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %219 = load i8*, i8** %8, align 8
  %220 = load i32, i32* %12, align 4
  %221 = zext i32 %220 to i64
  %222 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %218, i8* noundef %219, i64 noundef %221, i8* noundef getelementptr inbounds ([47 x i8], [47 x i8]* @.str.28, i64 0, i64 0))
  store i32 %222, i32* %6, align 4
  br label %328

223:                                              ; preds = %213
  br label %241

224:                                              ; preds = %186
  %225 = load i32, i32* %11, align 4
  %226 = and i32 %225, 2
  %227 = icmp ne i32 %226, 0
  br i1 %227, label %228, label %234

228:                                              ; preds = %224
  %229 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %230 = load i8*, i8** %8, align 8
  %231 = load i32, i32* %12, align 4
  %232 = zext i32 %231 to i64
  %233 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %229, i8* noundef %230, i64 noundef %232, i8* noundef getelementptr inbounds ([42 x i8], [42 x i8]* @.str.29, i64 0, i64 0))
  store i32 %233, i32* %6, align 4
  br label %328

234:                                              ; preds = %224
  br label %241

235:                                              ; preds = %186
  %236 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %237 = load i8*, i8** %8, align 8
  %238 = load i32, i32* %12, align 4
  %239 = zext i32 %238 to i64
  %240 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %236, i8* noundef %237, i64 noundef %239, i8* noundef getelementptr inbounds ([32 x i8], [32 x i8]* @.str.30, i64 0, i64 0))
  store i32 %240, i32* %6, align 4
  br label %328

241:                                              ; preds = %234, %223
  %242 = load i8*, i8** %10, align 8
  %243 = getelementptr inbounds i8, i8* %242, i64 12
  %244 = load i8, i8* %243, align 1
  %245 = zext i8 %244 to i32
  %246 = shl i32 %245, 24
  %247 = load i8*, i8** %10, align 8
  %248 = getelementptr inbounds i8, i8* %247, i64 12
  %249 = getelementptr inbounds i8, i8* %248, i64 1
  %250 = load i8, i8* %249, align 1
  %251 = zext i8 %250 to i32
  %252 = shl i32 %251, 16
  %253 = add i32 %246, %252
  %254 = load i8*, i8** %10, align 8
  %255 = getelementptr inbounds i8, i8* %254, i64 12
  %256 = getelementptr inbounds i8, i8* %255, i64 2
  %257 = load i8, i8* %256, align 1
  %258 = zext i8 %257 to i32
  %259 = shl i32 %258, 8
  %260 = add i32 %253, %259
  %261 = load i8*, i8** %10, align 8
  %262 = getelementptr inbounds i8, i8* %261, i64 12
  %263 = getelementptr inbounds i8, i8* %262, i64 3
  %264 = load i8, i8* %263, align 1
  %265 = zext i8 %264 to i32
  %266 = add i32 %260, %265
  store i32 %266, i32* %12, align 4
  %267 = load i32, i32* %12, align 4
  switch i32 %267, label %287 [
    i32 1935896178, label %268
    i32 1835955314, label %268
    i32 1886549106, label %268
    i32 1936744803, label %268
    i32 1633842036, label %269
    i32 1818848875, label %275
    i32 1852662636, label %281
  ]

268:                                              ; preds = %241, %241, %241, %241
  br label %293

269:                                              ; preds = %241
  %270 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %271 = load i8*, i8** %8, align 8
  %272 = load i32, i32* %12, align 4
  %273 = zext i32 %272 to i64
  %274 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %270, i8* noundef %271, i64 noundef %273, i8* noundef getelementptr inbounds ([38 x i8], [38 x i8]* @.str.31, i64 0, i64 0))
  store i32 %274, i32* %6, align 4
  br label %328

275:                                              ; preds = %241
  %276 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %277 = load i8*, i8** %8, align 8
  %278 = load i32, i32* %12, align 4
  %279 = zext i32 %278 to i64
  %280 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %276, i8* noundef %277, i64 noundef %279, i8* noundef getelementptr inbounds ([40 x i8], [40 x i8]* @.str.32, i64 0, i64 0))
  store i32 %280, i32* %6, align 4
  br label %328

281:                                              ; preds = %241
  %282 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %283 = load i8*, i8** %8, align 8
  %284 = load i32, i32* %12, align 4
  %285 = zext i32 %284 to i64
  %286 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %282, i8* noundef %283, i64 noundef %285, i8* noundef getelementptr inbounds ([40 x i8], [40 x i8]* @.str.33, i64 0, i64 0))
  br label %293

287:                                              ; preds = %241
  %288 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %289 = load i8*, i8** %8, align 8
  %290 = load i32, i32* %12, align 4
  %291 = zext i32 %290 to i64
  %292 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %288, i8* noundef %289, i64 noundef %291, i8* noundef getelementptr inbounds ([31 x i8], [31 x i8]* @.str.34, i64 0, i64 0))
  br label %293

293:                                              ; preds = %287, %281, %268
  %294 = load i8*, i8** %10, align 8
  %295 = getelementptr inbounds i8, i8* %294, i64 20
  %296 = load i8, i8* %295, align 1
  %297 = zext i8 %296 to i32
  %298 = shl i32 %297, 24
  %299 = load i8*, i8** %10, align 8
  %300 = getelementptr inbounds i8, i8* %299, i64 20
  %301 = getelementptr inbounds i8, i8* %300, i64 1
  %302 = load i8, i8* %301, align 1
  %303 = zext i8 %302 to i32
  %304 = shl i32 %303, 16
  %305 = add i32 %298, %304
  %306 = load i8*, i8** %10, align 8
  %307 = getelementptr inbounds i8, i8* %306, i64 20
  %308 = getelementptr inbounds i8, i8* %307, i64 2
  %309 = load i8, i8* %308, align 1
  %310 = zext i8 %309 to i32
  %311 = shl i32 %310, 8
  %312 = add i32 %305, %311
  %313 = load i8*, i8** %10, align 8
  %314 = getelementptr inbounds i8, i8* %313, i64 20
  %315 = getelementptr inbounds i8, i8* %314, i64 3
  %316 = load i8, i8* %315, align 1
  %317 = zext i8 %316 to i32
  %318 = add i32 %312, %317
  store i32 %318, i32* %12, align 4
  %319 = load i32, i32* %12, align 4
  switch i32 %319, label %321 [
    i32 1482250784, label %320
    i32 1281450528, label %320
  ]

320:                                              ; preds = %293, %293
  br label %327

321:                                              ; preds = %293
  %322 = load %struct.png_struct_def*, %struct.png_struct_def** %7, align 8
  %323 = load i8*, i8** %8, align 8
  %324 = load i32, i32* %12, align 4
  %325 = zext i32 %324 to i64
  %326 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %322, i8* noundef %323, i64 noundef %325, i8* noundef getelementptr inbounds ([28 x i8], [28 x i8]* @.str.35, i64 0, i64 0))
  store i32 %326, i32* %6, align 4
  br label %328

327:                                              ; preds = %320
  store i32 1, i32* %6, align 4
  br label %328

328:                                              ; preds = %327, %321, %275, %269, %235, %228, %217, %171, %128, %94, %54, %37
  %329 = load i32, i32* %6, align 4
  ret i32 %329
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_icc_check_tag_table(%struct.png_struct_def* noalias noundef %0, i8* noundef %1, i32 noundef %2, i8* noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca %struct.png_struct_def*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  %9 = alloca i8*, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i8*, align 8
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %6, align 8
  store i8* %1, i8** %7, align 8
  store i32 %2, i32* %8, align 4
  store i8* %3, i8** %9, align 8
  %16 = load i8*, i8** %9, align 8
  %17 = getelementptr inbounds i8, i8* %16, i64 128
  %18 = load i8, i8* %17, align 1
  %19 = zext i8 %18 to i32
  %20 = shl i32 %19, 24
  %21 = load i8*, i8** %9, align 8
  %22 = getelementptr inbounds i8, i8* %21, i64 128
  %23 = getelementptr inbounds i8, i8* %22, i64 1
  %24 = load i8, i8* %23, align 1
  %25 = zext i8 %24 to i32
  %26 = shl i32 %25, 16
  %27 = add i32 %20, %26
  %28 = load i8*, i8** %9, align 8
  %29 = getelementptr inbounds i8, i8* %28, i64 128
  %30 = getelementptr inbounds i8, i8* %29, i64 2
  %31 = load i8, i8* %30, align 1
  %32 = zext i8 %31 to i32
  %33 = shl i32 %32, 8
  %34 = add i32 %27, %33
  %35 = load i8*, i8** %9, align 8
  %36 = getelementptr inbounds i8, i8* %35, i64 128
  %37 = getelementptr inbounds i8, i8* %36, i64 3
  %38 = load i8, i8* %37, align 1
  %39 = zext i8 %38 to i32
  %40 = add i32 %34, %39
  store i32 %40, i32* %10, align 4
  %41 = load i8*, i8** %9, align 8
  %42 = getelementptr inbounds i8, i8* %41, i64 132
  store i8* %42, i8** %12, align 8
  store i32 0, i32* %11, align 4
  br label %43

43:                                               ; preds = %149, %4
  %44 = load i32, i32* %11, align 4
  %45 = load i32, i32* %10, align 4
  %46 = icmp ult i32 %44, %45
  br i1 %46, label %47, label %154

47:                                               ; preds = %43
  %48 = load i8*, i8** %12, align 8
  %49 = getelementptr inbounds i8, i8* %48, i64 0
  %50 = load i8, i8* %49, align 1
  %51 = zext i8 %50 to i32
  %52 = shl i32 %51, 24
  %53 = load i8*, i8** %12, align 8
  %54 = getelementptr inbounds i8, i8* %53, i64 0
  %55 = getelementptr inbounds i8, i8* %54, i64 1
  %56 = load i8, i8* %55, align 1
  %57 = zext i8 %56 to i32
  %58 = shl i32 %57, 16
  %59 = add i32 %52, %58
  %60 = load i8*, i8** %12, align 8
  %61 = getelementptr inbounds i8, i8* %60, i64 0
  %62 = getelementptr inbounds i8, i8* %61, i64 2
  %63 = load i8, i8* %62, align 1
  %64 = zext i8 %63 to i32
  %65 = shl i32 %64, 8
  %66 = add i32 %59, %65
  %67 = load i8*, i8** %12, align 8
  %68 = getelementptr inbounds i8, i8* %67, i64 0
  %69 = getelementptr inbounds i8, i8* %68, i64 3
  %70 = load i8, i8* %69, align 1
  %71 = zext i8 %70 to i32
  %72 = add i32 %66, %71
  store i32 %72, i32* %13, align 4
  %73 = load i8*, i8** %12, align 8
  %74 = getelementptr inbounds i8, i8* %73, i64 4
  %75 = load i8, i8* %74, align 1
  %76 = zext i8 %75 to i32
  %77 = shl i32 %76, 24
  %78 = load i8*, i8** %12, align 8
  %79 = getelementptr inbounds i8, i8* %78, i64 4
  %80 = getelementptr inbounds i8, i8* %79, i64 1
  %81 = load i8, i8* %80, align 1
  %82 = zext i8 %81 to i32
  %83 = shl i32 %82, 16
  %84 = add i32 %77, %83
  %85 = load i8*, i8** %12, align 8
  %86 = getelementptr inbounds i8, i8* %85, i64 4
  %87 = getelementptr inbounds i8, i8* %86, i64 2
  %88 = load i8, i8* %87, align 1
  %89 = zext i8 %88 to i32
  %90 = shl i32 %89, 8
  %91 = add i32 %84, %90
  %92 = load i8*, i8** %12, align 8
  %93 = getelementptr inbounds i8, i8* %92, i64 4
  %94 = getelementptr inbounds i8, i8* %93, i64 3
  %95 = load i8, i8* %94, align 1
  %96 = zext i8 %95 to i32
  %97 = add i32 %91, %96
  store i32 %97, i32* %14, align 4
  %98 = load i8*, i8** %12, align 8
  %99 = getelementptr inbounds i8, i8* %98, i64 8
  %100 = load i8, i8* %99, align 1
  %101 = zext i8 %100 to i32
  %102 = shl i32 %101, 24
  %103 = load i8*, i8** %12, align 8
  %104 = getelementptr inbounds i8, i8* %103, i64 8
  %105 = getelementptr inbounds i8, i8* %104, i64 1
  %106 = load i8, i8* %105, align 1
  %107 = zext i8 %106 to i32
  %108 = shl i32 %107, 16
  %109 = add i32 %102, %108
  %110 = load i8*, i8** %12, align 8
  %111 = getelementptr inbounds i8, i8* %110, i64 8
  %112 = getelementptr inbounds i8, i8* %111, i64 2
  %113 = load i8, i8* %112, align 1
  %114 = zext i8 %113 to i32
  %115 = shl i32 %114, 8
  %116 = add i32 %109, %115
  %117 = load i8*, i8** %12, align 8
  %118 = getelementptr inbounds i8, i8* %117, i64 8
  %119 = getelementptr inbounds i8, i8* %118, i64 3
  %120 = load i8, i8* %119, align 1
  %121 = zext i8 %120 to i32
  %122 = add i32 %116, %121
  store i32 %122, i32* %15, align 4
  %123 = load i32, i32* %14, align 4
  %124 = load i32, i32* %8, align 4
  %125 = icmp ugt i32 %123, %124
  br i1 %125, label %132, label %126

126:                                              ; preds = %47
  %127 = load i32, i32* %15, align 4
  %128 = load i32, i32* %8, align 4
  %129 = load i32, i32* %14, align 4
  %130 = sub i32 %128, %129
  %131 = icmp ugt i32 %127, %130
  br i1 %131, label %132, label %138

132:                                              ; preds = %126, %47
  %133 = load %struct.png_struct_def*, %struct.png_struct_def** %6, align 8
  %134 = load i8*, i8** %7, align 8
  %135 = load i32, i32* %13, align 4
  %136 = zext i32 %135 to i64
  %137 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %133, i8* noundef %134, i64 noundef %136, i8* noundef getelementptr inbounds ([32 x i8], [32 x i8]* @.str.36, i64 0, i64 0))
  store i32 %137, i32* %5, align 4
  br label %155

138:                                              ; preds = %126
  %139 = load i32, i32* %14, align 4
  %140 = and i32 %139, 3
  %141 = icmp ne i32 %140, 0
  br i1 %141, label %142, label %148

142:                                              ; preds = %138
  %143 = load %struct.png_struct_def*, %struct.png_struct_def** %6, align 8
  %144 = load i8*, i8** %7, align 8
  %145 = load i32, i32* %13, align 4
  %146 = zext i32 %145 to i64
  %147 = call i32 @png_icc_profile_error(%struct.png_struct_def* noundef %143, i8* noundef %144, i64 noundef %146, i8* noundef getelementptr inbounds ([42 x i8], [42 x i8]* @.str.37, i64 0, i64 0))
  br label %148

148:                                              ; preds = %142, %138
  br label %149

149:                                              ; preds = %148
  %150 = load i32, i32* %11, align 4
  %151 = add i32 %150, 1
  store i32 %151, i32* %11, align 4
  %152 = load i8*, i8** %12, align 8
  %153 = getelementptr inbounds i8, i8* %152, i64 12
  store i8* %153, i8** %12, align 8
  br label %43, !llvm.loop !16

154:                                              ; preds = %43
  store i32 1, i32* %5, align 4
  br label %155

155:                                              ; preds = %154, %132
  %156 = load i32, i32* %5, align 4
  ret i32 %156
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_set_rgb_coefficients(%struct.png_struct_def* noalias noundef %0) #0 {
  %2 = alloca %struct.png_struct_def*, align 8
  %3 = alloca %struct.png_XYZ, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %2, align 8
  %9 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %10 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %9, i32 0, i32 124
  %11 = load i8, i8* %10, align 1
  %12 = zext i8 %11 to i32
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %14, label %162

14:                                               ; preds = %1
  %15 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %16 = call i32 @have_chromaticities(%struct.png_struct_def* noundef %15)
  %17 = icmp ne i32 %16, 0
  br i1 %17, label %18, label %156

18:                                               ; preds = %14
  %19 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %20 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %19, i32 0, i32 80
  %21 = call i32 @png_XYZ_from_xy(%struct.png_XYZ* noundef %3, %struct.png_xy* noundef %20)
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %23, label %156

23:                                               ; preds = %18
  %24 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %3, i32 0, i32 1
  %25 = load i32, i32* %24, align 4
  store i32 %25, i32* %4, align 4
  %26 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %3, i32 0, i32 4
  %27 = load i32, i32* %26, align 4
  store i32 %27, i32* %5, align 4
  %28 = getelementptr inbounds %struct.png_XYZ, %struct.png_XYZ* %3, i32 0, i32 7
  %29 = load i32, i32* %28, align 4
  store i32 %29, i32* %6, align 4
  %30 = load i32, i32* %4, align 4
  %31 = load i32, i32* %5, align 4
  %32 = add nsw i32 %30, %31
  %33 = load i32, i32* %6, align 4
  %34 = add nsw i32 %32, %33
  store i32 %34, i32* %7, align 4
  %35 = load i32, i32* %7, align 4
  %36 = icmp sgt i32 %35, 0
  br i1 %36, label %37, label %155

37:                                               ; preds = %23
  %38 = load i32, i32* %4, align 4
  %39 = icmp sge i32 %38, 0
  br i1 %39, label %40, label %155

40:                                               ; preds = %37
  %41 = load i32, i32* %4, align 4
  %42 = load i32, i32* %7, align 4
  %43 = call i32 @png_muldiv(i32* noundef %4, i32 noundef %41, i32 noundef 32768, i32 noundef %42)
  %44 = icmp ne i32 %43, 0
  br i1 %44, label %45, label %155

45:                                               ; preds = %40
  %46 = load i32, i32* %4, align 4
  %47 = icmp sge i32 %46, 0
  br i1 %47, label %48, label %155

48:                                               ; preds = %45
  %49 = load i32, i32* %4, align 4
  %50 = icmp sle i32 %49, 32768
  br i1 %50, label %51, label %155

51:                                               ; preds = %48
  %52 = load i32, i32* %5, align 4
  %53 = icmp sge i32 %52, 0
  br i1 %53, label %54, label %155

54:                                               ; preds = %51
  %55 = load i32, i32* %5, align 4
  %56 = load i32, i32* %7, align 4
  %57 = call i32 @png_muldiv(i32* noundef %5, i32 noundef %55, i32 noundef 32768, i32 noundef %56)
  %58 = icmp ne i32 %57, 0
  br i1 %58, label %59, label %155

59:                                               ; preds = %54
  %60 = load i32, i32* %5, align 4
  %61 = icmp sge i32 %60, 0
  br i1 %61, label %62, label %155

62:                                               ; preds = %59
  %63 = load i32, i32* %5, align 4
  %64 = icmp sle i32 %63, 32768
  br i1 %64, label %65, label %155

65:                                               ; preds = %62
  %66 = load i32, i32* %6, align 4
  %67 = icmp sge i32 %66, 0
  br i1 %67, label %68, label %155

68:                                               ; preds = %65
  %69 = load i32, i32* %6, align 4
  %70 = load i32, i32* %7, align 4
  %71 = call i32 @png_muldiv(i32* noundef %6, i32 noundef %69, i32 noundef 32768, i32 noundef %70)
  %72 = icmp ne i32 %71, 0
  br i1 %72, label %73, label %155

73:                                               ; preds = %68
  %74 = load i32, i32* %6, align 4
  %75 = icmp sge i32 %74, 0
  br i1 %75, label %76, label %155

76:                                               ; preds = %73
  %77 = load i32, i32* %6, align 4
  %78 = icmp sle i32 %77, 32768
  br i1 %78, label %79, label %155

79:                                               ; preds = %76
  %80 = load i32, i32* %4, align 4
  %81 = load i32, i32* %5, align 4
  %82 = add nsw i32 %80, %81
  %83 = load i32, i32* %6, align 4
  %84 = add nsw i32 %82, %83
  %85 = icmp sle i32 %84, 32769
  br i1 %85, label %86, label %155

86:                                               ; preds = %79
  store i32 0, i32* %8, align 4
  %87 = load i32, i32* %4, align 4
  %88 = load i32, i32* %5, align 4
  %89 = add nsw i32 %87, %88
  %90 = load i32, i32* %6, align 4
  %91 = add nsw i32 %89, %90
  %92 = icmp sgt i32 %91, 32768
  br i1 %92, label %93, label %94

93:                                               ; preds = %86
  store i32 -1, i32* %8, align 4
  br label %103

94:                                               ; preds = %86
  %95 = load i32, i32* %4, align 4
  %96 = load i32, i32* %5, align 4
  %97 = add nsw i32 %95, %96
  %98 = load i32, i32* %6, align 4
  %99 = add nsw i32 %97, %98
  %100 = icmp slt i32 %99, 32768
  br i1 %100, label %101, label %102

101:                                              ; preds = %94
  store i32 1, i32* %8, align 4
  br label %102

102:                                              ; preds = %101, %94
  br label %103

103:                                              ; preds = %102, %93
  %104 = load i32, i32* %8, align 4
  %105 = icmp ne i32 %104, 0
  br i1 %105, label %106, label %136

106:                                              ; preds = %103
  %107 = load i32, i32* %5, align 4
  %108 = load i32, i32* %4, align 4
  %109 = icmp sge i32 %107, %108
  br i1 %109, label %110, label %118

110:                                              ; preds = %106
  %111 = load i32, i32* %5, align 4
  %112 = load i32, i32* %6, align 4
  %113 = icmp sge i32 %111, %112
  br i1 %113, label %114, label %118

114:                                              ; preds = %110
  %115 = load i32, i32* %8, align 4
  %116 = load i32, i32* %5, align 4
  %117 = add nsw i32 %116, %115
  store i32 %117, i32* %5, align 4
  br label %135

118:                                              ; preds = %110, %106
  %119 = load i32, i32* %4, align 4
  %120 = load i32, i32* %5, align 4
  %121 = icmp sge i32 %119, %120
  br i1 %121, label %122, label %130

122:                                              ; preds = %118
  %123 = load i32, i32* %4, align 4
  %124 = load i32, i32* %6, align 4
  %125 = icmp sge i32 %123, %124
  br i1 %125, label %126, label %130

126:                                              ; preds = %122
  %127 = load i32, i32* %8, align 4
  %128 = load i32, i32* %4, align 4
  %129 = add nsw i32 %128, %127
  store i32 %129, i32* %4, align 4
  br label %134

130:                                              ; preds = %122, %118
  %131 = load i32, i32* %8, align 4
  %132 = load i32, i32* %6, align 4
  %133 = add nsw i32 %132, %131
  store i32 %133, i32* %6, align 4
  br label %134

134:                                              ; preds = %130, %126
  br label %135

135:                                              ; preds = %134, %114
  br label %136

136:                                              ; preds = %135, %103
  %137 = load i32, i32* %4, align 4
  %138 = load i32, i32* %5, align 4
  %139 = add nsw i32 %137, %138
  %140 = load i32, i32* %6, align 4
  %141 = add nsw i32 %139, %140
  %142 = icmp ne i32 %141, 32768
  br i1 %142, label %143, label %145

143:                                              ; preds = %136
  %144 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  call void @png_error(%struct.png_struct_def* noundef %144, i8* noundef getelementptr inbounds ([42 x i8], [42 x i8]* @.str.38, i64 0, i64 0)) #10
  unreachable

145:                                              ; preds = %136
  %146 = load i32, i32* %4, align 4
  %147 = trunc i32 %146 to i16
  %148 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %149 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %148, i32 0, i32 125
  store i16 %147, i16* %149, align 2
  %150 = load i32, i32* %5, align 4
  %151 = trunc i32 %150 to i16
  %152 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %153 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %152, i32 0, i32 126
  store i16 %151, i16* %153, align 4
  br label %154

154:                                              ; preds = %145
  br label %155

155:                                              ; preds = %154, %79, %76, %73, %68, %65, %62, %59, %54, %51, %48, %45, %40, %37, %23
  br label %161

156:                                              ; preds = %18, %14
  %157 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %158 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %157, i32 0, i32 125
  store i16 6968, i16* %158, align 2
  %159 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %160 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %159, i32 0, i32 126
  store i16 23434, i16* %160, align 4
  br label %161

161:                                              ; preds = %156, %155
  br label %162

162:                                              ; preds = %161, %1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @have_chromaticities(%struct.png_struct_def* noalias noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.png_struct_def*, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %3, align 8
  %4 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %5 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %4, i32 0, i32 37
  %6 = load i32, i32* %5, align 8
  %7 = and i32 %6, 8388608
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %10

9:                                                ; preds = %1
  store i32 0, i32* %2, align 4
  br label %18

10:                                               ; preds = %1
  %11 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %12 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %11, i32 0, i32 37
  %13 = load i32, i32* %12, align 8
  %14 = and i32 %13, 64
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %16, label %17

16:                                               ; preds = %10
  store i32 1, i32* %2, align 4
  br label %18

17:                                               ; preds = %10
  store i32 0, i32* %2, align 4
  br label %18

18:                                               ; preds = %17, %16, %9
  %19 = load i32, i32* %2, align 4
  ret i32 %19
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_check_IHDR(%struct.png_struct_def* noalias noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3, i32 noundef %4, i32 noundef %5, i32 noundef %6, i32 noundef %7) #0 {
  %9 = alloca %struct.png_struct_def*, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %9, align 8
  store i32 %1, i32* %10, align 4
  store i32 %2, i32* %11, align 4
  store i32 %3, i32* %12, align 4
  store i32 %4, i32* %13, align 4
  store i32 %5, i32* %14, align 4
  store i32 %6, i32* %15, align 4
  store i32 %7, i32* %16, align 4
  store i32 0, i32* %17, align 4
  %18 = load i32, i32* %10, align 4
  %19 = icmp eq i32 %18, 0
  br i1 %19, label %20, label %22

20:                                               ; preds = %8
  %21 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %21, i8* noundef getelementptr inbounds ([28 x i8], [28 x i8]* @.str.39, i64 0, i64 0))
  store i32 1, i32* %17, align 4
  br label %22

22:                                               ; preds = %20, %8
  %23 = load i32, i32* %10, align 4
  %24 = icmp ugt i32 %23, 2147483647
  br i1 %24, label %25, label %27

25:                                               ; preds = %22
  %26 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %26, i8* noundef getelementptr inbounds ([28 x i8], [28 x i8]* @.str.40, i64 0, i64 0))
  store i32 1, i32* %17, align 4
  br label %27

27:                                               ; preds = %25, %22
  %28 = load i32, i32* %10, align 4
  %29 = add i32 %28, 7
  %30 = zext i32 %29 to i64
  %31 = and i64 %30, -8
  %32 = icmp ugt i64 %31, 2305843009213693944
  br i1 %32, label %33, label %35

33:                                               ; preds = %27
  %34 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %34, i8* noundef getelementptr inbounds ([47 x i8], [47 x i8]* @.str.41, i64 0, i64 0))
  store i32 1, i32* %17, align 4
  br label %35

35:                                               ; preds = %33, %27
  %36 = load i32, i32* %10, align 4
  %37 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  %38 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %37, i32 0, i32 138
  %39 = load i32, i32* %38, align 4
  %40 = icmp ugt i32 %36, %39
  br i1 %40, label %41, label %43

41:                                               ; preds = %35
  %42 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %42, i8* noundef getelementptr inbounds ([39 x i8], [39 x i8]* @.str.42, i64 0, i64 0))
  store i32 1, i32* %17, align 4
  br label %43

43:                                               ; preds = %41, %35
  %44 = load i32, i32* %11, align 4
  %45 = icmp eq i32 %44, 0
  br i1 %45, label %46, label %48

46:                                               ; preds = %43
  %47 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %47, i8* noundef getelementptr inbounds ([29 x i8], [29 x i8]* @.str.43, i64 0, i64 0))
  store i32 1, i32* %17, align 4
  br label %48

48:                                               ; preds = %46, %43
  %49 = load i32, i32* %11, align 4
  %50 = icmp ugt i32 %49, 2147483647
  br i1 %50, label %51, label %53

51:                                               ; preds = %48
  %52 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %52, i8* noundef getelementptr inbounds ([29 x i8], [29 x i8]* @.str.44, i64 0, i64 0))
  store i32 1, i32* %17, align 4
  br label %53

53:                                               ; preds = %51, %48
  %54 = load i32, i32* %11, align 4
  %55 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  %56 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %55, i32 0, i32 139
  %57 = load i32, i32* %56, align 8
  %58 = icmp ugt i32 %54, %57
  br i1 %58, label %59, label %61

59:                                               ; preds = %53
  %60 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %60, i8* noundef getelementptr inbounds ([40 x i8], [40 x i8]* @.str.45, i64 0, i64 0))
  store i32 1, i32* %17, align 4
  br label %61

61:                                               ; preds = %59, %53
  %62 = load i32, i32* %12, align 4
  %63 = icmp ne i32 %62, 1
  br i1 %63, label %64, label %78

64:                                               ; preds = %61
  %65 = load i32, i32* %12, align 4
  %66 = icmp ne i32 %65, 2
  br i1 %66, label %67, label %78

67:                                               ; preds = %64
  %68 = load i32, i32* %12, align 4
  %69 = icmp ne i32 %68, 4
  br i1 %69, label %70, label %78

70:                                               ; preds = %67
  %71 = load i32, i32* %12, align 4
  %72 = icmp ne i32 %71, 8
  br i1 %72, label %73, label %78

73:                                               ; preds = %70
  %74 = load i32, i32* %12, align 4
  %75 = icmp ne i32 %74, 16
  br i1 %75, label %76, label %78

76:                                               ; preds = %73
  %77 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %77, i8* noundef getelementptr inbounds ([26 x i8], [26 x i8]* @.str.46, i64 0, i64 0))
  store i32 1, i32* %17, align 4
  br label %78

78:                                               ; preds = %76, %73, %70, %67, %64, %61
  %79 = load i32, i32* %13, align 4
  %80 = icmp slt i32 %79, 0
  br i1 %80, label %90, label %81

81:                                               ; preds = %78
  %82 = load i32, i32* %13, align 4
  %83 = icmp eq i32 %82, 1
  br i1 %83, label %90, label %84

84:                                               ; preds = %81
  %85 = load i32, i32* %13, align 4
  %86 = icmp eq i32 %85, 5
  br i1 %86, label %90, label %87

87:                                               ; preds = %84
  %88 = load i32, i32* %13, align 4
  %89 = icmp sgt i32 %88, 6
  br i1 %89, label %90, label %92

90:                                               ; preds = %87, %84, %81, %78
  %91 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %91, i8* noundef getelementptr inbounds ([27 x i8], [27 x i8]* @.str.47, i64 0, i64 0))
  store i32 1, i32* %17, align 4
  br label %92

92:                                               ; preds = %90, %87
  %93 = load i32, i32* %13, align 4
  %94 = icmp eq i32 %93, 3
  br i1 %94, label %95, label %98

95:                                               ; preds = %92
  %96 = load i32, i32* %12, align 4
  %97 = icmp sgt i32 %96, 8
  br i1 %97, label %110, label %98

98:                                               ; preds = %95, %92
  %99 = load i32, i32* %13, align 4
  %100 = icmp eq i32 %99, 2
  br i1 %100, label %107, label %101

101:                                              ; preds = %98
  %102 = load i32, i32* %13, align 4
  %103 = icmp eq i32 %102, 4
  br i1 %103, label %107, label %104

104:                                              ; preds = %101
  %105 = load i32, i32* %13, align 4
  %106 = icmp eq i32 %105, 6
  br i1 %106, label %107, label %112

107:                                              ; preds = %104, %101, %98
  %108 = load i32, i32* %12, align 4
  %109 = icmp slt i32 %108, 8
  br i1 %109, label %110, label %112

110:                                              ; preds = %107, %95
  %111 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %111, i8* noundef getelementptr inbounds ([49 x i8], [49 x i8]* @.str.48, i64 0, i64 0))
  store i32 1, i32* %17, align 4
  br label %112

112:                                              ; preds = %110, %107, %104
  %113 = load i32, i32* %14, align 4
  %114 = icmp sge i32 %113, 2
  br i1 %114, label %115, label %117

115:                                              ; preds = %112
  %116 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %116, i8* noundef getelementptr inbounds ([33 x i8], [33 x i8]* @.str.49, i64 0, i64 0))
  store i32 1, i32* %17, align 4
  br label %117

117:                                              ; preds = %115, %112
  %118 = load i32, i32* %15, align 4
  %119 = icmp ne i32 %118, 0
  br i1 %119, label %120, label %122

120:                                              ; preds = %117
  %121 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %121, i8* noundef getelementptr inbounds ([35 x i8], [35 x i8]* @.str.50, i64 0, i64 0))
  store i32 1, i32* %17, align 4
  br label %122

122:                                              ; preds = %120, %117
  %123 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  %124 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %123, i32 0, i32 15
  %125 = load i32, i32* %124, align 4
  %126 = and i32 %125, 4096
  %127 = icmp ne i32 %126, 0
  br i1 %127, label %128, label %135

128:                                              ; preds = %122
  %129 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  %130 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %129, i32 0, i32 128
  %131 = load i32, i32* %130, align 8
  %132 = icmp ne i32 %131, 0
  br i1 %132, label %133, label %135

133:                                              ; preds = %128
  %134 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %134, i8* noundef getelementptr inbounds ([49 x i8], [49 x i8]* @.str.51, i64 0, i64 0))
  br label %135

135:                                              ; preds = %133, %128, %122
  %136 = load i32, i32* %16, align 4
  %137 = icmp ne i32 %136, 0
  br i1 %137, label %138, label %170

138:                                              ; preds = %135
  %139 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  %140 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %139, i32 0, i32 128
  %141 = load i32, i32* %140, align 8
  %142 = and i32 %141, 4
  %143 = icmp ne i32 %142, 0
  br i1 %143, label %144, label %159

144:                                              ; preds = %138
  %145 = load i32, i32* %16, align 4
  %146 = icmp eq i32 %145, 64
  br i1 %146, label %147, label %159

147:                                              ; preds = %144
  %148 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  %149 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %148, i32 0, i32 15
  %150 = load i32, i32* %149, align 4
  %151 = and i32 %150, 4096
  %152 = icmp eq i32 %151, 0
  br i1 %152, label %153, label %159

153:                                              ; preds = %147
  %154 = load i32, i32* %13, align 4
  %155 = icmp eq i32 %154, 2
  br i1 %155, label %161, label %156

156:                                              ; preds = %153
  %157 = load i32, i32* %13, align 4
  %158 = icmp eq i32 %157, 6
  br i1 %158, label %161, label %159

159:                                              ; preds = %156, %147, %144, %138
  %160 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %160, i8* noundef getelementptr inbounds ([30 x i8], [30 x i8]* @.str.52, i64 0, i64 0))
  store i32 1, i32* %17, align 4
  br label %161

161:                                              ; preds = %159, %156, %153
  %162 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  %163 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %162, i32 0, i32 15
  %164 = load i32, i32* %163, align 4
  %165 = and i32 %164, 4096
  %166 = icmp ne i32 %165, 0
  br i1 %166, label %167, label %169

167:                                              ; preds = %161
  %168 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_warning(%struct.png_struct_def* noundef %168, i8* noundef getelementptr inbounds ([30 x i8], [30 x i8]* @.str.53, i64 0, i64 0))
  store i32 1, i32* %17, align 4
  br label %169

169:                                              ; preds = %167, %161
  br label %170

170:                                              ; preds = %169, %135
  %171 = load i32, i32* %17, align 4
  %172 = icmp eq i32 %171, 1
  br i1 %172, label %173, label %175

173:                                              ; preds = %170
  %174 = load %struct.png_struct_def*, %struct.png_struct_def** %9, align 8
  call void @png_error(%struct.png_struct_def* noundef %174, i8* noundef getelementptr inbounds ([18 x i8], [18 x i8]* @.str.54, i64 0, i64 0)) #10
  unreachable

175:                                              ; preds = %170
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_check_fp_number(i8* noundef %0, i64 noundef %1, i32* noundef %2, i64* noundef %3) #0 {
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i32*, align 8
  %8 = alloca i64*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i64, align 8
  %11 = alloca i32, align 4
  store i8* %0, i8** %5, align 8
  store i64 %1, i64* %6, align 8
  store i32* %2, i32** %7, align 8
  store i64* %3, i64** %8, align 8
  %12 = load i32*, i32** %7, align 8
  %13 = load i32, i32* %12, align 4
  store i32 %13, i32* %9, align 4
  %14 = load i64*, i64** %8, align 8
  %15 = load i64, i64* %14, align 8
  store i64 %15, i64* %10, align 8
  br label %16

16:                                               ; preds = %117, %4
  %17 = load i64, i64* %10, align 8
  %18 = load i64, i64* %6, align 8
  %19 = icmp ult i64 %17, %18
  br i1 %19, label %20, label %120

20:                                               ; preds = %16
  %21 = load i8*, i8** %5, align 8
  %22 = load i64, i64* %10, align 8
  %23 = getelementptr inbounds i8, i8* %21, i64 %22
  %24 = load i8, i8* %23, align 1
  %25 = sext i8 %24 to i32
  switch i32 %25, label %32 [
    i32 43, label %26
    i32 45, label %27
    i32 46, label %28
    i32 48, label %29
    i32 49, label %30
    i32 50, label %30
    i32 51, label %30
    i32 52, label %30
    i32 53, label %30
    i32 54, label %30
    i32 55, label %30
    i32 56, label %30
    i32 57, label %30
    i32 69, label %31
    i32 101, label %31
  ]

26:                                               ; preds = %20
  store i32 4, i32* %11, align 4
  br label %33

27:                                               ; preds = %20
  store i32 132, i32* %11, align 4
  br label %33

28:                                               ; preds = %20
  store i32 16, i32* %11, align 4
  br label %33

29:                                               ; preds = %20
  store i32 8, i32* %11, align 4
  br label %33

30:                                               ; preds = %20, %20, %20, %20, %20, %20, %20, %20, %20
  store i32 264, i32* %11, align 4
  br label %33

31:                                               ; preds = %20, %20
  store i32 32, i32* %11, align 4
  br label %33

32:                                               ; preds = %20
  br label %121

33:                                               ; preds = %31, %30, %29, %28, %27, %26
  %34 = load i32, i32* %9, align 4
  %35 = and i32 %34, 3
  %36 = load i32, i32* %11, align 4
  %37 = and i32 %36, 60
  %38 = add nsw i32 %35, %37
  switch i32 %38, label %116 [
    i32 4, label %39
    i32 16, label %48
    i32 8, label %69
    i32 32, label %82
    i32 9, label %91
    i32 33, label %96
    i32 6, label %105
    i32 10, label %113
  ]

39:                                               ; preds = %33
  %40 = load i32, i32* %9, align 4
  %41 = and i32 %40, 60
  %42 = icmp ne i32 %41, 0
  br i1 %42, label %43, label %44

43:                                               ; preds = %39
  br label %121

44:                                               ; preds = %39
  %45 = load i32, i32* %11, align 4
  %46 = load i32, i32* %9, align 4
  %47 = or i32 %46, %45
  store i32 %47, i32* %9, align 4
  br label %117

48:                                               ; preds = %33
  %49 = load i32, i32* %9, align 4
  %50 = and i32 %49, 16
  %51 = icmp ne i32 %50, 0
  br i1 %51, label %52, label %53

52:                                               ; preds = %48
  br label %121

53:                                               ; preds = %48
  %54 = load i32, i32* %9, align 4
  %55 = and i32 %54, 8
  %56 = icmp ne i32 %55, 0
  br i1 %56, label %57, label %61

57:                                               ; preds = %53
  %58 = load i32, i32* %11, align 4
  %59 = load i32, i32* %9, align 4
  %60 = or i32 %59, %58
  store i32 %60, i32* %9, align 4
  br label %67

61:                                               ; preds = %53
  %62 = load i32, i32* %11, align 4
  %63 = or i32 1, %62
  %64 = load i32, i32* %9, align 4
  %65 = and i32 %64, 448
  %66 = or i32 %63, %65
  store i32 %66, i32* %9, align 4
  br label %67

67:                                               ; preds = %61, %57
  br label %68

68:                                               ; preds = %67
  br label %117

69:                                               ; preds = %33
  %70 = load i32, i32* %9, align 4
  %71 = and i32 %70, 16
  %72 = icmp ne i32 %71, 0
  br i1 %72, label %73, label %77

73:                                               ; preds = %69
  %74 = load i32, i32* %9, align 4
  %75 = and i32 %74, 448
  %76 = or i32 17, %75
  store i32 %76, i32* %9, align 4
  br label %77

77:                                               ; preds = %73, %69
  %78 = load i32, i32* %11, align 4
  %79 = or i32 %78, 64
  %80 = load i32, i32* %9, align 4
  %81 = or i32 %80, %79
  store i32 %81, i32* %9, align 4
  br label %117

82:                                               ; preds = %33
  %83 = load i32, i32* %9, align 4
  %84 = and i32 %83, 8
  %85 = icmp eq i32 %84, 0
  br i1 %85, label %86, label %87

86:                                               ; preds = %82
  br label %121

87:                                               ; preds = %82
  %88 = load i32, i32* %9, align 4
  %89 = and i32 %88, 448
  %90 = or i32 2, %89
  store i32 %90, i32* %9, align 4
  br label %117

91:                                               ; preds = %33
  %92 = load i32, i32* %11, align 4
  %93 = or i32 %92, 64
  %94 = load i32, i32* %9, align 4
  %95 = or i32 %94, %93
  store i32 %95, i32* %9, align 4
  br label %117

96:                                               ; preds = %33
  %97 = load i32, i32* %9, align 4
  %98 = and i32 %97, 8
  %99 = icmp eq i32 %98, 0
  br i1 %99, label %100, label %101

100:                                              ; preds = %96
  br label %121

101:                                              ; preds = %96
  %102 = load i32, i32* %9, align 4
  %103 = and i32 %102, 448
  %104 = or i32 2, %103
  store i32 %104, i32* %9, align 4
  br label %117

105:                                              ; preds = %33
  %106 = load i32, i32* %9, align 4
  %107 = and i32 %106, 60
  %108 = icmp ne i32 %107, 0
  br i1 %108, label %109, label %110

109:                                              ; preds = %105
  br label %121

110:                                              ; preds = %105
  %111 = load i32, i32* %9, align 4
  %112 = or i32 %111, 4
  store i32 %112, i32* %9, align 4
  br label %117

113:                                              ; preds = %33
  %114 = load i32, i32* %9, align 4
  %115 = or i32 %114, 72
  store i32 %115, i32* %9, align 4
  br label %117

116:                                              ; preds = %33
  br label %121

117:                                              ; preds = %113, %110, %101, %91, %87, %77, %68, %44
  %118 = load i64, i64* %10, align 8
  %119 = add i64 %118, 1
  store i64 %119, i64* %10, align 8
  br label %16, !llvm.loop !17

120:                                              ; preds = %16
  br label %121

121:                                              ; preds = %120, %116, %109, %100, %86, %52, %43, %32
  %122 = load i32, i32* %9, align 4
  %123 = load i32*, i32** %7, align 8
  store i32 %122, i32* %123, align 4
  %124 = load i64, i64* %10, align 8
  %125 = load i64*, i64** %8, align 8
  store i64 %124, i64* %125, align 8
  %126 = load i32, i32* %9, align 4
  %127 = and i32 %126, 8
  %128 = icmp ne i32 %127, 0
  %129 = zext i1 %128 to i32
  ret i32 %129
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_check_fp_string(i8* noundef %0, i64 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i8*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i32, align 4
  %7 = alloca i64, align 8
  store i8* %0, i8** %4, align 8
  store i64 %1, i64* %5, align 8
  store i32 0, i32* %6, align 4
  store i64 0, i64* %7, align 8
  %8 = load i8*, i8** %4, align 8
  %9 = load i64, i64* %5, align 8
  %10 = call i32 @png_check_fp_number(i8* noundef %8, i64 noundef %9, i32* noundef %6, i64* noundef %7)
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %25

12:                                               ; preds = %2
  %13 = load i64, i64* %7, align 8
  %14 = load i64, i64* %5, align 8
  %15 = icmp eq i64 %13, %14
  br i1 %15, label %23, label %16

16:                                               ; preds = %12
  %17 = load i8*, i8** %4, align 8
  %18 = load i64, i64* %7, align 8
  %19 = getelementptr inbounds i8, i8* %17, i64 %18
  %20 = load i8, i8* %19, align 1
  %21 = sext i8 %20 to i32
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %23, label %25

23:                                               ; preds = %16, %12
  %24 = load i32, i32* %6, align 4
  store i32 %24, i32* %3, align 4
  br label %26

25:                                               ; preds = %16, %2
  store i32 0, i32* %3, align 4
  br label %26

26:                                               ; preds = %25, %23
  %27 = load i32, i32* %3, align 4
  ret i32 %27
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_ascii_from_fp(%struct.png_struct_def* noalias noundef %0, i8* noundef %1, i64 noundef %2, double noundef %3, i32 noundef %4) #0 {
  %6 = alloca %struct.png_struct_def*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i64, align 8
  %9 = alloca double, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca double, align 8
  %13 = alloca double, align 8
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca [10 x i8], align 1
  %18 = alloca double, align 8
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %6, align 8
  store i8* %1, i8** %7, align 8
  store i64 %2, i64* %8, align 8
  store double %3, double* %9, align 8
  store i32 %4, i32* %10, align 4
  %22 = load i32, i32* %10, align 4
  %23 = icmp ult i32 %22, 1
  br i1 %23, label %24, label %25

24:                                               ; preds = %5
  store i32 15, i32* %10, align 4
  br label %25

25:                                               ; preds = %24, %5
  %26 = load i32, i32* %10, align 4
  %27 = icmp ugt i32 %26, 16
  br i1 %27, label %28, label %29

28:                                               ; preds = %25
  store i32 16, i32* %10, align 4
  br label %29

29:                                               ; preds = %28, %25
  %30 = load i64, i64* %8, align 8
  %31 = load i32, i32* %10, align 4
  %32 = add i32 %31, 5
  %33 = zext i32 %32 to i64
  %34 = icmp uge i64 %30, %33
  br i1 %34, label %35, label %361

35:                                               ; preds = %29
  %36 = load double, double* %9, align 8
  %37 = fcmp olt double %36, 0.000000e+00
  br i1 %37, label %38, label %45

38:                                               ; preds = %35
  %39 = load double, double* %9, align 8
  %40 = fneg double %39
  store double %40, double* %9, align 8
  %41 = load i8*, i8** %7, align 8
  %42 = getelementptr inbounds i8, i8* %41, i32 1
  store i8* %42, i8** %7, align 8
  store i8 45, i8* %41, align 1
  %43 = load i64, i64* %8, align 8
  %44 = add i64 %43, -1
  store i64 %44, i64* %8, align 8
  br label %45

45:                                               ; preds = %38, %35
  %46 = load double, double* %9, align 8
  %47 = fcmp oge double %46, 0x10000000000000
  br i1 %47, label %48, label %345

48:                                               ; preds = %45
  %49 = load double, double* %9, align 8
  %50 = fcmp ole double %49, 0x7FEFFFFFFFFFFFFF
  br i1 %50, label %51, label %345

51:                                               ; preds = %48
  %52 = load double, double* %9, align 8
  %53 = call double @frexp(double noundef %52, i32* noundef %11) #13
  %54 = load i32, i32* %11, align 4
  %55 = mul nsw i32 %54, 77
  %56 = ashr i32 %55, 8
  store i32 %56, i32* %11, align 4
  %57 = load i32, i32* %11, align 4
  %58 = call double @png_pow10(i32 noundef %57)
  store double %58, double* %12, align 8
  br label %59

59:                                               ; preds = %79, %51
  %60 = load double, double* %12, align 8
  %61 = fcmp olt double %60, 0x10000000000000
  br i1 %61, label %66, label %62

62:                                               ; preds = %59
  %63 = load double, double* %12, align 8
  %64 = load double, double* %9, align 8
  %65 = fcmp olt double %63, %64
  br label %66

66:                                               ; preds = %62, %59
  %67 = phi i1 [ true, %59 ], [ %65, %62 ]
  br i1 %67, label %68, label %80

68:                                               ; preds = %66
  %69 = load i32, i32* %11, align 4
  %70 = add nsw i32 %69, 1
  %71 = call double @png_pow10(i32 noundef %70)
  store double %71, double* %13, align 8
  %72 = load double, double* %13, align 8
  %73 = fcmp ole double %72, 0x7FEFFFFFFFFFFFFF
  br i1 %73, label %74, label %78

74:                                               ; preds = %68
  %75 = load i32, i32* %11, align 4
  %76 = add nsw i32 %75, 1
  store i32 %76, i32* %11, align 4
  %77 = load double, double* %13, align 8
  store double %77, double* %12, align 8
  br label %79

78:                                               ; preds = %68
  br label %80

79:                                               ; preds = %74
  br label %59, !llvm.loop !18

80:                                               ; preds = %78, %66
  %81 = load double, double* %12, align 8
  %82 = load double, double* %9, align 8
  %83 = fdiv double %82, %81
  store double %83, double* %9, align 8
  br label %84

84:                                               ; preds = %87, %80
  %85 = load double, double* %9, align 8
  %86 = fcmp oge double %85, 1.000000e+00
  br i1 %86, label %87, label %92

87:                                               ; preds = %84
  %88 = load double, double* %9, align 8
  %89 = fdiv double %88, 1.000000e+01
  store double %89, double* %9, align 8
  %90 = load i32, i32* %11, align 4
  %91 = add nsw i32 %90, 1
  store i32 %91, i32* %11, align 4
  br label %84, !llvm.loop !19

92:                                               ; preds = %84
  %93 = load i32, i32* %11, align 4
  %94 = icmp slt i32 %93, 0
  br i1 %94, label %95, label %101

95:                                               ; preds = %92
  %96 = load i32, i32* %11, align 4
  %97 = icmp sgt i32 %96, -3
  br i1 %97, label %98, label %101

98:                                               ; preds = %95
  %99 = load i32, i32* %11, align 4
  %100 = sub i32 0, %99
  store i32 %100, i32* %14, align 4
  store i32 0, i32* %11, align 4
  br label %102

101:                                              ; preds = %95, %92
  store i32 0, i32* %14, align 4
  br label %102

102:                                              ; preds = %101, %98
  %103 = load i32, i32* %14, align 4
  store i32 %103, i32* %15, align 4
  store i32 0, i32* %16, align 4
  br label %104

104:                                              ; preds = %271, %102
  %105 = load double, double* %9, align 8
  %106 = fmul double %105, 1.000000e+01
  store double %106, double* %9, align 8
  %107 = load i32, i32* %16, align 4
  %108 = load i32, i32* %14, align 4
  %109 = add i32 %107, %108
  %110 = add i32 %109, 1
  %111 = load i32, i32* %10, align 4
  %112 = load i32, i32* %15, align 4
  %113 = add i32 %111, %112
  %114 = icmp ult i32 %110, %113
  br i1 %114, label %115, label %118

115:                                              ; preds = %104
  %116 = load double, double* %9, align 8
  %117 = call double @modf(double noundef %116, double* noundef %18) #13
  store double %117, double* %9, align 8
  br label %196

118:                                              ; preds = %104
  %119 = load double, double* %9, align 8
  %120 = fadd double %119, 5.000000e-01
  %121 = call double @llvm.floor.f64(double %120)
  store double %121, double* %18, align 8
  %122 = load double, double* %18, align 8
  %123 = fcmp ogt double %122, 9.000000e+00
  br i1 %123, label %124, label %195

124:                                              ; preds = %118
  %125 = load i32, i32* %14, align 4
  %126 = icmp ugt i32 %125, 0
  br i1 %126, label %127, label %136

127:                                              ; preds = %124
  %128 = load i32, i32* %14, align 4
  %129 = add i32 %128, -1
  store i32 %129, i32* %14, align 4
  store double 1.000000e+00, double* %18, align 8
  %130 = load i32, i32* %16, align 4
  %131 = icmp eq i32 %130, 0
  br i1 %131, label %132, label %135

132:                                              ; preds = %127
  %133 = load i32, i32* %15, align 4
  %134 = add i32 %133, -1
  store i32 %134, i32* %15, align 4
  br label %135

135:                                              ; preds = %132, %127
  br label %194

136:                                              ; preds = %124
  br label %137

137:                                              ; preds = %166, %136
  %138 = load i32, i32* %16, align 4
  %139 = icmp ugt i32 %138, 0
  br i1 %139, label %140, label %143

140:                                              ; preds = %137
  %141 = load double, double* %18, align 8
  %142 = fcmp ogt double %141, 9.000000e+00
  br label %143

143:                                              ; preds = %140, %137
  %144 = phi i1 [ false, %137 ], [ %142, %140 ]
  br i1 %144, label %145, label %172

145:                                              ; preds = %143
  %146 = load i8*, i8** %7, align 8
  %147 = getelementptr inbounds i8, i8* %146, i32 -1
  store i8* %147, i8** %7, align 8
  %148 = load i8, i8* %147, align 1
  %149 = sext i8 %148 to i32
  store i32 %149, i32* %19, align 4
  %150 = load i32, i32* %11, align 4
  %151 = icmp ne i32 %150, -1
  br i1 %151, label %152, label %155

152:                                              ; preds = %145
  %153 = load i32, i32* %11, align 4
  %154 = add nsw i32 %153, 1
  store i32 %154, i32* %11, align 4
  br label %166

155:                                              ; preds = %145
  %156 = load i32, i32* %19, align 4
  %157 = icmp eq i32 %156, 46
  br i1 %157, label %158, label %165

158:                                              ; preds = %155
  %159 = load i8*, i8** %7, align 8
  %160 = getelementptr inbounds i8, i8* %159, i32 -1
  store i8* %160, i8** %7, align 8
  %161 = load i8, i8* %160, align 1
  %162 = sext i8 %161 to i32
  store i32 %162, i32* %19, align 4
  %163 = load i64, i64* %8, align 8
  %164 = add i64 %163, 1
  store i64 %164, i64* %8, align 8
  store i32 1, i32* %11, align 4
  br label %165

165:                                              ; preds = %158, %155
  br label %166

166:                                              ; preds = %165, %152
  %167 = load i32, i32* %16, align 4
  %168 = add i32 %167, -1
  store i32 %168, i32* %16, align 4
  %169 = load i32, i32* %19, align 4
  %170 = sub nsw i32 %169, 47
  %171 = sitofp i32 %170 to double
  store double %171, double* %18, align 8
  br label %137, !llvm.loop !20

172:                                              ; preds = %143
  %173 = load double, double* %18, align 8
  %174 = fcmp ogt double %173, 9.000000e+00
  br i1 %174, label %175, label %193

175:                                              ; preds = %172
  %176 = load i32, i32* %11, align 4
  %177 = icmp eq i32 %176, -1
  br i1 %177, label %178, label %189

178:                                              ; preds = %175
  %179 = load i8*, i8** %7, align 8
  %180 = getelementptr inbounds i8, i8* %179, i32 -1
  store i8* %180, i8** %7, align 8
  %181 = load i8, i8* %180, align 1
  %182 = sext i8 %181 to i32
  store i32 %182, i32* %20, align 4
  %183 = load i32, i32* %20, align 4
  %184 = icmp eq i32 %183, 46
  br i1 %184, label %185, label %188

185:                                              ; preds = %178
  %186 = load i64, i64* %8, align 8
  %187 = add i64 %186, 1
  store i64 %187, i64* %8, align 8
  store i32 1, i32* %11, align 4
  br label %188

188:                                              ; preds = %185, %178
  br label %192

189:                                              ; preds = %175
  %190 = load i32, i32* %11, align 4
  %191 = add nsw i32 %190, 1
  store i32 %191, i32* %11, align 4
  br label %192

192:                                              ; preds = %189, %188
  store double 1.000000e+00, double* %18, align 8
  br label %193

193:                                              ; preds = %192, %172
  br label %194

194:                                              ; preds = %193, %135
  br label %195

195:                                              ; preds = %194, %118
  store double 0.000000e+00, double* %9, align 8
  br label %196

196:                                              ; preds = %195, %115
  %197 = load double, double* %18, align 8
  %198 = fcmp oeq double %197, 0.000000e+00
  br i1 %198, label %199, label %208

199:                                              ; preds = %196
  %200 = load i32, i32* %14, align 4
  %201 = add i32 %200, 1
  store i32 %201, i32* %14, align 4
  %202 = load i32, i32* %16, align 4
  %203 = icmp eq i32 %202, 0
  br i1 %203, label %204, label %207

204:                                              ; preds = %199
  %205 = load i32, i32* %15, align 4
  %206 = add i32 %205, 1
  store i32 %206, i32* %15, align 4
  br label %207

207:                                              ; preds = %204, %199
  br label %259

208:                                              ; preds = %196
  %209 = load i32, i32* %14, align 4
  %210 = load i32, i32* %15, align 4
  %211 = sub i32 %209, %210
  %212 = load i32, i32* %16, align 4
  %213 = add i32 %212, %211
  store i32 %213, i32* %16, align 4
  store i32 0, i32* %15, align 4
  br label %214

214:                                              ; preds = %231, %208
  %215 = load i32, i32* %14, align 4
  %216 = icmp ugt i32 %215, 0
  br i1 %216, label %217, label %236

217:                                              ; preds = %214
  %218 = load i32, i32* %11, align 4
  %219 = icmp ne i32 %218, -1
  br i1 %219, label %220, label %231

220:                                              ; preds = %217
  %221 = load i32, i32* %11, align 4
  %222 = icmp eq i32 %221, 0
  br i1 %222, label %223, label %228

223:                                              ; preds = %220
  %224 = load i8*, i8** %7, align 8
  %225 = getelementptr inbounds i8, i8* %224, i32 1
  store i8* %225, i8** %7, align 8
  store i8 46, i8* %224, align 1
  %226 = load i64, i64* %8, align 8
  %227 = add i64 %226, -1
  store i64 %227, i64* %8, align 8
  br label %228

228:                                              ; preds = %223, %220
  %229 = load i32, i32* %11, align 4
  %230 = add nsw i32 %229, -1
  store i32 %230, i32* %11, align 4
  br label %231

231:                                              ; preds = %228, %217
  %232 = load i8*, i8** %7, align 8
  %233 = getelementptr inbounds i8, i8* %232, i32 1
  store i8* %233, i8** %7, align 8
  store i8 48, i8* %232, align 1
  %234 = load i32, i32* %14, align 4
  %235 = add i32 %234, -1
  store i32 %235, i32* %14, align 4
  br label %214, !llvm.loop !21

236:                                              ; preds = %214
  %237 = load i32, i32* %11, align 4
  %238 = icmp ne i32 %237, -1
  br i1 %238, label %239, label %250

239:                                              ; preds = %236
  %240 = load i32, i32* %11, align 4
  %241 = icmp eq i32 %240, 0
  br i1 %241, label %242, label %247

242:                                              ; preds = %239
  %243 = load i8*, i8** %7, align 8
  %244 = getelementptr inbounds i8, i8* %243, i32 1
  store i8* %244, i8** %7, align 8
  store i8 46, i8* %243, align 1
  %245 = load i64, i64* %8, align 8
  %246 = add i64 %245, -1
  store i64 %246, i64* %8, align 8
  br label %247

247:                                              ; preds = %242, %239
  %248 = load i32, i32* %11, align 4
  %249 = add nsw i32 %248, -1
  store i32 %249, i32* %11, align 4
  br label %250

250:                                              ; preds = %247, %236
  %251 = load double, double* %18, align 8
  %252 = fptosi double %251 to i32
  %253 = add nsw i32 48, %252
  %254 = trunc i32 %253 to i8
  %255 = load i8*, i8** %7, align 8
  %256 = getelementptr inbounds i8, i8* %255, i32 1
  store i8* %256, i8** %7, align 8
  store i8 %254, i8* %255, align 1
  %257 = load i32, i32* %16, align 4
  %258 = add i32 %257, 1
  store i32 %258, i32* %16, align 4
  br label %259

259:                                              ; preds = %250, %207
  br label %260

260:                                              ; preds = %259
  %261 = load i32, i32* %16, align 4
  %262 = load i32, i32* %14, align 4
  %263 = add i32 %261, %262
  %264 = load i32, i32* %10, align 4
  %265 = load i32, i32* %15, align 4
  %266 = add i32 %264, %265
  %267 = icmp ult i32 %263, %266
  br i1 %267, label %268, label %271

268:                                              ; preds = %260
  %269 = load double, double* %9, align 8
  %270 = fcmp ogt double %269, 0x10000000000000
  br label %271

271:                                              ; preds = %268, %260
  %272 = phi i1 [ false, %260 ], [ %270, %268 ]
  br i1 %272, label %104, label %273, !llvm.loop !22

273:                                              ; preds = %271
  %274 = load i32, i32* %11, align 4
  %275 = icmp sge i32 %274, -1
  br i1 %275, label %276, label %289

276:                                              ; preds = %273
  %277 = load i32, i32* %11, align 4
  %278 = icmp sle i32 %277, 2
  br i1 %278, label %279, label %289

279:                                              ; preds = %276
  br label %280

280:                                              ; preds = %284, %279
  %281 = load i32, i32* %11, align 4
  %282 = add nsw i32 %281, -1
  store i32 %282, i32* %11, align 4
  %283 = icmp sgt i32 %281, 0
  br i1 %283, label %284, label %287

284:                                              ; preds = %280
  %285 = load i8*, i8** %7, align 8
  %286 = getelementptr inbounds i8, i8* %285, i32 1
  store i8* %286, i8** %7, align 8
  store i8 48, i8* %285, align 1
  br label %280, !llvm.loop !23

287:                                              ; preds = %280
  %288 = load i8*, i8** %7, align 8
  store i8 0, i8* %288, align 1
  br label %363

289:                                              ; preds = %276, %273
  %290 = load i32, i32* %16, align 4
  %291 = zext i32 %290 to i64
  %292 = load i64, i64* %8, align 8
  %293 = sub i64 %292, %291
  store i64 %293, i64* %8, align 8
  %294 = load i8*, i8** %7, align 8
  %295 = getelementptr inbounds i8, i8* %294, i32 1
  store i8* %295, i8** %7, align 8
  store i8 69, i8* %294, align 1
  %296 = load i64, i64* %8, align 8
  %297 = add i64 %296, -1
  store i64 %297, i64* %8, align 8
  %298 = load i32, i32* %11, align 4
  %299 = icmp slt i32 %298, 0
  br i1 %299, label %300, label %307

300:                                              ; preds = %289
  %301 = load i8*, i8** %7, align 8
  %302 = getelementptr inbounds i8, i8* %301, i32 1
  store i8* %302, i8** %7, align 8
  store i8 45, i8* %301, align 1
  %303 = load i64, i64* %8, align 8
  %304 = add i64 %303, -1
  store i64 %304, i64* %8, align 8
  %305 = load i32, i32* %11, align 4
  %306 = sub i32 0, %305
  store i32 %306, i32* %21, align 4
  br label %310

307:                                              ; preds = %289
  %308 = load i32, i32* %11, align 4
  %309 = add i32 0, %308
  store i32 %309, i32* %21, align 4
  br label %310

310:                                              ; preds = %307, %300
  store i32 0, i32* %16, align 4
  br label %311

311:                                              ; preds = %314, %310
  %312 = load i32, i32* %21, align 4
  %313 = icmp ugt i32 %312, 0
  br i1 %313, label %314, label %325

314:                                              ; preds = %311
  %315 = load i32, i32* %21, align 4
  %316 = urem i32 %315, 10
  %317 = add i32 48, %316
  %318 = trunc i32 %317 to i8
  %319 = load i32, i32* %16, align 4
  %320 = add i32 %319, 1
  store i32 %320, i32* %16, align 4
  %321 = zext i32 %319 to i64
  %322 = getelementptr inbounds [10 x i8], [10 x i8]* %17, i64 0, i64 %321
  store i8 %318, i8* %322, align 1
  %323 = load i32, i32* %21, align 4
  %324 = udiv i32 %323, 10
  store i32 %324, i32* %21, align 4
  br label %311, !llvm.loop !24

325:                                              ; preds = %311
  %326 = load i64, i64* %8, align 8
  %327 = load i32, i32* %16, align 4
  %328 = zext i32 %327 to i64
  %329 = icmp ugt i64 %326, %328
  br i1 %329, label %330, label %344

330:                                              ; preds = %325
  br label %331

331:                                              ; preds = %334, %330
  %332 = load i32, i32* %16, align 4
  %333 = icmp ugt i32 %332, 0
  br i1 %333, label %334, label %342

334:                                              ; preds = %331
  %335 = load i32, i32* %16, align 4
  %336 = add i32 %335, -1
  store i32 %336, i32* %16, align 4
  %337 = zext i32 %336 to i64
  %338 = getelementptr inbounds [10 x i8], [10 x i8]* %17, i64 0, i64 %337
  %339 = load i8, i8* %338, align 1
  %340 = load i8*, i8** %7, align 8
  %341 = getelementptr inbounds i8, i8* %340, i32 1
  store i8* %341, i8** %7, align 8
  store i8 %339, i8* %340, align 1
  br label %331, !llvm.loop !25

342:                                              ; preds = %331
  %343 = load i8*, i8** %7, align 8
  store i8 0, i8* %343, align 1
  br label %363

344:                                              ; preds = %325
  br label %360

345:                                              ; preds = %48, %45
  %346 = load double, double* %9, align 8
  %347 = fcmp oge double %346, 0x10000000000000
  br i1 %347, label %352, label %348

348:                                              ; preds = %345
  %349 = load i8*, i8** %7, align 8
  %350 = getelementptr inbounds i8, i8* %349, i32 1
  store i8* %350, i8** %7, align 8
  store i8 48, i8* %349, align 1
  %351 = load i8*, i8** %7, align 8
  store i8 0, i8* %351, align 1
  br label %363

352:                                              ; preds = %345
  %353 = load i8*, i8** %7, align 8
  %354 = getelementptr inbounds i8, i8* %353, i32 1
  store i8* %354, i8** %7, align 8
  store i8 105, i8* %353, align 1
  %355 = load i8*, i8** %7, align 8
  %356 = getelementptr inbounds i8, i8* %355, i32 1
  store i8* %356, i8** %7, align 8
  store i8 110, i8* %355, align 1
  %357 = load i8*, i8** %7, align 8
  %358 = getelementptr inbounds i8, i8* %357, i32 1
  store i8* %358, i8** %7, align 8
  store i8 102, i8* %357, align 1
  %359 = load i8*, i8** %7, align 8
  store i8 0, i8* %359, align 1
  br label %363

360:                                              ; preds = %344
  br label %361

361:                                              ; preds = %360, %29
  %362 = load %struct.png_struct_def*, %struct.png_struct_def** %6, align 8
  call void @png_error(%struct.png_struct_def* noundef %362, i8* noundef getelementptr inbounds ([34 x i8], [34 x i8]* @.str.55, i64 0, i64 0)) #10
  unreachable

363:                                              ; preds = %352, %348, %342, %287
  ret void
}

; Function Attrs: nounwind
declare double @frexp(double noundef, i32* noundef) #8

; Function Attrs: noinline nounwind optnone uwtable
define internal double @png_pow10(i32 noundef %0) #0 {
  %2 = alloca double, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca double, align 8
  %6 = alloca double, align 8
  store i32 %0, i32* %3, align 4
  store i32 0, i32* %4, align 4
  store double 1.000000e+00, double* %5, align 8
  %7 = load i32, i32* %3, align 4
  %8 = icmp slt i32 %7, 0
  br i1 %8, label %9, label %16

9:                                                ; preds = %1
  %10 = load i32, i32* %3, align 4
  %11 = icmp slt i32 %10, -307
  br i1 %11, label %12, label %13

12:                                               ; preds = %9
  store double 0.000000e+00, double* %2, align 8
  br label %46

13:                                               ; preds = %9
  store i32 1, i32* %4, align 4
  %14 = load i32, i32* %3, align 4
  %15 = sub nsw i32 0, %14
  store i32 %15, i32* %3, align 4
  br label %16

16:                                               ; preds = %13, %1
  %17 = load i32, i32* %3, align 4
  %18 = icmp sgt i32 %17, 0
  br i1 %18, label %19, label %44

19:                                               ; preds = %16
  store double 1.000000e+01, double* %6, align 8
  br label %20

20:                                               ; preds = %34, %19
  %21 = load i32, i32* %3, align 4
  %22 = and i32 %21, 1
  %23 = icmp ne i32 %22, 0
  br i1 %23, label %24, label %28

24:                                               ; preds = %20
  %25 = load double, double* %6, align 8
  %26 = load double, double* %5, align 8
  %27 = fmul double %26, %25
  store double %27, double* %5, align 8
  br label %28

28:                                               ; preds = %24, %20
  %29 = load double, double* %6, align 8
  %30 = load double, double* %6, align 8
  %31 = fmul double %30, %29
  store double %31, double* %6, align 8
  %32 = load i32, i32* %3, align 4
  %33 = ashr i32 %32, 1
  store i32 %33, i32* %3, align 4
  br label %34

34:                                               ; preds = %28
  %35 = load i32, i32* %3, align 4
  %36 = icmp sgt i32 %35, 0
  br i1 %36, label %20, label %37, !llvm.loop !26

37:                                               ; preds = %34
  %38 = load i32, i32* %4, align 4
  %39 = icmp ne i32 %38, 0
  br i1 %39, label %40, label %43

40:                                               ; preds = %37
  %41 = load double, double* %5, align 8
  %42 = fdiv double 1.000000e+00, %41
  store double %42, double* %5, align 8
  br label %43

43:                                               ; preds = %40, %37
  br label %44

44:                                               ; preds = %43, %16
  %45 = load double, double* %5, align 8
  store double %45, double* %2, align 8
  br label %46

46:                                               ; preds = %44, %12
  %47 = load double, double* %2, align 8
  ret double %47
}

; Function Attrs: nounwind
declare double @modf(double noundef, double* noundef) #8

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.floor.f64(double) #9

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_ascii_from_fixed(%struct.png_struct_def* noalias noundef %0, i8* noundef %1, i64 noundef %2, i32 noundef %3) #0 {
  %5 = alloca %struct.png_struct_def*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca [10 x i8], align 1
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %5, align 8
  store i8* %1, i8** %6, align 8
  store i64 %2, i64* %7, align 8
  store i32 %3, i32* %8, align 4
  %15 = load i64, i64* %7, align 8
  %16 = icmp ugt i64 %15, 12
  br i1 %16, label %17, label %109

17:                                               ; preds = %4
  %18 = load i32, i32* %8, align 4
  %19 = icmp slt i32 %18, 0
  br i1 %19, label %20, label %25

20:                                               ; preds = %17
  %21 = load i8*, i8** %6, align 8
  %22 = getelementptr inbounds i8, i8* %21, i32 1
  store i8* %22, i8** %6, align 8
  store i8 45, i8* %21, align 1
  %23 = load i32, i32* %8, align 4
  %24 = sub nsw i32 0, %23
  store i32 %24, i32* %9, align 4
  br label %27

25:                                               ; preds = %17
  %26 = load i32, i32* %8, align 4
  store i32 %26, i32* %9, align 4
  br label %27

27:                                               ; preds = %25, %20
  %28 = load i32, i32* %9, align 4
  %29 = icmp ule i32 %28, -2147483648
  br i1 %29, label %30, label %108

30:                                               ; preds = %27
  store i32 0, i32* %10, align 4
  store i32 16, i32* %11, align 4
  %31 = bitcast [10 x i8]* %12 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %31, i8 0, i64 10, i1 false)
  br label %32

32:                                               ; preds = %56, %30
  %33 = load i32, i32* %9, align 4
  %34 = icmp ne i32 %33, 0
  br i1 %34, label %35, label %58

35:                                               ; preds = %32
  %36 = load i32, i32* %9, align 4
  %37 = udiv i32 %36, 10
  store i32 %37, i32* %13, align 4
  %38 = load i32, i32* %13, align 4
  %39 = mul i32 %38, 10
  %40 = load i32, i32* %9, align 4
  %41 = sub i32 %40, %39
  store i32 %41, i32* %9, align 4
  %42 = load i32, i32* %9, align 4
  %43 = add i32 48, %42
  %44 = trunc i32 %43 to i8
  %45 = load i32, i32* %10, align 4
  %46 = add i32 %45, 1
  store i32 %46, i32* %10, align 4
  %47 = zext i32 %45 to i64
  %48 = getelementptr inbounds [10 x i8], [10 x i8]* %12, i64 0, i64 %47
  store i8 %44, i8* %48, align 1
  %49 = load i32, i32* %11, align 4
  %50 = icmp eq i32 %49, 16
  br i1 %50, label %51, label %56

51:                                               ; preds = %35
  %52 = load i32, i32* %9, align 4
  %53 = icmp ugt i32 %52, 0
  br i1 %53, label %54, label %56

54:                                               ; preds = %51
  %55 = load i32, i32* %10, align 4
  store i32 %55, i32* %11, align 4
  br label %56

56:                                               ; preds = %54, %51, %35
  %57 = load i32, i32* %13, align 4
  store i32 %57, i32* %9, align 4
  br label %32, !llvm.loop !27

58:                                               ; preds = %32
  %59 = load i32, i32* %10, align 4
  %60 = icmp ugt i32 %59, 0
  br i1 %60, label %61, label %103

61:                                               ; preds = %58
  br label %62

62:                                               ; preds = %65, %61
  %63 = load i32, i32* %10, align 4
  %64 = icmp ugt i32 %63, 5
  br i1 %64, label %65, label %73

65:                                               ; preds = %62
  %66 = load i32, i32* %10, align 4
  %67 = add i32 %66, -1
  store i32 %67, i32* %10, align 4
  %68 = zext i32 %67 to i64
  %69 = getelementptr inbounds [10 x i8], [10 x i8]* %12, i64 0, i64 %68
  %70 = load i8, i8* %69, align 1
  %71 = load i8*, i8** %6, align 8
  %72 = getelementptr inbounds i8, i8* %71, i32 1
  store i8* %72, i8** %6, align 8
  store i8 %70, i8* %71, align 1
  br label %62, !llvm.loop !28

73:                                               ; preds = %62
  %74 = load i32, i32* %11, align 4
  %75 = icmp ule i32 %74, 5
  br i1 %75, label %76, label %102

76:                                               ; preds = %73
  %77 = load i8*, i8** %6, align 8
  %78 = getelementptr inbounds i8, i8* %77, i32 1
  store i8* %78, i8** %6, align 8
  store i8 46, i8* %77, align 1
  store i32 5, i32* %14, align 4
  br label %79

79:                                               ; preds = %83, %76
  %80 = load i32, i32* %10, align 4
  %81 = load i32, i32* %14, align 4
  %82 = icmp ult i32 %80, %81
  br i1 %82, label %83, label %88

83:                                               ; preds = %79
  %84 = load i8*, i8** %6, align 8
  %85 = getelementptr inbounds i8, i8* %84, i32 1
  store i8* %85, i8** %6, align 8
  store i8 48, i8* %84, align 1
  %86 = load i32, i32* %14, align 4
  %87 = add i32 %86, -1
  store i32 %87, i32* %14, align 4
  br label %79, !llvm.loop !29

88:                                               ; preds = %79
  br label %89

89:                                               ; preds = %93, %88
  %90 = load i32, i32* %10, align 4
  %91 = load i32, i32* %11, align 4
  %92 = icmp uge i32 %90, %91
  br i1 %92, label %93, label %101

93:                                               ; preds = %89
  %94 = load i32, i32* %10, align 4
  %95 = add i32 %94, -1
  store i32 %95, i32* %10, align 4
  %96 = zext i32 %95 to i64
  %97 = getelementptr inbounds [10 x i8], [10 x i8]* %12, i64 0, i64 %96
  %98 = load i8, i8* %97, align 1
  %99 = load i8*, i8** %6, align 8
  %100 = getelementptr inbounds i8, i8* %99, i32 1
  store i8* %100, i8** %6, align 8
  store i8 %98, i8* %99, align 1
  br label %89, !llvm.loop !30

101:                                              ; preds = %89
  br label %102

102:                                              ; preds = %101, %73
  br label %106

103:                                              ; preds = %58
  %104 = load i8*, i8** %6, align 8
  %105 = getelementptr inbounds i8, i8* %104, i32 1
  store i8* %105, i8** %6, align 8
  store i8 48, i8* %104, align 1
  br label %106

106:                                              ; preds = %103, %102
  %107 = load i8*, i8** %6, align 8
  store i8 0, i8* %107, align 1
  ret void

108:                                              ; preds = %27
  br label %109

109:                                              ; preds = %108, %4
  %110 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  call void @png_error(%struct.png_struct_def* noundef %110, i8* noundef getelementptr inbounds ([34 x i8], [34 x i8]* @.str.55, i64 0, i64 0)) #10
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_fixed(%struct.png_struct_def* noalias noundef %0, double noundef %1, i8* noundef %2) #0 {
  %4 = alloca %struct.png_struct_def*, align 8
  %5 = alloca double, align 8
  %6 = alloca i8*, align 8
  %7 = alloca double, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %4, align 8
  store double %1, double* %5, align 8
  store i8* %2, i8** %6, align 8
  %8 = load double, double* %5, align 8
  %9 = call double @llvm.fmuladd.f64(double 1.000000e+05, double %8, double 5.000000e-01)
  %10 = call double @llvm.floor.f64(double %9)
  store double %10, double* %7, align 8
  %11 = load double, double* %7, align 8
  %12 = fcmp ogt double %11, 0x41DFFFFFFFC00000
  br i1 %12, label %16, label %13

13:                                               ; preds = %3
  %14 = load double, double* %7, align 8
  %15 = fcmp olt double %14, 0xC1E0000000000000
  br i1 %15, label %16, label %19

16:                                               ; preds = %13, %3
  %17 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %18 = load i8*, i8** %6, align 8
  call void @png_fixed_error(%struct.png_struct_def* noundef %17, i8* noundef %18) #10
  unreachable

19:                                               ; preds = %13
  %20 = load double, double* %7, align 8
  %21 = fptosi double %20 to i32
  ret i32 %21
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare double @llvm.fmuladd.f64(double, double, double) #9

; Function Attrs: noreturn
declare void @png_fixed_error(%struct.png_struct_def* noundef, i8* noundef) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_gamma_significant(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = icmp slt i32 %3, 95000
  br i1 %4, label %8, label %5

5:                                                ; preds = %1
  %6 = load i32, i32* %2, align 4
  %7 = icmp sgt i32 %6, 105000
  br label %8

8:                                                ; preds = %5, %1
  %9 = phi i1 [ true, %1 ], [ %7, %5 ]
  %10 = zext i1 %9 to i32
  ret i32 %10
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_reciprocal2(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca double, align 8
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  %7 = load i32, i32* %4, align 4
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %32

9:                                                ; preds = %2
  %10 = load i32, i32* %5, align 4
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %32

12:                                               ; preds = %9
  %13 = load i32, i32* %4, align 4
  %14 = sitofp i32 %13 to double
  %15 = fdiv double 1.000000e+15, %14
  store double %15, double* %6, align 8
  %16 = load i32, i32* %5, align 4
  %17 = sitofp i32 %16 to double
  %18 = load double, double* %6, align 8
  %19 = fdiv double %18, %17
  store double %19, double* %6, align 8
  %20 = load double, double* %6, align 8
  %21 = fadd double %20, 5.000000e-01
  %22 = call double @llvm.floor.f64(double %21)
  store double %22, double* %6, align 8
  %23 = load double, double* %6, align 8
  %24 = fcmp ole double %23, 0x41DFFFFFFFC00000
  br i1 %24, label %25, label %31

25:                                               ; preds = %12
  %26 = load double, double* %6, align 8
  %27 = fcmp oge double %26, 0xC1E0000000000000
  br i1 %27, label %28, label %31

28:                                               ; preds = %25
  %29 = load double, double* %6, align 8
  %30 = fptosi double %29 to i32
  store i32 %30, i32* %3, align 4
  br label %33

31:                                               ; preds = %25, %12
  br label %32

32:                                               ; preds = %31, %9, %2
  store i32 0, i32* %3, align 4
  br label %33

33:                                               ; preds = %32, %28
  %34 = load i32, i32* %3, align 4
  ret i32 %34
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i8 @png_gamma_8bit_correct(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i8, align 1
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca double, align 8
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  %7 = load i32, i32* %4, align 4
  %8 = icmp ugt i32 %7, 0
  br i1 %8, label %9, label %24

9:                                                ; preds = %2
  %10 = load i32, i32* %4, align 4
  %11 = icmp ult i32 %10, 255
  br i1 %11, label %12, label %24

12:                                               ; preds = %9
  %13 = load i32, i32* %4, align 4
  %14 = sitofp i32 %13 to double
  %15 = fdiv double %14, 2.550000e+02
  %16 = load i32, i32* %5, align 4
  %17 = sitofp i32 %16 to double
  %18 = fmul double %17, 1.000000e-05
  %19 = call double @pow(double noundef %15, double noundef %18) #13
  %20 = call double @llvm.fmuladd.f64(double 2.550000e+02, double %19, double 5.000000e-01)
  %21 = call double @llvm.floor.f64(double %20)
  store double %21, double* %6, align 8
  %22 = load double, double* %6, align 8
  %23 = fptoui double %22 to i8
  store i8 %23, i8* %3, align 1
  br label %28

24:                                               ; preds = %9, %2
  %25 = load i32, i32* %4, align 4
  %26 = and i32 %25, 255
  %27 = trunc i32 %26 to i8
  store i8 %27, i8* %3, align 1
  br label %28

28:                                               ; preds = %24, %12
  %29 = load i8, i8* %3, align 1
  ret i8 %29
}

; Function Attrs: nounwind
declare double @pow(double noundef, double noundef) #8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i16 @png_gamma_16bit_correct(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i16, align 2
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca double, align 8
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  %7 = load i32, i32* %4, align 4
  %8 = icmp ugt i32 %7, 0
  br i1 %8, label %9, label %24

9:                                                ; preds = %2
  %10 = load i32, i32* %4, align 4
  %11 = icmp ult i32 %10, 65535
  br i1 %11, label %12, label %24

12:                                               ; preds = %9
  %13 = load i32, i32* %4, align 4
  %14 = sitofp i32 %13 to double
  %15 = fdiv double %14, 6.553500e+04
  %16 = load i32, i32* %5, align 4
  %17 = sitofp i32 %16 to double
  %18 = fmul double %17, 1.000000e-05
  %19 = call double @pow(double noundef %15, double noundef %18) #13
  %20 = call double @llvm.fmuladd.f64(double 6.553500e+04, double %19, double 5.000000e-01)
  %21 = call double @llvm.floor.f64(double %20)
  store double %21, double* %6, align 8
  %22 = load double, double* %6, align 8
  %23 = fptoui double %22 to i16
  store i16 %23, i16* %3, align 2
  br label %27

24:                                               ; preds = %9, %2
  %25 = load i32, i32* %4, align 4
  %26 = trunc i32 %25 to i16
  store i16 %26, i16* %3, align 2
  br label %27

27:                                               ; preds = %24, %12
  %28 = load i16, i16* %3, align 2
  ret i16 %28
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local zeroext i16 @png_gamma_correct(%struct.png_struct_def* noalias noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i16, align 2
  %5 = alloca %struct.png_struct_def*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %5, align 8
  store i32 %1, i32* %6, align 4
  store i32 %2, i32* %7, align 4
  %8 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %9 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %8, i32 0, i32 63
  %10 = load i8, i8* %9, align 8
  %11 = zext i8 %10 to i32
  %12 = icmp eq i32 %11, 8
  br i1 %12, label %13, label %18

13:                                               ; preds = %3
  %14 = load i32, i32* %6, align 4
  %15 = load i32, i32* %7, align 4
  %16 = call zeroext i8 @png_gamma_8bit_correct(i32 noundef %14, i32 noundef %15)
  %17 = zext i8 %16 to i16
  store i16 %17, i16* %4, align 2
  br label %22

18:                                               ; preds = %3
  %19 = load i32, i32* %6, align 4
  %20 = load i32, i32* %7, align 4
  %21 = call zeroext i16 @png_gamma_16bit_correct(i32 noundef %19, i32 noundef %20)
  store i16 %21, i16* %4, align 2
  br label %22

22:                                               ; preds = %18, %13
  %23 = load i16, i16* %4, align 2
  ret i16 %23
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_destroy_gamma_table(%struct.png_struct_def* noalias noundef %0) #0 {
  %2 = alloca %struct.png_struct_def*, align 8
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %2, align 8
  %9 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %10 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %11 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %10, i32 0, i32 86
  %12 = load i8*, i8** %11, align 8
  call void @png_free(%struct.png_struct_def* noundef %9, i8* noundef %12)
  %13 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %14 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %13, i32 0, i32 86
  store i8* null, i8** %14, align 8
  %15 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %16 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %15, i32 0, i32 87
  %17 = load i16**, i16*** %16, align 8
  %18 = icmp ne i16** %17, null
  br i1 %18, label %19, label %50

19:                                               ; preds = %1
  %20 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %21 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %20, i32 0, i32 81
  %22 = load i32, i32* %21, align 8
  %23 = sub nsw i32 8, %22
  %24 = shl i32 1, %23
  store i32 %24, i32* %4, align 4
  store i32 0, i32* %3, align 4
  br label %25

25:                                               ; preds = %39, %19
  %26 = load i32, i32* %3, align 4
  %27 = load i32, i32* %4, align 4
  %28 = icmp slt i32 %26, %27
  br i1 %28, label %29, label %42

29:                                               ; preds = %25
  %30 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %31 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %32 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %31, i32 0, i32 87
  %33 = load i16**, i16*** %32, align 8
  %34 = load i32, i32* %3, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds i16*, i16** %33, i64 %35
  %37 = load i16*, i16** %36, align 8
  %38 = bitcast i16* %37 to i8*
  call void @png_free(%struct.png_struct_def* noundef %30, i8* noundef %38)
  br label %39

39:                                               ; preds = %29
  %40 = load i32, i32* %3, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, i32* %3, align 4
  br label %25, !llvm.loop !31

42:                                               ; preds = %25
  %43 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %44 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %45 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %44, i32 0, i32 87
  %46 = load i16**, i16*** %45, align 8
  %47 = bitcast i16** %46 to i8*
  call void @png_free(%struct.png_struct_def* noundef %43, i8* noundef %47)
  %48 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %49 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %48, i32 0, i32 87
  store i16** null, i16*** %49, align 8
  br label %50

50:                                               ; preds = %42, %1
  %51 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %52 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %53 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %52, i32 0, i32 88
  %54 = load i8*, i8** %53, align 8
  call void @png_free(%struct.png_struct_def* noundef %51, i8* noundef %54)
  %55 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %56 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %55, i32 0, i32 88
  store i8* null, i8** %56, align 8
  %57 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %58 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %59 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %58, i32 0, i32 89
  %60 = load i8*, i8** %59, align 8
  call void @png_free(%struct.png_struct_def* noundef %57, i8* noundef %60)
  %61 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %62 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %61, i32 0, i32 89
  store i8* null, i8** %62, align 8
  %63 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %64 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %63, i32 0, i32 90
  %65 = load i16**, i16*** %64, align 8
  %66 = icmp ne i16** %65, null
  br i1 %66, label %67, label %98

67:                                               ; preds = %50
  %68 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %69 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %68, i32 0, i32 81
  %70 = load i32, i32* %69, align 8
  %71 = sub nsw i32 8, %70
  %72 = shl i32 1, %71
  store i32 %72, i32* %6, align 4
  store i32 0, i32* %5, align 4
  br label %73

73:                                               ; preds = %87, %67
  %74 = load i32, i32* %5, align 4
  %75 = load i32, i32* %6, align 4
  %76 = icmp slt i32 %74, %75
  br i1 %76, label %77, label %90

77:                                               ; preds = %73
  %78 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %79 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %80 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %79, i32 0, i32 90
  %81 = load i16**, i16*** %80, align 8
  %82 = load i32, i32* %5, align 4
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds i16*, i16** %81, i64 %83
  %85 = load i16*, i16** %84, align 8
  %86 = bitcast i16* %85 to i8*
  call void @png_free(%struct.png_struct_def* noundef %78, i8* noundef %86)
  br label %87

87:                                               ; preds = %77
  %88 = load i32, i32* %5, align 4
  %89 = add nsw i32 %88, 1
  store i32 %89, i32* %5, align 4
  br label %73, !llvm.loop !32

90:                                               ; preds = %73
  %91 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %92 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %93 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %92, i32 0, i32 90
  %94 = load i16**, i16*** %93, align 8
  %95 = bitcast i16** %94 to i8*
  call void @png_free(%struct.png_struct_def* noundef %91, i8* noundef %95)
  %96 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %97 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %96, i32 0, i32 90
  store i16** null, i16*** %97, align 8
  br label %98

98:                                               ; preds = %90, %50
  %99 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %100 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %99, i32 0, i32 91
  %101 = load i16**, i16*** %100, align 8
  %102 = icmp ne i16** %101, null
  br i1 %102, label %103, label %134

103:                                              ; preds = %98
  %104 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %105 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %104, i32 0, i32 81
  %106 = load i32, i32* %105, align 8
  %107 = sub nsw i32 8, %106
  %108 = shl i32 1, %107
  store i32 %108, i32* %8, align 4
  store i32 0, i32* %7, align 4
  br label %109

109:                                              ; preds = %123, %103
  %110 = load i32, i32* %7, align 4
  %111 = load i32, i32* %8, align 4
  %112 = icmp slt i32 %110, %111
  br i1 %112, label %113, label %126

113:                                              ; preds = %109
  %114 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %115 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %116 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %115, i32 0, i32 91
  %117 = load i16**, i16*** %116, align 8
  %118 = load i32, i32* %7, align 4
  %119 = sext i32 %118 to i64
  %120 = getelementptr inbounds i16*, i16** %117, i64 %119
  %121 = load i16*, i16** %120, align 8
  %122 = bitcast i16* %121 to i8*
  call void @png_free(%struct.png_struct_def* noundef %114, i8* noundef %122)
  br label %123

123:                                              ; preds = %113
  %124 = load i32, i32* %7, align 4
  %125 = add nsw i32 %124, 1
  store i32 %125, i32* %7, align 4
  br label %109, !llvm.loop !33

126:                                              ; preds = %109
  %127 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %128 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %129 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %128, i32 0, i32 91
  %130 = load i16**, i16*** %129, align 8
  %131 = bitcast i16** %130 to i8*
  call void @png_free(%struct.png_struct_def* noundef %127, i8* noundef %131)
  %132 = load %struct.png_struct_def*, %struct.png_struct_def** %2, align 8
  %133 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %132, i32 0, i32 91
  store i16** null, i16*** %133, align 8
  br label %134

134:                                              ; preds = %126, %98
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_build_gamma_table(%struct.png_struct_def* noalias noundef %0, i32 noundef %1) #0 {
  %3 = alloca %struct.png_struct_def*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i8, align 1
  %11 = alloca i8, align 1
  store %struct.png_struct_def* %0, %struct.png_struct_def** %3, align 8
  store i32 %1, i32* %4, align 4
  %12 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %13 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %12, i32 0, i32 86
  %14 = load i8*, i8** %13, align 8
  %15 = icmp ne i8* %14, null
  br i1 %15, label %21, label %16

16:                                               ; preds = %2
  %17 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %18 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %17, i32 0, i32 87
  %19 = load i16**, i16*** %18, align 8
  %20 = icmp ne i16** %19, null
  br i1 %20, label %21, label %24

21:                                               ; preds = %16, %2
  %22 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  call void @png_warning(%struct.png_struct_def* noundef %22, i8* noundef getelementptr inbounds ([26 x i8], [26 x i8]* @.str.56, i64 0, i64 0))
  %23 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  call void @png_destroy_gamma_table(%struct.png_struct_def* noundef %23)
  br label %24

24:                                               ; preds = %21, %16
  %25 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %26 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %25, i32 0, i32 83
  %27 = load i32, i32* %26, align 8
  store i32 %27, i32* %5, align 4
  %28 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %29 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %28, i32 0, i32 82
  %30 = load i32, i32* %29, align 4
  store i32 %30, i32* %6, align 4
  %31 = load i32, i32* %5, align 4
  %32 = call i32 @png_reciprocal(i32 noundef %31)
  store i32 %32, i32* %8, align 4
  %33 = load i32, i32* %6, align 4
  %34 = icmp sgt i32 %33, 0
  br i1 %34, label %35, label %41

35:                                               ; preds = %24
  %36 = load i32, i32* %6, align 4
  %37 = call i32 @png_reciprocal(i32 noundef %36)
  store i32 %37, i32* %9, align 4
  %38 = load i32, i32* %6, align 4
  %39 = load i32, i32* %5, align 4
  %40 = call i32 @png_reciprocal2(i32 noundef %38, i32 noundef %39)
  store i32 %40, i32* %7, align 4
  br label %43

41:                                               ; preds = %24
  %42 = load i32, i32* %5, align 4
  store i32 %42, i32* %9, align 4
  store i32 100000, i32* %7, align 4
  br label %43

43:                                               ; preds = %41, %35
  %44 = load i32, i32* %4, align 4
  %45 = icmp sle i32 %44, 8
  br i1 %45, label %46, label %66

46:                                               ; preds = %43
  %47 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %48 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %49 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %48, i32 0, i32 86
  %50 = load i32, i32* %7, align 4
  call void @png_build_8bit_table(%struct.png_struct_def* noundef %47, i8** noundef %49, i32 noundef %50)
  %51 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %52 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %51, i32 0, i32 17
  %53 = load i32, i32* %52, align 4
  %54 = and i32 %53, 6291584
  %55 = icmp ne i32 %54, 0
  br i1 %55, label %56, label %65

56:                                               ; preds = %46
  %57 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %58 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %59 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %58, i32 0, i32 89
  %60 = load i32, i32* %8, align 4
  call void @png_build_8bit_table(%struct.png_struct_def* noundef %57, i8** noundef %59, i32 noundef %60)
  %61 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %62 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %63 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %62, i32 0, i32 88
  %64 = load i32, i32* %9, align 4
  call void @png_build_8bit_table(%struct.png_struct_def* noundef %61, i8** noundef %63, i32 noundef %64)
  br label %65

65:                                               ; preds = %56, %46
  br label %188

66:                                               ; preds = %43
  %67 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %68 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %67, i32 0, i32 62
  %69 = load i8, i8* %68, align 1
  %70 = zext i8 %69 to i32
  %71 = and i32 %70, 2
  %72 = icmp ne i32 %71, 0
  br i1 %72, label %73, label %106

73:                                               ; preds = %66
  %74 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %75 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %74, i32 0, i32 92
  %76 = getelementptr inbounds %struct.png_color_8_struct, %struct.png_color_8_struct* %75, i32 0, i32 0
  %77 = load i8, i8* %76, align 8
  store i8 %77, i8* %11, align 1
  %78 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %79 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %78, i32 0, i32 92
  %80 = getelementptr inbounds %struct.png_color_8_struct, %struct.png_color_8_struct* %79, i32 0, i32 1
  %81 = load i8, i8* %80, align 1
  %82 = zext i8 %81 to i32
  %83 = load i8, i8* %11, align 1
  %84 = zext i8 %83 to i32
  %85 = icmp sgt i32 %82, %84
  br i1 %85, label %86, label %91

86:                                               ; preds = %73
  %87 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %88 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %87, i32 0, i32 92
  %89 = getelementptr inbounds %struct.png_color_8_struct, %struct.png_color_8_struct* %88, i32 0, i32 1
  %90 = load i8, i8* %89, align 1
  store i8 %90, i8* %11, align 1
  br label %91

91:                                               ; preds = %86, %73
  %92 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %93 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %92, i32 0, i32 92
  %94 = getelementptr inbounds %struct.png_color_8_struct, %struct.png_color_8_struct* %93, i32 0, i32 2
  %95 = load i8, i8* %94, align 2
  %96 = zext i8 %95 to i32
  %97 = load i8, i8* %11, align 1
  %98 = zext i8 %97 to i32
  %99 = icmp sgt i32 %96, %98
  br i1 %99, label %100, label %105

100:                                              ; preds = %91
  %101 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %102 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %101, i32 0, i32 92
  %103 = getelementptr inbounds %struct.png_color_8_struct, %struct.png_color_8_struct* %102, i32 0, i32 2
  %104 = load i8, i8* %103, align 2
  store i8 %104, i8* %11, align 1
  br label %105

105:                                              ; preds = %100, %91
  br label %111

106:                                              ; preds = %66
  %107 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %108 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %107, i32 0, i32 92
  %109 = getelementptr inbounds %struct.png_color_8_struct, %struct.png_color_8_struct* %108, i32 0, i32 3
  %110 = load i8, i8* %109, align 1
  store i8 %110, i8* %11, align 1
  br label %111

111:                                              ; preds = %106, %105
  %112 = load i8, i8* %11, align 1
  %113 = zext i8 %112 to i32
  %114 = icmp sgt i32 %113, 0
  br i1 %114, label %115, label %125

115:                                              ; preds = %111
  %116 = load i8, i8* %11, align 1
  %117 = zext i8 %116 to i32
  %118 = icmp ult i32 %117, 16
  br i1 %118, label %119, label %125

119:                                              ; preds = %115
  %120 = load i8, i8* %11, align 1
  %121 = zext i8 %120 to i32
  %122 = sub i32 16, %121
  %123 = and i32 %122, 255
  %124 = trunc i32 %123 to i8
  store i8 %124, i8* %10, align 1
  br label %126

125:                                              ; preds = %115, %111
  store i8 0, i8* %10, align 1
  br label %126

126:                                              ; preds = %125, %119
  %127 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %128 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %127, i32 0, i32 17
  %129 = load i32, i32* %128, align 4
  %130 = and i32 %129, 67109888
  %131 = icmp ne i32 %130, 0
  br i1 %131, label %132, label %138

132:                                              ; preds = %126
  %133 = load i8, i8* %10, align 1
  %134 = zext i8 %133 to i32
  %135 = icmp ult i32 %134, 5
  br i1 %135, label %136, label %137

136:                                              ; preds = %132
  store i8 5, i8* %10, align 1
  br label %137

137:                                              ; preds = %136, %132
  br label %138

138:                                              ; preds = %137, %126
  %139 = load i8, i8* %10, align 1
  %140 = zext i8 %139 to i32
  %141 = icmp ugt i32 %140, 8
  br i1 %141, label %142, label %143

142:                                              ; preds = %138
  store i8 8, i8* %10, align 1
  br label %143

143:                                              ; preds = %142, %138
  %144 = load i8, i8* %10, align 1
  %145 = zext i8 %144 to i32
  %146 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %147 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %146, i32 0, i32 81
  store i32 %145, i32* %147, align 8
  %148 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %149 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %148, i32 0, i32 17
  %150 = load i32, i32* %149, align 4
  %151 = and i32 %150, 67109888
  %152 = icmp ne i32 %151, 0
  br i1 %152, label %153, label %161

153:                                              ; preds = %143
  %154 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %155 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %156 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %155, i32 0, i32 87
  %157 = load i8, i8* %10, align 1
  %158 = zext i8 %157 to i32
  %159 = load i32, i32* %7, align 4
  %160 = call i32 @png_reciprocal(i32 noundef %159)
  call void @png_build_16to8_table(%struct.png_struct_def* noundef %154, i16*** noundef %156, i32 noundef %158, i32 noundef %160)
  br label %168

161:                                              ; preds = %143
  %162 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %163 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %164 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %163, i32 0, i32 87
  %165 = load i8, i8* %10, align 1
  %166 = zext i8 %165 to i32
  %167 = load i32, i32* %7, align 4
  call void @png_build_16bit_table(%struct.png_struct_def* noundef %162, i16*** noundef %164, i32 noundef %166, i32 noundef %167)
  br label %168

168:                                              ; preds = %161, %153
  %169 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %170 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %169, i32 0, i32 17
  %171 = load i32, i32* %170, align 4
  %172 = and i32 %171, 6291584
  %173 = icmp ne i32 %172, 0
  br i1 %173, label %174, label %187

174:                                              ; preds = %168
  %175 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %176 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %177 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %176, i32 0, i32 91
  %178 = load i8, i8* %10, align 1
  %179 = zext i8 %178 to i32
  %180 = load i32, i32* %8, align 4
  call void @png_build_16bit_table(%struct.png_struct_def* noundef %175, i16*** noundef %177, i32 noundef %179, i32 noundef %180)
  %181 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %182 = load %struct.png_struct_def*, %struct.png_struct_def** %3, align 8
  %183 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %182, i32 0, i32 90
  %184 = load i8, i8* %10, align 1
  %185 = zext i8 %184 to i32
  %186 = load i32, i32* %9, align 4
  call void @png_build_16bit_table(%struct.png_struct_def* noundef %181, i16*** noundef %183, i32 noundef %185, i32 noundef %186)
  br label %187

187:                                              ; preds = %174, %168
  br label %188

188:                                              ; preds = %187, %65
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @png_build_8bit_table(%struct.png_struct_def* noalias noundef %0, i8** noundef %1, i32 noundef %2) #0 {
  %4 = alloca %struct.png_struct_def*, align 8
  %5 = alloca i8**, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i8*, align 8
  store %struct.png_struct_def* %0, %struct.png_struct_def** %4, align 8
  store i8** %1, i8*** %5, align 8
  store i32 %2, i32* %6, align 4
  %9 = load %struct.png_struct_def*, %struct.png_struct_def** %4, align 8
  %10 = call noalias i8* @png_malloc(%struct.png_struct_def* noundef %9, i64 noundef 256)
  %11 = load i8**, i8*** %5, align 8
  store i8* %10, i8** %11, align 8
  store i8* %10, i8** %8, align 8
  %12 = load i32, i32* %6, align 4
  %13 = call i32 @png_gamma_significant(i32 noundef %12)
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %15, label %31

15:                                               ; preds = %3
  store i32 0, i32* %7, align 4
  br label %16

16:                                               ; preds = %27, %15
  %17 = load i32, i32* %7, align 4
  %18 = icmp ult i32 %17, 256
  br i1 %18, label %19, label %30

19:                                               ; preds = %16
  %20 = load i32, i32* %7, align 4
  %21 = load i32, i32* %6, align 4
  %22 = call zeroext i8 @png_gamma_8bit_correct(i32 noundef %20, i32 noundef %21)
  %23 = load i8*, i8** %8, align 8
  %24 = load i32, i32* %7, align 4
  %25 = zext i32 %24 to i64
  %26 = getelementptr inbounds i8, i8* %23, i64 %25
  store i8 %22, i8* %26, align 1
  br label %27

27:                                               ; preds = %19
  %28 = load i32, i32* %7, align 4
  %29 = add i32 %28, 1
  store i32 %29, i32* %7, align 4
  br label %16, !llvm.loop !34

30:                                               ; preds = %16
  br label %47

31:                                               ; preds = %3
  store i32 0, i32* %7, align 4
  br label %32

32:                                               ; preds = %43, %31
  %33 = load i32, i32* %7, align 4
  %34 = icmp ult i32 %33, 256
  br i1 %34, label %35, label %46

35:                                               ; preds = %32
  %36 = load i32, i32* %7, align 4
  %37 = and i32 %36, 255
  %38 = trunc i32 %37 to i8
  %39 = load i8*, i8** %8, align 8
  %40 = load i32, i32* %7, align 4
  %41 = zext i32 %40 to i64
  %42 = getelementptr inbounds i8, i8* %39, i64 %41
  store i8 %38, i8* %42, align 1
  br label %43

43:                                               ; preds = %35
  %44 = load i32, i32* %7, align 4
  %45 = add i32 %44, 1
  store i32 %45, i32* %7, align 4
  br label %32, !llvm.loop !35

46:                                               ; preds = %32
  br label %47

47:                                               ; preds = %46, %30
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @png_build_16to8_table(%struct.png_struct_def* noalias noundef %0, i16*** noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca %struct.png_struct_def*, align 8
  %6 = alloca i16***, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i16**, align 8
  %14 = alloca i16, align 2
  %15 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %5, align 8
  store i16*** %1, i16**** %6, align 8
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  %16 = load i32, i32* %7, align 4
  %17 = sub i32 8, %16
  %18 = shl i32 1, %17
  store i32 %18, i32* %9, align 4
  %19 = load i32, i32* %7, align 4
  %20 = sub i32 16, %19
  %21 = shl i32 1, %20
  %22 = sub i32 %21, 1
  store i32 %22, i32* %10, align 4
  %23 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %24 = load i32, i32* %9, align 4
  %25 = zext i32 %24 to i64
  %26 = mul i64 %25, 8
  %27 = call noalias i8* @png_calloc(%struct.png_struct_def* noundef %23, i64 noundef %26)
  %28 = bitcast i8* %27 to i16**
  %29 = load i16***, i16**** %6, align 8
  store i16** %28, i16*** %29, align 8
  store i16** %28, i16*** %13, align 8
  store i32 0, i32* %11, align 4
  br label %30

30:                                               ; preds = %42, %4
  %31 = load i32, i32* %11, align 4
  %32 = load i32, i32* %9, align 4
  %33 = icmp ult i32 %31, %32
  br i1 %33, label %34, label %45

34:                                               ; preds = %30
  %35 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %36 = call noalias i8* @png_malloc(%struct.png_struct_def* noundef %35, i64 noundef 512)
  %37 = bitcast i8* %36 to i16*
  %38 = load i16**, i16*** %13, align 8
  %39 = load i32, i32* %11, align 4
  %40 = zext i32 %39 to i64
  %41 = getelementptr inbounds i16*, i16** %38, i64 %40
  store i16* %37, i16** %41, align 8
  br label %42

42:                                               ; preds = %34
  %43 = load i32, i32* %11, align 4
  %44 = add i32 %43, 1
  store i32 %44, i32* %11, align 4
  br label %30, !llvm.loop !36

45:                                               ; preds = %30
  store i32 0, i32* %12, align 4
  store i32 0, i32* %11, align 4
  br label %46

46:                                               ; preds = %88, %45
  %47 = load i32, i32* %11, align 4
  %48 = icmp ult i32 %47, 255
  br i1 %48, label %49, label %91

49:                                               ; preds = %46
  %50 = load i32, i32* %11, align 4
  %51 = mul i32 %50, 257
  %52 = trunc i32 %51 to i16
  store i16 %52, i16* %14, align 2
  %53 = load i16, i16* %14, align 2
  %54 = zext i16 %53 to i32
  %55 = add i32 %54, 128
  %56 = load i32, i32* %8, align 4
  %57 = call zeroext i16 @png_gamma_16bit_correct(i32 noundef %55, i32 noundef %56)
  %58 = zext i16 %57 to i32
  store i32 %58, i32* %15, align 4
  %59 = load i32, i32* %15, align 4
  %60 = load i32, i32* %10, align 4
  %61 = mul i32 %59, %60
  %62 = add i32 %61, 32768
  %63 = udiv i32 %62, 65535
  %64 = add i32 %63, 1
  store i32 %64, i32* %15, align 4
  br label %65

65:                                               ; preds = %69, %49
  %66 = load i32, i32* %12, align 4
  %67 = load i32, i32* %15, align 4
  %68 = icmp ult i32 %66, %67
  br i1 %68, label %69, label %87

69:                                               ; preds = %65
  %70 = load i16, i16* %14, align 2
  %71 = load i16**, i16*** %13, align 8
  %72 = load i32, i32* %12, align 4
  %73 = load i32, i32* %7, align 4
  %74 = lshr i32 255, %73
  %75 = and i32 %72, %74
  %76 = zext i32 %75 to i64
  %77 = getelementptr inbounds i16*, i16** %71, i64 %76
  %78 = load i16*, i16** %77, align 8
  %79 = load i32, i32* %12, align 4
  %80 = load i32, i32* %7, align 4
  %81 = sub i32 8, %80
  %82 = lshr i32 %79, %81
  %83 = zext i32 %82 to i64
  %84 = getelementptr inbounds i16, i16* %78, i64 %83
  store i16 %70, i16* %84, align 2
  %85 = load i32, i32* %12, align 4
  %86 = add i32 %85, 1
  store i32 %86, i32* %12, align 4
  br label %65, !llvm.loop !37

87:                                               ; preds = %65
  br label %88

88:                                               ; preds = %87
  %89 = load i32, i32* %11, align 4
  %90 = add i32 %89, 1
  store i32 %90, i32* %11, align 4
  br label %46, !llvm.loop !38

91:                                               ; preds = %46
  br label %92

92:                                               ; preds = %97, %91
  %93 = load i32, i32* %12, align 4
  %94 = load i32, i32* %9, align 4
  %95 = shl i32 %94, 8
  %96 = icmp ult i32 %93, %95
  br i1 %96, label %97, label %114

97:                                               ; preds = %92
  %98 = load i16**, i16*** %13, align 8
  %99 = load i32, i32* %12, align 4
  %100 = load i32, i32* %7, align 4
  %101 = ashr i32 255, %100
  %102 = and i32 %99, %101
  %103 = zext i32 %102 to i64
  %104 = getelementptr inbounds i16*, i16** %98, i64 %103
  %105 = load i16*, i16** %104, align 8
  %106 = load i32, i32* %12, align 4
  %107 = load i32, i32* %7, align 4
  %108 = sub i32 8, %107
  %109 = lshr i32 %106, %108
  %110 = zext i32 %109 to i64
  %111 = getelementptr inbounds i16, i16* %105, i64 %110
  store i16 -1, i16* %111, align 2
  %112 = load i32, i32* %12, align 4
  %113 = add i32 %112, 1
  store i32 %113, i32* %12, align 4
  br label %92, !llvm.loop !39

114:                                              ; preds = %92
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @png_build_16bit_table(%struct.png_struct_def* noalias noundef %0, i16*** noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca %struct.png_struct_def*, align 8
  %6 = alloca i16***, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca double, align 8
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i16**, align 8
  %15 = alloca i16*, align 8
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca double, align 8
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %5, align 8
  store i16*** %1, i16**** %6, align 8
  store i32 %2, i32* %7, align 4
  store i32 %3, i32* %8, align 4
  %21 = load i32, i32* %7, align 4
  %22 = sub i32 8, %21
  %23 = shl i32 1, %22
  store i32 %23, i32* %9, align 4
  %24 = load i32, i32* %7, align 4
  %25 = sub i32 16, %24
  %26 = shl i32 1, %25
  %27 = sub nsw i32 %26, 1
  %28 = sitofp i32 %27 to double
  %29 = fdiv double 1.000000e+00, %28
  store double %29, double* %10, align 8
  %30 = load i32, i32* %7, align 4
  %31 = sub i32 16, %30
  %32 = shl i32 1, %31
  %33 = sub i32 %32, 1
  store i32 %33, i32* %11, align 4
  %34 = load i32, i32* %7, align 4
  %35 = sub i32 15, %34
  %36 = shl i32 1, %35
  store i32 %36, i32* %12, align 4
  %37 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %38 = load i32, i32* %9, align 4
  %39 = zext i32 %38 to i64
  %40 = mul i64 %39, 8
  %41 = call noalias i8* @png_calloc(%struct.png_struct_def* noundef %37, i64 noundef %40)
  %42 = bitcast i8* %41 to i16**
  %43 = load i16***, i16**** %6, align 8
  store i16** %42, i16*** %43, align 8
  store i16** %42, i16*** %14, align 8
  store i32 0, i32* %13, align 4
  br label %44

44:                                               ; preds = %122, %4
  %45 = load i32, i32* %13, align 4
  %46 = load i32, i32* %9, align 4
  %47 = icmp ult i32 %45, %46
  br i1 %47, label %48, label %125

48:                                               ; preds = %44
  %49 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %50 = call noalias i8* @png_malloc(%struct.png_struct_def* noundef %49, i64 noundef 512)
  %51 = bitcast i8* %50 to i16*
  %52 = load i16**, i16*** %14, align 8
  %53 = load i32, i32* %13, align 4
  %54 = zext i32 %53 to i64
  %55 = getelementptr inbounds i16*, i16** %52, i64 %54
  store i16* %51, i16** %55, align 8
  store i16* %51, i16** %15, align 8
  %56 = load i32, i32* %8, align 4
  %57 = call i32 @png_gamma_significant(i32 noundef %56)
  %58 = icmp ne i32 %57, 0
  br i1 %58, label %59, label %90

59:                                               ; preds = %48
  store i32 0, i32* %16, align 4
  br label %60

60:                                               ; preds = %86, %59
  %61 = load i32, i32* %16, align 4
  %62 = icmp ult i32 %61, 256
  br i1 %62, label %63, label %89

63:                                               ; preds = %60
  %64 = load i32, i32* %16, align 4
  %65 = load i32, i32* %7, align 4
  %66 = sub i32 8, %65
  %67 = shl i32 %64, %66
  %68 = load i32, i32* %13, align 4
  %69 = add i32 %67, %68
  store i32 %69, i32* %17, align 4
  %70 = load i32, i32* %17, align 4
  %71 = uitofp i32 %70 to double
  %72 = load double, double* %10, align 8
  %73 = fmul double %71, %72
  %74 = load i32, i32* %8, align 4
  %75 = sitofp i32 %74 to double
  %76 = fmul double %75, 1.000000e-05
  %77 = call double @pow(double noundef %73, double noundef %76) #13
  %78 = call double @llvm.fmuladd.f64(double 6.553500e+04, double %77, double 5.000000e-01)
  %79 = call double @llvm.floor.f64(double %78)
  store double %79, double* %18, align 8
  %80 = load double, double* %18, align 8
  %81 = fptoui double %80 to i16
  %82 = load i16*, i16** %15, align 8
  %83 = load i32, i32* %16, align 4
  %84 = zext i32 %83 to i64
  %85 = getelementptr inbounds i16, i16* %82, i64 %84
  store i16 %81, i16* %85, align 2
  br label %86

86:                                               ; preds = %63
  %87 = load i32, i32* %16, align 4
  %88 = add i32 %87, 1
  store i32 %88, i32* %16, align 4
  br label %60, !llvm.loop !40

89:                                               ; preds = %60
  br label %121

90:                                               ; preds = %48
  store i32 0, i32* %19, align 4
  br label %91

91:                                               ; preds = %117, %90
  %92 = load i32, i32* %19, align 4
  %93 = icmp ult i32 %92, 256
  br i1 %93, label %94, label %120

94:                                               ; preds = %91
  %95 = load i32, i32* %19, align 4
  %96 = load i32, i32* %7, align 4
  %97 = sub i32 8, %96
  %98 = shl i32 %95, %97
  %99 = load i32, i32* %13, align 4
  %100 = add i32 %98, %99
  store i32 %100, i32* %20, align 4
  %101 = load i32, i32* %7, align 4
  %102 = icmp ne i32 %101, 0
  br i1 %102, label %103, label %110

103:                                              ; preds = %94
  %104 = load i32, i32* %20, align 4
  %105 = mul i32 %104, 65535
  %106 = load i32, i32* %12, align 4
  %107 = add i32 %105, %106
  %108 = load i32, i32* %11, align 4
  %109 = udiv i32 %107, %108
  store i32 %109, i32* %20, align 4
  br label %110

110:                                              ; preds = %103, %94
  %111 = load i32, i32* %20, align 4
  %112 = trunc i32 %111 to i16
  %113 = load i16*, i16** %15, align 8
  %114 = load i32, i32* %19, align 4
  %115 = zext i32 %114 to i64
  %116 = getelementptr inbounds i16, i16* %113, i64 %115
  store i16 %112, i16* %116, align 2
  br label %117

117:                                              ; preds = %110
  %118 = load i32, i32* %19, align 4
  %119 = add i32 %118, 1
  store i32 %119, i32* %19, align 4
  br label %91, !llvm.loop !41

120:                                              ; preds = %91
  br label %121

121:                                              ; preds = %120, %89
  br label %122

122:                                              ; preds = %121
  %123 = load i32, i32* %13, align 4
  %124 = add i32 %123, 1
  store i32 %124, i32* %13, align 4
  br label %44, !llvm.loop !42

125:                                              ; preds = %44
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_set_option(%struct.png_struct_def* noalias noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca %struct.png_struct_def*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store %struct.png_struct_def* %0, %struct.png_struct_def** %5, align 8
  store i32 %1, i32* %6, align 4
  store i32 %2, i32* %7, align 4
  %11 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %12 = icmp ne %struct.png_struct_def* %11, null
  br i1 %12, label %13, label %48

13:                                               ; preds = %3
  %14 = load i32, i32* %6, align 4
  %15 = icmp sge i32 %14, 0
  br i1 %15, label %16, label %48

16:                                               ; preds = %13
  %17 = load i32, i32* %6, align 4
  %18 = icmp slt i32 %17, 14
  br i1 %18, label %19, label %48

19:                                               ; preds = %16
  %20 = load i32, i32* %6, align 4
  %21 = and i32 %20, 1
  %22 = icmp eq i32 %21, 0
  br i1 %22, label %23, label %48

23:                                               ; preds = %19
  %24 = load i32, i32* %6, align 4
  %25 = shl i32 3, %24
  store i32 %25, i32* %8, align 4
  %26 = load i32, i32* %7, align 4
  %27 = icmp ne i32 %26, 0
  %28 = zext i1 %27 to i32
  %29 = add i32 2, %28
  %30 = load i32, i32* %6, align 4
  %31 = shl i32 %29, %30
  store i32 %31, i32* %9, align 4
  %32 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %33 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %32, i32 0, i32 115
  %34 = load i32, i32* %33, align 8
  store i32 %34, i32* %10, align 4
  %35 = load i32, i32* %10, align 4
  %36 = load i32, i32* %8, align 4
  %37 = xor i32 %36, -1
  %38 = and i32 %35, %37
  %39 = load i32, i32* %9, align 4
  %40 = or i32 %38, %39
  %41 = load %struct.png_struct_def*, %struct.png_struct_def** %5, align 8
  %42 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %41, i32 0, i32 115
  store i32 %40, i32* %42, align 8
  %43 = load i32, i32* %10, align 4
  %44 = load i32, i32* %8, align 4
  %45 = and i32 %43, %44
  %46 = load i32, i32* %6, align 4
  %47 = ashr i32 %45, %46
  store i32 %47, i32* %4, align 4
  br label %49

48:                                               ; preds = %19, %16, %13, %3
  store i32 1, i32* %4, align 4
  br label %49

49:                                               ; preds = %48, %23
  %50 = load i32, i32* %4, align 4
  ret i32 %50
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @png_image_free(%struct.png_image* noundef %0) #0 {
  %2 = alloca %struct.png_image*, align 8
  store %struct.png_image* %0, %struct.png_image** %2, align 8
  %3 = load %struct.png_image*, %struct.png_image** %2, align 8
  %4 = icmp ne %struct.png_image* %3, null
  br i1 %4, label %5, label %23

5:                                                ; preds = %1
  %6 = load %struct.png_image*, %struct.png_image** %2, align 8
  %7 = getelementptr inbounds %struct.png_image, %struct.png_image* %6, i32 0, i32 0
  %8 = load %struct.png_control*, %struct.png_control** %7, align 8
  %9 = icmp ne %struct.png_control* %8, null
  br i1 %9, label %10, label %23

10:                                               ; preds = %5
  %11 = load %struct.png_image*, %struct.png_image** %2, align 8
  %12 = getelementptr inbounds %struct.png_image, %struct.png_image* %11, i32 0, i32 0
  %13 = load %struct.png_control*, %struct.png_control** %12, align 8
  %14 = getelementptr inbounds %struct.png_control, %struct.png_control* %13, i32 0, i32 2
  %15 = load i8*, i8** %14, align 8
  %16 = icmp eq i8* %15, null
  br i1 %16, label %17, label %23

17:                                               ; preds = %10
  %18 = load %struct.png_image*, %struct.png_image** %2, align 8
  %19 = bitcast %struct.png_image* %18 to i8*
  %20 = call i32 @png_image_free_function(i8* noundef %19)
  %21 = load %struct.png_image*, %struct.png_image** %2, align 8
  %22 = getelementptr inbounds %struct.png_image, %struct.png_image* %21, i32 0, i32 0
  store %struct.png_control* null, %struct.png_control** %22, align 8
  br label %23

23:                                               ; preds = %17, %10, %5, %1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @png_image_free_function(i8* noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 8
  %4 = alloca %struct.png_image*, align 8
  %5 = alloca %struct.png_control*, align 8
  %6 = alloca %struct.png_control, align 8
  %7 = alloca %struct._IO_FILE*, align 8
  store i8* %0, i8** %3, align 8
  %8 = load i8*, i8** %3, align 8
  %9 = bitcast i8* %8 to %struct.png_image*
  store %struct.png_image* %9, %struct.png_image** %4, align 8
  %10 = load %struct.png_image*, %struct.png_image** %4, align 8
  %11 = getelementptr inbounds %struct.png_image, %struct.png_image* %10, i32 0, i32 0
  %12 = load %struct.png_control*, %struct.png_control** %11, align 8
  store %struct.png_control* %12, %struct.png_control** %5, align 8
  %13 = load %struct.png_control*, %struct.png_control** %5, align 8
  %14 = getelementptr inbounds %struct.png_control, %struct.png_control* %13, i32 0, i32 0
  %15 = load %struct.png_struct_def*, %struct.png_struct_def** %14, align 8
  %16 = icmp eq %struct.png_struct_def* %15, null
  br i1 %16, label %17, label %18

17:                                               ; preds = %1
  store i32 0, i32* %2, align 4
  br label %70

18:                                               ; preds = %1
  %19 = load %struct.png_control*, %struct.png_control** %5, align 8
  %20 = getelementptr inbounds %struct.png_control, %struct.png_control* %19, i32 0, i32 5
  %21 = load i8, i8* %20, align 8
  %22 = lshr i8 %21, 1
  %23 = and i8 %22, 1
  %24 = zext i8 %23 to i32
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %26, label %48

26:                                               ; preds = %18
  %27 = load %struct.png_control*, %struct.png_control** %5, align 8
  %28 = getelementptr inbounds %struct.png_control, %struct.png_control* %27, i32 0, i32 0
  %29 = load %struct.png_struct_def*, %struct.png_struct_def** %28, align 8
  %30 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %29, i32 0, i32 9
  %31 = load i8*, i8** %30, align 8
  %32 = bitcast i8* %31 to %struct._IO_FILE*
  store %struct._IO_FILE* %32, %struct._IO_FILE** %7, align 8
  %33 = load %struct.png_control*, %struct.png_control** %5, align 8
  %34 = getelementptr inbounds %struct.png_control, %struct.png_control* %33, i32 0, i32 5
  %35 = load i8, i8* %34, align 8
  %36 = and i8 %35, -3
  %37 = or i8 %36, 0
  store i8 %37, i8* %34, align 8
  %38 = load %struct._IO_FILE*, %struct._IO_FILE** %7, align 8
  %39 = icmp ne %struct._IO_FILE* %38, null
  br i1 %39, label %40, label %47

40:                                               ; preds = %26
  %41 = load %struct.png_control*, %struct.png_control** %5, align 8
  %42 = getelementptr inbounds %struct.png_control, %struct.png_control* %41, i32 0, i32 0
  %43 = load %struct.png_struct_def*, %struct.png_struct_def** %42, align 8
  %44 = getelementptr inbounds %struct.png_struct_def, %struct.png_struct_def* %43, i32 0, i32 9
  store i8* null, i8** %44, align 8
  %45 = load %struct._IO_FILE*, %struct._IO_FILE** %7, align 8
  %46 = call i32 @fclose(%struct._IO_FILE* noundef %45)
  br label %47

47:                                               ; preds = %40, %26
  br label %48

48:                                               ; preds = %47, %18
  %49 = load %struct.png_control*, %struct.png_control** %5, align 8
  %50 = bitcast %struct.png_control* %6 to i8*
  %51 = bitcast %struct.png_control* %49 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %50, i8* align 8 %51, i64 48, i1 false)
  %52 = load %struct.png_image*, %struct.png_image** %4, align 8
  %53 = getelementptr inbounds %struct.png_image, %struct.png_image* %52, i32 0, i32 0
  store %struct.png_control* %6, %struct.png_control** %53, align 8
  %54 = getelementptr inbounds %struct.png_control, %struct.png_control* %6, i32 0, i32 0
  %55 = load %struct.png_struct_def*, %struct.png_struct_def** %54, align 8
  %56 = load %struct.png_control*, %struct.png_control** %5, align 8
  %57 = bitcast %struct.png_control* %56 to i8*
  call void @png_free(%struct.png_struct_def* noundef %55, i8* noundef %57)
  %58 = getelementptr inbounds %struct.png_control, %struct.png_control* %6, i32 0, i32 5
  %59 = load i8, i8* %58, align 8
  %60 = and i8 %59, 1
  %61 = zext i8 %60 to i32
  %62 = icmp ne i32 %61, 0
  br i1 %62, label %63, label %66

63:                                               ; preds = %48
  %64 = getelementptr inbounds %struct.png_control, %struct.png_control* %6, i32 0, i32 0
  %65 = getelementptr inbounds %struct.png_control, %struct.png_control* %6, i32 0, i32 1
  call void @png_destroy_write_struct(%struct.png_struct_def** noundef %64, %struct.png_info_def** noundef %65)
  br label %69

66:                                               ; preds = %48
  %67 = getelementptr inbounds %struct.png_control, %struct.png_control* %6, i32 0, i32 0
  %68 = getelementptr inbounds %struct.png_control, %struct.png_control* %6, i32 0, i32 1
  call void @png_destroy_read_struct(%struct.png_struct_def** noundef %67, %struct.png_info_def** noundef %68, %struct.png_info_def** noundef null)
  br label %69

69:                                               ; preds = %66, %63
  store i32 1, i32* %2, align 4
  br label %70

70:                                               ; preds = %69, %17
  %71 = load i32, i32* %2, align 4
  ret i32 %71
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @png_image_error(%struct.png_image* noundef %0, i8* noundef %1) #0 {
  %3 = alloca %struct.png_image*, align 8
  %4 = alloca i8*, align 8
  store %struct.png_image* %0, %struct.png_image** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %struct.png_image*, %struct.png_image** %3, align 8
  %6 = getelementptr inbounds %struct.png_image, %struct.png_image* %5, i32 0, i32 8
  %7 = getelementptr inbounds [64 x i8], [64 x i8]* %6, i64 0, i64 0
  %8 = load i8*, i8** %4, align 8
  %9 = call i64 @png_safecat(i8* noundef %7, i64 noundef 64, i64 noundef 0, i8* noundef %8)
  %10 = load %struct.png_image*, %struct.png_image** %3, align 8
  %11 = getelementptr inbounds %struct.png_image, %struct.png_image* %10, i32 0, i32 7
  %12 = load i32, i32* %11, align 8
  %13 = or i32 %12, 2
  store i32 %13, i32* %11, align 8
  %14 = load %struct.png_image*, %struct.png_image** %3, align 8
  call void @png_image_free(%struct.png_image* noundef %14)
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @png_fp_add(i32 noundef %0, i32 noundef %1, i32* noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32*, align 8
  store i32 %0, i32* %5, align 4
  store i32 %1, i32* %6, align 4
  store i32* %2, i32** %7, align 8
  %8 = load i32, i32* %5, align 4
  %9 = icmp sgt i32 %8, 0
  br i1 %9, label %10, label %20

10:                                               ; preds = %3
  %11 = load i32, i32* %5, align 4
  %12 = sub nsw i32 2147483647, %11
  %13 = load i32, i32* %6, align 4
  %14 = icmp sge i32 %12, %13
  br i1 %14, label %15, label %19

15:                                               ; preds = %10
  %16 = load i32, i32* %5, align 4
  %17 = load i32, i32* %6, align 4
  %18 = add nsw i32 %16, %17
  store i32 %18, i32* %4, align 4
  br label %38

19:                                               ; preds = %10
  br label %36

20:                                               ; preds = %3
  %21 = load i32, i32* %5, align 4
  %22 = icmp slt i32 %21, 0
  br i1 %22, label %23, label %33

23:                                               ; preds = %20
  %24 = load i32, i32* %5, align 4
  %25 = sub nsw i32 -2147483647, %24
  %26 = load i32, i32* %6, align 4
  %27 = icmp sle i32 %25, %26
  br i1 %27, label %28, label %32

28:                                               ; preds = %23
  %29 = load i32, i32* %5, align 4
  %30 = load i32, i32* %6, align 4
  %31 = add nsw i32 %29, %30
  store i32 %31, i32* %4, align 4
  br label %38

32:                                               ; preds = %23
  br label %35

33:                                               ; preds = %20
  %34 = load i32, i32* %6, align 4
  store i32 %34, i32* %4, align 4
  br label %38

35:                                               ; preds = %32
  br label %36

36:                                               ; preds = %35, %19
  %37 = load i32*, i32** %7, align 8
  store i32 1, i32* %37, align 4
  store i32 50000, i32* %4, align 4
  br label %38

38:                                               ; preds = %36, %33, %28, %15
  %39 = load i32, i32* %4, align 4
  ret i32 %39
}

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @is_ICC_signature(i64 noundef %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, i64* %2, align 8
  %3 = load i64, i64* %2, align 8
  %4 = lshr i64 %3, 24
  %5 = call i32 @is_ICC_signature_char(i64 noundef %4)
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %24

7:                                                ; preds = %1
  %8 = load i64, i64* %2, align 8
  %9 = lshr i64 %8, 16
  %10 = and i64 %9, 255
  %11 = call i32 @is_ICC_signature_char(i64 noundef %10)
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %13, label %24

13:                                               ; preds = %7
  %14 = load i64, i64* %2, align 8
  %15 = lshr i64 %14, 8
  %16 = and i64 %15, 255
  %17 = call i32 @is_ICC_signature_char(i64 noundef %16)
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %19, label %24

19:                                               ; preds = %13
  %20 = load i64, i64* %2, align 8
  %21 = and i64 %20, 255
  %22 = call i32 @is_ICC_signature_char(i64 noundef %21)
  %23 = icmp ne i32 %22, 0
  br label %24

24:                                               ; preds = %19, %13, %7, %1
  %25 = phi i1 [ false, %13 ], [ false, %7 ], [ false, %1 ], [ %23, %19 ]
  %26 = zext i1 %25 to i32
  ret i32 %26
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @png_icc_tag_name(i8* noundef %0, i32 noundef %1) #0 {
  %3 = alloca i8*, align 8
  %4 = alloca i32, align 4
  store i8* %0, i8** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load i8*, i8** %3, align 8
  %6 = getelementptr inbounds i8, i8* %5, i64 0
  store i8 39, i8* %6, align 1
  %7 = load i32, i32* %4, align 4
  %8 = lshr i32 %7, 24
  %9 = call signext i8 @png_icc_tag_char(i32 noundef %8)
  %10 = load i8*, i8** %3, align 8
  %11 = getelementptr inbounds i8, i8* %10, i64 1
  store i8 %9, i8* %11, align 1
  %12 = load i32, i32* %4, align 4
  %13 = lshr i32 %12, 16
  %14 = call signext i8 @png_icc_tag_char(i32 noundef %13)
  %15 = load i8*, i8** %3, align 8
  %16 = getelementptr inbounds i8, i8* %15, i64 2
  store i8 %14, i8* %16, align 1
  %17 = load i32, i32* %4, align 4
  %18 = lshr i32 %17, 8
  %19 = call signext i8 @png_icc_tag_char(i32 noundef %18)
  %20 = load i8*, i8** %3, align 8
  %21 = getelementptr inbounds i8, i8* %20, i64 3
  store i8 %19, i8* %21, align 1
  %22 = load i32, i32* %4, align 4
  %23 = call signext i8 @png_icc_tag_char(i32 noundef %22)
  %24 = load i8*, i8** %3, align 8
  %25 = getelementptr inbounds i8, i8* %24, i64 4
  store i8 %23, i8* %25, align 1
  %26 = load i8*, i8** %3, align 8
  %27 = getelementptr inbounds i8, i8* %26, i64 5
  store i8 39, i8* %27, align 1
  ret void
}

declare void @png_chunk_benign_error(%struct.png_struct_def* noundef, i8* noundef) #3

; Function Attrs: noinline nounwind optnone uwtable
define internal i32 @is_ICC_signature_char(i64 noundef %0) #0 {
  %2 = alloca i64, align 8
  store i64 %0, i64* %2, align 8
  %3 = load i64, i64* %2, align 8
  %4 = icmp eq i64 %3, 32
  br i1 %4, label %25, label %5

5:                                                ; preds = %1
  %6 = load i64, i64* %2, align 8
  %7 = icmp uge i64 %6, 48
  br i1 %7, label %8, label %11

8:                                                ; preds = %5
  %9 = load i64, i64* %2, align 8
  %10 = icmp ule i64 %9, 57
  br i1 %10, label %25, label %11

11:                                               ; preds = %8, %5
  %12 = load i64, i64* %2, align 8
  %13 = icmp uge i64 %12, 65
  br i1 %13, label %14, label %17

14:                                               ; preds = %11
  %15 = load i64, i64* %2, align 8
  %16 = icmp ule i64 %15, 90
  br i1 %16, label %25, label %17

17:                                               ; preds = %14, %11
  %18 = load i64, i64* %2, align 8
  %19 = icmp uge i64 %18, 97
  br i1 %19, label %20, label %23

20:                                               ; preds = %17
  %21 = load i64, i64* %2, align 8
  %22 = icmp ule i64 %21, 122
  br label %23

23:                                               ; preds = %20, %17
  %24 = phi i1 [ false, %17 ], [ %22, %20 ]
  br label %25

25:                                               ; preds = %23, %14, %8, %1
  %26 = phi i1 [ true, %14 ], [ true, %8 ], [ true, %1 ], [ %24, %23 ]
  %27 = zext i1 %26 to i32
  ret i32 %27
}

; Function Attrs: noinline nounwind optnone uwtable
define internal signext i8 @png_icc_tag_char(i32 noundef %0) #0 {
  %2 = alloca i8, align 1
  %3 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  %4 = load i32, i32* %3, align 4
  %5 = and i32 %4, 255
  store i32 %5, i32* %3, align 4
  %6 = load i32, i32* %3, align 4
  %7 = icmp uge i32 %6, 32
  br i1 %7, label %8, label %14

8:                                                ; preds = %1
  %9 = load i32, i32* %3, align 4
  %10 = icmp ule i32 %9, 126
  br i1 %10, label %11, label %14

11:                                               ; preds = %8
  %12 = load i32, i32* %3, align 4
  %13 = trunc i32 %12 to i8
  store i8 %13, i8* %2, align 1
  br label %15

14:                                               ; preds = %8, %1
  store i8 63, i8* %2, align 1
  br label %15

15:                                               ; preds = %14, %11
  %16 = load i8, i8* %2, align 1
  ret i8 %16
}

declare noalias i8* @png_malloc(%struct.png_struct_def* noundef, i64 noundef) #3

declare noalias i8* @png_calloc(%struct.png_struct_def* noundef, i64 noundef) #3

declare i32 @fclose(%struct._IO_FILE* noundef) #3

declare void @png_destroy_write_struct(%struct.png_struct_def** noundef, %struct.png_info_def** noundef) #3

declare void @png_destroy_read_struct(%struct.png_struct_def** noundef, %struct.png_info_def** noundef, %struct.png_info_def** noundef) #3

attributes #0 = { noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { noreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind readonly willreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { argmemonly nofree nounwind willreturn writeonly }
attributes #5 = { nounwind returns_twice "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { argmemonly nofree nounwind willreturn }
attributes #8 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #10 = { noreturn }
attributes #11 = { nounwind readonly willreturn }
attributes #12 = { nounwind returns_twice }
attributes #13 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
!22 = distinct !{!22, !7}
!23 = distinct !{!23, !7}
!24 = distinct !{!24, !7}
!25 = distinct !{!25, !7}
!26 = distinct !{!26, !7}
!27 = distinct !{!27, !7}
!28 = distinct !{!28, !7}
!29 = distinct !{!29, !7}
!30 = distinct !{!30, !7}
!31 = distinct !{!31, !7}
!32 = distinct !{!32, !7}
!33 = distinct !{!33, !7}
!34 = distinct !{!34, !7}
!35 = distinct !{!35, !7}
!36 = distinct !{!36, !7}
!37 = distinct !{!37, !7}
!38 = distinct !{!38, !7}
!39 = distinct !{!39, !7}
!40 = distinct !{!40, !7}
!41 = distinct !{!41, !7}
!42 = distinct !{!42, !7}
