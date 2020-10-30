note

	description:

	"Constants for the directory names for the generated wrapper files"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_DIRECTORY_STRUCTURE

inherit

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	EWG_SHARED_EIFFEL_COMPILER_NAMES

create

	make

feature {NONE}

	make (a_config_system: like config_system)
			-- Create new directory structure.
		require
			a_config_system_not_void: a_config_system /= Void
		do
			config_system := a_config_system
		ensure
			config_system_set: config_system = a_config_system
		end

feature

	config_system: EWG_CONFIG_SYSTEM
			-- Config system

feature

	wrapper_directory_name: STRING
		do
			Result := config_system.output_directory_name
		ensure
			result_not_void: Result /= Void
		end

	relative_default_output_directory: STRING = "generated_wrapper"

	relative_eiffel_directory_name: STRING = "eiffel"

	relative_eiffel_external_directory_name: STRING
		do
			Result := file_system.pathname (relative_eiffel_directory_name, "external")
		ensure
			result_not_void: Result /= Void
		end

	relative_eiffel_external_callback_directory_name: STRING
		do
			Result := file_system.pathname (relative_eiffel_external_directory_name, "callback")
		ensure
			result_not_void: Result /= Void
		end

	relative_c_directory_name: STRING = "c"

	relative_c_src_directory_name: STRING
		do
			Result := file_system.pathname (relative_c_directory_name, "src")
		ensure
			result_not_void: Result /= Void
		end

	relative_c_include_directory_name: STRING
		do
			Result := file_system.pathname (relative_c_directory_name, "include")
		ensure
			result_not_void: Result /= Void
		end

feature

	eiffel_directory_name: STRING
		do
			Result := file_system.pathname (wrapper_directory_name, relative_eiffel_directory_name)
		ensure
			result_not_void: Result /= Void
		end

	eiffel_external_directory_name: STRING
		do
			Result := file_system.pathname (wrapper_directory_name, relative_eiffel_external_directory_name)
		ensure
			result_not_void: Result /= Void
		end

	eiffel_external_callback_directory_name: STRING
		do
			Result := file_system.pathname (wrapper_directory_name, relative_eiffel_external_callback_directory_name)
		ensure
			result_not_void: Result /= Void
		end

	c_directory_name: STRING
		do
			Result := file_system.pathname (wrapper_directory_name, relative_c_directory_name)
		ensure
			result_not_void: Result /= Void
		end

	c_src_directory_name: STRING
		do
			Result := file_system.pathname (wrapper_directory_name, relative_c_src_directory_name)
		ensure
			result_not_void: Result /= Void
		end

	c_include_directory_name: STRING
		do
			Result := file_system.pathname (wrapper_directory_name, relative_c_include_directory_name)
		ensure
			result_not_void: Result /= Void
		end

feature -- File names (to be moved out of here)

	relative_function_c_glue_code_file_name: STRING
		do
			Result := "ewg_" + config_system.name + "_function_c_glue_code.c"
		ensure
			result_not_void: Result /= Void
		end

	relative_function_c_glue_header_file_name: STRING
		do
			Result := "ewg_" + config_system.name + "_function_c_glue_code.h"
		ensure
			result_not_void: Result /= Void
		end

	relative_callback_c_glue_header_file_name: STRING
		do
			Result := "ewg_" + config_system.name + "_callback_c_glue_code.h"
		ensure
			result_not_void: Result /= Void
		end

	relative_callback_c_glue_code_file_name: STRING
		do
			Result := "ewg_" + config_system.name + "_callback_c_glue_code.c"
		ensure
			result_not_void: Result /= Void
		end

	relative_callback_c_glue_code_object_name: STRING
		do
			Result := "ewg_" + config_system.name + "_callback_c_glue_code"
		ensure
			result_not_void: Result /= Void
		end

feature

	default_output_directory: STRING
		once
			Result := file_system.pathname (file_system.current_working_directory, relative_default_output_directory)
		ensure
			result_not_void: Result /= Void
		end

	function_c_glue_code_file_name (a_eiffel_compiler: INTEGER): STRING
		require
			valid_eiffel_compiler: eiffel_compiler_names.is_valid_eiffel_compiler_code (a_eiffel_compiler)
		do
			Result := file_system.pathname (c_src_directory_name, "spec")
			Result := file_system.pathname (Result,
				eiffel_compiler_names.eiffel_compiler_name_from_code (a_eiffel_compiler))
			Result := file_system.pathname (Result, relative_function_c_glue_code_file_name)
		ensure
			result_not_void: Result /= Void
		end

	function_c_glue_header_file_name (a_eiffel_compiler: INTEGER): STRING
		do
			Result := file_system.pathname (c_include_directory_name, "spec")
			Result := file_system.pathname (Result,
				eiffel_compiler_names.eiffel_compiler_name_from_code (a_eiffel_compiler))
			Result := file_system.pathname (Result, relative_function_c_glue_header_file_name)
		ensure
			result_not_void: Result /= Void
		end

	callback_c_glue_header_file_name (a_eiffel_compiler: INTEGER): STRING
		do
			Result := file_system.pathname (c_include_directory_name, relative_callback_c_glue_header_file_name)
		ensure
			result_not_void: Result /= Void
		end

	callback_c_glue_code_file_name (a_eiffel_compiler: INTEGER): STRING
		do
			Result := file_system.pathname (c_src_directory_name, relative_callback_c_glue_code_file_name)
		ensure
			result_not_void: Result /= Void
		end

	callback_c_glue_code_object_name (a_eiffel_compiler: INTEGER): STRING
		do
			Result := file_system.pathname (c_src_directory_name, relative_callback_c_glue_code_object_name)
		ensure
			result_not_void: Result /= Void
		end

invariant

	config_system_not_void: config_system /= Void

end
