note
	description: "Eiffel Vision range. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RANGE_IMP

inherit
	EV_RANGE_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			make,
			interface
		end

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create the range control.
		local
			rect : RECT_STRUCT
			struct_ptr : POINTER
			err : INTEGER
		do
			Precursor {EV_GAUGE_IMP} (an_interface)
			create rect.make_new_unshared
			rect.set_left(0)
			rect.set_right(20)
			rect.set_bottom(20)
			rect.set_top (0)
			err := create_user_pane_control_external ( default_pointer, rect.item, {CONTROLS_ANON_ENUMS}.kcontrolsupportsembedding, $struct_ptr )
			set_c_object ( struct_ptr )
			err := create_slider_control_external ( null, rect.item, 0, 0, 100, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlSliderPointsDownOrRight, 10, 0, null, $gauge_ptr )
			err := hiview_add_subview_external ( c_object, gauge_ptr )
			setup_binding ( c_object, gauge_ptr )

			event_id := app_implementation.get_id (current)
		end

feature -- Layout handling

	setup_binding ( user_pane, progress_bar : POINTER )
			-- Setup layout binding. This is redefined by vertical/horizontal range to make sure the control has the right orientation
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_RANGE;

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_RANGE_IMP

