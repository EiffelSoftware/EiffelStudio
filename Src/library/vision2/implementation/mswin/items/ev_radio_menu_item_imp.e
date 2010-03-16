note
	description: "Eiffel Vision radio menu item. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_MENU_ITEM_IMP

inherit
	EV_RADIO_MENU_ITEM_I
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
			interface,
			on_activate,
			make
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

	EV_CHECKABLE_MENU_ITEM_IMP

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize with state `is_selected'.
		do
			Precursor
			is_selected := True
		end

feature {EV_ANY_I} -- Status report

	is_selected: BOOLEAN

feature {EV_ANY_I} -- Status setting

	disable_select
			-- Assign `False' to `is_selected'.
		do
			is_selected := False
		end

	enable_select
		local
			cur: CURSOR
		do
			if attached radio_group as l_radio_group and then attached parent_imp as l_parent_imp then
				cur := l_radio_group.cursor
				from
					l_radio_group.start
				until
					l_radio_group.off
				loop
					l_parent_imp.uncheck_item (l_radio_group.item.id)
					l_radio_group.item.disable_select
					l_radio_group.forth
				end
				l_radio_group.go_to (cur)
			end
			is_selected := True
			if has_parent and then attached parent_imp as l_parent_imp then
				l_parent_imp.check_item (id)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_RADIO_MENU_ITEM note option: stable attribute end

feature {NONE} -- Implementation

	on_activate
			-- Enable this item and call `Precursor'.
		do
			enable_select
			Precursor
		end

	check_mark_bitmap_constant: INTEGER
			-- Constant coding for the check mark used in Current.
		do
			Result := Wel_drawing_constants.Dfcs_menubullet
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

end -- class EV_RADIO_MENU_ITEM_IMP
