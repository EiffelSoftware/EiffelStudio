note
	description: "[
					COM IStream
					The IStream interface supports reading and writing data to stream objects. Stream objects
					contain the data in a structured storage object, where storages provide the structure.
					
					It's different from C++ standard lib's istream
																												]"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COM_ISTREAM

inherit
	DISPOSABLE

create
	create_istream_from_file,
	create_istream_from_memory

feature {NONE} -- Initialization

	create_istream_from_file (a_file_name: READABLE_STRING_GENERAL)
			-- Opens or creates a file and retrieves a stream to read or write to that file.
		require
			not_void: a_file_name /= void
		local
			l_string: WEL_STRING
			l_result: POINTER
			l_com_result: NATURAL_32
		do
			create l_string.make (a_file_name)
			l_com_result := c_sh_create_stream_on_file (l_string.item, $l_result)
			check l_com_result = {WEL_COM_HRESULT}.s_ok end
			item := l_result
		end

	create_istream_from_memory (a_pointer: POINTER; a_size: NATURAL_32)
			-- Creates a memory stream using a similar process to CreateStreamOnHGlobal, but with less functionality.
		require
			valid: a_pointer /= default_pointer
		do
			item := c_sh_create_mem_stream (a_pointer, a_size)
			check success: item /= default_pointer end
		end

feature -- Query

	item: POINTER
			-- IStream object

feature -- Command

	dispose
			-- <Precursor>
		do
			if item /= default_pointer then
				c_release (item)
			end
		end

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

	c_sh_create_mem_stream (a_const_byte: POINTER; a_size: NATURAL_32): POINTER
			-- Creates a memory stream using a similar process to CreateStreamOnHGlobal, but with less functionality.
		external
			"C++ inline use <Shlwapi.h>"
		alias
			"[
			{
				return SHCreateMemStream ((const BYTE *)$a_const_byte, (UINT)$a_size);
			}
			]"
		end

	c_release (a_item: POINTER)
			-- Streams can remain open for long periods of time without consuming file system resources. The Release
			-- method is similar to a close function on a file. Once released, the stream object is no longer valid and
			-- cannot be used.
		external
			"C++ inline use <Objidl.h>"
		alias
			"[
			{
				IStream *l_item = (IStream *)$a_item;
				l_item->Release();
			}
			]"
		end

	c_commit (a_item: POINTER): NATURAL_32
			-- The Commit method ensures that any changes made to a stream object open in transacted mode are reflected
			-- in the parent storage. If the stream object is open in direct mode, IStream::Commit has no effect other
			-- than flushing all memory buffers to the next-level storage object. The COM compound file implementation
			-- of streams does not support opening streams in transacted mode.
		external
			"C++ inline use <Objidl.h>"
		alias
			"[
			{
				IStream *l_item = (IStream *)$a_item;
				return l_item->Commit(STGC_DEFAULT);
			}
			]"
		end

	c_clone (a_item: POINTER; a_result: TYPED_POINTER [POINTER]): NATURAL_32
			--
		external
			"C++ inline use <Objidl.h>"
		alias
			"[
			{
				IStream *l_item = (IStream *)$a_item;
				return l_item->Clone((IStream **)$a_result);
			}
			]"
		end

	c_copy_to
			-- The CopyTo method copies a specified number of bytes from the current seek pointer in the stream to
			-- the current seek pointer in another stream.
		do

		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
