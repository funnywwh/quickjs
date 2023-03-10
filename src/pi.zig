const std = @import("std");
const quickjs = @import("quickjs/quickjs.zig");

pub fn main() !void{
    var qjsc_pi_bigint = [_]u8{
        0x02, 0x30, 0x14, 0x66, 0x6c, 0x6f, 0x6f, 0x72,
        0x5f, 0x6c, 0x6f, 0x67, 0x32, 0x12, 0x63, 0x65,
        0x69, 0x6c, 0x5f, 0x6c, 0x6f, 0x67, 0x32, 0x10,
        0x69, 0x6e, 0x74, 0x5f, 0x73, 0x71, 0x72, 0x74,
        0x0e, 0x63, 0x61, 0x6c, 0x63, 0x5f, 0x70, 0x69,
        0x08, 0x6d, 0x61, 0x69, 0x6e, 0x08, 0x61, 0x72,
        0x67, 0x73, 0x14, 0x75, 0x73, 0x65, 0x20, 0x73,
        0x74, 0x72, 0x69, 0x63, 0x74, 0x14, 0x73, 0x63,
        0x72, 0x69, 0x70, 0x74, 0x41, 0x72, 0x67, 0x73,
        0x0a, 0x73, 0x68, 0x69, 0x66, 0x74, 0x2a, 0x65,
        0x78, 0x61, 0x6d, 0x70, 0x6c, 0x65, 0x73, 0x2f,
        0x70, 0x69, 0x5f, 0x62, 0x69, 0x67, 0x69, 0x6e,
        0x74, 0x2e, 0x6a, 0x73, 0x02, 0x61, 0x0a, 0x6b,
        0x5f, 0x6d, 0x61, 0x78, 0x04, 0x61, 0x31, 0x02,
        0x6b, 0x02, 0x69, 0x02, 0x6c, 0x02, 0x75, 0x02,
        0x73, 0x08, 0x70, 0x72, 0x65, 0x63, 0x0c, 0x43,
        0x48, 0x55, 0x44, 0x5f, 0x41, 0x0c, 0x43, 0x48,
        0x55, 0x44, 0x5f, 0x42, 0x0c, 0x43, 0x48, 0x55,
        0x44, 0x5f, 0x43, 0x0e, 0x43, 0x48, 0x55, 0x44,
        0x5f, 0x43, 0x33, 0x24, 0x43, 0x48, 0x55, 0x44,
        0x5f, 0x42, 0x49, 0x54, 0x53, 0x5f, 0x50, 0x45,
        0x52, 0x5f, 0x54, 0x45, 0x52, 0x4d, 0x0e, 0x63,
        0x68, 0x75, 0x64, 0x5f, 0x62, 0x73, 0x02, 0x6e,
        0x02, 0x50, 0x02, 0x51, 0x02, 0x47, 0x08, 0x63,
        0x65, 0x69, 0x6c, 0x02, 0x62, 0x0c, 0x6e, 0x65,
        0x65, 0x64, 0x5f, 0x47, 0x02, 0x63, 0x04, 0x50,
        0x31, 0x04, 0x51, 0x31, 0x04, 0x47, 0x31, 0x04,
        0x50, 0x32, 0x04, 0x51, 0x32, 0x04, 0x47, 0x32,
        0x02, 0x72, 0x10, 0x6e, 0x5f, 0x64, 0x69, 0x67,
        0x69, 0x74, 0x73, 0x0c, 0x6e, 0x5f, 0x62, 0x69,
        0x74, 0x73, 0x06, 0x6f, 0x75, 0x74, 0x0a, 0x70,
        0x72, 0x69, 0x6e, 0x74, 0x24, 0x75, 0x73, 0x61,
        0x67, 0x65, 0x3a, 0x20, 0x70, 0x69, 0x20, 0x6e,
        0x5f, 0x64, 0x69, 0x67, 0x69, 0x74, 0x73, 0x08,
        0x6c, 0x6f, 0x67, 0x32, 0x02, 0x2e, 0x0a, 0x73,
        0x6c, 0x69, 0x63, 0x65, 0x0e, 0x00, 0x06, 0x01,
        0xa0, 0x01, 0x00, 0x01, 0x00, 0x03, 0x00, 0x05,
        0xbf, 0x01, 0x01, 0xa2, 0x01, 0x00, 0x00, 0x00,
        0x3f, 0xe1, 0x00, 0x00, 0x00, 0x40, 0x3f, 0xe2,
        0x00, 0x00, 0x00, 0x40, 0x3f, 0xe3, 0x00, 0x00,
        0x00, 0x40, 0x3f, 0xe4, 0x00, 0x00, 0x00, 0x40,
        0x3f, 0xe5, 0x00, 0x00, 0x00, 0x40, 0x3f, 0xe6,
        0x00, 0x00, 0x00, 0x00, 0xc0, 0x00, 0x40, 0xe1,
        0x00, 0x00, 0x00, 0x00, 0xc0, 0x01, 0x40, 0xe2,
        0x00, 0x00, 0x00, 0x00, 0xc0, 0x02, 0x40, 0xe3,
        0x00, 0x00, 0x00, 0x00, 0xc0, 0x03, 0x40, 0xe4,
        0x00, 0x00, 0x00, 0x00, 0xc0, 0x04, 0x40, 0xe5,
        0x00, 0x00, 0x00, 0x00, 0x3e, 0xe6, 0x00, 0x00,
        0x00, 0x00, 0x04, 0xe7, 0x00, 0x00, 0x00, 0xc9,
        0x06, 0xc9, 0x37, 0xe8, 0x00, 0x00, 0x00, 0xf4,
        0xeb, 0x22, 0x36, 0xe6, 0x00, 0x00, 0x00, 0x38,
        0xe8, 0x00, 0x00, 0x00, 0x15, 0x3b, 0xe6, 0x00,
        0x00, 0x00, 0xc9, 0x38, 0xe6, 0x00, 0x00, 0x00,
        0x42, 0xe9, 0x00, 0x00, 0x00, 0x24, 0x00, 0x00,
        0xc9, 0xec, 0x30, 0x06, 0xc9, 0x37, 0x4d, 0x00,
        0x00, 0x00, 0xf4, 0xeb, 0x14, 0x36, 0xe6, 0x00,
        0x00, 0x00, 0x38, 0x4d, 0x00, 0x00, 0x00, 0x15,
        0x3b, 0xe6, 0x00, 0x00, 0x00, 0xc9, 0xec, 0x13,
        0x36, 0xe6, 0x00, 0x00, 0x00, 0xbe, 0xe8, 0x03,
        0x26, 0x01, 0x00, 0x15, 0x3b, 0xe6, 0x00, 0x00,
        0x00, 0xc9, 0x38, 0xe5, 0x00, 0x00, 0x00, 0x38,
        0xe6, 0x00, 0x00, 0x00, 0xef, 0xcd, 0x28, 0xd4,
        0x03, 0x01, 0x0e, 0xb5, 0xe9, 0x1e, 0x00, 0x01,
        0xd0, 0x01, 0x35, 0x58, 0x49, 0x3f, 0x58, 0x0e,
        0x5f, 0x0e, 0x43, 0x06, 0x01, 0xc2, 0x03, 0x01,
        0x04, 0x01, 0x03, 0x00, 0x09, 0x3d, 0x05, 0xd6,
        0x03, 0x00, 0x01, 0x00, 0xd8, 0x03, 0x00, 0x00,
        0x00, 0xda, 0x03, 0x00, 0x01, 0x00, 0xdc, 0x03,
        0x00, 0x02, 0x00, 0xde, 0x03, 0x00, 0x03, 0x00,
        0xbf, 0x00, 0xc9, 0xd1, 0xbf, 0x01, 0xc5, 0x9f,
        0xa1, 0xbf, 0x02, 0xaa, 0xea, 0x05, 0x93, 0x00,
        0xec, 0xf2, 0xbf, 0x03, 0xcb, 0xd1, 0xca, 0xc5,
        0xbf, 0x04, 0x9e, 0xcc, 0xc8, 0xbf, 0x05, 0xa6,
        0xea, 0x1a, 0xd1, 0xbf, 0x06, 0xc8, 0x9f, 0xa1,
        0xce, 0xbf, 0x07, 0xaa, 0xea, 0x0a, 0xc6, 0xd5,
        0xc7, 0xbf, 0x08, 0xc8, 0xa0, 0xaf, 0xcb, 0x92,
        0x03, 0xec, 0xe2, 0xc7, 0x28, 0xd4, 0x03, 0x07,
        0x0d, 0x05, 0x12, 0x3a, 0x0d, 0x0d, 0x12, 0x0d,
        0x3a, 0x26, 0x1c, 0x0d, 0x27, 0x17, 0x0a, 0x00,
        0x0a, 0x14, 0x01, 0x80, 0x0a, 0x00, 0x0a, 0x00,
        0x0a, 0x10, 0x01, 0x80, 0x0a, 0x00, 0x0a, 0x14,
        0x01, 0x80, 0x0a, 0x00, 0x0a, 0x10, 0x01, 0x80,
        0x0e, 0x43, 0x06, 0x01, 0xc4, 0x03, 0x01, 0x00,
        0x01, 0x03, 0x00, 0x02, 0x0e, 0x01, 0xd6, 0x03,
        0x00, 0x01, 0x00, 0x38, 0xe1, 0x00, 0x00, 0x00,
        0xd1, 0xbf, 0x00, 0x9e, 0xef, 0xbf, 0x01, 0x9d,
        0x28, 0xd4, 0x03, 0x1b, 0x01, 0x04, 0x0a, 0x10,
        0x01, 0x80, 0x0a, 0x10, 0x01, 0x80, 0x0e, 0x43,
        0x06, 0x01, 0xc6, 0x03, 0x01, 0x03, 0x01, 0x03,
        0x00, 0x05, 0x2e, 0x04, 0xd6, 0x03, 0x00, 0x01,
        0x00, 0xe0, 0x03, 0x00, 0x00, 0x00, 0xe2, 0x03,
        0x00, 0x01, 0x00, 0xe4, 0x03, 0x00, 0x02, 0x00,
        0xd1, 0xbf, 0x00, 0xa9, 0xea, 0x03, 0xd1, 0x28,
        0x38, 0xe2, 0x00, 0x00, 0x00, 0xd1, 0xef, 0xc9,
        0xbf, 0x01, 0xc5, 0xbf, 0x02, 0x9d, 0xbf, 0x03,
        0x9b, 0xa0, 0xca, 0xc6, 0xcb, 0xd1, 0xc7, 0x9b,
        0xc7, 0x9d, 0xbf, 0x04, 0x9b, 0xce, 0xc7, 0xa6,
        0xeb, 0x03, 0xec, 0xf0, 0xc7, 0x28, 0xd4, 0x03,
        0x21, 0x0a, 0x05, 0x21, 0x0d, 0x2b, 0x3c, 0x0d,
        0x30, 0x0d, 0x0d, 0x0d, 0x0a, 0x00, 0x0a, 0x10,
        0x01, 0x80, 0x0a, 0x10, 0x01, 0x80, 0x0a, 0x14,
        0x01, 0x80, 0x0a, 0x14, 0x01, 0x80, 0x0e, 0x43,
        0x06, 0x01, 0xc8, 0x03, 0x01, 0x0a, 0x01, 0x08,
        0x00, 0x0a, 0xa8, 0x01, 0x0b, 0xe6, 0x03, 0x00,
        0x01, 0x00, 0xe8, 0x03, 0x01, 0x00, 0x70, 0xea,
        0x03, 0x01, 0x01, 0x70, 0xec, 0x03, 0x01, 0x02,
        0x30, 0xee, 0x03, 0x01, 0x03, 0x70, 0xf0, 0x03,
        0x01, 0x04, 0x30, 0xf2, 0x03, 0x00, 0x00, 0x40,
        0xf4, 0x03, 0x00, 0x06, 0x00, 0xf6, 0x03, 0x00,
        0x07, 0x00, 0xf8, 0x03, 0x00, 0x08, 0x00, 0xfa,
        0x03, 0x00, 0x09, 0x00, 0xc0, 0x05, 0xc3, 0x05,
        0x61, 0x04, 0x00, 0x61, 0x03, 0x00, 0x61, 0x02,
        0x00, 0x61, 0x01, 0x00, 0x61, 0x00, 0x00, 0xbf,
        0x00, 0xc9, 0xbf, 0x01, 0xca, 0xbf, 0x02, 0xcb,
        0xbf, 0x03, 0xcc, 0xbf, 0x04, 0xc3, 0x04, 0x38,
        0xb2, 0x00, 0x00, 0x00, 0x38, 0x9d, 0x00, 0x00,
        0x00, 0x42, 0xfe, 0x00, 0x00, 0x00, 0x38, 0x98,
        0x00, 0x00, 0x00, 0xd1, 0xef, 0x62, 0x04, 0x00,
        0x9b, 0x24, 0x01, 0x00, 0xef, 0xbf, 0x06, 0x9d,
        0xc3, 0x06, 0xec, 0x27, 0x11, 0x7d, 0x78, 0xfb,
        0x00, 0x00, 0x00, 0x07, 0x00, 0x80, 0x02, 0x0e,
        0x3d, 0x78, 0xfc, 0x00, 0x00, 0x00, 0x08, 0x00,
        0x80, 0x02, 0x0e, 0x3d, 0x78, 0xfd, 0x00, 0x00,
        0x00, 0x09, 0x00, 0x80, 0x02, 0x0e, 0x3d, 0x83,
        0xec, 0x0b, 0xc2, 0x05, 0xbf, 0x07, 0xc2, 0x06,
        0x09, 0xf1, 0xec, 0xd1, 0x0e, 0x62, 0x02, 0x00,
        0xbf, 0x08, 0x9b, 0xc2, 0x08, 0xd1, 0xa0, 0x9a,
        0xc2, 0x07, 0xc2, 0x08, 0x62, 0x00, 0x00, 0x9a,
        0x9d, 0x9b, 0xc3, 0x08, 0x38, 0xe3, 0x00, 0x00,
        0x00, 0x62, 0x02, 0x00, 0xbf, 0x09, 0xd1, 0x9a,
        0xa0, 0xef, 0xc3, 0x09, 0xc2, 0x08, 0xc2, 0x09,
        0x9a, 0xd1, 0xa1, 0x28, 0xd4, 0x03, 0x33, 0x0c,
        0x62, 0x12, 0x12, 0x12, 0x12, 0x00, 0x04, 0x36,
        0xc1, 0xf3, 0x76, 0x53, 0x0a, 0x6c, 0x03, 0x71,
        0x63, 0xcf, 0x0a, 0x84, 0x01, 0x04, 0x98, 0xb6,
        0xf8, 0x81, 0x0a, 0x5c, 0x02, 0x54, 0x9c, 0x0a,
        0xe4, 0x01, 0x05, 0x1e, 0x76, 0x10, 0x74, 0x9b,
        0x06, 0xc7, 0xd7, 0x88, 0x04, 0x22, 0x8e, 0x47,
        0x40, 0x0e, 0x43, 0x06, 0x01, 0xf2, 0x03, 0x03,
        0x0a, 0x03, 0x08, 0x04, 0x0a, 0xcf, 0x01, 0x0d,
        0xd6, 0x03, 0x00, 0x01, 0x00, 0xfe, 0x03, 0x00,
        0x01, 0x00, 0x80, 0x04, 0x00, 0x01, 0x00, 0x82,
        0x04, 0x00, 0x00, 0x00, 0xf6, 0x03, 0x00, 0x01,
        0x00, 0xf8, 0x03, 0x00, 0x02, 0x00, 0xfa, 0x03,
        0x00, 0x03, 0x00, 0x84, 0x04, 0x00, 0x04, 0x00,
        0x86, 0x04, 0x00, 0x05, 0x00, 0x88, 0x04, 0x00,
        0x06, 0x00, 0x8a, 0x04, 0x00, 0x07, 0x00, 0x8c,
        0x04, 0x00, 0x08, 0x00, 0x8e, 0x04, 0x00, 0x09,
        0x00, 0xea, 0x03, 0x01, 0x0d, 0xe8, 0x03, 0x00,
        0x0d, 0xee, 0x03, 0x03, 0x0d, 0xf2, 0x03, 0x05,
        0x01, 0xd1, 0xd2, 0xbf, 0x00, 0x9e, 0xa9, 0xea,
        0x3a, 0xbf, 0x01, 0xd2, 0x9a, 0xbf, 0x02, 0x9e,
        0xbf, 0x03, 0xd2, 0x9a, 0xbf, 0x04, 0x9e, 0x9a,
        0xbf, 0x05, 0xd2, 0x9a, 0xbf, 0x06, 0x9e, 0x9a,
        0xd0, 0x65, 0x00, 0x00, 0xd2, 0x9a, 0x65, 0x01,
        0x00, 0x9d, 0x9a, 0xca, 0xd2, 0xbf, 0x07, 0xad,
        0xea, 0x04, 0xc6, 0x8c, 0xca, 0xd2, 0xd2, 0x9a,
        0xd2, 0x9a, 0x65, 0x02, 0x00, 0x9a, 0xcb, 0xed,
        0x89, 0x00, 0xd1, 0xd2, 0x9d, 0xbf, 0x08, 0xa1,
        0xc9, 0xec, 0x27, 0x11, 0x7d, 0x78, 0x02, 0x01,
        0x00, 0x00, 0x04, 0x00, 0x80, 0x02, 0x0e, 0x3d,
        0x78, 0x03, 0x01, 0x00, 0x00, 0x05, 0x00, 0x80,
        0x02, 0x0e, 0x3d, 0x78, 0x04, 0x01, 0x00, 0x00,
        0x06, 0x00, 0x80, 0x02, 0x0e, 0x3d, 0x83, 0xec,
        0x08, 0xe0, 0xd1, 0xc5, 0x0a, 0xf1, 0xec, 0xd4,
        0x0e, 0xec, 0x27, 0x11, 0x7d, 0x78, 0x05, 0x01,
        0x00, 0x00, 0x07, 0x00, 0x80, 0x02, 0x0e, 0x3d,
        0x78, 0x06, 0x01, 0x00, 0x00, 0x08, 0x00, 0x80,
        0x02, 0x0e, 0x3d, 0x78, 0x07, 0x01, 0x00, 0x00,
        0x09, 0x00, 0x80, 0x02, 0x0e, 0x3d, 0x83, 0xec,
        0x08, 0xe0, 0xc5, 0xd2, 0xd3, 0xf1, 0xec, 0xd4,
        0x0e, 0xc2, 0x04, 0xc2, 0x08, 0x9a, 0xc2, 0x07,
        0xc2, 0x06, 0x9a, 0x9d, 0xca, 0xc2, 0x05, 0xc2,
        0x08, 0x9a, 0xcb, 0xd3, 0xea, 0x09, 0xc2, 0x06,
        0xc2, 0x09, 0x9a, 0xcc, 0xec, 0x04, 0xbf, 0x09,
        0xcc, 0xc6, 0xc7, 0xc8, 0x26, 0x03, 0x00, 0x28,
        0xd4, 0x03, 0x3b, 0x10, 0x04, 0x2b, 0x7b, 0x3a,
        0x21, 0x12, 0x35, 0x12, 0x35, 0xf3, 0xe4, 0x3f,
        0x21, 0x12, 0x2c, 0x13, 0x0a, 0x10, 0x01, 0x80,
        0x0a, 0x14, 0x01, 0x80, 0x0a, 0x10, 0x01, 0x80,
        0x0a, 0x18, 0x01, 0xc0, 0x0a, 0x10, 0x01, 0x80,
        0x0a, 0x18, 0x01, 0xc0, 0x0a, 0x18, 0x01, 0xa0,
        0x0a, 0x10, 0x01, 0x80, 0x0a, 0x10, 0x01, 0x80,
        0x0a, 0x00, 0x0a, 0x1c, 0x01, 0xa0, 0x0a, 0x00,
        0x0a, 0x1c, 0x01, 0xc0, 0x0a, 0x14, 0x01, 0x80,
        0x0e, 0x43, 0x06, 0x01, 0xca, 0x03, 0x01, 0x04,
        0x01, 0x07, 0x00, 0x02, 0x7b, 0x05, 0xcc, 0x03,
        0x00, 0x01, 0x00, 0x90, 0x04, 0x00, 0x00, 0x00,
        0x92, 0x04, 0x00, 0x01, 0x00, 0x94, 0x04, 0x00,
        0x02, 0x00, 0x96, 0x04, 0x00, 0x03, 0x00, 0xd1,
        0xe9, 0xb6, 0xa3, 0xea, 0x0d, 0x38, 0x0c, 0x01,
        0x00, 0x00, 0x04, 0x0d, 0x01, 0x00, 0x00, 0xef,
        0x29, 0xd1, 0xb5, 0x47, 0xb5, 0xaf, 0xca, 0x38,
        0xb2, 0x00, 0x00, 0x00, 0x38, 0x9d, 0x00, 0x00,
        0x00, 0x42, 0xfe, 0x00, 0x00, 0x00, 0xc6, 0x38,
        0x9d, 0x00, 0x00, 0x00, 0x42, 0x0e, 0x01, 0x00,
        0x00, 0xbd, 0x0a, 0x24, 0x01, 0x00, 0x9a, 0x24,
        0x01, 0x00, 0xef, 0xbf, 0x00, 0x9d, 0xcb, 0x38,
        0xe4, 0x00, 0x00, 0x00, 0xc7, 0xef, 0xc9, 0xbf,
        0x01, 0x38, 0xb2, 0x00, 0x00, 0x00, 0xc6, 0xef,
        0x9f, 0xc5, 0x9a, 0xc7, 0xa1, 0xcd, 0x42, 0x37,
        0x00, 0x00, 0x00, 0x24, 0x00, 0x00, 0xcc, 0x38,
        0x0c, 0x01, 0x00, 0x00, 0xc8, 0xb5, 0x47, 0x04,
        0x0f, 0x01, 0x00, 0x00, 0x9d, 0xc8, 0x42, 0x10,
        0x01, 0x00, 0x00, 0xb6, 0x24, 0x01, 0x00, 0x9d,
        0xef, 0x29, 0xd4, 0x03, 0x5a, 0x0c, 0x04, 0x21,
        0x3b, 0x08, 0x00, 0x06, 0x08, 0xcb, 0x2b, 0x4e,
        0x30, 0x85, 0x0a, 0x24, 0x01, 0x80, 0x0a, 0x1c,
        0x01, 0xa0,
    };

    var rt = try quickjs.Runtime.NewRuntime();
    defer rt.Free();
    quickjs.Context.std_set_worker_new_context_func();
    rt.std_init_handlers();
    rt.SetModuleLoaderFunc();

    var ctx = try quickjs.Context.NewContext(rt);
    defer ctx.Free();
    ctx.std_add_helpers(std.os.argv);
    ctx.std_eval_binary(&qjsc_pi_bigint, false);
    ctx.std_loop();
}
