indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROFILER_WIZARD_GENERATOR
	
inherit
	EB_ERROR_MANAGER
		export
			{NONE} all
		end
		
	EB_SHARED_ARGUMENTS
		export
			{NONE} all
		end
		
	SHARED_QUERY_VALUES
		export
			{NONE} all
		end
		
	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (an_information: EB_PROFILER_WIZARD_INFORMATION) is
			-- Initialize
		do
			information := an_information
			last_operation_successful := True
		end

feature -- Access
	
	last_operation_successful: BOOLEAN

feature -- Basic operations

	generate_execution_profile is
			-- Create profile according to `options_dialog' specifications
			--
			-- Raise an exception if an error occurs.
		local
			profinfo: STRING
			compile: STRING
			profiler: STRING
			prof_converter: CONVERTER_CALLER
			conf_load: CONFIGURATION_LOADER
			prof_invoker: PROFILER_INVOKER
			error_msg: STRING
		do
			last_operation_successful := True
			profinfo := strip_path (information.runtime_information_record)
			if information.workbench_mode then
				compile := "workbench"
			else
				compile := "final"
			end
			profiler := information.runtime_information_type
			create conf_load.make_and_load (profiler)
			if conf_load.error_occurred then
				add_error_message (Warning_messages.w_Load_configuration)
				last_operation_successful := False
			else
				create prof_invoker.make (profiler, current_cmd_line_argument, profinfo, compile)
				if prof_invoker.must_invoke_profiler then
					prof_invoker.invoke_profiler
				end
				create prof_converter.make (<<profinfo, compile>>, conf_load.shared_prof_config)
				if not prof_converter.is_last_conversion_ok then
					if prof_converter.conf_load_error then
						error_msg := "Error while generating the execution profile.%N" + profinfo + ": file does not exist"
					else
						error_msg := "An unknown error has occurred while generating%Nthe execution profile."
					end
					add_error_message (error_msg)
					last_operation_successful := False
				end
			end
		end

	execute_query is
			-- Execute Current command.
		local
			profiler_query: PROFILER_QUERY
			profiler_options: PROFILER_OPTIONS
			st: STRUCTURED_TEXT
			executer: E_SHOW_PROFILE_QUERY
			retried: BOOLEAN
		do
			last_operation_successful := False
			
			if not retried then
					--| Run the query
				clear_values
				if fill_values (Current) then
					create profiler_query
					profiler_query.set_subqueries (subqueries)
					profiler_query.set_subquery_operators (subquery_operators)
	
					create profiler_options
					profiler_options.set_output_names (clone (output_names))
					profiler_options.set_filenames (clone (filenames))
					profiler_options.set_language_names (clone (language_names))
	
					create st.make
					create executer.make (st, profiler_query, profiler_options)
					executer.execute
					show_new_window (st, profiler_query, profiler_options, executer.last_output)
					last_operation_successful := True
				end
			end
			
				-- Add default error message if there are no error message
			if not last_operation_successful and then error_messages.is_empty then
				add_error_message (Warning_messages.w_Profiler_bad_query)
			end
		rescue
			retried := True
			retry
		end
		
feature {NONE} -- Implementation

	fill_values (shared_values: SHARED_QUERY_VALUES): BOOLEAN is
			-- Fill `shared_values' with value specified
			-- by the user.
		require
			shared_values_valid:
				shared_values /= Void and then 
				shared_values.output_names /= Void and then
				shared_values.language_names /= Void and then
				shared_values.filenames /= Void
		local
			parser: EB_QUERY_PARSER
			filename: STRING
			file_name: FILE_NAME
			result_language: BOOLEAN
			result_output_switches: BOOLEAN
		do
			result_language := fill_language_values (shared_values)
			result_output_switches := fill_output_switches_values (shared_values)
			Result := result_language and result_output_switches
			
			if Result then
					--| Copy the filename
				if information.generate_execution_profile then
					create file_name.make_from_string (information.generation_path)
					file_name.set_file_name ("profinfo.pfi")
					filename := file_name
				else
					filename := clone (information.existing_profile)
				end
				shared_values.filenames.force (filename, shared_values.filenames.lower)
	
					--| Copy the subqueries
				if information.query /= Void and then not information.query.is_empty then
					create parser
					Result := parser.parse (information.query, shared_values)
				else
					add_error_message (Warning_messages.w_Profiler_bad_query)
					Result := false
				end
			end
		end
		
	fill_output_switches_values (shared_values: SHARED_QUERY_VALUES): BOOLEAN is
			-- Fill `shared_values' with value specified by the user concerning
			-- the output switches
		require
			shared_values_valid: shared_values /= Void and then shared_values.output_names /= Void
		local
			i: INTEGER
		do
			i := shared_values.output_names.lower

				--| Copy the output column switches
			if information.number_of_calls_switch then
				shared_values.output_names.force ("calls", i)
				i := i + 1
			end
			if information.time_switch then
				shared_values.output_names.force ("self", i)
				i := i + 1
			end
			if information.descendant_switch then
				shared_values.output_names.force ("descendants", i)
				i := i + 1
			end
			if information.total_time_switch then
				shared_values.output_names.force ("total", i)
				i := i + 1
			end
			if information.percentage_switch then
				shared_values.output_names.force ("percentage", i)
				i := i + 1
			end
			if information.name_switch then
				shared_values.output_names.force ("featurename", i)
				i := i + 1
			end

				-- We need at least one item checked
			if i > shared_values.output_names.lower then
				Result := True
			else
				add_error_message (Warning_messages.w_Profiler_select_one_output_switch)
			end
		end

	fill_language_values (shared_values: SHARED_QUERY_VALUES): BOOLEAN is
			-- Fill `shared_values' with value specified by the user concerning
			-- the languages
		require
			shared_values_valid: shared_values /= Void and then shared_values.language_names /= Void
		local
			i: INTEGER
		do
			i := shared_values.language_names.lower

				--| Copy the language names
			if information.eiffel_switch then
				shared_values.language_names.force ("eiffel", i)
				i := i + 1
			end
			if information.c_switch then
				shared_values.language_names.force ("c", i)
				i := i + 1
			end
			if information.recursive_switch then
				shared_values.language_names.force ("cycle", i)
				i := i + 1
			end

				-- We need at least one item checked
			if i > shared_values.language_names.lower then
				Result := True
			else
				add_error_message (Warning_messages.w_Profiler_select_one_language)
			end
		end

		
	show_new_window (st: STRUCTURED_TEXT; pq: PROFILER_QUERY;
				po: PROFILER_OPTIONS; profinfo: PROFILE_INFORMATION) is
			-- Create and show a new EB_PROFILE_QUERY_WINDOW.
			-- This window will be associated with `pq', will
			-- use `po' and `profinfo', and display `st'.
		local
			new_window: EB_PROFILE_QUERY_WINDOW
		do
			create new_window.make_default
			new_window.update_window (st, pq, po, profinfo)
			new_window.show
			new_window.raise
		end
		
	strip_path (a_full_pathname: STRING): STRING is
			-- Return the base filename of a full qualified pathname
			-- Ex: strip_path ("c:\temp\test.pfi") = "test.pfi"
		local
			index_sep: INTEGER
		do
			index_sep := a_full_pathname.last_index_of (Operating_environment.Directory_separator, a_full_pathname.count)
			if index_sep = 0 then
				Result := a_full_pathname
			elseif index_sep = a_full_pathname.count then
				Result := ""
			else
				Result := a_full_pathname.substring (index_sep + 1, a_full_pathname.count)
			end
		end

feature {NONE} -- Implementation / Attributes

	information: EB_PROFILER_WIZARD_INFORMATION
			-- Options for generation
			
end -- class EB_PROFILER_WIZARD_GENERATOR
