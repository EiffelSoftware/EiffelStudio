note
	description:
		"Eiffel Vision button. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "press, push, label, pixmap"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BUTTON_IMP

inherit
	EV_BUTTON_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			make,
			set_foreground_color,
			on_focus_changed,
			on_event
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface,
			initialize,
			internal_set_pixmap,
			internal_remove_pixmap
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			initialize,
			set_text
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			initialize
		end

	EV_BUTTON_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES} select_actions_internal
		redefine
			interface
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Connect interface and initialize `c_object'.
		local
			ret: INTEGER
			rect: RECT_STRUCT;
			ptr: POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared

			--rect.set_right(100)
			--rect.set_left (0)
			--rect.set_top (0)
			--rect.set_bottom(20)
			ret := create_push_button_control_external( null, rect.item, null, $c_object )
		end

	initialize
			-- `Precursor' initialization,
			-- create button box to hold label and pixmap.
		local
			target, h_ret: POINTER
		do
			pixmapable_imp_initialize
			Precursor {EV_PRIMITIVE_IMP}
			initialize_events
		--	event_id := app_implementation.get_id (current)
		--	target := get_control_event_target_external( c_object )
		--	h_ret := app_implementation.install_event_handler (event_id, target, {CARBONEVENTS_ANON_ENUMS}.kEventClassControl, {CARBONEVENTS_ANON_ENUMS}.kEventMouseDown )
		end

feature -- Access

	is_default_push_button: BOOLEAN
			-- Is this button currently a default push button
			-- for a particular container?
		do
			Result := get_control_data_boolean ( c_object, {CONTROLS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlPushButtonDefaultTag )
		end

feature -- Status Setting


	enable_default_push_button
			-- Set the style of the button corresponding
			-- to the default push button.
		local
			res : INTEGER
		do
			res := set_control_data_boolean( c_object, {CONTROLS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlPushButtonDefaultTag, true  )
		end

	disable_default_push_button
			-- Remove the style of the button corresponding
			-- to the default push button.
		local
			res : INTEGER
		do
			res := set_control_data_boolean( c_object, {CONTROLS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlPushButtonDefaultTag, false  )
		end

	enable_can_default
			-- Allow the style of the button to be the default push button.
		do
			 -- doesn't seem to be necessary in Carbon.
		end

	set_foreground_color (a_color: EV_COLOR)
		do
		end

	set_text (a_str: STRING_GENERAL)
			local
				ret: INTEGER
			do
				Precursor {EV_TEXTABLE_IMP}(a_str)
				ret := set_control_title_with_cfstring_external (c_object, real_text.item)
			end



feature {NONE} -- implementation

	internal_set_pixmap (a_pixmap_imp: EV_PIXMAP_IMP; a_width, a_height: INTEGER)
			--
		local
			ret: INTEGER
		do


		end

	internal_remove_pixmap
			-- Remove pixmap from Current
		do
		end

	set_carbon_button_picture (incontrol, inpic: POINTER): INTEGER
			-- set a boolean value with set_control_data
		do
		end

	on_focus_changed (a_has_focus: BOOLEAN)
			-- Called from focus intermediary agents when focus for `Current' has changed.
			-- if `a_has_focus' then `Current' has just received focus.
		do
		end

	on_event (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER
			-- Feature that is called if an event occurs
		local
			event_class, event_kind : INTEGER
		do
				event_class := get_event_class_external (a_inevent)
				event_kind := get_event_kind_external (a_inevent)

				if event_kind = {CARBONEVENTS_ANON_ENUMS}.kEventMouseDown and event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassControl then
					select_actions.call (void)
					Result := noErr -- event handled
					--io.put_string ("Actions in queue" + select_actions.count.out)
				else
					Result := Precursor {EV_PRIMITIVE_IMP} (a_inhandlercallref, a_inevent, a_inuserdata)
				end
		end

feature {EV_ANY_I} -- implementation

	interface: EV_BUTTON;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'



note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_BUTTON_IMP
