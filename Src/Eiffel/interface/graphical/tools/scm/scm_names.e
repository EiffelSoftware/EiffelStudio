note
	description: "Summary description for {SCM_NAMES}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_NAMES

inherit
	SHARED_LOCALE

feature -- Header

	header_status: STRING_32 do Result := locale.translation_in_context ("Status", "scm") end

	header_name: STRING_32 do Result := locale.translation_in_context ("Name", "scm") end

	header_folder: STRING_32 do Result := locale.translation_in_context ("Folder", "scm") end

	header_repository: STRING_32 do Result := locale.translation_in_context ("Repository", "scm") end

feature -- Menu

	menu_scm: STRING_32 do Result := locale.translation_in_context ("Source Control", "scm") end

	menu_status: STRING_32 do Result := locale.translation_in_context ("Update status", "scm") end

	menu_check: STRING_32 do Result := locale.translation_in_context ("Update status", "scm") end

	menu_editor_status (a_name: detachable READABLE_STRING_GENERAL; a_status: detachable READABLE_STRING_GENERAL): STRING_32
		do
			if a_name = Void or else a_name.is_whitespace then
				Result := menu_item_status (locale.translation_in_context ("Editor status", "scm"), a_status)
			else
				Result := menu_item_status (a_name, a_status)
			end
		end

	menu_file_outside_any_repository: STRING_32
		do
			Result := locale.translation_in_context ("Outside any repository.", "scm")
		end

	menu_item_status (a_item_name: detachable READABLE_STRING_GENERAL; a_status: detachable READABLE_STRING_GENERAL): STRING_32
		do
			if a_item_name = Void or else a_item_name.is_whitespace then
				Result := locale.formatted_string (
						locale.translation_in_context ("Status - $1", "scm"),
						[a_item_name]
					)
			elseif a_status = Void then
				Result := locale.formatted_string (
						locale.translation_in_context ("$1", "scm"),
						[a_item_name]
					)
			else
				Result := locale.formatted_string (
						locale.translation_in_context ("$1 - $2", "scm"),
						[a_item_name, a_status]
					)
			end
		end

	menu_add_to_changelist (a_name: detachable READABLE_STRING_GENERAL; a_count: INTEGER): STRING_32
		do
			if a_name = Void then
				Result := locale.translation_in_context ("Add to changelist", "scm")
			else
				Result := locale.formatted_string (locale.translation_in_context ("$1 ($2)", "scm"), [a_name, a_count])
			end
		end

	menu_diff: STRING_32 do Result := locale.translation_in_context ("Diff ...", "scm") end
	menu_diff_selection: STRING_32 do Result := locale.translation_in_context ("Diff selection ...", "scm") end
	menu_revert: STRING_32 do Result := locale.translation_in_context ("Revert ...", "scm") end
	menu_update: STRING_32 do Result := locale.translation_in_context ("Update ...", "scm") end

	menu_commit: STRING_32 do Result := locale.translation_in_context ("Commit ...", "scm") end
	menu_git_push: STRING_32 do Result := locale.translation_in_context ("Push ...", "scm") end
	menu_git_pull: STRING_32 do Result := locale.translation_in_context ("Pull ...", "scm") end
	menu_git_rebase: STRING_32 do Result := locale.translation_in_context ("Rebase ...", "scm") end

	menu_configuration: STRING_32 do Result := locale.translation_in_context ("Configuration ...", "scm") end

	menu_go_to_tool: STRING_32 do Result := locale.translation_in_context ("Go to the tool", "scm") end

	open_location: STRING_32 do Result := locale.translation_in_context ("Open location ...", "scm") end

	open_parent_location: STRING_32 do Result := locale.translation_in_context ("Open parent location ...", "scm") end

feature -- Dialogs

	question_show_unversioned_files: STRING_32 do Result := locale.translation_in_context ("Show unversioned files", "scm") end

	question_hide_location_with_no_change: STRING_32 do Result := locale.translation_in_context ("Hide location with no change", "scm") end
	tooltip_question_hide_location_with_no_change: STRING_32 do Result := locale.translation_in_context ("Hide location that has no change", "scm") end

	question_include_all_content: STRING_32 do Result := locale.translation_in_context ("Include all content", "scm") end

	label_set_svn_commands: STRING_32 do Result := locale.translation_in_context ("Set the Subversion commands", "scm") end
	label_set_git_commands: STRING_32 do Result := locale.translation_in_context ("Set the GIT commands", "scm") end
	label_command: STRING_32 do Result := locale.translation_in_context ("Command ", "scm") end
	label_diff_command: STRING_32 do Result := locale.translation_in_context ("Diff command ", "scm") end


	label_not_available_check_configuration: STRING_32 do Result := locale.translation_in_context ("Not available, check the configuration...", "scm") end

	label_git_support_status (a_supported: BOOLEAN): STRING_32
		do
			if a_supported then
				Result := locale.translation_in_context ("GIT support: yes", "scm")
			else
				Result := locale.translation_in_context ("GIT support: not available", "scm")
			end
		end

	label_svn_support_status (a_supported: BOOLEAN): STRING_32
		do
			if a_supported then
				Result := locale.translation_in_context ("Subversion support: yes", "scm")
			else
				Result := locale.translation_in_context ("Subversion support: not available", "scm")
			end
		end

	label_changes: STRING_32 do Result := locale.translation_in_context ("Changes", "scm") end

	label_operation_logs: STRING_32 do Result := locale.translation_in_context ("Operation logs", "scm") end

	label_commit_message: STRING_32 do Result := locale.translation_in_context ("Commit message", "scm") end


	text_about_source_control_tool: STRING_32 do Result := locale.translation_in_context ("[
			This tool has support for GIT and Subversion tools. 
			Use the [Config] button to check or update the expected locations.
			Use the [Project] button to (de)select the groups of the project.
		]", "scm") end

	text_no_output: STRING_32 do Result := locale.translation_in_context ("No output ...", "scm") end

	title_scm_diff: STRING_32 do Result := locale.translation_in_context ("Source Control / Diff", "scm") end
	title_scm_command_execution (a_title: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation_in_context ("Source Control / $1", "scm"), [a_title])
		end
	title_scm_commit: STRING_32 do Result := locale.translation_in_context ("Source Control / Commit", "scm") end
	title_scm_config: STRING_32 do Result := locale.translation_in_context ("Source Control / Configuration", "scm") end
	title_scm_push: STRING_32 do Result := locale.translation_in_context ("Source Control / Push", "scm") end
	title_scm_pull: STRING_32 do Result := locale.translation_in_context ("Source Control / Pull", "scm") end
	title_scm_rebase: STRING_32 do Result := locale.translation_in_context ("Source Control / Rebase", "scm") end

	label_resetting: STRING_32 do Result := locale.translation_in_context ("Resetting ...", "scm") end

	label_checking: STRING_32 do Result := locale.translation_in_context ("Checking ...", "scm") end

	label_changes_count (nb: INTEGER): STRING_32
		do
			if nb = 0 then
				Result := locale.translation_in_context ("No change", "scm")
			else
				Result := locale.formatted_string (locale.plural_translation_in_context ("$1 change", "$1 changes", "scm", nb), [nb])
			end
		end

	label_unversioned: STRING_32 do Result := locale.translation_in_context ("unversioned", "scm") end

	label_remote_repositories: STRING_32 do Result := locale.translation_in_context ("Destination repositories", "scm") end
	label_remote: STRING_32 do Result := locale.translation_in_context ("Remote", "scm") end
	label_remote_custom_location: STRING_32 do Result := locale.translation_in_context ("Custom location", "scm") end
	label_branches: STRING_32 do Result := locale.translation_in_context ("Branches", "scm") end

feature -- Tools

	desc_scm_tool: STRING_32 do Result := locale.translation_in_context ("Source Control Management", "scm") end

	double_click_show_diff_tooltip: STRING_32 do Result := locale.translation_in_context ("Double-clicked to show the differences%N(when Shift is pressed, open the location)", "scm") end

feature -- General

	button_scm: STRING_32 do Result := locale.translation_in_context ("Source Control", "scm") end
	button_check: STRING_32 do Result := locale.translation_in_context ("Check", "scm") end
	tooltip_button_check: STRING_32 do Result := locale.translation_in_context ("Check for changes", "scm") end
	button_project: STRING_32 do Result := locale.translation_in_context ("Project", "scm") end
	tooltip_button_project: STRING_32 do Result := locale.translation_in_context ("Open the project structure", "scm") end
	button_diff: STRING_32 do Result := locale.translation_in_context ("Diff", "scm") end
	tooltip_button_diff: STRING_32 do Result := locale.translation_in_context ("Show the differences", "scm") end

	button_push: STRING_32 do Result := locale.translation_in_context ("Push", "scm") end
	button_pull: STRING_32 do Result := locale.translation_in_context ("Pull", "scm") end
	button_rebase: STRING_32 do Result := locale.translation_in_context ("Rebase", "scm") end

	button_process_post_commit_operations: STRING_32 do Result := locale.translation_in_context ("Next", "scm") end
	tooltip_button_process_post_commit_operations: STRING_32 do Result := locale.translation_in_context ("Continue with post-commit operation(s)...", "scm") end

	button_external_diff: STRING_32 do Result := locale.translation_in_context ("External diff", "scm") end

	button_config: STRING_32 do Result := locale.translation_in_context ("Config", "scm") end
	tooltip_button_config: STRING_32 do Result := locale.translation_in_context ("Open the configuration dialog", "scm") end

	button_check_all: STRING_32 do Result := locale.translation_in_context ("Status", "scm") end
	button_commit_changelist: STRING_32 do Result := locale.translation_in_context ("Commit", "scm") end
	button_commit_changelist_tooltip: STRING_32 do Result := locale.translation_in_context ("Commit active changelist", "scm") end
	button_clear_changelist: STRING_32 do Result := locale.translation_in_context ("Clear", "scm") end
	button_clear_changelist_tooltip: STRING_32 do Result := locale.translation_in_context ("Clear the active changelist", "scm") end

	checkbutton_use_external_terminal: STRING_32 do Result := locale.translation_in_context ("Use external terminal?", "scm") end

feature -- Messages

	message_for_post_commit_operations (nb: INTEGER): STRING_32
		require
			nb > 0
		do
			Result := locale.formatted_string (locale.plural_translation_in_context ("You may need to operate the following manual instruction:", "You may need to operate the following $1 manual instructions:", "scm", nb), [nb])
		end


;note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
