
define i32 @crc32(i32 %crc, i8* %buf, i32 %len) {
  ret i32 0
}

%struct.png_struct = type { i32, i32, i8* }

define void @png_read_row(%struct.png_struct* %ptr, i8** %row) {
  ret void
}

