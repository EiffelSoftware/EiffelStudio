indexing

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

	default_create is
			-- Create and initialize degree output.
		do
			is_output_quiet := False
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

	is_compilation_cancellable: BOOLEAN is
			-- May the compilation be cancelled at the current stage/degree?
		do
			Result := current_degree > 2 or else current_degree = -2
					-- Cannot cancel a compilation after end of degree 3, or
					-- after degree -2 because we need to generate code at
					-- this stage, and we cannot save what we have generated
					-- and what we have not generated.		
		end

feature -- Start output features

	put_new_compilation is
			-- A new compilation has begun.
		do
			cancel_compilation_requested := False
		end

	put_start_degree_6 (total_nbr: INTEGER) is
			-- Put message indicating the start of degree six
			-- with `total_nbr' passes to be done.
		require
			positive_total_nbr: total_nbr >= 0
		do
			total_number := total_nbr;
			current_degree := 6;
			last_reached_degree := 6;
			processed := 0
			if is_output_quiet then
				display_message (degree_description (6))
				display_new_line
			end
		end

	put_end_degree_6 is
			-- Put message indicating the end of degree six.
		do
			if not is_output_quiet then
				display_message (once "Processing options");
				display_new_line
			end
		end;

	put_start_degree (degree_nbr: INTEGER; total_nbr: INTEGER) is
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

	degree_description (a_degree: INTEGER): STRING is
			-- Description for the currently processed degree.
		require
			a_degree_valid: a_degree >= -3 and then a_degree <= 6
		local
			l_degree_str: STRING
		do
			create Result.make (35)
			inspect
				a_degree
			when 6 then
				l_degree_str := once "Examining Universe"
			when 5 then
				l_degree_str := once "Parsing Classes"
			when 4 then
				l_degree_str := once "Inheritance Analysis"
			when 3 then
				l_degree_str := once "Type Checking"
			when 2 then
				l_degree_str := once "Melting code (code)"
			when 1 then
				l_degree_str := once "Melting code (metadata)"
			when 0 then
					-- Used when generating documentation
				l_degree_str := once "Processing"
			when -1 then
				l_degree_str := once "Code Generation"
			when -2 then
				l_degree_str := once "Building Polymorphic table"
			when -3 then
				l_degree_str := once "Optimized Code Generation"
			end
			if a_degree /= 0 then
				Result.append (Degree_output_string + a_degree.out + ": ")
			end
			Result.append (l_degree_str)
		ensure
			result_not_void: Result /= Void
		end

	put_end_degree is
			-- Put message indicating the end of a degree.
		do
			current_degree := 0;
		end;

	put_melting_changes_message  is
			-- Put message indicating that melting changes is occurring.
		do
			if not is_output_quiet then
				display_message (melting_changes_message);
				display_new_line
			end
		end;

	put_freezing_message is
			-- Put message indicating that freezing is occurring.
		do
			display_message (freezing_system_message);
			display_new_line
		end;

	put_start_dead_code_removal_message  is
			-- Put message indicating the start of dead code removal.
		do
			display_message (removing_dead_code_message);
			display_new_line
		end;

	put_end_dead_code_removal_message  is
			-- Put message indicating the start of dead code removal.
		do
		end;

	finish_degree_output is
			-- Process end degree output.
		do
			cancel_compilation_requested := False
		end

	put_initializing_documentation is
			-- Start documentation generation.
		do
			display_message ("Initializing documentation");
			display_new_line;
		end

	put_start_documentation (total_num: INTEGER; type: STRING) is
			-- Initialize the document generation.
		require
			valid_type: type /= Void
		do
			total_number := total_num;
			display_message ("Generating ");
			display_message (type);
			display_new_line;
			processed := 0;
		end;

	put_string (a_message: STRING) is
			-- Put `a_message' to output window.
		do
			display_message (a_message)
			display_new_line
		end

	put_resynchronizing_breakpoints_message is
			-- Put a message to indicate that the
			-- breakpoints are being resynchronized.
		do
		end

	put_system_compiled is
			-- Put message indicating that the system has been compiled.
		do
			display_message (once "System recompiled.")
			display_new_line
		end

	put_header (displayed_version_number: STRING) is
		do
			display_message (
				once "Eiffel compilation manager%N%
				%  (version ")
			display_message (displayed_version_number)
			display_message (")%N")
		end

feature -- Output on per class

	put_degree_6 (a_name: STRING; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_name' is being
			-- compiled during degree six' clusters to go.
		require
			a_name_not_void: a_name /= Void
			positive_nbr_to_go: nbr_to_go >= 0
			in_degree_six: current_degree = 6
		do
			total_number := nbr_to_go + processed
			display_degree (degree_message (6), nbr_to_go, a_name)
			processed := processed + 1
		end

	put_recursive_degree_6 (a_cluster: CLUSTER_I; a_path: STRING) is
			-- Put message to indicate that `a_cluster' is being compiled
			-- during degree six and that it is a recursive cluster so we have
			-- to display the path too.
		require
			cluster_not_void: a_cluster /= Void
			in_degree_six: current_degree = 6
		do
			-- Do nothing, but do something in graphical mode.
		end

	put_degree_5 (a_class: CLASS_C; nbr_to_go: INTEGER) is
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

	put_degree_4 (a_class: CLASS_C; nbr_to_go: INTEGER) is
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

	put_degree_3 (a_class: CLASS_C; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_class' is being
			-- compiled during degree three with `nbr_to_go'
			-- classes to go.
		require
			class_not_void: a_class /= Void;
			positive_nbr_to_go: nbr_to_go >= 0
			in_degree_3: current_degree = 3
		do
			processed := processed + 1 -- Used when error occurs
			display_degree (degree_message(3), nbr_to_go, a_class.name)
		end

	put_degree_2 (a_class: CLASS_C; nbr_to_go: INTEGER) is
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

	put_degree_1 (a_class: CLASS_C; nbr_to_go: INTEGER) is
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

	put_degree_minus_1 (a_class: CLASS_C; nbr_to_go: INTEGER) is
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

	put_degree_minus_2 (a_class: CLASS_C; nbr_to_go: INTEGER) is
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

	put_degree_minus_3 (a_class: CLASS_C; nbr_to_go: INTEGER) is
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

	put_dead_code_removal_message (total_nbr, nbr_to_go: INTEGER) is
			-- Put message progress the start of dead code removal.
		do
			processed := processed + total_nbr
			display_message (once "Features done: ")
			display_message (processed.out)
			display_message (once "%TFeatures to go: ")
			display_message (nbr_to_go.out)
			display_new_line
			flush_output
		end

	put_case_cluster_message (a_name: STRING) is
			-- Put message to indicate that `a_name' is being
			-- analyzed.
		require
			name_not_void: a_name /= Void
		local
			str: STRING
		do
			str := a_name.as_lower
			display_message (case_cluster_message)
			display_message (str)
			display_new_line
		end

	put_case_class_message (a_class: CLASS_C) is
			-- Put message to indicate that `a_class' is being
			-- analyzed for case.
		require
			class_not_void: a_class /= Void
		do
			display_degree (case_class_message,
					total_number - processed, a_class.name)
			processed := processed + 1;
		end

	put_class_document_message (a_class: CLASS_C) is
			-- Put message to indicate that `a_class' is being
			-- generated for documentation.
		require
			class_not_void: a_class /= Void
		do
			display_degree (document_class_message,
					total_number - processed, a_class.name)
			processed := processed + 1;
		end

	skip_case_class is
			-- Process the skipping of a case class.
		do
			processed := processed + 1;
		end

	flush_output is
			-- Make sure any pending output is flushed to display.
		do
			-- By default do nothing
		end

feature -- Element Change

	user_has_requested_cancellation is
			-- Flag current compilation for cancellation.
		do
			cancel_compilation_requested := True
		end

feature {NONE} -- Implementation

	degree_message (a_degree: INTEGER): STRING is
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

	display_degree_output (deg_nbr: STRING; to_go: INTEGER; total: INTEGER) is
			-- Display degree `deg_nbr' with entity `a_class'.
		do
			total_number := total;
			display_message (percentage_output (to_go));
			display_message (deg_nbr);
			display_new_line
		end

feature {NONE} -- Display implementation for redefinition by descendants.

	display_degree (deg_nbr: STRING; to_go: INTEGER; a_name: STRING) is
			-- Display degree `deg_nbr' with entity `a_class'.
		do
			if cancel_compilation_requested and then is_compilation_cancellable then
					-- The user has requested cancellation of compilation.
				cancel_compilation_requested := False
				Error_handler.insert_interrupt_error (True)
			end
			if not is_output_quiet then
				display_message (percentage_output (to_go));
				display_message (deg_nbr);
				display_message (a_name);
				display_new_line
			end
		end

	display_percentage (left_to_process: INTEGER) is
			-- Display percentage of 'total_number' for 'left_to_process'.
		do
			display_message (percentage_output (left_to_process))
		end

	percentage_output (nbr_to_go: INTEGER): STRING is
			-- Return percentage based on `nbr_to_go' and
			-- `total_number'
		require
			positive_total_nbr: total_number > 0
		local
			nbr_spaces, perc: INTEGER;
			to_go_out, total_nbr_out: STRING
		do
			total_nbr_out := total_number.out;
			create Result.make (7);
			Result.append (once "[");
			perc := percentage_calculation (nbr_to_go);
			if perc < 10 then
				Result.append (once "  ");
			else
				Result.extend (' ')
			end;
			Result.append_integer (perc);
			Result.append_string (once "%% - ");
			to_go_out := nbr_to_go.out;
			nbr_spaces := total_nbr_out.count - to_go_out.count;
			inspect nbr_spaces
			when 1 then
				Result.extend (' ')
			when 2 then
				Result.append (once "  ")
			when 3 then
					-- Limit is about 99000
				Result.append (once "   ")
			else
			end;
			Result.append (to_go_out)
			Result.append (once "] ")
		end

	percentage_calculation (to_go: INTEGER): INTEGER is
			-- Percentage calcuation based on `to_go' and `total_number'
		do
			Result := 100 - (100 * to_go) // total_number;
			if Result = 100 and then to_go /= 0 then
				Result := 99
			end
		end

	display_message (a_message: STRING) is
			-- Display `a_message' to output.
		require
			a_message_not_void: a_message /= Void
		do
			io.error.put_string (a_message)
		end

	display_new_line is
			-- Display a new line on the output.
		do
			io.error.put_new_line
		end

feature {NONE} -- Implementation

	is_output_quiet: BOOLEAN
		-- Is the output quiet?
		-- False by default as verbosity is the default compiler option

	enable_quiet_output is
			-- Enable quiet output.
		do
			is_output_quiet := True
		end

	disable_quiet_output is
			-- Disable quiet output.
		do
			is_output_quiet := False
		end

feature {NONE} -- Constants

	Melting_changes_message: STRING is "Melting changes";
	Freezing_system_message: STRING is "Freezing system";
	Removing_dead_code_message: STRING is "Removing dead code";
	Case_class_message: STRING is "Analyzing class ";
	Case_cluster_message: STRING is "Analyzing cluster ";
	Document_class_message: STRING is "Generating class ";
	Degree_output_string: STRING is "Degree ";
	Cluster_output_string: STRING is " cluster ";
	Class_output_string: STRING is " class ";;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
