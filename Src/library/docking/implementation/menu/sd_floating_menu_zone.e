indexing
	description: "A dialog hold SD_MENU_ZONE when it floating."
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

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			default_create
			internal_docking_manager := a_docking_manager
			create internal_shared
			disable_user_resize
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature -- Basic operation

	show is
			-- Show `Current'.
		do
			if internal_shared.allow_window_to_back then
				show_allow_to_back
			else
				show_relative_to_window (internal_docking_manager.main_window)
			end
		ensure
			shown: is_displayed
		end

	extend (a_menu_zone: SD_MENU_ZONE) is
			-- Extend `a_menu_zone'.
		require
			a_menu_zone_not_void: a_menu_zone /= Void
			a_menu_zone_horizontal: not a_menu_zone.is_vertical
			a_menu_zone_parent_void: a_menu_zone.parent = Void
			not_extended: not extended
		do
			extend_to_dialog (a_menu_zone)
			extended := True
		ensure
			extended: extended = True and has (a_menu_zone)
		end

feature -- States report

	extended: BOOLEAN
			-- If `Current' extended?

feature {NONE} -- Implementation

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.
			
	internal_shared: SD_SHARED
			-- All singletons.

invariant

	internal_shared_not_void: internal_shared /= Void

end
