indexing
	description: "Picture that consists of a bitmapped image."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ICON

inherit
	WEL_RESOURCE

creation
	make_by_id,
	make_by_name,
	make_by_predefined_id,
	make_by_file,
	make_by_pointer,
	make_by_icon_info

feature {NONE} -- Initialization

	make_by_file (file_name: FILE_NAME) is
			-- Load an icon file named `file_name'.
			-- Only Windows 95.
		require
			file_name_not_void: file_name /= Void
		local
			a_wel_string: WEL_STRING
		do
			!! a_wel_string.make (file_name)
			item := cwin_load_image (default_pointer, a_wel_string.item,
				Image_icon, 0, 0, Lr_loadfromfile)
		end

	make_by_icon_info (icon_info: WEL_ICON_INFO) is
		
		do
			item := cwin_create_icon_indirect (icon_info.item)
		end

feature {NONE} -- Implementation

	load_item (hinstance, id: POINTER) is
			-- Load icon.
		do
			item := cwin_load_icon (hinstance, id)
		end

	destroy_item is
			-- Destroy icon.
		do
			cwin_destroy_icon (item)
			item := default_pointer
		end

feature {NONE} -- Externals

	cwin_load_icon (hinstance: POINTER; id: POINTER): POINTER is
			-- SDK LoadIcon
		external
			"C [macro <wel.h>] (HINSTANCE, LPCSTR): EIF_POINTER"
		alias
			"LoadIcon"
		end

	cwin_create_icon_indirect (info: POINTER): POINTER is
			-- SDK CreateIconIndirect
		external
			"C [macro <wel.h>] (ICONINFO *): EIF_POINTER"
		alias
			"CreateIconIndirect"
		end

	cwin_destroy_icon (hicon: POINTER) is
			-- SDK DestroyIcon
		external
			"C [macro <wel.h>] (HICON)"
		alias
			"DestroyIcon"
		end

	cwin_load_image (hinstance, name: POINTER; type, width, height,
				load_flags: INTEGER): POINTER is
			-- SDK LoadImage
		external
			"C [macro <wel.h>] (HINSTANCE, LPCSTR, UINT, int, int, %
				%UINT): EIF_POINTER"
		alias
			"LoadImage"
		end

	Lr_loadfromfile: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"LR_LOADFROMFILE"
		end

	Image_icon: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"IMAGE_ICON"
		end

end -- class WEL_ICON

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

