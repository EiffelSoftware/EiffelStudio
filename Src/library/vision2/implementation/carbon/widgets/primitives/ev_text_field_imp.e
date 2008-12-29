note
	description: "EiffelVision text field. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_FIELD_IMP

inherit
	EV_TEXT_FIELD_I
		redefine
			interface,
			hide_border
		end

	EV_PRIMITIVE_IMP
		undefine
			initialize,
			default_key_processing_blocked
		redefine
			interface,
			on_key_event,
			minimum_height,
			minimum_width,
			on_event
		end

	EV_TEXT_COMPONENT_IMP
		redefine
			interface,
			create_change_actions,
			on_key_event,
			set_minimum_width_in_characters,
			minimum_height,
			minimum_width,
			initialize,
			on_event
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

	EV_TEXT_FIELD_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES}
				return_actions_internal
		redefine
			create_return_actions
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	EV_CARBON_EVENTABLE
		redefine
			on_event
		end

create
	make

feature {NONE} -- Initialization

		make (an_interface: like interface)
			-- Create Textfield on a user_pane
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

			rect.set_left (4)
			rect.set_right (102)
			rect.set_bottom (20)
			rect.set_top (4)
			ret := create_edit_unicode_text_control_external (null,rect.item, null,0, NULL, $entry_widget)
			ret := set_control_data_boolean (entry_widget, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontroledittextsinglelinetag, true)

			ret := hiview_set_visible_external (entry_widget, 1)
			ret := hiview_add_subview_external (c_object, entry_widget)
			text_binding (entry_widget)

			event_id := app_implementation.get_id (current)
		end


	initialize
			-- `Precursor' initialization,
			-- create button box to hold label and pixmap.
		local
			target, h_ret: POINTER
			a_font: EV_FONT
		do
	--		Precursor {EV_TEXT_COMPONENT_IMP}
			event_id := app_implementation.get_id (current)
			target := get_control_event_target_external( entry_widget )
			h_ret := app_implementation.install_event_handler (event_id, target, {CARBONEVENTS_ANON_ENUMS}.keventclasstextinput, {CARBONEVENTS_ANON_ENUMS}.keventtextinputunicodeforkeyevent )
			expandable := false
			create a_font.default_create
			a_font.set_height (12)
			set_font (a_font)
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
					
					LayoutInfo.binding.right.toView = NULL;
					LayoutInfo.binding.right.kind = kHILayoutBindRight;
					LayoutInfo.binding.right.offset = 0;
					
					LayoutInfo.binding.top.toView = NULL;
					LayoutInfo.binding.top.kind = kHILayoutBindTop;
					LayoutInfo.binding.top.offset = 4;
					
					HIViewSetLayoutInfo( $a_control, &LayoutInfo );
					HIViewApplyLayout( $a_control );
				}
			]"
		end

feature -- Access

	text: STRING_32
			-- Text displayed in field.
		local
			ret, size: INTEGER
			str: C_STRING
		do

			ret := get_control_data_size_external (entry_widget, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlEditTextTextTag, $size)
			create str.make_empty (size)
			ret := get_control_data_external (entry_widget, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlEditTextTextTag, size, str.item, $size)
			Result := str.string
		end

feature -- Status setting

	set_minimum_width_in_characters (nb: INTEGER)
			-- Make `nb' characters visible on one line.
		local
			ret : INTEGER
			size : CGSIZE_STRUCT
			rect : CGRECT_STRUCT
		do
			create rect.make_new_unshared
			ret := hiview_get_frame_external (c_object, rect.item)

			create size.make_shared (rect.size)

			-- maximum_character_width should be implemented
			--size.set_width ((nb + 1) * maximum_character_width)

			size.set_width (100)
			rect.set_size (size.item)
			ret := hiview_set_frame_external (c_object, rect.item)
		end

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			str: C_STRING
			ret: INTEGER
		do
			create str.make (a_text)
			ret := set_control_data_external (entry_widget, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlEditTextTextTag, a_text.count, str.item)

		end

	append_text (a_text: STRING_GENERAL)
			-- Append `a_text' to the end of the text.
		do
		end

	prepend_text (a_text: STRING_GENERAL)
			-- Prepend `a_text' to the end of the text.
		do
		end

	set_capacity (len: INTEGER)
			-- Set the maximum number of characters that `Current' can hold to `len'.
		do

		end

	capacity: INTEGER
			-- Return the maximum number of characters that the
			-- user may enter.
		do

		end

	align_text_left
			-- Make text left aligned.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_left
		end

	align_text_right
			-- Make text right aligned.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_right
		end

	align_text_center
			-- Make text center aligned.
		do
			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center
		end

feature -- Status Report

	text_alignment: INTEGER
		-- Text alignment of `Current'.

	caret_position: INTEGER
			-- Current position of the caret.
		do

		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	create_return_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create an initialize return actions for `Current'.
		do
			create Result
		end

feature
	minimum_height: INTEGER
			local
				a_rect: CGRECT_STRUCT
				a_size: CGSIZE_STRUCT
				ret: INTEGER
			do
				create a_rect.make_new_unshared
				create a_size.make_shared (a_rect.size)
				ret := hiview_get_optimal_bounds_external (entry_widget, a_rect.item, null)
				Result := a_size.height.rounded + 8
				if Result < 0 then
					Result := 0
				end
				--io.put_string ("Result height: " + Result.out)

			end

	minimum_width: INTEGER
			local
				a_rect: CGRECT_STRUCT
				a_size: CGSIZE_STRUCT
				ret: INTEGER
			do
				create a_rect.make_new_unshared
				create a_size.make_shared (a_rect.size)
				ret := hiview_get_optimal_bounds_external (entry_widget, a_rect.item, null)
				Result := a_size.width.rounded + 8
				if Result <= 0 then
					Result := 50
				end
			end


feature -- Status report

	is_editable: BOOLEAN
			-- Is the text editable.
		do
			Result := (get_control_data_boolean (entry_widget, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlEditTextLockedTag) = 0)

		end

	has_selection: BOOLEAN
			-- Is something selected?


		do

		end

	selection_start: INTEGER
			-- Index of the first character selected.
		do


		end

	selection_end: INTEGER
			-- Index of the last character selected.
		do

		end

	clipboard_content: STRING_32
			-- `Result' is current clipboard content.
		do

		end

feature -- status settings

	hide_border
			-- Hide the border of `Current'.
		do

		end

	set_editable (a_editable: BOOLEAN)
			-- Set editable state to `a_editable'.
		local
			ret: INTEGER
		do
			ret := set_control_data_boolean (entry_widget, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontrolentirecontrol, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlEditTextLockedTag, not a_editable)

		end

	set_caret_position (pos: INTEGER)
			-- Set the position of the caret to `pos'.
		do

		end

feature -- Basic operation

	insert_text (txt: STRING_GENERAL)
			-- Insert `txt' at the current position.
		do

		end

	insert_text_at_position (txt: STRING_GENERAL; a_pos: INTEGER)
			-- Insert `txt' at the current position at position `a_pos'
		do

		end

	select_region (start_pos, end_pos: INTEGER)
			-- Select (highlight) the text between
			-- 'start_pos' and 'end_pos'.
		do

		end

	select_from_start_pos (start_pos, end_pos: INTEGER)
			-- Hack to select region from change actions
		do

		end

	deselect_all
			-- Unselect the current selection.
		do

		end

	delete_selection
			-- Delete the current selection.
		do

		end

	cut_selection
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do

		end

	copy_selection
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do

		end

	paste (index: INTEGER)
			-- Insert the string which is in the
			-- Clipboard at the `index' position in the
			-- text.
			-- If the Clipboard is empty, it does nothing.
		do

		end

feature {EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE
		do
			create Result
		end

	stored_text: STRING_32
			-- Value of 'text' prior to a change action, used to compare
			-- between old and new text.


	on_change_actions
			-- A change action has occurred.
		local
			new_text: STRING_32
		do
			new_text := text
			if not in_change_action and then (stored_text /= Void and then not new_text.is_equal (stored_text)) or else stored_text = Void then
					-- The text has actually changed
				in_change_action := True
				if change_actions_internal /= Void then

					change_actions_internal.call (Void)
				end
				in_change_action := False
				stored_text := text
			end

		end

	in_change_action: BOOLEAN
		-- Is `Current' in the process of calling `on_change_actions'

	last_key_backspace: BOOLEAN
		-- Was the last key pressed a backspace, used for select region hack for EiffelStudio.

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN)
			-- A key event has occurred
		do
			if a_key_press then
				if a_key /= Void then
					last_key_backspace := a_key.code = {EV_KEY_CONSTANTS}.key_back_space
				end
			end
			Precursor {EV_TEXT_COMPONENT_IMP} (a_key, a_key_string, a_key_press)
		end

feature {NONE} -- Implementation


on_event (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER
			-- Feature that is called if an event occurs
		local
			event_class, event_kind: INTEGER
			ret, length: INTEGER
			a_string: C_STRING
			a_key: EV_KEY
		do
				event_class := get_event_class_external (a_inevent)
				event_kind := get_event_kind_external (a_inevent)
				if event_kind = {CARBONEVENTS_ANON_ENUMS}.keventtextinputunicodeforkeyevent and event_class =  {CARBONEVENTS_ANON_ENUMS}.keventclasstextinput then
					ret := call_next_event_handler_external (a_inhandlercallref, a_inevent)

					ret := get_event_parameter_external (a_inevent, kEventParamTextInputSendText, typeUnicodeText, null, 0, $length, NULL)
					create a_string. make_empty (length)
					ret := get_event_parameter_external (a_inevent, kEventParamTextInputSendText, typeUnicodeText, null, length, null, a_string.item)

					create a_key.default_create
					on_key_event (a_key, a_string.string.as_string_32, true)

					on_change_actions
					Result := {EV_ANY_IMP}.noErr -- event handled
				else

					Result := Precursor {EV_TEXT_COMPONENT_IMP} (a_inhandlercallref, a_inevent, a_inuserdata)

				end
		end


	frozen typeUnicodeText: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"typeUnicodeText"
	end

	frozen kEventParamTextInputSendText: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kEventParamTextInputSendText"
	end


	entry_widget: POINTER
		-- A pointer on the text field

	visual_widget: POINTER
			-- Pointer to the widget shown on screen.
		do
			Result := c_object
		end

feature {EV_TEXT_FIELD_I} -- Implementation

	interface: EV_TEXT_FIELD;
			--Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_TEXT_FIELD_IMP

