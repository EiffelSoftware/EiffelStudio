note
	description: "Eiffel Vision Progress bar. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR_IMP

inherit
	EV_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			interface,
			make,
			initialize,
			on_event
		end

feature {NONE} -- Implementation

	make (an_interface: like interface)
			-- Create the progress bar.
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
			err := create_progress_bar_control_external (default_pointer, rect.item, 0, 0, 100, 0, $gauge_ptr )
			err := hiview_add_subview_external ( c_object, gauge_ptr )
			setup_binding ( c_object, gauge_ptr )

			event_id := app_implementation.get_id (current)
		end

	initialize
		local
			h_ret, target : POINTER
		do
			Precursor
			target := get_control_event_target_external( c_object )
			h_ret := app_implementation.install_event_handler (event_id, target, {CARBONEVENTS_ANON_ENUMS}.kEventClassControl, {CARBONEVENTS_ANON_ENUMS}.keventcontrolboundschanged )
			current_style := -1
		end

feature -- Status report

	is_segmented: BOOLEAN
			-- Is display animated ?
		do
			Result := get_control_data_boolean ( gauge_ptr, {CONTROLS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolprogressbaranimatingtag )
		end

feature -- Status setting

	enable_segmentation
			-- Display bar is animated
		local
			err : INTEGER
		do
			err := set_control_data_boolean( gauge_ptr, {CONTROLS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolprogressbaranimatingtag,  true )
		end

	disable_segmentation
			-- Display bar is not animated
		local
			err : INTEGER
		do
			err := set_control_data_boolean( gauge_ptr, {CONTROLS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolprogressbaranimatingtag,  false )
		end

feature {NONE} -- Implementation

	setup_binding ( user_pane, progress_bar : POINTER )
			-- setup layout binding
		deferred
		end

	set_style_large
			-- set the large progressbar style
		local
			err : INTEGER
			data : INTEGER_16
		do
			data := {CONTROLS_ANON_ENUMS}.kcontrolsizelarge.to_integer_16
			err := set_control_data_external ( gauge_ptr, {CONTROLS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLS_ANON_ENUMS}.kControlSizeTag, 2, $data ) -- 2 = sizeof(INTEGER_16)			
			current_style :=  {CONTROLS_ANON_ENUMS}.kcontrolsizelarge
		end

	set_style_small
			-- set the small progressbar style
		local
			err : INTEGER
			data : INTEGER_16
		do
			data := {CONTROLS_ANON_ENUMS}.kcontrolsizenormal.to_integer_16
			err := set_control_data_external ( gauge_ptr, {CONTROLS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLS_ANON_ENUMS}.kControlSizeTag, 2, $data ) -- 2 = sizeof(INTEGER_16)			
			current_style :=  {CONTROLS_ANON_ENUMS}.kcontrolsizenormal
		end

	current_style : INTEGER

feature {NONE} -- Implementation

	on_event (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER
			-- Feature that is called if an event occurs
		local
			event_class, event_kind : INTEGER_32
			actual_type, actual_size : INTEGER_32
			err : INTEGER
			prev_rect, cur_rect : CGRECT_STRUCT
			attributes : INTEGER_32
		do
				event_class := get_event_class_external (a_inevent)
				event_kind := get_event_kind_external (a_inevent)

				if event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassControl and event_kind =  {CARBONEVENTS_ANON_ENUMS}.keventcontrolboundschanged then
					create prev_rect.make_new_unshared
					create cur_rect.make_new_unshared
					err := get_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamattributes, {AEDATA_MODEL_ANON_ENUMS}.typeWildCard, $actual_type, 4, $actual_size, $attributes ) -- 4 = sizeof(INTEGER_32)
					err := get_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamoriginalbounds, {CARBONEVENTS_ANON_ENUMS}.typehirect, $actual_type, prev_rect.sizeof, $actual_size, prev_rect.item )
					err := get_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamcurrentbounds, {CARBONEVENTS_ANON_ENUMS}.typehirect, $actual_type, cur_rect.sizeof, $actual_size, cur_rect.item )
					bounds_changed ( attributes, prev_rect, cur_rect )
					Result := noErr -- Event handled
				else
					Result := {CARBON_EVENTS_CORE_ANON_ENUMS}.eventnothandlederr
				end
		end

	bounds_changed ( options : INTEGER; original_bounds, current_bounds : CGRECT_STRUCT )
			-- Handler for the bounds changed event
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PROGRESS_BAR;

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




end -- class EV_PROGRESS_BAR_IMP

