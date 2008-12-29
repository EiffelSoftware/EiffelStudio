note
	description: "Eiffel Vision radio button. Carbon implementation."
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
				c_object
		undefine
			default_alignment
		redefine
			interface,
			make,
			initialize,
			minimum_height,
			minimum_width
		end

	EV_RADIO_PEER_IMP
		redefine
			interface,
			widget_object
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create radio button.
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			ret := create_radio_button_control_external ( null, rect.item, null, 0, 1, $ptr )
			set_c_object ( ptr )

			event_id := app_implementation.get_id (current)  --getting an id from the application
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

feature -- Minimum size

	minimum_height: INTEGER
			-- Minimum height that the widget may occupy.
		local
			err : INTEGER
			y: INTEGER
			rect: RECT_STRUCT
		do
			create rect.make_new_unshared
			err := get_best_control_rect_external ( c_object, rect.item, $y )
			Result := rect.bottom - rect.top
		end

	minimum_width: INTEGER
			-- Minimum width that the widget may occupy.
		local
			err : INTEGER
			y: INTEGER
			rect: RECT_STRUCT
		do
			create rect.make_new_unshared
			err := get_best_control_rect_external ( c_object, rect.item, $y )
			Result := rect.right - rect.left
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


feature {EV_ANY_I} -- Implementation

	interface: EV_RADIO_BUTTON;

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_RADIO_BUTTON_IMP

