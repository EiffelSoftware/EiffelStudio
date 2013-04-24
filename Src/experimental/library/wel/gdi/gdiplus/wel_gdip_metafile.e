note
	description: "[
		Abstraction of a graphic metafile. A metafile contains recors that describe a sequence of graphics API calls.
		A Metafile can be recorded (i.e. constructed) and played back (i.e. displayed).
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_METAFILE

inherit
	WEL_GDIP_IMAGE
		redefine
			load_image_from_stream
		end

create
	default_create

feature -- Access

	header: WEL_METAFILE_HEADER
			-- Metafile header structure.
		require
			exists: exists
		local
			l_result: INTEGER_32
		do
			create Result.make
			c_gdip_get_metafile_header (gdi_plus_handle, item, Result.item, $l_result)
		end

feature -- Command

	load_image_from_stream (a_stream: WEL_COM_ISTREAM)
			-- Load Metafile from `a_stream'.
		local
			l_result: INTEGER_32
		do
			item := c_gdip_create_metafile_from_stream (gdi_plus_handle, a_stream.item, $l_result)
		end

feature {NONE} -- Externals

	c_gdip_create_metafile_from_stream (a_gdiplus_handle: POINTER; a_stream: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
			-- Create a Gdi+ bitmap object name from `a_stream'.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_stream_not_null: a_stream /= default_pointer
			has_result: a_result_status /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipCreateMetafileFromStream = NULL;
				GpMetafile *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipCreateMetafileFromStream) {
					GdipCreateMetafileFromStream = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreateMetafileFromStream");
				}	
				
				if (GdipCreateMetafileFromStream) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (IStream *, GpMetafile **)) GdipCreateMetafileFromStream)
								((IStream *) $a_stream,
								(GpMetafile **) &l_result);
				}				
				
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_get_metafile_header (a_gdiplus_handle: POINTER; a_metafile, a_metafile_header: POINTER; a_result_status: TYPED_POINTER [INTEGER])
			-- Load Metafile Header structure in `a_metafile_header'.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_metafile_not_null: a_metafile /= default_pointer
			a_metafile_header_not_null: a_metafile_header /= default_pointer
			has_result: a_result_status /= default_pointer
		external
			"C++ inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipGetMetafileHeaderFromMetafile = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipGetMetafileHeaderFromMetafile) {
					GdipGetMetafileHeaderFromMetafile = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGetMetafileHeaderFromMetafile");
				}	
				
				if (GdipGetMetafileHeaderFromMetafile) {
					MetafileHeader l_header;
					memset(&l_header, 0, sizeof(MetafileHeader));
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpMetafile *, MetafileHeader *)) GdipGetMetafileHeaderFromMetafile)
								((GpMetafile *) $a_metafile, &l_header);

						/* Let's copy the structure */								
					*(ENHMETAHEADER3 *) $a_metafile_header = l_header.EmfHeader;
				}				
			}
			]"
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
