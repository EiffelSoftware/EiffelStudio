note
	description: "Formatter that uses an editor as its display"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_EDITOR_FORMATTER

inherit
	EB_FORMATTER
		undefine
			veto_pebble_function
		redefine
			displayer,
			is_editor_formatter
		end

feature -- Access

	editor: EB_CLICKABLE_EDITOR
			-- Output editor.
		do
			if displayer /= Void then
				Result := displayer.editor
			end
		ensure then
			good_result: displayer /= Void implies Result = displayer.editor
		end

	new_editor (a_dev_window: EB_DEVELOPMENT_WINDOW; a_drop_actions: EV_PND_ACTION_SEQUENCE): like editor
			-- New Editor
		do
			create Result.make (a_dev_window)
			Result.widget.set_border_width (1)
			Result.widget.set_background_color ((create {EV_STOCK_COLORS}).gray)
			Result.disable_line_numbers
			Result.drop_actions.append (a_drop_actions)
		ensure
			result_attached: Result /= Void
		end

	displayer_generator: TUPLE [any_generator: FUNCTION [ANY, TUPLE, like displayer]; name: STRING]
			-- Generator to generate proper `displayer' for Current formatter
		do
			Result := [agent displayer_generators.new_editor_displayer, displayer_generators.editor_displayer]
		end

	control_bar: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Possible area to display a tool bar
		do
		end

	displayer: EB_FORMATTER_EDITOR_DISPLAYER
			-- Displayer used to display results of Current formatter

feature -- Status report

	is_editor_formatter: BOOLEAN
			-- Is Current formatter based on an editor?
		do
			Result := True
		end

feature -- Setting

	setup_viewpoint
			-- Setup viewpoint for formatting.
		do
			if viewpoints /= Void and then editor /= Void and then editor.text_displayed /= Void then
				editor.text_displayed.set_context_group (viewpoints.current_viewpoint)
			end
		end

	set_editor_displayer (a_displayer: like displayer)
			-- Set `a_displayer' with `a_displayer'.
		do
			displayer := a_displayer
		end

feature -- Positioning

	go_to_position
			-- Save manager position and go to position in `editor' if possible.
		local
			l_line_stone: LINE_STONE
			l_feature_stone: FEATURE_STONE
		do
			save_manager_position
			if
				selected and then
				stone /= Void and then
				stone.pos_container = current and then
				stone.position > 0
			then
				l_line_stone ?= stone
				if l_line_stone /= Void then
					editor.display_line_at_top_when_ready (l_line_stone.line_number, l_line_stone.column_number)
				else
					l_feature_stone ?= stone
					if l_feature_stone /= Void then
						editor.display_line_at_top_when_ready (l_feature_stone.line_number, 0)
					else
						editor.display_line_at_top_when_ready (1, 0)
					end
				end
			end
		end

note
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

end
