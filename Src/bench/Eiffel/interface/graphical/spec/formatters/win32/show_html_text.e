indexing
	description: "Command to display text. No warning or watch cursor.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_HTML_TEXT  

inherit
	SHOW_TEXT
		redefine
			format
		end

	EB_CONSTANTS

creation
	make

feature -- format

	format (stone: STONE) is
			-- Show text of `stone' in `text_window'
		local
			stone_text, class_name: STRING;
			filed_stone: FILED_STONE;
			classc_stone: CLASSC_STONE;
			e_class: E_CLASS;
			class_tool: CLASS_W;
			modified_class: BOOLEAN;
			retried: BOOLEAN;
			same_stone, error: BOOLEAN;
			mp: MOUSE_PTR;
			cur: CURSOR;
			routine_w: ROUTINE_W;
			st: STRUCTURED_TEXT
		do
			if not retried then
				classc_stone ?= stone;
				if classc_stone /= Void and then classc_stone.is_valid then
					e_class := classc_stone.e_class;
					modified_class := not e_class.is_precompiled and then
						e_class.lace_class.date_has_changed and then	not e_class.has_syntax_error
				end
				if
					do_format or filtered or modified_class or else
					(tool.last_format.associated_command /= Current or
					stone /= Void and then not stone.same_as (tool.stone))
				then
					if stone /= Void and then stone.is_valid then
						same_stone := stone.same_as (tool.stone);
						display_temp_header (stone);
						!! mp.set_watch_cursor;
						stone_text := stone.origin_text;
						if stone_text = Void then
							stone_text := "";
							filed_stone ?= stone;
							if filed_stone /= Void then
								if filed_stone.file_name /= Void then
									error := true;
									warner (popup_parent).gotcha_call 	
									(Warning_messages.w_Cannot_read_file (filed_stone.file_name))
								else
									error := true;
									warner (popup_parent).gotcha_call 
										(Warning_messages.w_No_associated_file)
								end;
							end			
						end;
						class_tool ?= tool;
						if 
							class_tool /= Void and then (
							(same_stone and tool.last_format = class_tool.showclick_frmt_holder) or
							(do_format and tool.last_format.associated_command = Current))
						then
							cur := text_window.cursor
						else
							text_window.set_cursor_position (0)
							cur := text_window.cursor
						end;
						text_window.clear_window;
						tool.set_editable_text;
						filed_stone ?= stone;
						if filed_stone = Void then
							tool.set_file_name (Void);
						else
							tool.set_file_name (file_name (filed_stone));
						end;
						tool.set_stone (stone);
						routine_w ?= tool;
						if 	
							routine_w /= Void and then
							routine_w.stone.e_feature.written_class.lace_class.hide_implementation
						then
							st := rout_flat_context_text (routine_w.stone);
							text_window.process_text (st);
							text_window.display
						else	
							text_window.set_text (stone_text)
						end;
						tool.update_save_symbol;
						if stone.clickable then
							if modified_class then
								if not error and not do_format then
										-- Do not display the warning message
										-- if the format has been changed
										-- internally (resynchronization, ...)
									class_name := classc_stone.e_class.name;
									error := true;
									warner (popup_parent).gotcha_call 
										(Warning_messages.w_Class_modified (class_name))
								end
							elseif st = Void then
								text_window.update_clickable_from_stone (stone)
							end
						end;

						text_to_html (text_window)

						if cur /= Void then
							text_window.go_to (cur)
						end;

						tool.set_mode_for_editing;
						tool.show_editable_text;

						if routine_w /= Void then
							routine_w.highlight_routine
						end
						tool.set_last_format (holder);
						display_header (stone);
						mp.restore
					end;
					filtered := false
				end
			else
				!! mp.do_nothing;
				mp.restore
				warner (popup_parent).gotcha_call (Warning_messages.w_Cannot_retrieve_info);
			end
		rescue
			if original_exception = Io_exception then
					-- We probably don't have the read permissions
					-- on the server files.
				retried := true;
				retry
			end
		end;

feature {NONE}

	text_to_html (window: like TEXT_WINDOW) is
			-- Underlined the names of the classes and
			-- the names of the features
		local
			g_window: GRAPHICAL_TEXT_WINDOW
			click_item: CLICK_STONE
			click_array: ARRAY [CLICK_STONE]
			i: INTEGER
			count: INTEGER
			top_position: INTEGER
		do
			if general_resources.browsing_facilities.actual_value then
				g_window ?= window
				if g_window /= Void then
					click_array ?= g_window
					if click_array /= Void then
						from
							i := click_array.lower
							count := click_array.upper
							g_window.set_changed (True)
							g_window.implementation.hide_selection
							top_position := g_window.implementation.top_character_position
						until
							i > count or else click_array.item (i) = Void
						loop
							click_item := click_array.item (i)
							g_window.implementation.wel_set_selection (click_item.start_position, click_item.end_position)
							g_window.implementation.set_character_format_word (g_window.html_format);
							i := i + 1
						end
						g_window.implementation.set_top_character_position (top_position)
						g_window.implementation.wel_set_selection (top_position, top_position)
						g_window.implementation.show_selection
						g_window.set_changed (False)
					end
				end
			end
		end

end -- SHOW_HTML_TEXT
