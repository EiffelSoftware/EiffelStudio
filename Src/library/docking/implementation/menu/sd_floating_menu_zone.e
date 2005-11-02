indexing
	description: "Objects that hold menu items when floating."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FLOATING_MENU_ZONE

inherit
	EV_UNTITLED_DIALOG
		rename
			show as show_allow_to_back,
			extend as extend_to_dialog
		end
create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method.
		do
			default_create
			create internal_shared
			disable_user_resize
		end
		
feature -- Basic operation

	show is
			-- 
		do
			if internal_shared.allow_window_to_back then
				show_allow_to_back
			else
				show_relative_to_window (internal_shared.docking_manager.main_window)
			end
		end
	
	extend (a_menu_zone: SD_MENU_ZONE) is
			-- 
		require
			a_menu_zone_not_void: a_menu_zone /= Void
			a_menu_zone_horizontal: not a_menu_zone.is_vertical
			a_menu_zone_parent_void: a_menu_zone.parent = Void
			not_extended: not extended
		do
			extend_to_dialog (a_menu_zone)
			internal_extended := True
		end

feature -- States report
	
	extended: BOOLEAN is
			-- 
		do
			Result := internal_extended
		end
		
feature {NONE} -- Implementation

	internal_extended: BOOLEAN
			-- If `Current' extended?

	internal_shared: SD_SHARED

end
