indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	TYMED_ENUM

feature -- Access

	Tymed_hglobal: INTEGER is 1 
			-- The storage medium is a global memory handle
			-- (HGLOBAL). Allocate the global handle with the
			-- GMEM_SHARE flag. If the STGMEDIUM punkForRelease
			-- member is NULL, the destination process should
			-- use GlobalFree to release the memory

	Tymed_file: INTEGER is 2
			-- The storage medium is a disk file identified 
			-- by a path. If the STGMEDIUM punkForRelease 
			-- member is NULL, the destination process should 
			-- use OpenFile to delete the file. 

	Tymed_istream: INTEGER is 4 
			-- The storage medium is a stream object identified 
			-- by an IStream pointer. Use 
			-- ISequentialStream::Read to read the data. 
			-- If the STGMEDIUM punkForRelease member is 
			-- not NULL, the destination process should 
			-- use IStream::Release to release the stream
			-- component.

	Tymed_istorage: INTEGER is 8 
			-- The storage medium is a storage component 
			-- identified by an IStorage pointer. The data 
			-- is in the streams and storages contained by 
			-- this IStorage instance. If the STGMEDIUM
			-- punkForRelease member is not NULL, the destination
			-- process should use IStorage::Release to release 
			-- the storage component.

	Tymed_gdi: INTEGER is 16
			-- The storage medium is a GDI component (HBITMAP). 
			-- If the STGMEDIUM punkForRelease member is NULL, 
			-- the destination process should use DeleteObject 
			-- to delete the bitmap. 

	Tymed_mfpict: INTEGER is 32
			-- The storage medium is a metafile (HMETAFILE). 
			-- Use the Windows or WIN32 functions to access 
			-- the metafile's data. If the STGMEDIUM 
			-- punkForRelease member is NULL, the destination
			-- process should use DeleteMetaFile to delete 
			-- the bitmap. 

	Tymed_enhmf: INTEGER is 64
			-- The storage medium is an enhanced metafile. 
			-- If the STGMEDIUM punkForRelease member is NULL, 
			-- the destination process should use 
			-- DeleteEnhMetaFile to delete the bitmap. 


	Tymed_null: INTEGER is 0; 
			-- No data is being passed. 


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TYMED_ENUM
