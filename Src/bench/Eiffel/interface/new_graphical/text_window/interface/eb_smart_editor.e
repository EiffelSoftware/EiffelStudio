indexing
	description: "[
		Advanced editor for Eiffel Studio.
		Completes syntax automatically.
		Includes tool to make basic eiffel text clickable.
	]"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SMART_EDITOR

inherit
	EB_CLICKABLE_EDITOR
		export
			{ANY} highlight_selected, first_line_displayed
			{EB_COMPLETION_CHOICE_WINDOW} Editor_preferences
		redefine
			handle_extended_key,
			handle_extended_ctrled_key, 
			handle_character, reset,
			on_mouse_button_down,
			on_double_click,
			process_text, load_file,
			load_text, reload, 
			initialize_customizable_commands,
			basic_cursor_move,
			text_displayed,
			recycle	,
			file_loading_setup,
			key_not_handled_action,
			on_text_saved
		end	

create
	make

feature -- Content change

	set_text (s: STRING) is
			-- load text represented by `s' in the editor
			-- text is considered edited after load, i.e. save command
			-- is sensitive.
			-- `file_name' is left unchanged.
		local
			f_n: FILE_NAME
			f_d, f_d_c: INTEGER
		do
			f_n := file_name
			f_d := date_of_file_when_loaded
			f_d_c := date_when_checked
			load_eiffel_text (s)
			text_displayed.on_text_edited (False)
			file_name := f_n
			date_of_file_when_loaded := f_d
			date_when_checked := f_d_c
		end

	process_text (str_text: STRUCTURED_TEXT) is
			-- Load the text `str_text' in the editor.
		do
			if (not load_without_save) and then changed then
				load_without_save := True
				dev_window.save_and (~process_text (str_text))
			else
				{EB_CLICKABLE_EDITOR} Precursor (str_text)
			end
			load_without_save := False
		end

	reload is
			-- Reload the file named `file_name' in the editor.
		do
			load_without_save := True
			{EB_CLICKABLE_EDITOR} Precursor
		end

feature -- Status report

	click_and_complete_is_active: BOOLEAN is
			-- If in the basic text format, is the text clickable?
		do
			Result := text_displayed.current_class_is_clickable and then allow_edition and then not open_backup
		end

	syntax_is_correct: BOOLEAN is
			-- When text was parsed, was a syntax error found?
		do
			Result := text_displayed.click_tool_status /= text_displayed.syntax_error
		end

	load_without_save: BOOLEAN
			-- Check and save file before loading a new content?

	exploring_current_class: BOOLEAN is
			-- Is the current class being explored by the click tool?
		do
			Result := text_displayed.exploring_current_class
		end

feature -- Status setting

	no_save_before_next_load is
			-- Disable check before next loading.
		do
			load_without_save := True
		end

feature -- Search

	find_feature_named (a_name: STRING) is
			-- Look for a feature named `a_name' in the text and 
			-- scroll to the corresponding line.
		require
			text_is_fully_loaded
		do
			text_displayed.find_feature_named (a_name)
			if text_displayed.found_feature then
				set_first_line_displayed (text_displayed.current_line_number.min (maximum_top_line_index), True)
				refresh_now
			end
		end	

	found_feature: BOOLEAN is
			-- Was last searched feature name found?
		do
			Result := text_displayed.found_feature
		end

feature {EB_COMMAND} -- Commands

	complete_word is
			-- Autocomplete feature name before cursor.
		local
			add_point: BOOLEAN
		do
			switch_auto_point  := False
			if click_and_complete_is_active and then not has_selection then
				add_point := auto_point and then auto_point_token = text_displayed.cursor.token and then text_displayed.cursor.pos_in_token = 1
				text_displayed.prepare_auto_complete (add_point)
				if text_displayed.completion_possibilities /= Void then
					completion_mode := completion_mode + 1
					show_completion_list
				end
			end
			check_cursor_position			
		end

	embed_in_block (keyword: STRING; pos_in_keyword: INTEGER) is
			-- Embed selection or current line in block formed by `keyword' and "end".
			-- Cursor is positioned to the `pos_in_keyword'-th caracter of `keyword'.
		do
			if is_editable then
				text_displayed.embed_in_block (keyword, pos_in_keyword)
				refresh_now
				check_cursor_position
			end
		end

feature -- Autocomplete

	update_click_list (after_save: BOOLEAN) is
			-- update the click tool
			-- `after_save' must be True if current class text has just been saved
			-- and False otherwise.
		do
			if dev_window.stone /= Void and then text_displayed.click_tool_enabled then
				text_displayed.update_click_list (dev_window.stone, after_save)
				process_click_tool_error
			end
		end

feature {NONE} -- Text loading

	file_loading_setup is
			-- Setup editor just before file loading begins.
		do
			text_displayed.enable_click_tool
			text_displayed.setup_click_tool (dev_window.stone, not is_unix_file)
			process_click_tool_error
		end

	reset is
			-- Make the editor ready to load a new content.
		do
			{EB_CLICKABLE_EDITOR} Precursor
			completion_mode := 0
		end

feature {NONE} -- Process Vision2 events

	on_mouse_button_down (abs_x_pos, y_pos, button: INTEGER; unused1, unused2, unused3: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Process single click on mouse buttons.
		do
			completion_mode := 0
			{EB_CLICKABLE_EDITOR} Precursor (abs_x_pos, y_pos, button, unused1, unused2, unused3, a_screen_x, a_screen_y)
		end

	on_double_click (abs_x_pos, y_pos, button: INTEGER; unused1, unused2, unused3: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Process double clicks on mouse buttons 
		do
			completion_mode := 0
			{EB_CLICKABLE_EDITOR} Precursor (abs_x_pos, y_pos, button, unused1, unused2, unused3, a_screen_x, a_screen_y)
		end

feature {NONE} -- Handle keystokes

	handle_extended_key (ev_key: EV_KEY) is
 			-- Process the push on an extended key.
		local
			t: EDITOR_TOKEN_KEYWORD
			code: INTEGER
			token: EDITOR_TOKEN
			syntax_completed: BOOLEAN
		do
			code := ev_key.code
			switch_auto_point := auto_point and then not (code = Key_shift or code = Key_left_meta or code = Key_right_meta)
			if code = Key_tab and then completion_mode > 0 then
					-- Tab action
				run_if_editable (~tab_action)

			elseif code = Key_enter and then not has_selection then
					-- Return/Enter key action
				completion_mode := 0
				if is_editable then
					token := text_displayed.cursor.token
					if token /= Void then 
						if latest_typed_word_is_keyword then
							t ?= token.previous
							if t /= Void and then keyword_image (t).is_equal (previous_token_image) then
								text_displayed.complete_syntax (previous_token_image, True, True)
								syntax_completed := text_displayed.syntax_completed
								latest_typed_word_is_keyword := false
							end
						else
							t ?= token.previous
							if t /= Void and then text_displayed.cursor.pos_in_token = 1 then
								text_displayed.complete_syntax (keyword_image (t), False, True)
								syntax_completed := text_displayed.syntax_completed
							end
						end
					end

					if syntax_completed then
						check_cursor_position
						refresh_now
					else
						{EB_CLICKABLE_EDITOR} Precursor (ev_key)
					end
				else
					display_not_editable_warning_message
				end
			else
				if completion_mode > 0 then
					if code /= Key_back_space then
						completion_bckp := completion_mode
						completion_mode := 0
					end
					Precursor (ev_key)
					completion_bckp := 0
				else
					Precursor (ev_key)
					completion_mode := 0
				end
			end
			auto_point := switch_auto_point xor auto_point
		end

	completion_bckp: INTEGER

	handle_extended_ctrled_key (ev_key: EV_KEY) is
 			-- Process the push on Ctrl + an extended key.
		local
			code: INTEGER
		do
			code := ev_key.code
			switch_auto_point := auto_point and then not (code = Key_ctrl or code = Key_shift or code = Key_left_meta or code = Key_right_meta)
			if code = Key_i then
				if not shifted_key then
					if is_editable then
						embed_in_block ("if  then", 3)
					end
				end
			elseif code = Key_d then
				if not shifted_key then
					if is_editable then
						embed_in_block ("debug", 5)
					end
				end
			else
				Precursor (ev_key)
					-- if `auto_point' is true, user has called auto complete
					-- we don't change the value. Else, its new value is set to False unless
					-- only ctrl key was pressed
			end
			auto_point := auto_point xor switch_auto_point
		end
			
	key_not_handled_action is
			-- Apply default key processing.
		do
			completion_mode := completion_bckp
		end

 	handle_character (c: CHARACTER) is
 			-- Process the push on a character key.
		local
			t: EDITOR_TOKEN_KEYWORD
			token: EDITOR_TOKEN
			look_for_keyword: BOOLEAN
			insert: CHARACTER
			syntax_completed: BOOLEAN
			cur: EDITOR_CURSOR
 		do
			switch_auto_point := auto_point
			if is_editable then
				if has_selection then
					Precursor (c)
				else
					Precursor (c)
					look_for_keyword := True
					if c = ' ' then
						if latest_typed_word_is_keyword then
							cur := clone (text_displayed.cursor)
							cur.go_left_char
							token := cur.token
							if token /= Void then
								t ?= token.previous
								if t /= Void and then keyword_image(t).is_equal (previous_token_image) then
									text_displayed.back_delete_char
									text_displayed.complete_syntax (previous_token_image, True, False)
									syntax_completed := text_displayed.syntax_completed
									look_for_keyword := False
									latest_typed_word_is_keyword := False
								end
							end
						else
							token := text_displayed.cursor.token
							if text_displayed.cursor.line.eol_token = token then
									-- case: keyword|space|eol
								if token.previous /= Void and then token.previous.length = 1 then
									t ?= token.previous.previous
								end
							elseif token /= Void then
									-- case: keyword|space|space|...
								if text_displayed.cursor.pos_in_token = 2 then
									t ?= token.previous
								end
							end
							if t /= Void then
								text_displayed.back_delete_char
								look_for_keyword := False
								text_displayed.complete_syntax (keyword_image (t), False, False)
								syntax_completed := text_displayed.syntax_completed
								look_for_keyword := False
							end
						end
						if syntax_completed then
							refresh
						end
					else
						insert := complementary_character (c)
						if insert /= '%U' then
							text_displayed.insert_char (insert)
							text_displayed.cursor.go_left_char
							invalidate_cursor_rect (True)
						end
					end
					if look_for_keyword then
						if text_displayed.cursor.token /= Void then
							t ?= text_displayed.cursor.token.previous
						end
						latest_typed_word_is_keyword := (t /= Void) and then text_displayed.cursor.pos_in_token = 1
						if latest_typed_word_is_keyword then
							previous_token_image := keyword_image (t)
						end
					end
				end
			else
				display_not_editable_warning_message
			end
			auto_point := switch_auto_point xor auto_point
		end

	basic_cursor_move (action: PROCEDURE[EDITOR_CURSOR,TUPLE]) is
			-- Perform a basic cursor move such as go_left,
			-- go_right, ... an example of agent `action' is
			-- cursor~go_left_char.
		do
			{EB_CLICKABLE_EDITOR} Precursor (action)
			switch_auto_point := False
		end

	tab_action is
			-- Process push on tab key when in auto_complete mode.
		local
			x,y: INTEGER
			cursor: EDITOR_CURSOR
		do
			from
				cursor := text_displayed.cursor
			until 
				cursor.item = '(' or cursor.item = ';' or cursor.item = ')'
			loop
				cursor.go_right_char
			end
			if cursor.item = ')' then
				if has_selection then
					disable_selection
				end
				completion_mode := (completion_mode - 1).max (0)
				cursor.go_right_char
			else
				if cursor.item = ';' then
					text_displayed.replace_char (',')
				end
				cursor.go_right_char
				from
					x := cursor.x_in_characters
					y := cursor.y_in_lines
				until 
					cursor.item = ';' or cursor.item = ')' or else cursor.token = cursor.line.eol_token
				loop
					cursor.go_right_char
				end
				text_displayed.selection_cursor.make_from_character_pos (cursor.x_in_characters, cursor.y_in_lines, text_displayed)
				cursor.set_y_in_lines (y)
				cursor.set_x_in_characters (x)
				if not has_selection and not cursor.is_equal (text_displayed.selection_cursor) then
					text_displayed.enable_selection
				end
			end
			invalidate_cursor_rect (True)
		end

feature {EB_COMPLETION_CHOICE_WINDOW} -- automatic completion

	exit_complete_mode is
			-- Set mode to normal (not completion mode).
		do
			completion_mode := (completion_mode - 1).max (0)
		end

	complete_from_window (completed: STRING; is_feature_signature: BOOLEAN) is
			-- Insert `completed' in the editor and switch to completion mode.
		do
			auto_point := False
			if completed.is_empty then
				completion_mode := (completion_mode - 1).max (0)
				--history.unbind_current_item_to_next
			else
				text_displayed.complete_feature_call (completed, is_feature_signature)
				if is_feature_signature then
					if completed.last_index_of (')',completed.count) = completed.count then
			--			completion_mode := completion_mode + 1
						tab_action
					else
						completion_mode := (completion_mode - 1).max (0)
						switch_auto_point := False
						auto_point := True
						auto_point_token := text_displayed.cursor.token
					end
				else
					completion_mode := (completion_mode - 1).max (0)
				end
			end
			refresh
		end

feature {NONE} -- Autocomplete implementation

	show_completion_list is
			-- Show list of possible features after a point.
		local
			choices: EB_COMPLETION_CHOICE_WINDOW
			w_height, w_width: INTEGER
			y_pos: INTEGER
			x_pos: INTEGER
			tok: EDITOR_TOKEN
			cursor: EDITOR_CURSOR
		do
			create choices.make_with_editor (Current, text_displayed.feature_name_part_to_be_completed, text_displayed.completion_possibilities)
			if choices.show_needed then
				cursor := text_displayed.cursor
				tok := cursor.token
				tok.update_position
				x_pos := tok.position + tok.get_substring_width (cursor.pos_in_token)
				x_pos := widget.screen_x + x_pos + left_margin_width + 5 - offset
				y_pos := widget.screen_y + (cursor.y_in_lines - first_line_displayed)*line_height
				y_pos := y_pos + (line_height - choices.to_be_inserted.height) // 2
--! FIXME : screen_* are null after show on GTK
				w_height := dev_window.window.height + dev_window.window.screen_y - y_pos - 20
				w_width := dev_window.window.width + dev_window.window.screen_x - x_pos - 20
				invalidate_cursor_rect (True)
				choices.set_position (x_pos, y_pos)
				choices.show
				choices.set_minimum_size (w_width, w_height)
				choices.to_be_inserted.set_focus
			end
		end

	completion_mode: INTEGER
			-- Are we in auto_complete mode?
			
	auto_point: BOOLEAN
			-- Should autocomplete add `.' next time it is called?

	switch_auto_point: BOOLEAN
			-- Should `auto_point' have the opposite value?

	auto_point_token: EDITOR_TOKEN
			-- Point where autocomplete should add a period.

feature {NONE} -- syntax completion

	latest_typed_word_is_keyword: BOOLEAN
			-- Is the preceeding token a keyword?

	previous_token_image: STRING
			-- Image of the previous token

	keyword_image (token: EDITOR_TOKEN_KEYWORD): STRING is
			-- Image of keyword beginning by `token'.
		local
			test: STRING
			kw: like token
			blnk: EDITOR_TOKEN_BLANK
			tok: EDITOR_TOKEN
			is_else, is_then: BOOLEAN
		do
			Result := clone (token.image)
			test := clone (Result)
			test.to_lower
			is_else := test.is_equal ("else")
			is_then := test.is_equal ("then")
			if is_else or is_then then
				from
					blnk ?= token.previous
				until
					blnk = Void
				loop
					tok := blnk.previous
					blnk ?= tok
				end
				kw ?= tok
				if kw /= Void then
					if is_else then
						test := clone (kw.image)
						test.to_lower
						if test.is_equal ("or") then
							Result.prepend ("or ")
						elseif test.is_equal ("require") then
							Result.prepend ("require ")
						end
					elseif is_then then
						test := clone (kw.image)
						test.to_lower
						if test.is_equal ("and") then
							Result.prepend ("and ")
						elseif test.is_equal ("ensure") then
							Result.prepend ("ensure ")
						end
					end
				end
			end	
		end

feature {EB_EDITOR_TOOL} -- Implementation

	on_text_saved is
			-- 
		do
			Precursor {EB_CLICKABLE_EDITOR}
			if syntax_error_dialog /= Void and then not syntax_error_dialog.is_destroyed then
				syntax_error_dialog.destroy
			end
			syntax_error_dialog := Void
		end

feature {NONE} -- Implementation

	text_displayed: SMART_TEXT
			-- Displayed text.

	process_click_tool_error is
			-- Show warning corresponding to `click_tool' error.
		do
			if text_displayed.click_tool_status = text_displayed.class_name_changed then
				show_warning_message (Warning_messages.w_Class_name_changed)
			elseif text_displayed.click_tool_status = text_displayed.syntax_error then
				show_syntax_warning
			end
		end

	complementary_character (c:CHARACTER): CHARACTER is
			-- Character complementary to `c', i.e. closing bracket
			-- for an opening one for instance.
		do
			Result := '%U'
			if Editor_preferences.autocomplete_brackets_and_parenthesis then
				inspect
					c
				when '%<' then
					Result := '%>'
				when '(' then
					Result := ')'
				when '%(' then
					Result := '%)'
				else
				end
			end
			if Editor_preferences.autocomplete_quotes then
				inspect
					c
				when '%'' then
					Result := '%''
				when '%Q' then
					Result := '%''
				when '%"' then
					Result := '%"'
				else
				end
			end
		end

	initialize_customizable_commands is
			-- Create array of customizable commands.
		do
			create customizable_commands.make (1, 9)
			customizable_commands.put (~complete_word, 1)
			customizable_commands.put (~search, 2)
			customizable_commands.put (~replace, 3)
			customizable_commands.put (~find_selection, 4)
			customizable_commands.put (~find_next, 5)
			customizable_commands.put (~find_previous, 6)
			customizable_commands.put (~insert_customized_string (1), 7)
			customizable_commands.put (~insert_customized_string (2), 8)
			customizable_commands.put (~insert_customized_string (3), 9)
		end

	insert_customized_string (index: INTEGER) is
			-- 
		do
			text_displayed.insert_customized_expression (Editor_preferences.customized_strings.item (index))
			refresh_now
		end
		

	show_syntax_warning is
			-- Display syntax error warning message
			-- and highlight error.
		require
			syntax_error: not syntax_is_correct
			dev_window_is_not_void: dev_window /= Void
		local
			syn_error: SYNTAX_ERROR
			start_pos, stop_pos: INTEGER
			txt: STRING
			retried: BOOLEAN
			fl: RAW_FILE
		do
			if text_is_fully_loaded then
				if retried then
					show_warning_message (Warning_messages.w_Cannot_read_file (file_name))
				else
					deselect_all
					syn_error := text_displayed.last_syntax_error
					text_displayed.clear_syntax_error
					if file_name /= Void and syn_error /= Void then
						create fl.make_open_read (file_name)
						fl.read_stream (fl.count)
						fl.close
						txt := fl.last_string
--! FIXME : problem with unix files on windows
						if platform_is_windows then
							start_pos := syn_error.start_position + 1 - txt.substring (1, syn_error.start_position + 1).occurrences ('%N')
							stop_pos := syn_error.end_position + 1 - txt.substring (1, syn_error.end_position + 1).occurrences ('%N')
							highlight_when_ready (start_pos, stop_pos)
						else
							highlight_when_ready (syn_error.start_position + 1, syn_error.end_position + 1)
						end
						show_syntax_error
					end
				end
			else
				after_reading_text_actions.extend(~show_syntax_warning)
			end
		rescue
			retried := True
			retry
		end
		
	show_syntax_error is
			-- 
		do
			if syntax_error_dialog = Void or else syntax_error_dialog.is_destroyed then
				create syntax_error_dialog.make_with_text (Warning_messages.w_Syntax_error)
				syntax_error_dialog.show_relative_to_window (reference_window)
			end
		end
		
	syntax_error_dialog: EV_WARNING_DIALOG
	
	load_file (a_file_name: FILE_NAME) is
			-- Load file named `a_file_name' in the editor.
		do
			if (not load_without_save) and then changed then
				load_without_save := True
				dev_window.save_and (~load_file (a_file_name))
			else
				{EB_CLICKABLE_EDITOR} Precursor (a_file_name)
			end
			load_without_save := False
		end

	load_text (s: STRING) is
			-- Load text represented by `s' in the editor.
		do
			if (not load_without_save) and then changed then
				load_without_save := True
				dev_window.save_and (~load_text (s))
			else
				{EB_CLICKABLE_EDITOR} Precursor (s)
			end
			load_without_save := False
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			Precursor {EB_CLICKABLE_EDITOR}
			dev_window := Void
		end

invariant

	not is_editable implies not text_displayed.click_and_complete_is_active

end -- class SMART_EDITOR
