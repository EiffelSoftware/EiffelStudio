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

	make (an_interface: like interface)
			-- Create a Cocoa toggle button.
		do
			base_make (an_interface)
			create {NS_BUTTON}cocoa_item.make
			button.set_bezel_style ({NS_BUTTON}.rounded_bezel_style)
			button.set_button_type ({NS_BUTTON}.push_on_push_off_button)
		end

feature -- Status setting

	enable_select
			-- Set `is_selected' `True'.
		do
		end

	disable_select
				-- Set `is_selected' `False'.
		do
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is toggle button pressed?
		do
		end

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

	interface: EV_TOGGLE_BUTTON;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_TOGGLE_BUTTON_IMP

