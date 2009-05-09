note
	description: "Eiffel Vision radio button. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RADIO_BUTTON_IMP

inherit
	EV_RADIO_BUTTON_I
		redefine
			interface
		end

	EV_BUTTON_IMP
		export
			{NONE}
				cocoa_item
		undefine
			default_alignment
		redefine
			interface,
			make,
			initialize
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create radio button.
		do
			base_make (an_interface)
			create {NS_BUTTON}cocoa_item.new
			button.set_button_type ({NS_BUTTON}.radio_button)
		end

	initialize
			-- Initialize `Current'
		do
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is toggle button pressed?
		do
		end

feature -- Status setting

	enable_select
			-- Set `is_selected' `True'.
		do
		end

feature {EV_ANY_I} -- Implementation

	radio_group: LINKED_LIST [like current]
			-- List of all radio item implementations
		do
		end


feature {EV_ANY_I} -- Implementation

	interface: EV_RADIO_BUTTON;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_RADIO_BUTTON_IMP

