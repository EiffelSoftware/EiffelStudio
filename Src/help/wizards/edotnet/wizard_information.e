indexing
	description	: "All information about the wizard ... This class is inherited in each state "

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

	make is
			-- Assign default values
		do
			Precursor
			icon_location := wizard_resources_path
			icon_location := icon_location + Icon_relative_filename
			generate_dll := False
			root_class_name := Default_root_class_name
			creation_routine_name := Default_creation_routine_name
			clr_version := clr_version_10
		end

feature -- Setting

	set_icon_location (new_value: STRING) is
			-- Set `icon_location' to `new_value'
		do
			icon_location := new_value
		end
		
	set_generate_dll (new_value: BOOLEAN) is
			-- Set `generate_dll' to `new_value'
		do
			generate_dll := new_value
		end

	set_root_class_name (a_name: like root_class_name) is
			-- Set `root_class_name' with `a_name'.
		local
			upper_case_name: STRING
		do
			upper_case_name := clone (a_name)
			upper_case_name.to_upper
			root_class_name := upper_case_name
		end

	set_creation_routine_name (a_name: like creation_routine_name) is
			-- Set `creation_routine_name' with `a_name'.
		do
			creation_routine_name := a_name
		ensure
			creation_routine_name_set: creation_routine_name = a_name
		end

	set_console_application (a_bool: like console_application) is
			-- Set `console_application' with `a_bool'.
		do
			console_application := a_bool
		ensure
			console_application_set: console_application = a_bool
		end
		
	set_clr_version (a_version: like clr_version) is
			-- set `clr_version' with `a_version'
		require
			non_void_version: a_version /= Void
			valid_version: is_valid_clr_version (a_version)
		do
			clr_version := clone (a_version)
		ensure
			clr_version_set: equal (clr_version, a_version)
		end
		

feature -- Access

	icon_location: STRING
			-- Location of the icon choose by the user

	generate_dll: BOOLEAN
			-- Should the compiler generate a DLL?
			-- If set to False, it will generate an EXE.

	root_class_name: STRING
			-- Name of the root class of the Eiffel.NET project

	creation_routine_name: STRING
			-- Name of the creation routine of the root class

	application_type: STRING is
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
			
	clr_version: STRING
			-- version of clr to target
			
	is_valid_clr_version (a_version: STRING): BOOLEAN is
			-- is `a_version' a valid clr version?
		require
			non_void_version: a_version /= Void
		do
			Result := not a_version.is_empty and then a_version.is_equal (clr_version_10) or a_version.is_equal (clr_version_11)
		end
		
	clr_version_10: STRING is "v1.0.3705"
			-- version 1.0 of CLR
			
	clr_version_11: STRING is "v1.1.4322"
			-- version 1.1 of CLR

feature {NONE} -- Implementation

	Default_project_name: STRING is "my_dotnet_application"
			-- Default project name

feature {NONE} -- Constants

	Icon_relative_filename: STRING is "\eiffel.ico"
			-- Filename of `eiffel.ico' relatively to `icon_location'

	Default_root_class_name: STRING is "APPLICATION"
			-- Default root class name

	Default_creation_routine_name: STRING is "make"
			-- Default creation routine name

	Dll_type: STRING is "dll"
			-- DLL type

	Exe_type: STRING is "exe"
			-- EXE type

invariant
	non_void_root_class_name: root_class_name /= Void
	non_void_creation_routine_name: creation_routine_name /= Void
	non_void_clr_version: clr_version /= Void
	valid_clr_version: is_valid_clr_version (clr_version)

end -- class WIZARD_INFORMATION
