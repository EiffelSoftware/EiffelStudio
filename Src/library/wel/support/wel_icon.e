indexing
	description: "Picture that consists of a bitmapped image."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ICON

inherit
	WEL_GRAPHICAL_RESOURCE

create
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
			item := cwin_load_icon_image (hinstance, id)
		end

feature {NONE} -- Implementation

	destroy_resource: BOOLEAN is
			-- SDK DestroyIcon/DestroyCursor
		do
			Result := cwin_destroy_icon (item)
		end

feature {NONE} -- Externals

	cwin_load_icon_image (hinstance, id: POINTER): POINTER is
			--
		external
			"C inline use <winuser.h>"
		alias
			"[
				return LoadImage((HINSTANCE)$hinstance, MAKEINTRESOURCE($id), IMAGE_ICON, 0, 0, LR_SHARED | LR_DEFAULTSIZE);
			]"
		end

	cwin_destroy_icon (hicon: POINTER): BOOLEAN is
			-- SDK DestroyIcon
		external
			"C [macro <wel.h>] (HICON): BOOL"
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




end -- class WEL_ICON

