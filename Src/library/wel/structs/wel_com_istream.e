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
			not_void: a_file_name /= Void
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
			-- Creates a memory stream using a similar process to CreateStreamOnHGlobal,
			-- but with less functionality. If `a_pointer' is `default_pointer', current
			-- is initialized without an initial content.
		require
			valid_pointer: a_pointer = default_pointer implies a_size = 0
		do
			item := c_sh_create_mem_stream (shlwapi_handle, a_pointer, a_size)
			check success: item /= default_pointer end
		end

feature -- Query

	item: POINTER
			-- IStream object

	stat: WEL_STAT_STG
			-- The Stat method retrieves the STATSTG structure for this stream.
		require
			valid: item /= default_pointer
		local
			l_result: NATURAL_32
		do
			create Result.make_empty
			l_result := c_stat (item, Result.item.item)
			check l_result = {WEL_COM_HRESULT}.s_ok end
		end

feature -- Command

	commit
			-- The Commit method ensures that any changes made to a stream object open in transacted mode are reflected
			-- in the parent storage.
		local
			l_result: NATURAL_32
		do
			if item /= default_pointer then
				l_result := c_commit (item)
				check l_result = {WEL_COM_HRESULT}.s_ok end
			end
		end

	set_size (a_new_size: NATURAL_64)
			-- The SetSize method changes the size of the stream object.
		local
			l_result: NATURAL_32
		do
			if item /= default_pointer then
				l_result := c_set_size (item, a_new_size)
				check l_result = {WEL_COM_HRESULT}.s_ok end
			end
		end

	read_all: MANAGED_POINTER
			-- Reads all bytes from a specified stream to result pointer
		local
			l_bytes_count: NATURAL_64
			l_com_result: NATURAL_32
			l_acutal_read: NATURAL_32
		do
			l_bytes_count := stat.cb_size
			check not_too_big: l_bytes_count <= {INTEGER_32}.max_value.as_natural_64 end
			create Result.make (l_bytes_count.as_integer_32)

			seek_from_beginning (0)
			l_com_result := c_read (item, Result.item, l_bytes_count.as_natural_32, $l_acutal_read)
			check l_com_result = {WEL_COM_HRESULT}.s_ok end
			check l_acutal_read = l_bytes_count.as_natural_32 end
		end

	seek_from_beginning (a_position: INTEGER_64)
			-- The Seek method changes the seek pointer to a new location.
		local
			l_new_position: NATURAL_64
			l_result: NATURAL_32
		do
			if item /= default_pointer then
				l_result := c_seek (item, a_position, stream_seek_set, $l_new_position)
				check l_result = {WEL_COM_HRESULT}.s_ok end
			end
		end

	destroy
			-- Destroy.
		do
			if item /= default_pointer then
				destroy_item
			end
		end
		
	dispose
			-- <Precursor>
		do
			destroy
		end

feature {NONE} -- Implementation

	destroy_item
			-- Called by the `dispose' routine to
			-- destroy `item' by calling the
			-- corresponding Windows function and
			-- set `item' to `default_pointer'.
		require
			exists: item /= default_pointer
		do
			c_release (item)
			item := default_pointer
		end

	shlwapi_handle: POINTER
			--
		local
			l_dll: detachable WEL_DLL
		do
			l_dll := shlwapi_dll
			if l_dll = Void then
				create l_dll.make ("shlwapi.dll")
				shlwapi_dll := l_dll
			end

			Result := l_dll.item
		end

	shlwapi_dll: detachable WEL_DLL
			-- DLL helper for `shalwapi.dll'

feature {NONE} -- Externals

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

	c_sh_create_mem_stream (a_shlwpai_handle: POINTER; a_const_byte: POINTER; a_size: NATURAL_32): POINTER
			-- Creates a memory stream using a similar process to CreateStreamOnHGlobal, but with less functionality.
		external
			"C++ inline use <windows.h>"
		alias
			"[
			{
				typedef IStream* (__stdcall *tSHCreateMemStream)(const BYTE *, UINT);
				static tSHCreateMemStream pSHCreateMemStream = NULL;
				HMODULE hShlWapi = (HMODULE)$a_shlwpai_handle;
				IStream *Result = NULL;

				if ((!pSHCreateMemStream) && hShlWapi) {
					pSHCreateMemStream = (tSHCreateMemStream) GetProcAddress(hShlWapi, "SHCreateMemStream");
					if (!pSHCreateMemStream) {
						pSHCreateMemStream = (tSHCreateMemStream) GetProcAddress(hShlWapi, (LPCSTR) 12);
					}
				}
				if (pSHCreateMemStream) {
					return pSHCreateMemStream ((const BYTE *)$a_const_byte, (UINT)$a_size);
				} else {
					return NULL;
				}
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

-- FIXME: OK to convert NATURAL_64 with C union ULARGE_INTEGER.QuadPart?
	c_copy_to (a_item: POINTER; a_stream: POINTER; a_bytes_count: NATURAL_64; a_actual_read, a_actual_write: TYPED_POINTER [NATURAL_64]): NATURAL_32
			-- The CopyTo method copies a specified number of bytes from the current seek pointer in the stream to
			-- the current seek pointer in another stream.
			-- `a_bytes_count' The number of bytes to copy from the source stream.
		external
			"C++ inline use <Objidl.h>"
		alias
			"[
			{
				HRESULT l_result;
				IStream *l_item = (IStream *)$a_stream;
				ULARGE_INTEGER l_cb;
				l_cb.QuadPart = (ULONGLONG) $a_bytes_count;
				ULARGE_INTEGER l_pcbRead; 
				ULARGE_INTEGER l_pcbWritten;
				
				l_result = l_item->CopyTo((IStream *)l_item, l_cb, &l_pcbRead, &l_pcbWritten);
				
				*((ULONGLONG *)$a_actual_read) = l_pcbRead.QuadPart;
				*((ULONGLONG *)$a_actual_write) = l_pcbWritten.QuadPart;
				
				return l_result;
			}
			]"
		end

	c_set_size (a_item: POINTER; a_size: NATURAL_64): NATURAL_32
			-- The SetSize method changes the size of the stream object.
		external
			"C++ inline use <Objidl.h>"
		alias
			"[
			{
				IStream *l_item = (IStream *)$a_item;
				ULARGE_INTEGER libNewSize;
				libNewSize.QuadPart = (ULONGLONG) $a_size;
				
				return l_item->SetSize(libNewSize);
			}
			]"
		end

	c_stat (a_item: POINTER; a_result: POINTER): NATURAL_32
			-- The Stat method retrieves the STATSTG structure for this stream.
		external
			"C++ inline use <Objidl.h>"
		alias
			"[
			{
				IStream *l_item = (IStream *)$a_item;
				STATSTG *l_pstatstg = (STATSTG *)$a_result;

				return l_item->Stat(l_pstatstg, STATFLAG_DEFAULT);
			}
			]"
		end

	c_read (a_item: POINTER; a_pointer_to_write: POINTER; a_cb: NATURAL_32; a_actual_read: TYPED_POINTER [NATURAL_32]): NATURAL_32
			-- The Read method reads a specified number of bytes from the stream
			-- object into memory, starting at the current seek pointer.
		external
			"C++ inline use <Objidl.h>"
		alias
			"[
			{
				IStream *l_item = (IStream *)$a_item;
				VOID *l_pointer_to_write = (VOID *)$a_pointer_to_write;
				ULONG l_cb = (ULONG)$a_cb;
				ULONG l_pcbRead;
				HRESULT l_result;

				l_result = l_item->Read (l_pointer_to_write, l_cb, &l_pcbRead);
				*((EIF_NATURAL_32 *)$a_actual_read) = (EIF_NATURAL_32)l_pcbRead;

				return l_result;
			}
			]"
		end

	c_istream_write
			--
		do
			check not_implemented: False end
		end

	c_seek (a_item: POINTER; a_dlib_move: INTEGER_64; a_dw_origin: NATURAL_32; a_plib_new_position: TYPED_POINTER [NATURAL_64]): NATURAL_32
			-- The Seek method changes the seek pointer to a new location.
			-- The new location is relative to either the beginning of the stream,
			-- the end of the stream, or the current seek pointer.
		external
			"C++ inline use <Objidl.h>"
		alias
			"[
			{
				IStream *l_item = (IStream *)$a_item;
				DWORD l_dwOrigin = (DWORD)$a_dw_origin;
				LARGE_INTEGER l_dlibMove;
				HRESULT l_result;
				ULARGE_INTEGER l_plibNewPosition;
				
				l_dlibMove.QuadPart = (LONGLONG)$a_dlib_move;
				
				l_result = l_item->Seek (l_dlibMove, l_dwOrigin, &l_plibNewPosition);
				
				*((ULONGLONG *)($a_plib_new_position)) = l_plibNewPosition.QuadPart;
				
				return l_result;
			}
			]"
		end

feature -- STREAM_SEEK Enumeration

	stream_seek_set: NATURAL_32 = 0
			-- The new seek pointer is an offset relative to the beginning of the stream. In this case,
			-- the dlibMove parameter is the new seek position relative to the beginning of the stream.

	stream_seek_cur: NATURAL_32 = 1
			-- The new seek pointer is an offset relative to the current seek pointer location. In this
			-- case, the dlibMove parameter is the signed displacement from the current seek position.

	stream_seek_end: NATURAL_32 = 2
			-- The new seek pointer is an offset relative to the end of the stream. In this case, the
			-- dlibMove parameter is the new seek position relative to the end of the stream.

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
