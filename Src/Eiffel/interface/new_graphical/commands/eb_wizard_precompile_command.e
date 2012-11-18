note
	description	: "Command to start the precompilation wizard."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_WIZARD_PRECOMPILE_COMMAND

inherit
	EB_MENUABLE_COMMAND

	EB_CONSTANTS
		export
			{NONE} all
		end

	EXECUTION_ENVIRONMENT_32
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	SHARED_LOCALE
		export
			{NONE} all
		end

feature -- Execution

	execute
			-- Start the precompilation wizard.
		local
			command: STRING_32
		do
			create command.make (50)
			command.append_character ('"')
			command.append_string (eiffel_layout.precompilation_wizard_command_name.name)
			command.append_character ('"')
			command.append_character (' ')
			command.append_character ('"')
			command.append_string (eiffel_layout.precompilation_wizard_resources_path.name)
			command.append_character ('"')
			command.append_character (' ')
			command.append_string (locale.info.id.name)
			launch (command)
		end

feature {NONE} -- Implementation

	pixmap: EV_PIXMAP
			-- Pixmap

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Wizard_precompile
		end

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

end -- class EB_WIZARD_PRECOMPILE_COMMAND
