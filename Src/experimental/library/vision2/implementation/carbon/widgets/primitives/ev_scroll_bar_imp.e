note
	description: "Eiffel Vision scrollbar. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SCROLL_BAR_IMP

inherit
	EV_SCROLL_BAR_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		undefine
			minimum_height,
			minimum_width
		redefine
			interface,
			make
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create the separator control.
		local
			rect: RECT_STRUCT
			ptr: POINTER
			ret: INTEGER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_right (16)
			rect.set_bottom (16)
			ret := create_user_pane_control_external ( default_pointer, rect.item, {CONTROLS_ANON_ENUMS}.kcontrolsupportsembedding, $ptr )
			set_c_object ( ptr )
			ret := create_scroll_bar_control_external ( null, rect.item, 0, 0, 100, 0, 0, null, $gauge_ptr )
			ret := hiview_add_subview_external ( c_object, gauge_ptr )
			setup_binding ( c_object, gauge_ptr )

			event_id := app_implementation.get_id (current)
		end

feature -- Layout handling

	setup_binding ( user_pane, progress_bar : POINTER )
			-- Setup layout binding. This is redefined by vertical/horizontal separator to make sure the control has the right orientation
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SCROLL_BAR;

note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_SCROLL_BAR_IMP

