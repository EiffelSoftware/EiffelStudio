note
	description:
		" EiffelVision tool-bar radio button. Cocoa implementation%
		% interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_RADIO_BUTTON_IMP

inherit
	EV_TOOL_BAR_RADIO_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			make,
			interface,
			create_select_actions
		end

	EV_RADIO_PEER_IMP
		redefine
			interface,
			widget_object
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a Cocoa toggle button.
		do
			base_make (an_interface)
			create button.make
			cocoa_item := button
		end

feature -- Status setting

	enable_select
			-- Select `Current'.
		local
			temp: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			temp ?= peers.first.implementation

			temp.disable_select
			radio_group.prune (current)
			radio_group.put_front (current)
			-- First element of 'radio_group' is the one that is selected
		end

	disable_select
			-- Unselect 'Current'
		do
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected.
		do
			Result := radio_group.first = current
			-- First element of 'radio_group' is the one that is selected
		end

feature {EV_ANY_I} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a select action sequence.
		do
			create Result.default_create
		end

feature {EV_ANY_I} -- Implementation

	widget_object (a_list: POINTER): POINTER
			-- Returns c_object relative to a_list data.
		do
		end

	radio_group: LINKED_LIST [like current]
			-- List of all radio item implementations
		do
		end


	interface: EV_TOOL_BAR_RADIO_BUTTON;
			-- Interface of `Current'

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
end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP

