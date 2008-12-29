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
	ANY
		redefine
			default_create
		end

	SHARED_ERROR_HANDLER
		redefine
			default_create
		end

feature {NONE} -- Creation

	default_create
			-- Create and initialize degree output.
		do
			enable_quiet_output
		end

feature -- Access

	cancel_compilation_requested: BOOLEAN
		-- Has the user requested to cancel the compilation?

	processed: INTEGER;
			-- Numnber of processed elements

	current_degree: INTEGER;
			-- Current degree being displayed

	last_reached_degree: INTEGER;
			-- Current degree being displayed if a compilation is under way,
			-- or else the degree that was attained during the last compilation.

	total_number: INTEGER;
			-- Number of entities being processed

feature -- Status Report

	is_compilation_cancellable: BOOLEAN
			-- May the compilation be cancelled at the current stage/degree?
		do
			Result := current_degree > 2 or else current_degree = -2
					-- Cannot cancel a compilation after end of degree 3, or
					-- after degree -2 because we need to generate code at
					-- this stage, and we cannot save what we have generated
					-- and what we have not generated.		
		end

feature -- Status setting

	enable_quiet_output
			-- Enable quiet output.
		do
			is_output_quiet := True
		end

	disable_quiet_output
			-- Disable quiet output.
		do
			is_output_quiet := False
		end

feature -- Start output features

	put_new_compilation
			-- A new compilation has begun.
		do
			cancel_compilation_requested := False
		end

	put_start_degree_6
			-- Put message indicating the start of degree six.
		do
			current_degree := 6;
			last_reached_degree := 6;
			processed := 0
			total_number := 0
			put_start_degree (6, 1)
		end

	put_start_degree (degree_nbr: INTEGER; total_nbr: INTEGER)
			-- Put message indicating the start of a degree
			-- with `total_nbr' passes to be done.
		require
			valid_degree_nbr: degree_nbr >= -5 and then degree_nbr <= 6
			positive_total_nbr: total_nbr >= 0
		do
			total_number := total_nbr;
			current_degree := degree_nbr;
			last_reached_degree := degree_nbr;
			processed := 0
			if is_output_quiet then
				display_message (degree_description (degree_nbr))
				display_new_line
			end
		end;

	degree_short_description (a_degree: INTEGER): STRING
			-- Short description for `a_degree'.
		require
			a_degree_valid: a_degree >= -3 and then a_degree <= 6
		do
			inspect
				a_degree
			when 6 then
				Result := once "Examining System"
			when 5 then
				Result := once "Parsing Classes"
			when 4 then
				Result := once "Analyzing Inheritance"
			when 3 then
				Result := once "Checking Types"
			when 2 then
				Result := once "Generating Byte Code"
			when 1 then
				Result := once "Generating Metadata"
			when 0 then
					-- Used when generating documentation
				Result := once "Processing"
			when -1 then
				Result := once "Generating Code"
			when -2 then
				Result := once "Constructing Polymorphic Table"
			when -3 then
				Result := once "Generating Optimized Code"
			end
		end

	degree_description (a_degree: INTEGER): STRING
			-- Description for the currently processed degree.
		require
			a_degree_valid: a_degree >= -3 and then a_degree <= 6
		local
			l_degree_str: STRING
		do
			create Result.make (35)
			l_degree_str := degree_short_description (a_degree)
			if a_degree /= 0 then
				Result.append (Degree_output_string + a_degree.out + ": ")
			end
			Result.append (l_degree_str)
		ensure
			result_not_void: Result /= Void
		end

	put_end_degree
			-- Put message indicating the end of a degree.
		do
			current_degree := 0;
		end;

	put_melting_changes_message
			-- Put message indicating that melting changes is occurring.
		do
			display_message (melting_changes_message);
			display_new_line
		end;

	put_freezing_message
			-- Put message indicating that freezing is occurring.
		do
			display_message (freezing_system_message);
			display_new_line
		end;

	put_start_dead_code_removal_message
			-- Put message indicating the start of dead code removal.
		do
			display_message (removing_dead_code_message);
			display_new_line
		end;

	put_end_dead_code_removal_message
			-- Put message indicating the start of dead code removal.
		do
		end;

	finish_degree_output
			-- Process end degree output.
		do
			cancel_compilation_requested := False
		end

	put_initializing_documentation
			-- Start documentation generation.
		do
			display_message ("Initializing Documentation");
			display_new_line;
		end

	put_start_documentation (total_num: INTEGER; type: STRING)
			-- Initialize the document generation.
		require
			valid_type: type /= Void
		do
			total_number := total_num;
			display_message ("Generating " + type);
			display_new_line;
			processed := 0;
			current_degree := 0
		end;

	put_string (a_message: STRING)
			-- Put `a_message' to output window.
		do
			display_message (a_message)
			display_new_line
		end

	put_resynchronizing_breakpoints_message
			-- Put a message to indicate that the
			-- breakpoints are being resynchronized.
		do
		end

	put_system_compiled
			-- Put message indicating that the system has been compiled.
		do
			display_message (once "System Recompiled.")
			display_new_line
		end

	put_header (displayed_version_number: STRING)
		local
			l_msg: STRING
		do
			l_msg := once "Eiffel Compilation Manager%N%
				%  (version " + displayed_version_number + ")%N"
			display_message (l_msg)
		end

feature -- Output on per class

	put_consume_assemblies
			-- Put message to indicate that assemblies are consumed.
		do
			display_message (consume_assemblies_message);
			display_new_line
		end

	put_process_group (a_group: CONF_GROUP)
			-- Put message to indicate that `a_group' is processed.
		require
			a_group_not_void: a_group /= Void
		do
				-- clusters are displayed with `put_process_directory'.
			if not a_group.is_cluster then
				display_degree (degree_message(6), 1, a_group.name)
			end
		end

	put_process_directory (a_cluster: CONF_CLUSTER; a_path: STRING)
			-- Put message to indicate that `a_path' of `a_cluster' is processed.
		require
			a_cluster_not_void: a_cluster /= Void
			a_path_not_void: a_path /= Void
		do
			display_degree (degree_message(6), 1, a_cluster.name + a_path)
		end

	put_degree_5 (a_class: CLASS_C; nbr_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree five with `nbr_to_go'
			-- classes to go.
		require
			class_not_void: a_class /= Void
			positive_nbr_to_go: nbr_to_go >= 0
			in_degree_5: current_degree = 5
		do
			total_number := nbr_to_go + processed
			display_degree (degree_message(5), nbr_to_go, a_class.name)
			processed := processed + 1
		end;

	put_degree_4 (a_class: CLASS_C; nbr_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree four with `nbr_to_go'
			-- classes to go out of `total_nbr'..
		require
			class_not_void: a_class /= Void
			positive_nbr_to_go: nbr_to_go >= 0
			in_degree_4: current_degree = 4
		do
			total_number := nbr_to_go + processed
			display_degree (degree_message(4), nbr_to_go, a_class.name)
			processed := processed + 1;
		end

	put_degree_3 (a_class: CLASS_C; nbr_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree three with `nbr_to_go'
			-- classes to go.
		require
			class_not_void: a_class /= Void;
			positive_nbr_to_go: nbr_to_go >= 0
			in_degree_3: current_degree = 3
		do
			total_number := nbr_to_go + processed
			display_degree (degree_message(3), nbr_to_go, a_class.name)
			processed := processed + 1
		end

	put_degree_2 (a_class: CLASS_C; nbr_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree two with `nbr_to_go'
			-- classes to go.
		require
			class_not_void: a_class /= Void;
			positive_nbr_to_go: nbr_to_go >= 0;
			in_degree_2: current_degree = 2
		do
			display_degree (degree_message(2), nbr_to_go, a_class.name)
		end

	put_degree_1 (a_class: CLASS_C; nbr_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree one with `nbr_to_go'
			-- classes to go.
		require
			class_not_void: a_class /= Void;
			positive_nbr_to_go: nbr_to_go >= 0;
			in_degree_1: current_degree = 1
		do
			display_degree (degree_message(1), nbr_to_go, a_class.name)
		end

	put_degree_minus_1 (a_class: CLASS_C; nbr_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree minus one with `nbr_to_go'
			-- classes to go.
		require
			class_not_void: a_class /= Void;
			positive_nbr_to_go: nbr_to_go >= 0;
			in_degree_minus_1: current_degree = -1
		do
			display_degree (degree_message(-1), nbr_to_go, a_class.name)
		end

	put_degree_minus_2 (a_class: CLASS_C; nbr_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree minus four with `nbr_to_go'
			-- classes to go.
		require
			class_not_void: a_class /= Void
			positive_nbr_to_go: nbr_to_go >= 0
			in_degree_minus_2: current_degree = -2
		do
			display_degree (degree_message (-2), nbr_to_go, a_class.name)
		end

	put_degree_minus_3 (a_class: CLASS_C; nbr_to_go: INTEGER)
			-- Put message to indicate that `a_class' is being
			-- compiled during degree minus five with `nbr_to_go'
			-- classes to go.
		require
			class_not_void: a_class /= Void
			positive_nbr_to_go: nbr_to_go >= 0
			in_degree_minus_3: current_degree = -3
		do
			display_degree (degree_message (-3), nbr_to_go, a_class.name)
		end

	put_dead_code_removal_message (a_processed, nbr_to_go: INTEGER)
			-- Put message progress the start of dead code removal.
		local
			l_msg: STRING
		do
			processed := processed + a_processed
			if not is_output_quiet then
				l_msg := once "Features done: " + processed.out + once "%TFeatures to go: " + nbr_to_go.out
				display_message (l_msg)
				display_new_line
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
			display_message (case_cluster_message + str)
			display_new_line
		end

	put_case_class_message (a_class: CONF_CLASS)
			-- Put message to indicate that `a_class' is being
			-- analyzed for case.
		require
			class_not_void: a_class /= Void
		do
			display_degree (case_class_message,
					total_number - processed, a_class.name)
			processed := processed + 1;
		end

	put_class_document_message (a_class: CONF_CLASS)
			-- Put message to indicate that `a_class' is being
			-- generated for documentation.
		require
			class_not_void: a_class /= Void
		do
			display_degree (document_class_message,
					total_number - processed, a_class.name)
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

feature -- Element Change

	user_has_requested_cancellation
			-- Flag current compilation for cancellation.
		do
			cancel_compilation_requested := True
		end

feature {NONE} -- Implementation

	degree_message (a_degree: INTEGER): STRING
			-- Display the message corresponding to degree `a_degree'.
		do
			create Result.make (30)
			Result.append (degree_output_string)
			Result.append_integer(a_degree)
			if a_degree = 6 then
				Result.append (cluster_output_string)
			else
				Result.append (class_output_string)
			end
		end

feature {SYSTEM_I} -- Implementation

	display_degree_output (deg_nbr: STRING; to_go: INTEGER; total: INTEGER)
			-- Display degree `deg_nbr' with entity `a_class'.
		do
			total_number := total;
			if not is_output_quiet then
				display_message (percentage_output (to_go) + deg_nbr);
				display_new_line
			end
		end

feature {NONE} -- Display implementation for redefinition by descendants.

	display_degree (deg_nbr: STRING; to_go: INTEGER; a_name: STRING)
			-- Display degree `deg_nbr' with entity `a_class'.
		do
			if cancel_compilation_requested and then is_compilation_cancellable then
					-- The user has requested cancellation of compilation.
				cancel_compilation_requested := False
				Error_handler.insert_error (create {INTERRUPT_ERROR}.make (True))
				Error_handler.raise_error
			end
			if not is_output_quiet then
				display_message (percentage_output (to_go) + deg_nbr + a_name);
				display_new_line
			end
		end

	display_percentage (left_to_process: INTEGER)
			-- Display percentage of 'total_number' for 'left_to_process'.
		do
			display_message (percentage_output (left_to_process))
		end

	percentage_output (nbr_to_go: INTEGER): STRING
			-- Return percentage based on `nbr_to_go' and
			-- `total_number'
		require
			positive_total_nbr: total_number > 0
		local
			perc: INTEGER;
			to_go_out, total_nbr_out: STRING
			l_two_spaces: STRING
		do
			l_two_spaces := once "  "
			total_nbr_out := total_number.out;
			create Result.make (7);
			Result.extend ('[');
			perc := percentage_calculation (nbr_to_go);
			if perc < 10 then
				Result.append (l_two_spaces);
			else
				Result.extend (' ')
			end;
			Result.append_integer (perc);
			Result.append_string (once "%% - ");
			to_go_out := nbr_to_go.out;
			inspect
				total_nbr_out.count - to_go_out.count
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

			Result.append (to_go_out)
			Result.extend (']')
			Result.extend (' ')
		end

	percentage_calculation (to_go: INTEGER): INTEGER
			-- Percentage calcuation based on `to_go' and `total_number'
		do
				--| FIXME IEK We shouldn't need the max call but there is an odd situation
				--| where the `total_number' is zero (see bug#14036)
			check
				total_number_not_zero: total_number > 0
			end
			Result := 100 - (100 * to_go) // (total_number).max (1);
			if Result = 100 and then to_go /= 0 then
				Result := 99
			end
		end

	display_message (a_message: STRING)
			-- Display `a_message' to output.
		require
			a_message_not_void: a_message /= Void
		do
			io.error.put_string (a_message)
		end

	display_new_line
			-- Display a new line on the output.
		do
			io.error.put_new_line
		end

feature {NONE} -- Implementation

	is_output_quiet: BOOLEAN
		-- Is the output quiet?
		-- True by default.

feature {NONE} -- Constants

	Melting_changes_message: STRING = "Melting System Changes";
	Freezing_system_message: STRING = "Freezing System Changes";
	Removing_dead_code_message: STRING = "Removing Dead Code";
	Case_class_message: STRING = "Analyzing Class ";
	Case_cluster_message: STRING = "Analyzing Cluster ";
	Document_class_message: STRING = "Generating Class ";
	Consume_assemblies_message: STRING = "Pre-consuming Assembly Types";
	Degree_output_string: STRING = "Degree ";
	Cluster_output_string: STRING = " group ";
	Class_output_string: STRING = " class ";

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

end -- class degree_output
