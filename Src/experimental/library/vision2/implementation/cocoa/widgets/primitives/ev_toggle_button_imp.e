note
	description: "EiffelVision toggle button, Cocoa implementation."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TOGGLE_BUTTON_IMP

inherit
	EV_TOGGLE_BUTTON_I
		redefine
			interface
		end

	EV_BUTTON_IMP
		redefine
			make,
			interface,
			set_pixmap,
			remove_pixmap
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			Precursor {EV_BUTTON_IMP}
			set_bezel_style ({NS_BUTTON}.rounded_bezel_style)
			set_button_type ({NS_BUTTON}.push_on_push_off_button)
			align_text_left
			set_is_initialized (True)
		end

feature -- Status setting

	enable_select
			-- Set `is_selected' `True'.
		do
			set_state ({NS_CELL}.on_state)
			is_selected := True
		end

	disable_select
				-- Set `is_selected' `False'.
		do
			set_state ({NS_CELL}.off_state)
			is_selected := False
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is toggle button pressed?

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP)

			-- Display image of `a_pixmap' on `Current'.
			-- Image of `pixmap' will be a copy of `a_pixmap'.
			-- Image may be scaled in some descendents, i.e EV_TREE_ITEM
			-- See EV_TREE.set_pixmaps_size.

		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			-- First load the pixmap into the button
			pixmap_imp ?= a_pixmap.implementation

			if
				pixmap_imp /= Void
			then
			end

			-- Then move the text to the right
			align_text_right

		end

	remove_pixmap
			-- Remove image displayed on `Current'.
		do
			-- Then put the text into the center
			align_text_center
		end


feature {EV_ANY_I}

	interface: detachable EV_TOGGLE_BUTTON note option: stable attribute end;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_TOGGLE_BUTTON_IMP

