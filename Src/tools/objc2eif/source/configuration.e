note
	description: "[
		Various settings used to configure how the parser is processing the objective
		C classes and generating the Eiffel wrappers.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CONFIGURATION

create
	make

feature {NONE} -- Initialization

	make (a_frameworks_path: STRING; a_framework_name: STRING)
			-- Initialize Current with `a_frameworks_path' and `a_framework_name'.
			-- Initialize also `wrapper_name' to "objc_wrapper" and
			-- `generate_structs' to True.
		require
			valid_frameworks_path_and_name: (create {RAW_FILE}.make (a_frameworks_path + a_framework_name + ".framework")).exists
		do
			framework_name := a_framework_name
			frameworks_path := a_frameworks_path
				-- Default values
			wrapper_name := "objc_wrapper"
			generate_structs := True
			create retain_policies.make (0)
		ensure
			framework_name_set: framework_name = a_framework_name
			frameworks_path_set: frameworks_path = a_frameworks_path
		end

feature -- Setters

	set_framework_name (a_framework_name: like framework_name)
			-- Set `framework_name' with `a_framework_name'.
		require
			a_valid_framework_name: not a_framework_name.is_empty
		do
			framework_name := a_framework_name
		ensure
			framework_name_set: framework_name = a_framework_name
		end

	set_frameworks_path (a_frameworks_path: like frameworks_path)
			-- Set `frameworks_path' with `a_frameworks_path'.
		require
			a_valid_frameworks_path: not a_frameworks_path.is_empty
		do
			frameworks_path := a_frameworks_path
		ensure
			frameworks_path_set: frameworks_path = a_frameworks_path
		end

	set_wrapper_name (a_wrapper_name: like wrapper_name)
			-- Set `wrapper_name' with `a_wrapper_name'.
		require
			a_valid_wrapper_name: not a_wrapper_name.is_empty
		do
			wrapper_name := a_wrapper_name
		ensure
			wrapper_name_set: wrapper_name = a_wrapper_name
		end

	set_generate_structs (true_or_false: like generate_structs)
			-- Set `generate_structs' with `true_or_false'
		do
			generate_structs := true_or_false
		ensure
			generate_structs_set: generate_structs = true_or_false
		end

feature -- Access

	retain_policies: HASH_TABLE [BOOLEAN, STRING]
			-- A mapping from selector names with a heading symbol that denotes whether
			-- they're instance methods ("-") or class methods ("+") to boolean values
			-- that denote whether the client of the method should retain returned
			-- object or note.
			-- Example:
			-- ("+alloc") --> (False)
			-- ("+stringWithFormat:") --> (True)

	framework_name: STRING assign set_framework_name
			-- Name of the Objective-C framework.

	frameworks_path: STRING assign set_frameworks_path
			-- Path of the system folder containing the Objective-C frameworks.

	framework_headers_folder: STRING
			-- Path of the folder that contains the header files for the current framework
			-- specified by `framework_name' and `frameworks_path'.
		do
			Result := frameworks_path + framework_name + ".framework/Headers/"
		end

	wrapper_name: STRING assign set_wrapper_name
			-- The project name of the generated wrapper.

	generate_structs: BOOLEAN assign set_generate_structs
			-- Does the wrapper generator generate eiffel classes for Objective-C structs?

	templates_folder_name: STRING = "templates"
			-- The name of the templates folder

	ecf_file_template: RAW_FILE
			-- The ecf file template.
		once
			create Result.make_open_read (templates_folder_name + "/objc_wrapper.ecf")
		end

	auxiliary_folder_name: STRING = "auxiliary"
			-- The name of the auxiliary folder that will be created in the generated wrapper.

	objc_names_conversion_file: RAW_FILE
			-- The 'objc_names_conversion.e' file.
		once
			create Result.make_open_read (templates_folder_name + "/objc_names_conversion.e")
		end

	classes_mapper_file: RAW_FILE
			-- The 'classes_mapper.e' file.
		once
			create Result.make_open_read (templates_folder_name + "/classes_mapper.e")
		end

	ns_any_file: RAW_FILE
			-- The 'ns_any.e' file.
		once
			create Result.make_open_read (templates_folder_name + "/ns_any.e")
		end

	ns_common_file: RAW_FILE
			-- The 'ns_common.e' file.
		once
			create Result.make_open_read (templates_folder_name + "/ns_common.e")
		end

	ns_category_common_file: RAW_FILE
			-- The 'ns_category_common.e' file.
		once
			create Result.make_open_read (templates_folder_name + "/ns_category_common.e")
		end

	ns_named_class: RAW_FILE
			-- The 'ns_named_class.e' file.
		once
			create Result.make_open_read (templates_folder_name + "/ns_named_class.e")
		end

	objc_class_file: RAW_FILE
			-- The 'objc_class.e' file.
		once
			create Result.make_open_read (templates_folder_name + "/objc_class.e")
		end

	objc_selector_file: RAW_FILE
			-- The 'objc_selector.e' file.
		once
			create Result.make_open_read (templates_folder_name + "/objc_selector.e")
		end

	clib_folder_name: STRING = "Clib"
			-- The 'Clib' folder name.

	objc_callbacks_h_file: RAW_FILE
			-- The 'objc_callbacks.h' file.
		once
			create Result.make_open_read (templates_folder_name + "/objc_callbacks.h")
		end

	objc_callbacks_m_file: RAW_FILE
			-- The 'objc_callbacks.m' file.
		once
			create Result.make_open_read (templates_folder_name + "/objc_callbacks.m")
		end

	makefile: RAW_FILE
			-- The 'Makefile.SH' file.
		once
			create Result.make_open_read (templates_folder_name + "/Makefile.SH")
		end


end
