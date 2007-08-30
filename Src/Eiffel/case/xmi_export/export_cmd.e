indexing
	description: "Launch the exportation mechanism"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EXPORT_CMD

inherit
	EB_MENUABLE_COMMAND

	SHARED_EIFFEL_PROJECT

	EB_SHARED_INTERFACE_TOOLS

create
	make

feature -- Initialization

	make is
			-- Initialize `Current'.
		do
			enable_sensitive
		end

feature -- Access

	menu_name: STRING_GENERAL is
			-- Name as it appears in the menu (with '&' symbol).
		do
			Result := Interface_names.m_Export_XMI
		end

	pixmap: EV_PIXMAP
			-- Pixmap

feature -- Execution

	execute is
			-- Start XMI export wizard.
		do
			create wizard
			wizard.finish_button.select_actions.extend (agent generate)
			wizard.start
		end

feature {NONE} -- Implementation

	generate is
			-- Generate XMI with options in `wizard'.
		require
			wizard_not_void: wizard /= Void
		local
			xe: XMI_EXPORT
			retried: BOOLEAN
		do
			if not retried then
				create xe.make
				xe.set_directory (wizard.directory)
				xe.set_universe (wizard.documentation_universe)
				xe.generate (Degree_output)
			end
		rescue
			prompts.show_error_prompt ((create {WARNING_MESSAGES}).w_Invalid_directory_or_cannot_be_created (wizard.directory.name), Void, Void)
			retried := True
			retry
		end

	wizard: EB_EXPORT_WIZARD;
			-- XMI export option dialog.

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

end -- class EXPORT_CMD
