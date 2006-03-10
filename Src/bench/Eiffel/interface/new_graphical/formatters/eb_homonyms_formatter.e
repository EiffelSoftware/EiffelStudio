indexing
	description: "Command to display the homonyms of a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_HOMONYMS_FORMATTER

inherit
	EB_FEATURE_TEXT_FORMATTER
		redefine
			feature_cmd,
			generate_text,
			is_dotnet_formatter
		end

	EB_SHARED_PREFERENCES

create
	make

feature -- Properties

	symbol: ARRAY [EV_PIXMAP] is
			-- Graphical representation of the command.
		once
			create Result.make (1, 2)
			Result.put (Pixmaps.Icon_format_feature_homonyms, 1)
			Result.put (Pixmaps.Icon_format_feature_homonyms, 2)
		end

	feature_cmd: E_SHOW_ROUTINE_HOMONYMNS
			-- Feature command that can generate wanted information.

	menu_name: STRING is
			-- Identifier of `Current' in menus.
		do
			Result := Interface_names.m_Showhomonyms
		end

feature {NONE} -- Properties

	command_name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.l_Homonyms
		end

	post_fix: STRING is "hom"
			-- String symbol of the command, used as an extension when saving.

	is_dotnet_formatter: BOOLEAN is
			-- Is Current able to format .NET XML types?
		do
			Result := True
		end

feature {NONE} -- Implementation

	generate_text is
			-- Fill `formatted_text' with information concerning `associated_feature'.
		local
			cf: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
		do
			confirmed := False
			create cf.make_initialized (2, preferences.dialog_data.generate_homonyms_string, Interface_names.l_homonym_confirmation, Interface_names.L_do_not_show_again, preferences.preferences)
			cf.set_ok_action (agent confirm_generate)
			cf.show_modal_to_window (Window_manager.last_focused_development_window.window)
			if confirmed then
				last_was_error := False
				Precursor
			else
				last_was_error := True
			end
		end

	confirm_generate is
			-- The user DOES want to generate the homonyms.
		do
			confirmed := True
		end

	confirmed: BOOLEAN
			-- Did the user confirm he wanted to generate the homonyms?

	create_feature_cmd is
			-- Create `feature_cmd'.
		require else
			associated_feature_non_void: associated_feature /= Void
		do
			create feature_cmd.make (editor.text_displayed, associated_feature)
		end

	has_breakpoints: BOOLEAN is False;
			-- Should breakpoints be shown in Current?

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_HOMONYMS_FORMATTER


