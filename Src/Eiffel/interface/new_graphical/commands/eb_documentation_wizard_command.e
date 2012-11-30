note
	description: "Launch the documentation wizard"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DOCUMENTATION_WIZARD_COMMAND

inherit
	EB_MENUABLE_COMMAND

	ES_SHARED_OUTPUTS
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make
			-- Initialize `Current'.
		do
			enable_sensitive
		end

feature -- Access

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with '&' symbol).
		do
			Result := Interface_names.m_Generate_documentation
		end

feature -- Execution

	execute
			-- Start documentation wizard.
		do
			create wizard
			wizard.finish_button.select_actions.extend (agent generate)
			wizard.start
		end

feature {NONE} -- Implementation

	generate
			-- Generate documentation with options in `wizard'.
		require
			wizard_not_void: wizard /= Void
		local
			doc: DOCUMENTATION
			retried, l_dir_created: BOOLEAN
			l_str: STRING_32
			l_formatter: like compiler_formatter
		do
			if not retried then
				create doc.make
				doc.set_filter (wizard.filter)
				doc.set_universe (wizard.documentation_universe)
				doc.set_directory (wizard.directory)
				l_dir_created := True
				doc.set_excluded_indexing_items (wizard.excluded_indexing_items)
				doc.set_cluster_formats (
					wizard.cluster_charts_selected,
					wizard.cluster_diagrams_selected
				)
				doc.set_system_formats (
					wizard.class_list_selected,
					wizard.cluster_list_selected,
					wizard.cluster_hierarchy_selected
				)
				if wizard.cluster_diagrams_selected then
					doc.set_diagram_views (wizard.diagram_views)
				end

				if attached compiler_output as l_output then
					l_output.lock
					l_output.clear
					l_output.activate (preferences.development_window_data.outputs_tool_prompted)
				end
				l_formatter := compiler_formatter

				window_manager.display_message ("")
				l_str := interface_names.l_documentation_generated_in (wizard.directory.path.name)
				doc.generate (Degree_output)
				l_formatter.add_string (l_str)
				l_formatter.add_new_line
				window_manager.display_message (l_str)

				if attached compiler_output as l_output then
					l_output.unlock
				end
			end
		rescue
			if not l_dir_created then
				(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt ((create {WARNING_MESSAGES}).w_invalid_directory_or_cannot_be_created (wizard.directory.path.name), Void, Void)
			elseif doc.target_file_name /= Void then
				(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt ((create {WARNING_MESSAGES}).w_Cannot_create_file (doc.target_file_name.name), Void, Void)
			end
			Error_handler.error_list.wipe_out
			retried := True
			retry
		end

	wizard: EB_DOCUMENTATION_WIZARD;
		-- Documentation option dialog.

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
