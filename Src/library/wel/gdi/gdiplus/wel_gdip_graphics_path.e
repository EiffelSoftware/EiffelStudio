indexing
	description: "[
					Grapics path functions in Gdi+ which represents a series of connected lines and curves.
					For more information, please see:
					MSDN GraphicsPath Functions:
					http://msdn.microsoft.com/en-us/library/ms534039(VS.85).aspx
																				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_GRAPHICS_PATH

inherit
	WEL_GDIP_ANY
		redefine
			destroy_item
		end

create
	make,
	make_with_fill_mode,
	make_with_points_bytes_fill_mode

feature {NONE} -- Initlization

	make is
			-- Initializes Current with a FillMode value of Alternate.
		do
			make_with_fill_mode ({WEL_GDIP_FILL_MODE}.alternate)
		end

	make_with_fill_mode (a_fill_mode: INTEGER) is
			-- Initializes Current with `a_fill_mode'
		require
			valid: (create {WEL_GDIP_FILL_MODE}).is_valid (a_fill_mode)
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_create_path (gdi_plus_handle, a_fill_mode, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	make_with_points_bytes_fill_mode (a_points: ARRAYED_LIST [WEL_GDIP_POINT]; a_types: ARRAYED_LIST [INTEGER]; a_fill_mode: INTEGER) is
			-- Initializes Current with the specified PathPointType and
			-- Point arrays and with the specified FillMode enumeration element.
		require
			not_void: a_points /= Void and a_types = Void
			count_equal: a_points.count = a_types.count
			type_valid: (create {WEL_GDIP_PATH_POINT_TYPE}).is_valid_array (a_types)
		local
			l_result: INTEGER
			l_points: MANAGED_POINTER
			l_types: MANAGED_POINTER
			l_tmp_point: WEL_GDIP_POINT
			l_size: INTEGER
		do
			from
				create l_tmp_point.make
				l_size := l_tmp_point.structure_size
				create l_points.make (a_points.count * l_size)
				a_points.start
			until
				a_points.after
			loop
				l_points.put_integer_32  (a_points.item.x, (a_points.index - 1) * l_size)
				l_points.put_integer_32  (a_points.item.y, (a_points.index - 1) * l_size + l_size // 2)

				a_points.forth
			end

			from
				create l_types.make (a_types.count)
				a_types.start
			until
				a_types.after
			loop
				l_types.put_natural_8 (a_types.item.as_natural_8, a_types.index - 1)

				a_types.forth
			end

			default_create

			item := c_gdip_create_path_2_i (gdi_plus_handle, l_points.item, l_types.item, a_points.count, a_fill_mode, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Destroy

	destroy_item is
			-- <Precursor>
		local
			l_result: INTEGER
		do
			if item /= default_pointer then
				c_gdip_delete_path (gdi_plus_handle, item, $l_result)
				check ok: l_result = {WEL_GDIP_STATUS}.ok end
				item := default_pointer
			end
		end

feature {NONE} -- C externals

	c_gdip_create_path (a_gdiplus_handle: POINTER; a_fill_mode: INTEGER; a_result_status: TYPED_POINTER [INTEGER]): POINTER is
			-- Initializes a new instance of the Current
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			valid: (create {WEL_GDIP_FILL_MODE}).is_valid (a_fill_mode)
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipCreatePath = NULL;
				GpPath *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipCreatePath) {
					GdipCreatePath = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreatePath");
				}
				if (GdipCreatePath) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpFillMode, GpPath **)) GdipCreatePath)
								((GpFillMode) $a_fill_mode,
								(GpPath **) &l_result);
				}
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_create_path_2_i (a_gdiplus_handle: POINTER; a_points: POINTER; a_types: POINTER; a_count: INTEGER; a_fill_mode: INTEGER; a_result_status: TYPED_POINTER [INTEGER]): POINTER is
			-- Initializes a new instance of the Current
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			valid: (create {WEL_GDIP_FILL_MODE}).is_valid (a_fill_mode)
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipCreatePath2I = NULL;							
				GpPath *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipCreatePath2I) {
					GdipCreatePath2I = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreatePath2I");
				}				
				
				if (GdipCreatePath2I) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpPoint *, BYTE *, INT, GpFillMode, GpPath **)) GdipCreatePath2I)
								((GpPoint *) $a_points,
								(BYTE *) $a_types,
								(INT) $a_count,
								(GpFillMode) $a_fill_mode,
								(GpPath **) &l_result);
				}
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_delete_path (a_gdiplus_handle: POINTER; a_graphics_path: POINTER; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Delete `a_graphics_path' gdi+ object.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_handle_not_null: a_graphics_path /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipDeletePath = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipDeletePath) {
					GdipDeletePath = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipDeletePath");
				}
				
				if (GdipDeletePath) {			
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpPath *)) GdipDeletePath)
								((GpPath *) $a_graphics_path);
				}					
			}
			]"
		end

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

end
