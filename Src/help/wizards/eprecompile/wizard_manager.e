indexing
	description	: "Class which is launching the application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_MANAGER

inherit
	WIZARD_PROJECT_MANAGER
		redefine
			Wizard_title,
			prepare
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			default_create, copy
		end

	WIZARD_PROJECT_SHARED
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make_and_launch

feature -- Initialization

	prepare is
			-- Prepare the first window to be displayed.
		local
			l_layout: WIZARD_EIFFEL_LAYOUT
		do
			create l_layout
			l_layout.check_environment_variable
			set_eiffel_layout (l_layout)

			setup_locale

			Precursor
		end

	Wizard_title: STRING_GENERAL is
			-- Window title for this wizard.
		once
			Result := interface_names.t_precompilation_wizard
		end

	wizard_factory: PRECOMPILE_WIZARD_FACTORY is
		once
			create Result
		end

feature {NONE} -- Implementation

	setup_locale is
			-- Setup locale
		local
			l_manager: I18N_LOCALE_MANAGER
			l_arg: STRING
			l_locale: like locale
		do
			create l_manager.make (eiffel_layout.language_path)
			if argument_count >= 2 then
				l_arg := argument (2)
				l_locale := l_manager.locale (create {I18N_LOCALE_ID}.make_from_string (l_arg))
			end
			locale_cell.put (l_locale)
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
end -- class WIZARD_MANAGER
