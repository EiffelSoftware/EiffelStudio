indexing

	description: "Resource file name server"
	date: "$Date$"
	revision: "$Revision$"

class RESOURCE_FILES_PARSER

inherit
	EIFFEL_ENV

creation
	make

feature -- Initialization

	make (new_name: STRING) is
			-- Create a resource file name server for application `new_name'.
		require
			new_name_not_void: new_name /= Void
		do
			application_name := new_name
		ensure
			application_name = new_name
		end

feature -- File extension

	set_extension (an_extension: STRING) is
			-- Set `extension' to `an_extension'.
		require
			an_extension_valid: an_extension /= Void and then an_extension.count <= 3
		do
			extension := an_extension
		end

	extension: STRING
			-- The extension

feature -- File parsing

	parse_files (a_table: RESOURCE_TABLE) is
			-- Put resources from specified application and suffix into
			-- table `a_table'.
		local
			file_name: FILE_NAME
			parser: RESOURCE_PARSER
		do
			create parser
            file_name := system_specific
            if file_name /= Void and then not file_name.is_empty then
                parser.parse_file (file_name, a_table)
            end
		end

feature -- File name

	system_specific: FILE_NAME is
			-- Platform specific system level resource specification file
			-- ($ISE_EIFFEL/eifinit/application_name/spec/$ISE_PLATFORM)
		require
			Eiffel_installation_dir_name_not_void: Eiffel_installation_dir_name /= Void
			Eiffel_platform: Eiffel_platform /= Void
		do
			create Result.make_from_string (Eiffel_installation_dir_name)
			Result.extend_from_array (<<Eifinit, application_name, Spec, Platform_abstraction>>)
			Result.set_file_name (General)
			if extension /= Void then	
				Result.add_extension (extension)
			end
		end

feature {NONE} -- Implementation

	Eifinit: STRING is "eifinit"
	Spec: STRING is "spec"
	General: STRING is "general"
			-- File and directory names

	application_name: STRING
			-- Application name (bench, build, case, ...)

invariant
	application_name_not_void: application_name /= Void

end -- class RESOURCE_FILES_PARSER
