indexing
	description	: "Tool where information warnings are displayed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_WARNINGS_TOOL

inherit
	EB_OUTPUT_TOOL
		redefine
			process_warnings, process_errors,
			is_general,
			title,
			title_for_pre,
			clear,
			attach_to_docking_manager,
			pixmap,
			build_docking_content,
			show
		end

create
	make

feature {NONE} -- Initialize

	build_docking_content (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Build docking content.
		do
			Precursor {EB_OUTPUT_TOOL}(a_docking_manager)
			content.drop_actions.extend (agent drop_class)
			content.drop_actions.extend (agent drop_feature)
		end

feature -- Docking management

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Attach to docking manager
		do
			build_docking_content (a_docking_manager)

			check friend_tool_created: develop_window.tools.errors_tool /= Void end
			check not_already_has: not a_docking_manager.has_content (content) end
			a_docking_manager.contents.extend (content)
		end

feature -- Basic Operations

	clear is
			-- Clear window
		do
			Precursor {EB_OUTPUT_TOOL}
			set_title (0)
		end

	process_errors (errors: LINKED_LIST [ERROR]) is
			-- Do nothing.
		do
		end

	process_warnings (warnings: LINKED_LIST [ERROR]) is
			-- Display contextual error information from `warnings'.
		local
			st: TEXT_FORMATTER
			retried_count: INTEGER
		do
			st := text_area.text_displayed
			if retried_count = 0 then
				text_area.handle_before_processing (false)
				if warnings.is_empty then
						-- There is no error in the list put a separation before the next message
					display_separation_line (st)
				end
				display_error_list (st, warnings)
				text_area.handle_after_processing
			else
				if retried_count = 1 then
						-- Most likely a failure in `display_error_list'.
					text_area.handle_before_processing (false)
					display_error_error (st)
					text_area.handle_after_processing
				else
						-- Here most likely a failure in `process_text', so
						-- we clear its content and only display the error message.
					clear
					text_area.handle_before_processing (false)
					display_error_error (st)
					text_area.handle_after_processing
				end
			end
			set_title (warnings.count)
		end

	show is
			-- Show tool.
		do
			Precursor {EB_OUTPUT_TOOL}
			if text_area /= Void and then not text_area.is_empty then
				text_area.editor_drawing_area.set_focus
			end
		end

feature {NONE} -- Implementation

	is_general: BOOLEAN is false;
			-- If current general output tool?

	title: STRING_GENERAL is
			-- Title
		local
			l_constants: EB_CONSTANTS
		do
			create l_constants
			Result := l_constants.interface_names.l_tab_warning_output
		end

	title_for_pre: STRING is
			-- Title
		local
			l_constants: EB_CONSTANTS
		do
			create l_constants
			Result := l_constants.interface_names.to_warning_tool
		end

	pixmap: EV_PIXMAP is
			-- Pixmap
		local
			l_constants: EB_CONSTANTS
		do
			create l_constants
			Result := l_constants.pixmaps.icon_pixmaps.tool_warning_icon
		end

	set_title (a_count: INTEGER) is
			-- Sets tool title base on `a_count' of warnings
		require
			content_created: content /= Void
			widget_attached: widget /= Void
		local
			l_name: STRING_GENERAL
			l_title: STRING_32
		do
			l_name := interface_names.l_tab_warning_output
			if a_count > 0 then
				create l_title.make (l_name.count + 6)
				l_title.append (l_name)
				l_title.append (" (")
				l_title.append_integer (a_count)
				l_title.append_character (')')
			else
				l_title := l_name.as_string_32
			end
			content.set_long_title (l_title)
			content.set_short_title (l_title)
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

end -- class EB_WARNING_OUTPUT_TOOL
