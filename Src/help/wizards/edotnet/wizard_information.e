note
	description	: "All information about the wizard ... This class is inherited in each state "
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	WIZARD_INFORMATION

inherit
	BENCH_WIZARD_INFORMATION
		redefine
			make
		end

create
	make

feature  -- Initialization

	make
			-- Assign default values
		do
			Precursor
			generate_dll := False
			root_class_name := Default_root_class_name
			creation_routine_name := Default_creation_routine_name
			clr_version := clr_version_10
		end

feature -- Setting

	set_generate_dll (new_value: BOOLEAN)
			-- Set `generate_dll' to `new_value'
		do
			generate_dll := new_value
		end

	set_root_class_name (a_name: STRING_32)
			-- Set `root_class_name' with `a_name'.
		do
			if attached a_name then
				root_class_name := a_name.as_upper
			else
				root_class_name := Void
			end
		end

	set_creation_routine_name (a_name: STRING_32)
			-- Set `creation_routine_name' with `a_name'.
		do
			if attached a_name then
				creation_routine_name := a_name
			else
				creation_routine_name := Void
			end
		ensure
			creation_routine_name_set: creation_routine_name = a_name
		end

	set_console_application (a_bool: like console_application)
			-- Set `console_application' with `a_bool'.
		do
			console_application := a_bool
		ensure
			console_application_set: console_application = a_bool
		end

	set_clr_version (a_version: like clr_version)
			-- set `clr_version' with `a_version'
		require
			non_void_version: a_version /= Void
		do
			clr_version := a_version.twin
		ensure
			clr_version_set: clr_version.same_string_general (a_version)
		end

	set_is_most_recent_clr_version (a_flag: BOOLEAN)
			-- Set `is_most_recent_clr_version' to `a_flag'
		do
			is_most_recent_clr_version := a_flag
		ensure
			set: is_most_recent_clr_version = a_flag
		end

feature -- Access

	generate_dll: BOOLEAN
			-- Should the compiler generate a DLL?
			-- If set to False, it will generate an EXE.

	root_class_name: STRING_32
			-- Name of the root class of the Eiffel.NET project

	creation_routine_name: STRING_32
			-- Name of the creation routine of the root class

	application_type: STRING
			-- "dll" if `generate_dll' is set, "exe" otherwise
		do
			if generate_dll then
				Result := Dll_type
			else
				Result := Exe_type
			end
		end

	console_application: BOOLEAN
			-- Is it a console application system?

	is_most_recent_clr_version: BOOLEAN
			-- Should we target the most recent CLR version available on the users system?

	clr_version: STRING_32
			-- version of clr to target

	clr_version_10: STRING_32 = "v1.0.3705"
			-- version 1.0 of CLR

feature {NONE} -- Implementation

	Default_project_name: STRING = "my_dotnet_application"
			-- Default project name

feature {NONE} -- Constants

	Icon_relative_filename: STRING = "\eiffel.ico"
			-- Filename of `eiffel.ico' relatively to `icon_location'

	Default_root_class_name: STRING = "APPLICATION"
			-- Default root class name

	Default_creation_routine_name: STRING = "make"
			-- Default creation routine name

	Dll_type: STRING = "dll"
			-- DLL type

	Exe_type: STRING = "exe"
			-- EXE type

feature {NONE} -- Generation

	project_generator: WIZARD_PROJECT_GENERATOR
			-- <Precursor>
		do
			create Result.make (Current)
		end

invariant
	non_void_root_class_name: root_class_name /= Void
	non_void_creation_routine_name: creation_routine_name /= Void
	non_void_clr_version: clr_version /= Void

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
