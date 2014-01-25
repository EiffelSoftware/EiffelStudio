note
	description: "Summary description for {BITSTREAM_WRITER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BITSTREAM_WRITER

obsolete "Changed signature"

--create

--	make

--feature {NONE}

--	make (vector_a: UNSIGNED_CHAR_VECTOR)
--		do
--			item := make_external (vector_a.item)
--		end

--feature

--	item: POINTER

--feature {NONE} -- Externals

--	make_external (vector_a: POINTER): POINTER
--		external
--			"C++ inline use %"llvm/Bitcode/BitstreamWriter.h%""
--		alias
--			"[
--				return new llvm::BitstreamWriter (*((std::vector <unsigned char> *)$vector_a));
--			]"
--		end
end
