indexing
	description: "Picture that consists of a bitmapped image."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ICON

inherit
	WEL_GRAPHICAL_RESOURCE

creation
	make_by_id,
	make_by_name,
	make_by_predefined_id,
	make_by_file,
	make_by_pointer,
	make_by_icon_info

feature {NONE} -- Implementation

	load_item (hinstance, id: POINTER) is
			-- Load icon.
		do
			item := cwin_load_icon (hinstance, id)
		end

feature -- Removal

	delete is
			-- Delete icon object.
		local
			p: POINTER
		do
			if item /= p then
				cwin_destroy_icon (item)
				item := p
			end
		end

feature {NONE} -- Externals

	cwin_load_icon (hinstance: POINTER; id: POINTER): POINTER is
			-- SDK LoadIcon
		external
			"C [macro <wel.h>] (HINSTANCE, LPCSTR): EIF_POINTER"
		alias
			"LoadIcon"
		end

	cwin_destroy_icon (hicon: POINTER) is
			-- SDK DestroyIcon
		external
			"C [macro <wel.h>] (HICON)"
		alias
			"DestroyIcon"
		end

feature {NONE} -- Implementation

	Image_type: INTEGER is
		-- Constant defining the type of the image
		-- See WEL_IMAGE_CONSTANTS for possible values.
		do
			Result := Image_icon
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

