note
	description: "[
					COM IStream
					It's different from C++ standard lib's istream
																						]"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_ISTREAM

feature -- Command

	create_istream_from_file (a_file_name: READABLE_STRING_GENERAL)
			--
		local
			l_string: WEL_STRING
			l_result: POINTER
			l_com_result: NATURAL_32
		do
			create l_string.make (a_file_name)
			l_com_result := c_sh_create_stream_on_file (l_string.item, $l_result)
			check l_com_result = {EV_RIBBON_HRESULT}.s_ok end
			item := l_result
		end

	create_istream_from_memory
			-- using c SHCreateMemStream
		do
			--
		end

feature -- Query

	item: POINTER
			-- IStream object

feature {NONE} -- Implementation

	c_sh_create_stream_on_file (a_wchar_file_name: POINTER; a_result_istream: TYPED_POINTER[POINTER]): NATURAL_32
			-- Opens or creates a file and retrieves a stream to read or write to that file.
		external
			"C++ inline use <Shlwapi.h>"
		alias
			"[
			{
				IStream **l_stream = (IStream **) $a_result_istream;
				return SHCreateStreamOnFileW ((const WCHAR *)$a_wchar_file_name, STGM_READWRITE, l_stream);
			}
			]"
		end

--	c_stg_create_doc_file (a_wchar_file_name: POINTER; a_result_istorage: TYPED_POINTER[POINTER]): NATURAL_32
--			--
--		external
--			"C++ inline use <Objbase.h>"
--		alias
--			"[
--			{
--				IStorage **ppstgOpen = (IStorage **) $a_result_istorage;
--				return StgCreateDocfile ((const WCHAR *)$a_wchar_file_name, STGM_SIMPLE, 0, ppstgOpen);
--			}
--			]"
--		end
end
