note
	description: "Summary description for {XT_ARGUMENT_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XT_ARGUMENT_PARSER

inherit
	ARGUMENT_OPTION_PARSER
		rename
			make as make_option_parser
		export
			{NONE} all
			{ANY} execute, has_executed, is_successful
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the argument parser.
		do
			make_option_parser (False)
			set_is_showing_argument_usage_inline (False)
		end

feature -- Access


feature -- Status report

	project_name: STRING
			-- The name of the project
		require
			is_successful: is_successful
		do
			Result := ""
			if attached option_of_name (project_name_switch) as l_option then
				Result := l_option.value
			end
		ensure
			not_Result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end

	tag_lib_path: STRING
			-- The tag_lib_path
		require
			is_successful: is_successful
		do
			Result := ""
			if attached option_of_name (tag_lib_path_switch) as l_option then
				Result := l_option.value
			end
		ensure
			not_Result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end

	servlet_gen_path: STRING
			-- The servlet_gen_path
		require
			is_successful: is_successful
		do
			Result := ""
			if attached option_of_name (servlet_gen_path_switch) as l_option then
				Result := l_option.value
			end
		ensure
			not_Result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end

	output_path: STRING
			-- The output_path
		require
			is_successful: is_successful
		do
			Result := ""
			if attached option_of_name (output_path_switch) as l_option then
				Result := l_option.value
			end
		ensure
			not_Result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end

	input_path: STRING
			-- The input_path
		require
			is_successful: is_successful
		do
			Result := ""
			if attached option_of_name (input_path_switch) as l_option then
				Result := l_option.value
			end
		ensure
			not_Result_is_detached_or_empty: Result /= Void and then not Result.is_empty
		end


feature {NONE} -- Access: Usage

	name: STRING = "Xebra Translator"
			-- <Precursor>

	version: STRING
			-- <Precursor>
		once
--			create Result.make (3)
--			Result.append_integer ({EIFFEL_ENVIRONMENT_CONSTANTS}.major_version)
--			Result.append_character ('.')
--			Result.append_integer ({EIFFEL_ENVIRONMENT_CONSTANTS}.minor_version)
			Result := "not implemented"
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (1)
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (project_name_switch, "Specifies the name of the projec", False, False, "Project name", "Project name", False))
			Result.extend (create {ARGUMENT_FILE_OR_DIRECTORY_SWITCH}.make (input_path_switch, "Specifies the path to the directory with the input files", False, False, "Input path", "The input directory path", False))
			Result.extend (create {ARGUMENT_FILE_OR_DIRECTORY_SWITCH}.make (output_path_switch, "Specifies the path to the directory where the generated files will be written.", False, False, "Ouput path", "The output path", False))
			Result.extend (create {ARGUMENT_FILE_OR_DIRECTORY_SWITCH}.make (servlet_gen_path_switch, "Specifies the path to the directory where the servlet generator will be written", False, False, "Servlet gen path", "The servlet generator path", False))
			Result.extend (create {ARGUMENT_FILE_OR_DIRECTORY_SWITCH}.make (tag_lib_path_switch, "Specifies the path to the tag library.", False, False, "tag lib", "The tag library", False))
		end


feature {NONE} -- Switches

	project_name_switch: STRING = "n|project name"
	input_path_switch: STRING = "i|input path"
	output_path_switch: STRING = "o|output path"
	servlet_gen_path_switch: STRING = "s|servlet generator path"
	tag_lib_path_switch: STRING = "t|tag library path"


end
