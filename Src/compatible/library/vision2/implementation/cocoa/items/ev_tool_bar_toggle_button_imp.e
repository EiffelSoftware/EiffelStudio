note
	description:
		"EiffelVision toggle tool bar, Cocoa implementations."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_TOGGLE_BUTTON_IMP

inherit
	EV_TOOL_BAR_TOGGLE_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface,
			make
		end

create
	make

feature -- Initialization

	make (an_interface: like interface)
			-- Create a Cocoa toggle button.
		do
			base_make (an_interface)
			create button.make
			button.set_button_type ({NS_BUTTON}.push_on_push_off_button)
			cocoa_item := button
		end

feature -- Status setting

	disable_select
			-- Unselect `Current'.
		do
			if is_selected then

			end
		end

	enable_select
			-- Select `Current'.
		do
			if not is_selected then

			end
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected.
		do

		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_TOGGLE_BUTTON;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_TOOL_BAR_TOGGLE_BUTTON_IMP

