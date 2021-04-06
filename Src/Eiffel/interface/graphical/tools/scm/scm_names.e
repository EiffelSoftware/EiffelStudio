note
	description: "Summary description for {SCM_NAMES}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_NAMES

inherit
	SHARED_LOCALE

feature -- Menu

	menu_scm: STRING_32 do Result := locale.translation_in_context ("Source Control Management", "scm") end

	menu_status: STRING_32 do Result := locale.translation_in_context ("Status", "scm") end

	menu_check: STRING_32 do Result := locale.translation_in_context ("Check", "scm") end

	menu_save: STRING_32 do Result := locale.translation_in_context ("Save", "scm") end

feature -- Dialogs

	question_show_unversioned_files: STRING_32 do Result := locale.translation_in_context ("Show unversioned files?", "scm") end

	label_changes: STRING_32 do Result := locale.translation_in_context ("Changes", "scm") end

	label_operation_logs: STRING_32 do Result := locale.translation_in_context ("Operation logs", "scm") end

	label_commit_message: STRING_32 do Result := locale.translation_in_context ("Commit message", "scm") end

	text_no_output: STRING_32 do Result := locale.translation_in_context ("No output ...", "scm") end

	title_scm_save: STRING_32 do Result := locale.translation_in_context ("Source Control / Save", "scm") end

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

feature -- Tools

	desc_scm_tool: STRING_32 do Result := locale.translation_in_context ("Source Control Management (svn, git, ...)", "scm") end

feature -- General

	button_scm: STRING_32 do Result := locale.translation_in_context ("Source Control Management", "scm") end
	button_check: STRING_32 do Result := locale.translation_in_context ("Check", "scm") end
	tooltip_button_check: STRING_32 do Result := locale.translation_in_context ("Check for changes", "scm") end
	button_setup: STRING_32 do Result := locale.translation_in_context ("Setup", "scm") end
	tooltip_button_setup: STRING_32 do Result := locale.translation_in_context ("Open the settings", "scm") end
	button_check_all: STRING_32 do Result := locale.translation_in_context ("Check All", "scm") end
	button_save: STRING_32 do Result := locale.translation_in_context ("Save", "scm") end
	button_save_all: STRING_32 do Result := locale.translation_in_context ("Save All", "scm") end


;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
