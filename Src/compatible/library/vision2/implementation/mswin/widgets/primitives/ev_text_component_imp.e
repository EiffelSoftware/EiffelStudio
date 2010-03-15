note
	description: "EiffelVision text component. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXT_COMPONENT_IMP

inherit
	EV_TEXT_COMPONENT_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			set_default_minimum_size,
			interface,
			initialize,
			wel_background_color,
			wel_foreground_color,
			background_color,
			default_process_message
		end

	EV_TEXT_COMPONENT_ACTION_SEQUENCES_IMP

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current'.
		do
			wel_set_font ((create {WEL_SHARED_FONTS}).gui_font)
			Precursor {EV_PRIMITIVE_IMP}
		end

	set_default_minimum_size
			-- Called after creation. Set current size and
			-- notify parent.
		do
			ev_set_minimum_size (
				maximum_character_width * 4, internal_font_height +
				total_vertical_padding)
		end

	total_vertical_padding: INTEGER = 9
		-- Number of pixels to be added to height of font used internally,
		-- to give us minimum height of `Current'.

	internal_font_height: INTEGER
			-- `Result' is height of font used by `Current'.
		deferred
		end

feature -- Status report

	is_editable: BOOLEAN
			-- Is text editable?
		do
			Result := not read_only
		end

feature {EV_ANY, EV_ANY_I} -- Status report

	caret_position: INTEGER
			-- Current position of caret.
		do
			Result := internal_caret_position + 1
		end

	selection_start: INTEGER
			-- Index of first character selected.
		do
			Result := wel_selection_start + 1
		end

	selection_end: INTEGER
			-- Index of last character selected.
		do
			Result := wel_selection_end
		end

feature {EV_ANY_I}-- Status setting

	set_editable (flag: BOOLEAN)
				-- If `flag' then make `Current' editable else
				-- make `Current' component read-only.
			do
				if flag then
					set_read_write
				else
					set_read_only
				end
			end

	set_caret_position (pos: INTEGER)
			-- set current caret position.
			--| This position is used for insertions.
		do
				-- We store `pos' so caret position can be restored
				-- after operations that should not move caret, but do.
			internal_set_caret_position (pos - 1)
		end

	set_capacity (value: INTEGER)
			-- Make `value' new maximal length in characters of text.
		do
			set_text_limit (value)
		end

	capacity: INTEGER
			-- Return maximum number of characters `Current' may hold.
		do
			Result := get_text_limit
		end

feature {EV_ANY_I}-- element change

	insert_text (txt: STRING_GENERAL)
			-- Insert `txt' at `caret_position'.
		local
			temp_text: STRING_32
			previous_caret_position: INTEGER
		do
			previous_caret_position := internal_caret_position
			temp_text := text
			if caret_position > temp_text.count then
				temp_text.append (txt)
			else
				temp_text.insert_string (txt, caret_position)
			end
			set_text (temp_text)
			internal_set_caret_position (previous_caret_position)
		end

	append_text (txt:STRING_GENERAL)
			-- Append 'txt' to text of `Current'.
		local
			temp_text: STRING_32
			previous_caret_position: INTEGER
		do
			previous_caret_position := internal_caret_position
			temp_text := text
			temp_text.append (txt)
			set_text (temp_text)
			internal_set_caret_position (previous_caret_position)
		end

	prepend_text (txt: STRING_GENERAL)
			-- Prepend 'txt' to text of `Current'.
		local
			temp_text: STRING_32
			previous_caret_position: INTEGER
		do
			previous_caret_position := internal_caret_position
			temp_text :=  text
			temp_text.prepend (txt)
			set_text (temp_text)
			internal_set_caret_position (previous_caret_position)
		end

	maximum_character_width: INTEGER
			-- `Result' is width of widest character (W), when displayed.
		local
			screen_dc: WEL_SCREEN_DC
			extent: WEL_SIZE
		do
			create screen_dc
			screen_dc.get
			screen_dc.select_font ((create {WEL_SHARED_FONTS}).gui_font)
			extent := screen_dc.string_size ("W")
			screen_dc.unselect_font
			screen_dc.quick_release
			Result := extent.width
		end

feature {EV_ANY_I} -- Resizing

	set_minimum_width_in_characters (nb: INTEGER)
			-- Make a minimum of `nb' characters visible on one line.
		do
			set_minimum_width (nb * maximum_character_width)
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER)
			-- Select (hilight) text between
			-- 'start_pos' and 'end_pos'
		local
			actual_start, actual_end: INTEGER
		do
			if start_pos < end_pos then
				actual_start := start_pos - 1
				actual_end := end_pos
			else
				actual_start := start_pos
				actual_end := end_pos - 1
			end
			set_selection (actual_start, actual_end)
		end

	paste (index: INTEGER)
			-- Insert string which is in Clipboard at
			-- `index' postion in text.
			-- If Clipboard is empty, it does nothing.
		local
			pos: INTEGER
		do
			pos := caret_position
			set_caret_position (index)
			clip_paste
			if pos <= index then
				set_caret_position (pos)
			else
				set_caret_position (pos + clipboard_content.count)
			end
		end

	wel_set_font (a_wel_font: WEL_FONT)
			-- Assign `a_wel_font' to font of `Current'.
		deferred
		end

feature {NONE} -- Deferred features

	internal_caret_position: INTEGER
			-- Caret position.
		deferred
		end

	internal_set_caret_position (a_position: INTEGER)
			-- Set caret position with `a_position'.
		deferred
		end

	set_selection (start_position, end_position: INTEGER)
			-- Set selection between `start_position'
			-- and `end_position'.
		deferred
		end

	set_text_limit (value: INTEGER)
			-- Make `value' new maximal length of text.
		deferred
		end

	get_text_limit: INTEGER
			-- Result is maximum text length.
		deferred
		end

	read_only: BOOLEAN
			-- Is `current' edit control read-only?
		deferred
		end

	set_read_only
			-- Set `Current' read only.
		deferred
		end

	set_read_write
			-- Set `Current' read/write.
		deferred
		end

	clip_paste
			-- Paste at current caret position
			-- content of clipboard.
		deferred
		end

	wel_font: WEL_FONT
			-- Font of `Current'.
		deferred
		end

	wel_selection_start: INTEGER
		deferred
		end

	wel_selection_end: INTEGER
		deferred
		end

	wel_background_color: WEL_COLOR_REF
		do
			Result := background_color_imp
			if Result = Void then
				create Result.make_rgb (255, 255, 255)
			end
		end

	wel_foreground_color: WEL_COLOR_REF
		do
			Result := foreground_color_imp
			if Result = Void then
				create Result.make_rgb (0, 0, 0)
			end
		end

	background_color: EV_COLOR
			-- Color used for the background of `Current'.
			-- This has been redefined as the background color of
			-- text components is white, or `Color_read_write' by default.
		do
			if background_color_imp /= Void then
				Result ?= background_color_imp.interface
			else
				if is_sensitive then
					Result := (create {EV_STOCK_COLORS}).Color_read_write
				else
					Result := (create {EV_STOCK_COLORS}).color_read_only
				end
			end
		end

feature {EV_PICK_AND_DROPABLE_IMP, EV_INTERNAL_COMBO_FIELD_IMP} -- Implementation

	override_context_menu: BOOLEAN
		-- Should the context menu be overridden, so
		-- it is not displayed?

	disable_context_menu
			-- Assign `True' to `override_context_menu'.
			-- This will stop the context menu appearing, the
			-- next time that `allow_pick_and_drop' is executed.
		do
			override_context_menu := True
		end

	enable_context_menu
			-- Assign `False' to `override_context_menu'.
		do
			override_context_menu := False
		end

feature {NONE} -- Implementation

	default_process_message (msg: INTEGER; wparam, lparam: POINTER)
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do

			if msg = ({WEL_WINDOW_CONSTANTS}.Wm_contextmenu) then
				allow_pick_and_drop
			else
				Precursor {EV_PRIMITIVE_IMP} (msg, wparam, lparam)
			end
		end

	allow_pick_and_drop
			-- Override context menu on `Current' if pick and drop
			-- should be handled instead. We must handle two cases :-
			-- 1. We are attempting to pick from `Current'.
			-- 2. We are attempting to drop from `Current'.
		do
			if application_imp.pick_and_drop_source /= Void then
				disable_default_processing
			elseif pebble /= Void then
				disable_default_processing
			elseif override_context_menu then
				disable_default_processing
			end
			enable_context_menu
		end

	clipboard_content: STRING_32
			-- `Result' is current clipboard content.
		local
			edit_control: WEL_SINGLE_LINE_EDIT
		do
			create edit_control.make (Default_parent, "", 0, 0, 0, 0, 0)
			edit_control.clip_paste
			Result := edit_control.text
			edit_control.destroy
		end

feature {NONE} -- interface

	interface: EV_TEXT_COMPONENT;

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




end -- class EV_TEXT_COMPONENT_IMP

