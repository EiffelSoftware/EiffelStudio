note
	description: "Graphical resource common features (Icons & Cursors)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_GRAPHICAL_RESOURCE

inherit
	WEL_RESOURCE
		undefine
			make_by_pointer,
			dispose
		redefine
			make_by_id,
			make_by_name,
			make_by_predefined_id
		end

	WEL_GDI_ANY
		redefine
			delete,
			delete_gdi_object
		end

	WEL_IMAGE_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make_by_file (file_name: READABLE_STRING_GENERAL)
			-- Load an icon file named `file_name'.
		obsolete
			"Use `make_by_path' instead [2017-05-31]."
		require
			file_name_not_void: file_name /= Void
		do
			make_by_path (create {PATH}.make_from_string (file_name))
		end

	make_by_path (a_path: PATH)
			-- Load an icon file named `a_path'.
		require
			a_path_not_void: a_path /= Void
		local
			a_wel_string: WEL_STRING
			a_default_pointer: POINTER
		do
			create a_wel_string.make_from_path (a_path)
			item := cwin_load_image (
				a_default_pointer,
				a_wel_string.item,
				Image_type,
				0,
				0,
				Lr_loadfromfile
				)
			gdi_make
		end

	make_by_icon_info (icon_info: WEL_ICON_INFO)
			-- Create an icon from an `icon_info' structure
		require
			icon_info_not_void: icon_info /= Void
			icon_info_exists: icon_info.exists
		do
			item := cwin_create_icon_indirect (icon_info.item)
			gdi_make
		ensure
			item_not_void: item /= default_pointer
		end

	make_by_id (id: INTEGER)
			-- Load the resource by an `id'
		do
			Precursor {WEL_RESOURCE} (id)
			gdi_make
		end

	make_by_name (name: READABLE_STRING_GENERAL)
			-- Load the resource by a `name'
		do
			Precursor {WEL_RESOURCE} (name)
			gdi_make
		end

	make_by_predefined_id (id: POINTER)
			-- Load the resource by an `id', predefined by Windows
		do
			Precursor {WEL_RESOURCE} (id)
			gdi_make
		end

feature -- Access

	get_icon_info: detachable WEL_ICON_INFO
			-- Retrieve information about a icon/cursor
			--
			-- Return Void if an error occurred while retrieving
			-- the information.
		local
			icon_info: WEL_ICON_INFO
		do
			create icon_info.make
			if cwin_get_icon_info (item, icon_info.item) /= 0 then
				icon_info.initialize_bitmaps
				Result := icon_info
			end
		ensure
			Result_void_or_valid: Result = Void or else Result.is_initialized
		end

feature -- Removal

	delete
			-- Delete the current gdi object
		do
			delete_gdi_object
		end

	delete_gdi_object
			-- Delete the current gdi object
		local
			p: POINTER
			delete_result: BOOLEAN
			l_wel_error: WEL_ERROR
		do
			if item /= p then
				debug ("WEL_GDI_COUNT")
					decrease_gdi_objects_count
				end
				delete_result := destroy_resource
				if not delete_result then
					debug ("WEL")
						create l_wel_error
						io.put_string_32 ({STRING} "Unable to Destroy Icon/Cursor, Error=" +
							l_wel_error.last_error_code.out)
						print (Current)
					end
				end
				item := p
			end
		end

feature {NONE} -- Implementation

	destroy_resource: BOOLEAN
			-- SDK DestroyIcon/DestroyCursor
		deferred
		end

feature {NONE} -- Externals

	cwin_load_image (hinstance, name: POINTER; type, width, height,
				load_flags: INTEGER): POINTER
			-- SDK LoadImage
		external
			"C [macro <wel.h>] (HINSTANCE, LPCTSTR, UINT, int, int, %
				%UINT): EIF_POINTER"
		alias
			"LoadImage"
		end

	Lr_loadfromfile: INTEGER
		external
			"C [macro <wel.h>]"
		alias
			"LR_LOADFROMFILE"
		end

	cwin_get_icon_info (hicon: POINTER; iconinfo: POINTER): INTEGER
			-- SDK CreateIconIndirect
		external
			"C [macro <wel.h>] (HICON, ICONINFO *): EIF_INTEGER"
		alias
			"GetIconInfo"
		end

	cwin_create_icon_indirect (info: POINTER): POINTER
			-- SDK CreateIconIndirect
		external
			"C [macro <wel.h>] (ICONINFO *): EIF_POINTER"
		alias
			"CreateIconIndirect"
		end

feature {NONE} -- Constants

	Image_type: INTEGER
		-- Constant defining the type of the image
		-- See WEL_IMAGE_CONSTANTS for possible values.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_GRAPHICAL_RESOURCE

