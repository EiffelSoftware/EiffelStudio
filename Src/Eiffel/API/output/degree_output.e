note
	description:
		"Degree messages output during compilation. %
		%By default, all output is redirected to `io'."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	DEGREE_OUTPUT

inherit
	SHARED_ERROR_HANDLER

	SHARED_ENCODING_CONVERTER

feature -- Access

	degree: INTEGER;
			-- Current degree being processed.

	last_degree: INTEGER;
			-- Current degree being processed if a compilation is under way,
			-- or else the degree that was attained during the last compilation.

feature -- Measurement

	processed: INTEGER;
			-- Number of processed elements.

	total_number: INTEGER;
			-- Number of entities being processed.

feature -- Status Report

	is_verbose: BOOLEAN assign set_is_verbose
			-- Indicates if the compiler output is verbose.

	is_abort_requested: BOOLEAN
			-- Indicates if an abort signal has been requested, to stop the compilation

	is_compilation_cancellable: BOOLEAN
			-- May the compilation be cancelled at the current stage/degree?
		do
			Result := degree > 2 or else degree = -2
					-- Cannot cancel a compilation after end of degree 3, or
					-- after degree -2 because we need to generate code at
					-- this stage, and we cannot save what we have generated
					-- and what we have not generated.		
		end

feature -- Status setting

	set_is_verbose (a_verbose: BOOLEAN)
			-- Sets verbose output status.
			--
			-- `a_verbose': True to output the long compiler format; False otherwise.
		do
			is_verbose := a_verbose
		ensure
			is_verbose_set: is_verbose = a_verbose
		end

feature {NONE} -- Query

	degree_description (a_degree: INTEGER): STRING_32
			-- Retrieves a description for a given degree.
			--
			-- `a_degree': The degree index to retrieve a description for.
			-- `Result': A human readable description of the degree.
		require
			a_degree_valid: a_degree >= -3 and then a_degree <= 6
		local
			l_degree_str: STRING_32
		do
			create Result.make (35)
			l_degree_str := degree_short_description (a_degree)
			if a_degree /= 0 then
				Result.append (translate (lb_degree, Void))
				Result.append_character (' ')
				Result.append_integer (a_degree)
				Result.append_string_general (": ")
			end
			Result.append (l_degree_str)
		ensure
			result_attached: Result /= Void
		end

	degree_short_description (a_degree: INTEGER): STRING_32
			-- Retrieves a terse description for a given degree.
			--
			-- `a_degree': The degree index to retrieve a description for.
			-- `Result': A human readable description of the degree.
		require
			a_degree_valid: a_degree >= -3 and then a_degree <= 6
		do
			inspect
				a_degree
			when 6 then
				Result := translate (lb_degree_6, Void)
			when 5 then
				Result := translate (lb_degree_5, Void)
			when 4 then
				Result := translate (lb_degree_4, Void)
			when 3 then
				Result := translate (lb_degree_3, Void)
			when 2 then
				Result := translate (lb_degree_2, Void)
			when 1 then
				Result := translate (lb_degree_1, Void)
			when 0 then
					-- Used when generating documentation
				Result := translate (lb_degree_0, Void)
			when -1 then
				Result := translate (lb_degree_minus_1, Void)
			when -2 then
				Result := translate (lb_degree_minus_2, Void)
			when -3 then
				Result := translate (lb_degree_minus_3, Void)
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	degree_message (a_degree: INTEGER): STRING_32
			-- Retrieves a degree message for a given degree.
			--
			-- `a_degree': The degree index to retrieve a message for.
			-- `Result': A human readable message relating to the degree.
		do
			create Result.make (30)
			Result.append (translate (lb_degree, Void))
			Result.append_character (' ')
			Result.append_integer (a_degree)
			Result.append_character (' ')
			if a_degree = 6 then
				Result.append (translate (lb_group, Void))
			else
				Result.append (translate (lb_class, Void))
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	calculate_percentage (a_to_go: INTEGER): INTEGER
			-- Calculate the percentage based on a number of entities to go.
			--
			-- `a_to_go': Number of entities remaining to process.
			-- `Result': A percentage
		require
			a_to_go_small_enough: a_to_go <= total_number
		do
				--| FIXME IEK We shouldn't need the max call but there is an odd situation
				--| where the `total_number' is zero (see bug#14036)
			check
				total_number_not_zero: total_number > 0
			end
			Result := 100 - (100 * a_to_go) // (total_number).max (1);
			if Result = 100 and then a_to_go /= 0 then
				Result := 99
			end
		ensure
			result_non_negative: Result >= 0
			result_small_enough: Result <= 100
		end

	percentage_prefix (a_to_go: INTEGER): STRING_32
			-- Returns the percentage prefix string based on the number of entities still to process.
			--
			-- `a_to_go':
			-- `Result':
		require
			positive_total_nbr: total_number > 0
		local
			l_percent: INTEGER;
			l_to_go: STRING
			l_total_nbr: STRING
			l_two_spaces: STRING
		do
			l_total_nbr := total_number.out;

			create Result.make (7);
			Result.extend ('[');
			l_percent := calculate_percentage (a_to_go);
			if l_percent < 10 then
				Result.extend (' ')
			end
			if l_percent < 100 then
				Result.extend (' ')
			end
			Result.append_integer (l_percent)
			Result.append_string (once "%% - ");

			create l_two_spaces.make_filled (' ', 2)
			l_to_go := a_to_go.out
			inspect
				l_total_nbr.count - l_to_go.count
			when 1 then
				Result.extend (' ')
			when 2 then
				Result.append (l_two_spaces)
			when 3 then
					-- Limit is about 99000
				Result.append (l_two_spaces)
				Result.extend (' ')
			else
			end;

			Result.append (l_to_go)
			Result.extend (']')
			Result.extend (' ')
		ensure
			result_attached: Result /= Void
		end

	translate (a_string: STRING; a_args: detachable TUPLE): STRING_32
			-- Translate a string for internationalization.
			--
			-- `a_string': A string to translate.
			-- `a_args': A tuple or arguments or Void if no arguments.
		require
			a_string_attached: a_string /= Void
			not_a_args_is_empty: a_args /= Void implies not a_args.is_empty
		local
			i, nb: INTEGER
			l_arg: STRING
		do
			Result := a_string.as_string_32
			if a_args /= Void then
				if Result = a_string then
					create Result.make_from_string (a_string)
				end
				from
					i := 1
					nb := a_args.count
				until
					i > nb
				loop
					l_arg := a_args.item (i).out
					Result.replace_substring_all ("$" + i.out, l_arg)
					i := i + 1
				end
			end
		end

feature -- Basic operations

	request_abort
			-- Request the compilation aborts.
		do
			is_abort_requested := True
		ensure
			is_abort_requested: is_abort_requested
		end

	put_start_output
			-- Starts the output and initializes any resources.
			-- Note: Pair with call to `put_end_output'.
		do
			is_abort_requested := False
			total_number := 0
			processed := 0
			degree := 0
		ensure
			total_number_reset: total_number = 0
			processed_reset: processed = 0
			degree_reset: degree = 0
			not_is_abort_requested: not is_abort_requested
		end

	put_end_output
			-- Ends the output and frees any resources.
			-- Note: Pair with call to `put_start_output'.
		do
		end

	put_start_compilation
			-- Puts information indicating an Eiffel compilation has begun.
		require
			not_is_abort_requested: not is_abort_requested
		do
		end

	put_start_documentation (a_total_files: INTEGER; a_type: STRING)
			-- Puts information indicating an documentation generation has begun.
			--
			-- `a_total_files': Total number of files to process.
			-- `a_type': Documentation type.
		require
			not_is_abort_requested: not is_abort_requested
			a_type_attached: a_type /= Void
			not_a_type_is_empty: not a_type.is_empty
		do
			total_number := a_total_files
			put_message (translate (lb_generating_1, [a_type]))
			put_new_line
			processed := 0
			degree := 0
		ensure
			total_number_set: total_number = a_total_files
			processed_reset: processed = 0
			degree_reset: degree = 0
		end

feature -- Basic operations: Degrees

	put_degree_6 (a_cluster: CONF_CLUSTER; a_path: STRING)
			-- Put message to indicate that `a_path' of `a_cluster' is processed.
		require
			a_cluster_attached: a_cluster /= Void
			a_path_attached: a_path /= Void
		do
			total_number := 1
			put_degree (degree_message (6), 1, a_cluster.name + a_path)
		end

	put_degree_5 (a_class: CLASS_C; a_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree five with `a_to_go'
			-- classes to go.
		require
			a_class_attached: a_class /= Void
			a_to_go_non_negative: a_to_go >= 0
			in_degree_5: degree = 5
		do
			total_number := a_to_go + processed
			put_degree (degree_message (5), a_to_go, a_class.name)
			processed := processed + 1
		end;

	put_degree_4 (a_class: CLASS_C; a_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree four with `a_to_go'
			-- classes to go out of `total_nbr'..
		require
			a_class_attached: a_class /= Void
			a_to_go_non_negative: a_to_go >= 0
			in_degree_4: degree = 4
		do
			total_number := a_to_go + processed
			put_degree (degree_message (4), a_to_go, a_class.name)
			processed := processed + 1;
		end

	put_degree_3 (a_class: CLASS_C; a_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree three with `a_to_go'
			-- classes to go.
		require
			a_class_attached: a_class /= Void;
			a_to_go_non_negative: a_to_go >= 0
			in_degree_3: degree = 3
		do
			total_number := a_to_go + processed
			put_degree (degree_message (3), a_to_go, a_class.name)
			processed := processed + 1
		end

	put_degree_2 (a_class: CLASS_C; a_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree two with `a_to_go'
			-- classes to go.
		require
			a_class_attached: a_class /= Void;
			a_to_go_non_negative: a_to_go >= 0
			in_degree_2: degree = 2
		do
			put_degree (degree_message (2), a_to_go, a_class.name)
		end

	put_degree_1 (a_class: CLASS_C; a_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree one with `a_to_go'
			-- classes to go.
		require
			a_class_attached: a_class /= Void;
			a_to_go_non_negative: a_to_go >= 0
			in_degree_1: degree = 1
		do
			put_degree (degree_message (1), a_to_go, a_class.name)
		end

	put_start_dead_code_removal_message
			-- Put message indicating the start of dead code removal.
		require
			not_is_abort_requested: not is_abort_requested
		do
			put_string (translate (lb_removing_dead_code_message, Void))
			put_new_line
		end

	put_end_dead_code_removal_message
			-- Put message indicating the start of dead code removal.

		do
		end

	put_degree_minus_1 (a_class: CLASS_C; a_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree minus one with `a_to_go'
			-- classes to go.
		require
			a_class_attached: a_class /= Void;
			a_to_go_non_negative: a_to_go >= 0
			in_degree_minus_1: degree = -1
		do
			put_degree (degree_message (-1), a_to_go, a_class.name)
		end

	put_degree_minus_2 (a_class: CLASS_C; a_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree minus four with `a_to_go'
			-- classes to go.
		require
			a_class_attached: a_class /= Void
			a_to_go_non_negative: a_to_go >= 0
			in_degree_minus_2: degree = -2
		do
			put_degree (degree_message (-2), a_to_go, a_class.name)
		end

	put_degree_minus_3 (a_class: CLASS_C; a_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree minus five with `a_to_go'
			-- classes to go.
		require
			a_class_attached: a_class /= Void
			a_to_go_non_negative: a_to_go >= 0
			in_degree_minus_3: degree = -3
		do
			put_degree (degree_message (-3), a_to_go, a_class.name)
		end

feature -- Basic operations

	put_string (a_message: STRING_32)
			-- Puts a string and new line to the output
			--
			-- `a_message': The message to write.
		do
			put_message (a_message)
			put_new_line
		end

	put_message (a_message: STRING_32)
			-- Puts a message on the output.
			--
			-- `a_message': The message to write.
		require
			a_message_attached: a_message /= Void
		do
			encoding_converter.localized_print_error (a_message)
		end

	put_new_line
			-- Puts a new line on the output.
		do
			encoding_converter.localized_print_error ("%N")
		end

feature -- Basic operations

	put_start_degree (a_degree: INTEGER; a_total: INTEGER)
			-- Put a message indicating the start of a degree.
			-- Note: Should be paired with a call to `put_end_degree'.
			--
			-- `a_degree': A degree number.
			-- `a_total': Total number of entities to process
		require
			not_is_abort_requested: not is_abort_requested
			a_degree_small_enough: a_degree <= 6
			a_degree_big_enough: a_degree >= -3
			a_total_positive: a_total >= 0
		do
			total_number := a_total
			degree := a_degree
			last_degree := a_degree
			processed := 0
			if not is_verbose then
				put_message (degree_description (a_degree))
				put_new_line
			end
		ensure
			total_number_set: total_number = a_total
			degree_set: degree = a_degree
			last_degree_set: last_degree = a_degree
			processed_set: processed = 0
		end

	put_end_degree
			-- Put message indicating the end of a degree.
			-- Note: Should be paired with a call to `put_start_degree'.
		require
			degree_set: degree /= 0
		do
			degree := 0
		ensure
			last_degree_unchanged: last_degree = old last_degree
		end

	put_degree (a_degree: STRING_32; a_to_go: INTEGER; a_name: STRING)
			-- Puts a degree line message to the output.
			--
			-- `a_degree': A degree message string (or prefix).
			-- `a_to_go': Number of entities remaining.
			-- `a_name': The name of an entity currently being processed.
		require
			a_degree_attached: a_degree /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_msg: STRING_32
		do
			if is_abort_requested and then is_compilation_cancellable then
					-- The user has requested an abort of compilation.
				is_abort_requested := False
				error_handler.insert_error (create {INTERRUPT_ERROR}.make (True))
				error_handler.raise_error
			end
			if is_verbose then
				create l_msg.make_from_string (percentage_prefix (a_to_go))
				l_msg.append (a_degree)
				if not a_name.is_empty then
					l_msg.append_character (' ')
					l_msg.append (a_name)
				end
				put_message (l_msg)
				put_new_line
			end
		end

feature -- Basic operations: Eiffel compiler

	put_header
			-- Puts the degree output header information.
		require
			not_is_abort_requested: not is_abort_requested
		do
			put_string (translate (lb_compiler_header_1, [(create {SYSTEM_CONSTANTS}).version_number]))
			put_new_line
		end

	put_melting_changes_message
			-- Put message indicating that melting changes is occurring.
		require
			not_is_abort_requested: not is_abort_requested
		do
			put_string (translate (lb_melting_changes_message, Void))
		end

	put_freezing_message
			-- Put message indicating that freezing is occurring.
		require
			not_is_abort_requested: not is_abort_requested
		do
			put_string (translate (lb_freezing_system_message, Void))
		end

	put_resynchronizing_breakpoints_message
			-- Put a message to indicate that the
			-- breakpoints are being resynchronized.
		require
			not_is_abort_requested: not is_abort_requested
		do
		end

	put_system_compiled
			-- Put message indicating that the system has been compiled.
		require
			not_is_abort_requested: not is_abort_requested
		do
			put_string (translate (lb_system_recompiled, Void))
		end

feature -- Basic operations: Documentation generation

	put_initializing_documentation
			-- Start documentation generation.
		require
			not_is_abort_requested: not is_abort_requested
		do
			put_string (translate (lb_initialize_documentation, Void))
		end

feature -- Output on per class

	put_consume_assemblies
			-- Put message to indicate that assemblies are consumed.
		do
			put_string (lb_consume_assemblies_message);
			put_new_line
		end

	put_process_group (a_group: CONF_GROUP)
			-- Put message to indicate that `a_group' is processed.
		require
			a_group_not_void: a_group /= Void
		do
				-- clusters are displayed with `put_process_directory'.
			if not a_group.is_cluster then
				put_degree (degree_message(6), 1, a_group.name)
			end
		end

	put_dead_code_removal_message (a_processed, a_to_go: INTEGER)
			-- Put message progress the start of dead code removal.
		do
			processed := processed + a_processed
			if is_verbose then
				put_string (translate (lb_dead_code_done_to_go_2, [processed, a_to_go]))
				flush_output
			end
		end

	put_case_cluster_message (a_name: STRING)
			-- Put message to indicate that `a_name' is being
			-- analyzed.
		require
			name_not_void: a_name /= Void
		local
			str: STRING
		do
			str := a_name.as_lower
			put_string (lb_case_cluster_message + str)
		end

	put_case_class_message (a_class: CONF_CLASS)
			-- Put message to indicate that `a_class' is being
			-- analyzed for case.
		require
			a_class_attached: a_class /= Void
		do
			put_degree (lb_case_class_message, total_number - processed, a_class.name)
			processed := processed + 1;
		end

	put_class_document_message (a_class: CONF_CLASS)
			-- Put message to indicate that `a_class' is being
			-- generated for documentation.
		require
			a_class_attached: a_class /= Void
		do
			put_degree (lb_document_class_message, total_number - processed, a_class.name)
			processed := processed + 1;
		end

	skip_case_class
			-- Process the skipping of a case class.
		do
			processed := processed + 1;
		end

	flush_output
			-- Make sure any pending output is flushed to display.
		do
			-- By default do nothing
		end

feature {SYSTEM_I} -- Implementation

	put_degree_output (deg_nbr: STRING; to_go: INTEGER; total: INTEGER)
			-- Display degree `deg_nbr' with entity `a_class'.
		do
			total_number := total;
			if is_verbose then
				put_message (percentage_prefix (to_go) + deg_nbr);
				put_new_line
			end
		end

feature {NONE} -- Internationalization

	lb_group: STRING = "group"
	lb_class: STRING = "class"
	lb_degree: STRING = "Degree"
	lb_degree_6: STRING = "Examining System"
	lb_degree_5: STRING = "Parsing Classes"
	lb_degree_4: STRING = "Analyzing Inheritance"
	lb_degree_3: STRING = "Checking Types"
	lb_degree_2: STRING = "Generating Byte Code"
	lb_degree_1: STRING = "Generating Metadata"
	lb_degree_0: STRING = "Processing"
	lb_degree_minus_1: STRING = "Generating Code"
	lb_degree_minus_2: STRING = "Constructing Polymorphic Table"
	lb_degree_minus_3: STRING = "Generating Optimized Code"

	lb_compiler_header_1: STRING = "Eiffel Compilation Manager%NVersion $1"
	lb_melting_changes_message: STRING = "Melting System Changes"
	lb_consume_assemblies_message: STRING = "Pre-consuming Assembly Types"
	lb_freezing_system_message: STRING = "Freezing System Changes"
	lb_removing_dead_code_message: STRING = "Removing Unused Code"
	lb_system_recompiled: STRING = "System Recompiled."
	lb_dead_code_done_to_go_2: STRING = "Features done: $1%TFeatures to go: $2"

	lb_initialize_documentation: STRING = "Initializing Documentation."
	lb_generating_1: STRING = "Generating $1"
	lb_document_class_message: STRING = "Generating Class "
	lb_case_class_message: STRING = "Analyzing Class "
	lb_case_cluster_message: STRING = "Analyzing Cluster "

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end
