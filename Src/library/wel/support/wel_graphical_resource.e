indexing
	description	: "Graphical resource common features (Icons & Cursors)"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	WEL_GRAPHICAL_RESOURCE

inherit
	WEL_RESOURCE

	WEL_IMAGE_CONSTANTS
		export
			{NONE} all
		end
		
feature {NONE} -- Initialization

	make_by_file (file_name: FILE_NAME) is
			-- Load an icon file named `file_name'.
		require
			file_name_not_void: file_name /= Void
		local
			a_wel_string: WEL_STRING
		do
			create a_wel_string.make (file_name)
			item := cwin_load_image (
				default_pointer, 
				a_wel_string.item,
				Image_type, 
				0, 
				0, 
				Lr_loadfromfile
				)
		end

	make_by_icon_info (icon_info: WEL_ICON_INFO) is
			-- Create an icon from an `icon_info' structure
		do
			item := cwin_create_icon_indirect (icon_info.item)
		ensure
			item_not_void: item /= Void
		end

feature -- Access

	get_icon_info: WEL_ICON_INFO is
			-- Retrieve information about a icon/cusor
			--
			-- Return Void if an error occured while retrieving
			-- the information.
		local
			icon_info: WEL_ICON_INFO
		do
			create icon_info.make
			if cwin_get_icon_info(item, icon_info.item) = 0 then
				Result := Void
			else
				Result := icon_info
			end
		end

feature -- Removal

	delete is
			-- Delete the current gdi object
		deferred
		ensure
			not_exists: not exists
		end

feature {NONE} -- Removal

	destroy_item is
			-- Ensure the current gdi object is deleted when
			-- garbage collected.
		do
			delete
		end

feature {NONE} -- Externals

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

	cwin_get_icon_info (hicon: POINTER; iconinfo: POINTER): INTEGER is
			-- SDK CreateIconIndirect
		external
			"C [macro <wel.h>] (HICON, ICONINFO *): EIF_INTEGER"
		alias
			"GetIconInfo"
		end

	cwin_create_icon_indirect (info: POINTER): POINTER is
			-- SDK CreateIconIndirect
		external
			"C [macro <wel.h>] (ICONINFO *): EIF_POINTER"
		alias
			"CreateIconIndirect"
		end

feature {NONE} -- Constants

	Image_type: INTEGER is
		-- Constant defining the type of the image
		-- See WEL_IMAGE_CONSTANTS for possible values.
		deferred
		end

end -- class WEL_GRAPHICAL_RESOURCE
