note
	description:
		"Eiffel Vision separator. Carbon implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SEPARATOR_IMP

inherit
	EV_SEPARATOR_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			make,
			interface,
			minimum_height,
			minimum_width
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
			rect.set_right (20)
			rect.set_bottom (20)
			ret := create_user_pane_control_external ( default_pointer, rect.item, {CONTROLS_ANON_ENUMS}.kcontrolsupportsembedding, $ptr )
			set_c_object ( ptr )
			ret := create_separator_control_external ( null, rect.item, $ptr )
			ret := hiview_add_subview_external ( c_object, ptr )
			setup_binding ( c_object, ptr )

			event_id := app_implementation.get_id (current)
		end

feature -- Layout handling

	setup_binding ( user_pane, progress_bar : POINTER )
			-- Setup layout binding. This is redefined by vertical/horizontal separator to make sure the control has the right orientation
		deferred
		end

	minimum_height, minimum_width: INTEGER
			-- Minimum height/width that the widget may occupy.
		do
			Result := 1 -- Hardcoded value
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SEPARATOR;

note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_SEPARATOR_IMP

