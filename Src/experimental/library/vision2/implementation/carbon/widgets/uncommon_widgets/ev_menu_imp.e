note
	description: "Eiffel Vision menu. Carbon implementation."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_IMP

inherit
	EV_MENU_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		undefine
			parent
		redefine
			interface,
			initialize,
			destroy,
			show
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			interface,
			initialize,
			destroy
		end

create
	make

feature {NONE} -- Initialization

	initialize
		do
			Precursor {EV_MENU_ITEM_LIST_IMP}
			Precursor {EV_MENU_ITEM_IMP}
		end

feature -- Basic operations

	show
			-- Pop up on the current pointer position.
		do
		end

	show_at (a_widget: EV_WIDGET; a_x, a_y: INTEGER)
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU

feature {NONE} -- Implementation

	destroy
			-- Destroy the menu
		do
		end

note
	copyright:	"Copyright (c) 2006-2007, Eiffel.Mac Team"
end -- class EV_MENU_IMP

