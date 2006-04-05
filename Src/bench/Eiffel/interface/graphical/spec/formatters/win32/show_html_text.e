indexing
	description: "Command to display text. No warning or watch cursor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SHOW_HTML_TEXT  

inherit
	SHOW_TEXT
		redefine
			format
		end

	EB_CONSTANTS

	WEL_ECO_CONSTANTS

create
	make

feature -- format

	format (stone: STONE) is
			-- Show text of `stone' in `text_window'
		local
			stone_text, class_name: STRING
			filed_stone: FILED_STONE
			classc_stone: CLASSC_STONE
			e_class: CLASS_C
			class_tool: CLASS_W
			modified_class: BOOLEAN
			retried: BOOLEAN
			same_stone, error: BOOLEAN
			mp: MOUSE_PTR
			cur: CURSOR
			st: STRUCTURED_TEXT
		do
			class_tool ?= tool
			if class_tool /= Void then
				if not retried then
					classc_stone ?= stone
					if classc_stone /= Void and then classc_stone.is_valid then
						e_class := classc_stone.e_class
						modified_class := not e_class.is_precompiled and then
							e_class.lace_class.date_has_changed and then not e_class.has_syntax_error
					end
					if
						do_format or filtered or modified_class or else
						(class_tool.last_format.associated_command /= Current or
						stone /= Void and then not stone.same_as (class_tool.stone))
					then
						if stone /= Void and then stone.is_valid then
							same_stone := stone.same_as (class_tool.stone)
							display_temp_header (stone)
							create mp.set_watch_cursor
							stone_text := stone.origin_text
							if stone_text = Void then
								stone_text := ""
								filed_stone ?= stone
								if filed_stone /= Void then
									error := true
									if filed_stone.file_name /= Void then
										warner (popup_parent).gotcha_call 	
											(Warning_messages.w_Cannot_read_file (filed_stone.file_name))
									else
										warner (popup_parent).gotcha_call 
											(Warning_messages.w_No_associated_file)
									end
								end			
							end
							if 
								(same_stone and class_tool.last_format = class_tool.showclick_frmt_holder)
								or else (do_format and class_tool.last_format.associated_command = Current)
							then
								cur := text_window.cursor
							end

							text_window.clear_window
							class_tool.set_editable_text
							filed_stone ?= stone
							if filed_stone = Void then
								class_tool.set_file_name (Void)
							else
								class_tool.set_file_name (file_name (filed_stone))
							end
							class_tool.set_stone (stone)
							text_window.set_text (stone_text)

							if cur /= Void then
								text_window.go_to (cur)
							else
								text_window.set_top_character_position (0)
							end

							class_tool.update_save_symbol
							if stone.clickable then
								if modified_class then
									if not error and not do_format then
											-- Do not display the warning message
											-- if the format has been changed
											-- internally (resynchronization, ...)
										class_name := classc_stone.e_class.name
										error := true
										warner (popup_parent).gotcha_call 
											(Warning_messages.w_Class_modified (class_name))
									end
								elseif st = Void then
									class_tool.update_clickable_format (classc_stone.e_class)
								end
							end

							text_to_html (text_window)

							class_tool.set_mode_for_editing
							class_tool.show_editable_text

							class_tool.set_last_format (holder)
							display_header (stone)
							mp.restore
						end
						filtered := false
					end
				else
					warner (popup_parent).gotcha_call (Warning_messages.w_Cannot_retrieve_info)
				end
			end
		rescue
			if original_exception = Io_exception then
					-- We probably don't have the read permissions
					-- on the server files.
				retried := true
				retry
			end
		end

feature {NONE}

	text_to_html (window: like TEXT_WINDOW) is
			-- Underlined the names of the classes and
			-- the names of the features
		local
			g_window: GRAPHICAL_TEXT_WINDOW
			imp: SCROLLED_T_IMP
			html_format: WEL_CHARACTER_FORMAT
			click_item: CLICK_STONE
			click_array: ARRAY [CLICK_STONE]
			i: INTEGER
			count: INTEGER
			top_position: INTEGER
			new_options, old_options: INTEGER
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
							imp := g_window.implementation
							html_format := g_window.html_format

								--| Prepare the update and save old_values
							imp.hide_selection
							top_position := imp.top_character_position
							
								--| Get the old options of the window
								--| in order to put new ones which will makes
								--| the window not move
							old_options := imp.options
							new_options := Eco_selectionbar
							imp.set_options (Ecoop_set, new_options)

								--| For good looking update reasons, I'm going to the
								--| end of the text to avoid a anooying flashing
							imp.set_cursor_position (imp.count)

						until
							i > count or else click_array.item (i) = Void
						loop
							click_item := click_array.item (i)
							imp.wel_set_selection (click_item.start_position, click_item.end_position)
							imp.set_character_format_selection (html_format)
							i := i + 1
						end

							--| Restore the previous state of the window
						imp.wel_set_selection (top_position, top_position)
						imp.move_to_selection
						imp.set_options (Ecoop_set, old_options)
						imp.show_selection

							--| Enable updates
						g_window.set_changed (False)
					end
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- SHOW_HTML_TEXT
