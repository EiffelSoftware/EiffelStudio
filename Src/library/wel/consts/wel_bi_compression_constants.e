indexing
	description: "Enumeration for gdi biCompression field"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BI_COMPRESSION_CONSTANTS

feature -- Enumeration

	Bi_rgb: INTEGER_32 is 0
			-- BI_RGB

	Bi_rle8: INTEGER_32 is 1
			-- BI_RLE8

	Bi_rle4: INTEGER_32 is 2
			-- BI_RLE4

	Bi_bitfields: INTEGER_32 is  3
	 		-- BI_BITFIELDS

	Bi_jpeg: INTEGER_32 is 4
			-- BI_JPEG

	Bi_png: INTEGER_32 is 5
			-- BI_PNG

feature -- Query

	is_valid (a_bi: INTEGER_32): BOOLEAN is
			-- If `a_bi' valid?
		do
			Result := a_bi = Bi_rgb
				or a_bi = Bi_rle8
				or a_bi = Bi_rle4
				or a_bi = Bi_bitfields
				or a_bi = Bi_jpeg
				or a_bi = Bi_png
		end

end
