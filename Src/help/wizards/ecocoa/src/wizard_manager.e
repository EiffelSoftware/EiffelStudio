note
	description	: "Class which is launching the application."
	author		: "Daniel Furrer <danie.furrer@gmail.com>"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_MANAGER

inherit
	BENCH_WIZARD_MANAGER
		redefine
			Wizard_title,
			prepare
		end

	WIZARD_PROJECT_SHARED
		undefine
			default_create,
			copy
		end

	EXECUTION_ENVIRONMENT
		rename
			sleep as sleep_ee,
			launch as launch_ee,
			command_line as command_line_ee
		undefine
			default_create,
			copy
		end

create
	make_and_launch

feature -- Initialization

	prepare
		local
			original, link: FILE_NAME
		do
			-- The path to the icon is fixed so we make a link to the system icon we want to use
			create original.make
			original.set_directory ("/System/Library/Frameworks/AppKit.framework/Resources")
			original.set_file_name ("NSDefaultApplicationIcon")
			original.add_extension ("tiff")
			create link.make
			link.set_directory (wizard_pixmaps_path)
			link.set_file_name ("eiffel_wizard_icon")
			link.add_extension ("png")
			system ("ln -s " + original + " " + link)
			Precursor
		end

	Wizard_title: STRING_GENERAL
			-- Window title for this wizard.
		once
			Result := interface_names.t_new_cocoa_wizard
		end

	wizard_factory: BENCH_WIZARD_FACTORY
			-- Factory for Cocoa wizard.
		once
			create Result
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
end -- class WIZARD_MANAGER
