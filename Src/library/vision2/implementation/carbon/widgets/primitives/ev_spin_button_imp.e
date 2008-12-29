note
	description: "Eiffel Vision spin button. Carbon Implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPIN_BUTTON_IMP

inherit
	EV_SPIN_BUTTON_I
		undefine
			hide_border
		redefine
			interface
		end

	EV_GAUGE_IMP
		undefine
			on_key_event,
			default_key_processing_blocked,
			on_focus_changed,
			on_event,
			value,
			set_value,
			set_range
		redefine
			interface,
			initialize,
			make,
			dispose,
			minimum_width,
			minimum_height
		end

	EV_TEXT_FIELD_IMP

		rename
			create_change_actions as create_text_change_actions,
			change_actions as text_change_actions,
			change_actions_internal as text_change_actions_internal
		redefine
			make,
			interface,
			initialize,
			minimum_width,
			minimum_height,
			set_text,
			dispose,
			on_event,
			on_change_actions,
			text_binding
		end
	EV_CARBON_EVENTABLE
		redefine
			on_event
		end
	EVENTS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	MACWINDOWS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Implementation

	make (an_interface: like interface)
			-- Create the spin button.
			-- There is no control like this in carbon. It's probably best to take
			-- a text-field and a little-arrow control to do the same
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_left (0)
			rect.set_right (106)
			rect.set_bottom (26)
			rect.set_top (0)
			ret := create_user_pane_control_external ( null, rect.item, {CONTROLS_ANON_ENUMS}.kControlSupportsEmbedding, $c_object )

			rect.set_left (84)
			rect.set_right (104)
			rect.set_bottom (24)
			rect.set_top (4)
			ret := create_little_arrows_control_external ( null, rect.item, 0, 0, 100, 1, $gauge_ptr )

			rect.set_left (4)
			rect.set_right (82)
			rect.set_bottom (20)
			rect.set_top (4)
			ret := create_edit_unicode_text_control_external (null,rect.item, null,0, NULL, $entry_widget)
			ret := set_control_data_boolean (entry_widget, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontroledittextsinglelinetag, true)


			ret := hiview_set_visible_external (gauge_ptr, 1)
			ret := hiview_set_visible_external (entry_widget, 1)
			ret := hiview_add_subview_external (c_object, entry_widget)
			text_binding (entry_widget)
			ret := hiview_add_subview_external (c_object, gauge_ptr)
			gauge_binding (gauge_ptr)
			setup_binding (entry_widget, gauge_ptr)


			event_id := app_implementation.get_id (current)
		end

	initialize
		local
			target, h_ret: POINTER
		do

			Precursor {EV_TEXT_FIELD_IMP}
			ev_gauge_imp_initialize --| {EV_GAUGE} Precursor
			target := get_control_event_target_external( gauge_ptr )
			h_ret := app_implementation.install_event_handler (event_id, target, {CARBONEVENTS_ANON_ENUMS}.kEventClassControl, {CARBONEVENTS_ANON_ENUMS}.kEventMouseDown )
			set_text (internal_value.out)
			expandable := false

		end

	value: INTEGER
			-- Current value of the gauge.
		do
			--if text /= void and then text.is_integer_32 then
			--	Result := text.to_integer
			--else
			--	Result := ((value_range.upper + value_range.lower) /2).rounded
			--end

			Result := internal_value
		end

feature {NONE}--binding

		text_binding (a_control : POINTER)
			-- What does this do?
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					HILayoutInfo LayoutInfo;
					LayoutInfo.version = kHILayoutInfoVersionZero;
					HIViewGetLayoutInfo ($a_control, &LayoutInfo);
										
					LayoutInfo.binding.left.toView = NULL;
					LayoutInfo.binding.left.kind = kHILayoutBindLeft;
					LayoutInfo.binding.left.offset = 4;
					
					LayoutInfo.binding.top.toView = NULL;
					LayoutInfo.binding.top.kind = kHILayoutBindTop;
					LayoutInfo.binding.top.offset = 0;
					
					HIViewSetLayoutInfo( $a_control, &LayoutInfo );
					HIViewApplyLayout( $a_control );
				}
			]"
		end

			gauge_binding (a_control : POINTER)
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					HILayoutInfo LayoutInfo;
					LayoutInfo.version = kHILayoutInfoVersionZero;
					HIViewGetLayoutInfo ($a_control, &LayoutInfo);									
					
					LayoutInfo.binding.right.toView = NULL;
					LayoutInfo.binding.right.kind = kHILayoutBindRight;
					LayoutInfo.binding.right.offset = 2;
					
					LayoutInfo.binding.top.toView = NULL;
					LayoutInfo.binding.top.kind = kHILayoutBindTop;
					LayoutInfo.binding.top.offset = 0;
					
					HIViewSetLayoutInfo( $a_control, &LayoutInfo );
					HIViewApplyLayout( $a_control );
				}
			]"
		end

		setup_binding ( left_control, right_control : POINTER )
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					HILayoutInfo LayoutInfo;
					LayoutInfo.version = kHILayoutInfoVersionZero;
					HIViewGetLayoutInfo( $left_control, &LayoutInfo );
					
					
					if ( $right_control != NULL )
					{
						// Bind to right control (maintain padding)
						LayoutInfo.binding.right.toView = $right_control;
						LayoutInfo.binding.right.kind = kHILayoutBindLeft;
						LayoutInfo.binding.right.offset = 0;
					}
					else
					{
						// for leftmost control
						LayoutInfo.position.x.toView = NULL;
						LayoutInfo.position.x.kind = kHILayoutPositionLeft;
						LayoutInfo.position.x.offset = 0.0;
					}
					HIViewSetLayoutInfo( $left_control, &LayoutInfo );
					HIViewApplyLayout( $left_control );
				}
			]"
		end


feature -- Element change

	set_value (a_value: INTEGER)
			-- Set `value' to `a_value'.
		do
			internal_value := a_value
			set_text (a_value.out)
		ensure then
			step_same: step = old step
			leap_same: leap = old leap
			range_same: value_range.is_equal (old value_range)
		end

	set_range
			-- Update widget range from `value_range'
		local
			temp_value: INTEGER
		do
			temp_value := value
			if temp_value > value_range.upper then
				temp_value := value_range.upper
			elseif temp_value < value_range.lower then
				temp_value := value_range.lower
			end

			set_value ( temp_value )
		end


feature {NONE} -- Implementation

	on_change_actions
			do
				gauge_change_actions
			 	precursor {EV_TEXT_FIELD_IMP}
			end


	gauge_change_actions
			-- A change action has occurred.
		local
			a_data: TUPLE [INTEGER_32]
		do
				if change_actions_internal /= Void then
					create a_data.default_create
					a_data.put (value, 1)
					change_actions_internal.call (a_data)
				end
		end

	on_event (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER
			-- Feature that is called if an event occurs
		local
			event_class, event_kind : INTEGER
			ret, part : INTEGER
		do
				event_class := get_event_class_external (a_inevent)
				event_kind := get_event_kind_external (a_inevent)

				if event_kind = {CARBONEVENTS_ANON_ENUMS}.kEventMouseDown then
					ret := get_event_parameter_external (a_inevent, kEventParamControlPart, {CARBONEVENTS_ANON_ENUMS}.typecontrolpartcode, null, 32, NULL, $part );
					if part = kControlUpButtonPart then
						step_forward
					elseif part = kControlDownButtonPart then
						step_backward
					end
					gauge_change_actions
					Result := {EV_ANY_IMP}.noErr -- event handled
				else

					Result := precursor {EV_TEXT_FIELD_IMP}(a_inhandlercallref, a_inevent, a_inuserdata)
				end
		end

	frozen kEventParamControlPart: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kEventParamControlPart"
	end

		frozen kControlDownButtonPart: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kControlDownButtonPart"
	end
		frozen kControlUpButtonPart: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kControlUpButtonPart"
	end

	minimum_height: INTEGER_32
			do
				Result := 26
				--Result := Precursor {EV_GAUGE_IMP} + Precursor {EV_TEXT_FIELD_IMP}
			end

	minimum_width: INTEGER_32
			do
				--Ueli: Hardcoded for Widgets Example
				Result := 50
				--Result := Precursor {EV_GAUGE_IMP} + Precursor {EV_TEXT_FIELD_IMP}
			end



	dispose
			do
				precursor {EV_TEXT_FIELD_IMP}
				precursor {EV_GAUGE_IMP}
			end


	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		do
			precursor {EV_TEXT_FIELD_IMP} (a_text)
		end

	internal_value : INTEGER


feature {EV_ANY_I} -- Implementation

	interface: EV_SPIN_BUTTON;

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_SPIN_BUTTON_IMP

