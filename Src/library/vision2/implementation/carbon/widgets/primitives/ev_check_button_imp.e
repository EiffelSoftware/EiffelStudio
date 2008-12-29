note
	description: "EiffelVision check button, Carbon implementation."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_CHECK_BUTTON_IMP

inherit
	EV_CHECK_BUTTON_I
		redefine
			interface
		end

	EV_TOGGLE_BUTTON_IMP
		undefine
			default_alignment
		redefine
			make,
			interface,
			initialize,
			minimum_height,
			minimum_width
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a Carbon check button.
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			ret := create_check_box_control_external ( null, rect.item, null, 0, 1, $c_object )

			event_id := app_implementation.get_id (current)
		end

	initialize
			-- Initialize 'Current'
		do
			Precursor {EV_TOGGLE_BUTTON_IMP}
			align_text_left
		end

feature -- Minimum Size

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
			Result := 12
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

feature {EV_ANY_I}

	interface: EV_CHECK_BUTTON;


note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_CHECK_BUTTON_IMP

