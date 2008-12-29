note
	description: "EiffelVision check menu. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_CHECK_MENU_ITEM_IMP

inherit
	EV_CHECK_MENU_ITEM_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a menu.
		do
			base_make (an_interface)
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is this menu item checked?
		do
		end

feature -- Status setting

	enable_select
			-- Select this menu item.
		do
		end

	disable_select
			-- Deselect this menu item.
		do
		end

	ignore_select_actions: BOOLEAN
			-- Should select actions be ignore, ues if enable_select is called.

feature {NONE} -- Implementation

	interface: EV_CHECK_MENU_ITEM;

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_CHECK_MENU_ITEM_IMP

