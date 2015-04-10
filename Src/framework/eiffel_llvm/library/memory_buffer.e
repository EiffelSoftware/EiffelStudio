note
	description: "Summary description for {MEMORY_BUFFER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MEMORY_BUFFER

create

	make_from_pointer,
	get_file,
	get_mem_buffer_copy

feature {NONE}

	make_from_pointer (item_a: POINTER)
		do
			item := item_a
		end

	get_file (filename: STRING)
		local
--			filename_c_string: C_STRING
		do
			check signature_changed: False end
--			create filename_c_string.make (filename)
--			item := get_file_external (filename_c_string.item)
		end

	get_mem_buffer_copy (buffer: STRING)
		local
			buffer_c_string: C_STRING
		do
			create buffer_c_string.make (buffer)
			item := get_mem_buffer_copy_external (buffer_c_string.item, buffer_c_string.item.plus (buffer_c_string.bytes_count))
		end

feature

	get_buffer_size: INTEGER_32
		do
			Result := get_buffer_size_external (item)
		end

feature

	item: POINTER

feature {NONE} -- Externals

	get_mem_buffer_copy_external (buffer: POINTER; buffer_end: POINTER): POINTER
		external
			"C++ inline use %"llvm/Support/MemoryBuffer.h%", %"llvm/ADT/StringRef.h%""
		alias
			"[
				return llvm::MemoryBuffer::getMemBufferCopy ((const char *)$buffer, (const char *)$buffer_end);
			]"
		end

	get_buffer_size_external (item_a: POINTER): INTEGER_32
		external
			"C++ inline use %"llvm/Support/MemoryBuffer.h%""
		alias
			"[
				return ((llvm::MemoryBuffer *)$item_a)->getBufferSize ();
			]"
		end

--	get_file_external (filename: POINTER): POINTER
--		external
--			"C++ inline use %"llvm/Support/MemoryBuffer.h%""
--		alias
--			"[
--				std::string filename ((const char *)$filename);
--				
--				return llvm::MemoryBuffer::getFile (filename);
--			]"
--		end
end
