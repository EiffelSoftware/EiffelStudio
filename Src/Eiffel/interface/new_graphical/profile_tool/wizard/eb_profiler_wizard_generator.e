note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROFILER_WIZARD_GENERATOR

inherit
	ANY

	EB_ERROR_MANAGER
		export
			{NONE} all
		end

	SHARED_DEBUGGER_MANAGER
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

	E_PROFILER_CONSTANTS
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (an_information: EB_PROFILER_WIZARD_INFORMATION)
			-- Initialize
		do
			information := an_information
			last_operation_successful := True
		end

feature -- Access

	last_operation_successful: BOOLEAN

feature -- Basic operations

	generate_execution_profile
			-- Create profile according to `options_dialog' specifications
			--
			-- Raise an exception if an error occurs.
		local
			profinfo: STRING_32
			compile: STRING_32
			l_profiler: STRING
			prof_converter: CONVERTER_CALLER
			conf_load: CONFIGURATION_LOADER
			prof_invoker: PROFILER_INVOKER
			error_msg: STRING_32
		do
			last_operation_successful := True
			if attached information.runtime_information_record.entry as l_entry then
				profinfo := l_entry.name
			else
				create profinfo.make_empty
			end
			if information.workbench_mode then
				compile := "workbench"
			else
				compile := "final"
			end
			l_profiler := information.runtime_information_type
			create conf_load.make_and_load (l_profiler)
			if conf_load.error_occurred then
				add_error_message (Warning_messages.w_Load_configuration)
				last_operation_successful := False
			else
				create prof_invoker.make (l_profiler, debugger_manager.current_execution_parameters.arguments, profinfo, compile)
				if prof_invoker.must_invoke_profiler then
					prof_invoker.invoke_profiler
				end
				create prof_converter.make ({ARRAY [STRING_8]} <<profinfo, compile>>, conf_load.shared_prof_config)
				if not prof_converter.is_last_conversion_ok then
					if prof_converter.conf_load_error then
						error_msg := {STRING_32} "Error while generating the execution profile.%N" + profinfo + ": file does not exist"
					else
						error_msg := {STRING_32} "An unknown error has occurred while generating%Nthe execution profile."
					end
					add_error_message (error_msg)
					last_operation_successful := False
				end
			end
		end

	execute_query
			-- Execute Current command.
		local
			profiler_query: PROFILER_QUERY
			profiler_options: PROFILER_OPTIONS
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
					profiler_options.set_output_names (output_names.twin)
					profiler_options.set_filenames (filenames.twin)
					profiler_options.set_language_names (language_names.twin)

					create executer.make_simple (profiler_query, profiler_options)
					executer.execute
					show_new_window (profiler_query, profiler_options, executer.last_output)
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

	fill_values (shared_values: SHARED_QUERY_VALUES): BOOLEAN
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
			filename: PATH
			file_name: PATH
			result_language: BOOLEAN
			result_output_switches: BOOLEAN
		do
			result_language := fill_language_values (shared_values)
			result_output_switches := fill_output_switches_values (shared_values)
			Result := result_language and result_output_switches

			if Result then
					--| Copy the filename
				if information.generate_execution_profile then
					file_name := information.runtime_information_record.appended ("." + Dot_profile_information)
					filename := file_name
				else
					filename := information.existing_profile
					if filename /= Void then
						filename := filename.twin
					end
				end
				shared_values.filenames.force (filename.name, shared_values.filenames.lower)

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

	fill_output_switches_values (shared_values: SHARED_QUERY_VALUES): BOOLEAN
			-- Fill `shared_values' with value specified by the user concerning
			-- the output switches
		require
			shared_values_valid: shared_values /= Void and then shared_values.output_names /= Void
		local
			i: INTEGER
		do
			i := shared_values.output_names.lower

			if information.name_switch then
				shared_values.output_names.force (profiler_feature_name, i)
				i := i + 1
			end

				--| Copy the output column switches
			if information.number_of_calls_switch then
				shared_values.output_names.force (profiler_calls, i)
				i := i + 1
			end
			if information.time_switch then
				shared_values.output_names.force (profiler_self, i)
				i := i + 1
			end
			if information.descendant_switch then
				shared_values.output_names.force (profiler_descendants, i)
				i := i + 1
			end
			if information.total_time_switch then
				shared_values.output_names.force (profiler_total, i)
				i := i + 1
			end
			if information.percentage_switch then
				shared_values.output_names.force (profiler_percentage, i)
				i := i + 1
			end

				-- We need at least one item checked
			if i > shared_values.output_names.lower then
				Result := True
			else
				add_error_message (Warning_messages.w_Profiler_select_one_output_switch)
			end
		end

	fill_language_values (shared_values: SHARED_QUERY_VALUES): BOOLEAN
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

	show_new_window (pq: PROFILER_QUERY;
				po: PROFILER_OPTIONS; profinfo: PROFILE_INFORMATION)
			-- Create and show a new EB_PROFILE_QUERY_WINDOW.
			-- This window will be associated with `pq', will
			-- use `po' and `profinfo', and display `st'.
		local
			new_window: EB_PROFILE_QUERY_WINDOW
		do
			create new_window.make_default
			new_window.update_window (pq, po, profinfo)
			new_window.raise
		end

feature {NONE} -- Implementation / Attributes

	information: EB_PROFILER_WIZARD_INFORMATION;
			-- Options for generation

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_PROFILER_WIZARD_GENERATOR
