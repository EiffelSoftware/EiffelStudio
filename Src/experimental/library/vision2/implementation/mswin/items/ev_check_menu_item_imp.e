note
	description:
		"EiffelVision check menu item. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CHECK_MENU_ITEM_IMP

inherit
	EV_CHECK_MENU_ITEM_I
		undefine
			parent
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		undefine
			on_draw_menu_item_left_part,
			disabled_image
		redefine
			on_activate,
			interface,
			make
		end

	EV_CHECKABLE_MENU_ITEM_IMP

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize with state not `is_selected'.
		do
			Precursor
			is_selected := False
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is this menu item checked?

feature -- Status setting

	enable_select
			-- Select this menu item.
		do
			is_selected := True
			if has_parent and then attached parent_imp as l_parent_imp then
				l_parent_imp.check_item (id)
			end
		end

	disable_select
		do
			is_selected := False
			if has_parent and then attached parent_imp as l_parent_imp then
				l_parent_imp.uncheck_item (id)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_CHECK_MENU_ITEM note option: stable attribute end

feature {NONE} -- Implementation

	on_activate
			-- Invert the state and call `Precursor'.
		do
			toggle
			Precursor
		end

	check_mark_bitmap_constant: INTEGER
			-- Constant coding for the check mark used in Current.
		do
			Result := Wel_drawing_constants.Dfcs_menucheck
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EV_CHECK_MENU_ITEM_IMP
