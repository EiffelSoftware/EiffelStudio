indexing

	description: 
		"Degree messages output during compilation. %
		%By default, all output is redirected to `io'.";
	date: "$Date$";
	revision: "$Revision $"

class DEGREE_OUTPUT

feature -- Access

	processed: INTEGER;
			-- Numnber of processed elements

	current_degree: INTEGER;
			-- Current degree being displayed

	last_reached_degree: INTEGER;
			-- Current degree being displayed if a compilation is under way,
			-- or else the degree that was attained during the last compilation.

	total_number: INTEGER;
			-- Number of entities being processed

feature -- Start output features

	put_new_compilation is
			-- A new compilation has begun.
		do
			
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
		end;

	put_end_degree_6 is
			-- Put message indicating the end of degree six.
		do
			io.error.putstring ("Processing options%N");
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
		end;

	put_end_degree is
			-- Put message indicating the end of a degree.
		do
			current_degree := 0;
		end;

	put_melting_changes_message  is
			-- Put message indicating that melting changes is ocurring.
		do
			io.error.put_string (melting_changes_message);
			io.error.new_line
		end;

	put_freezing_message is
			-- Put message indicating that freezing is occurring.
		do
			io.error.put_string (freezing_system_message);
			io.error.new_line
		end;

	put_start_dead_code_removal_message  is
			-- Put message indicating the start of dead code removal.
		do
			io.error.put_string (removing_dead_code_message);
			io.error.new_line
		end;

	put_end_dead_code_removal_message  is
			-- Put message indicating the start of dead code removal.
		do
		end;

	finish_degree_output is
			-- Process end degree output.
			-- (Be default, do nothing).
		do
		end;

	put_initializing_documentation is
			-- Start documentation generation.
		do
			io.error.putstring ("Initializing documentation");
			io.error.new_line;
		end

	put_start_documentation (total_num: INTEGER; type: STRING) is
			-- Initialize the document generation.
		require
			valid_type: type /= Void
		do
			total_number := total_num;
			io.error.putstring ("Generating ");
			io.error.putstring (type);
			io.error.new_line;
			processed := 0;
		end;

	put_string (a_message: STRING) is
			-- Put `a_message' to output window.
		do
			io.error.putstring (a_message)
			io.error.new_line
		end

	put_resynchronizing_breakpoints_message is
			-- Put a message to indicate that the 
			-- breakpoints are being resynchronized.
		do
		end

	put_system_compiled is
			-- Put message indicating that the system has been compiled.
		do
			io.error.put_string ("System recompiled.")
			io.error.new_line
		end

	put_header (displayed_version_number: STRING) is
		do
			io.error.putstring (
				"Eiffel compilation manager%N%
				%  (version ")
			io.error.putstring (displayed_version_number)
			io.error.putstring (")%N")
		end

feature -- Output on per class

	put_degree_6 (a_cluster: CLUSTER_SD; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_cluster' is being
			-- compiled during degree six' clusters to go. 
		require
			cluster_not_void: a_cluster /= Void
			positive_nbr_to_go: nbr_to_go >= 0
			in_degree_six: current_degree = 6
		do
			total_number := nbr_to_go + processed
			display_degree (degree_message (6), nbr_to_go, a_cluster.cluster_name)
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
			display_degree (degree_message(5), nbr_to_go, a_class.name_in_upper)
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
			display_degree (degree_message(4), nbr_to_go, a_class.name_in_upper)
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
			processed := processed + 1 -- Used when error ocurrs
			display_degree (degree_message(3), nbr_to_go, a_class.name_in_upper)
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
			display_degree (degree_message(2), nbr_to_go, a_class.name_in_upper)
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
			display_degree (degree_message(1), nbr_to_go, a_class.name_in_upper)
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
			display_degree (degree_message(-1), nbr_to_go, a_class.name_in_upper)
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
			display_degree (degree_message (-2), nbr_to_go, a_class.name_in_upper)
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
			display_degree (degree_message (-3), nbr_to_go, a_class.name_in_upper)
		end

	put_dead_code_removal_message (total_nbr, nbr_to_go: INTEGER) is
			-- Put message progress the start of dead code removal.
		do
			processed := processed + total_nbr
			io.error.putstring ("Features done: ")
			io.error.putint (processed)
			io.error.putstring ("%TFeatures to go: ")
			io.error.putint (nbr_to_go)
			io.error.new_line
		end

	put_case_cluster_message (a_name: STRING) is
			-- Put message to indicate that `a_name' is being
			-- analyzed.
		require
			name_not_void: a_name /= Void
		local	
			str: STRING
		do	
			str := clone (a_name)
			str.to_lower
			io.error.putstring (case_cluster_message)
			io.error.putstring (str)
			io.error.new_line
		end

	put_case_class_message (a_class: CLASS_C) is
			-- Put message to indicate that `a_class' is being
			-- analyzed for case.
		require
			class_not_void: a_class /= Void
		do
			display_degree (case_class_message, 
					total_number - processed, a_class.name_in_upper)
			processed := processed + 1;
		end

	put_class_document_message (a_class: CLASS_C) is
			-- Put message to indicate that `a_class' is being
			-- generated for documentation.
		require
			class_not_void: a_class /= Void
		do
			display_degree (document_class_message, 
					total_number - processed, a_class.name_in_upper)
			processed := processed + 1;
		end

	skip_case_class is
			-- Process the skipping of a case class.
		do
			processed := processed + 1;
		end

feature -- Other

	display_degree_output (deg_nbr: STRING; to_go: INTEGER; total: INTEGER) is
			-- Display degree `deg_nbr' with entity `a_class'.
		do
			total_number := total;
			io.error.putstring (percentage_output (to_go));
			io.error.putstring (deg_nbr);
			io.error.new_line
		end

feature {NONE} -- Implementation

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
			!! Result.make (7);
			Result.append ("[");
			perc := percentage_calculation (nbr_to_go);
			if perc < 10 then
				Result.append ("  ");
			else
				Result.extend (' ')
			end;
			Result.append_integer (perc);
			Result.append_string ("%% - ");
			to_go_out := nbr_to_go.out;
			nbr_spaces := total_nbr_out.count - to_go_out.count;
			inspect nbr_spaces 
			when 1 then
				Result.extend (' ')
			when 2 then
				Result.append ("  ")
			when 3 then
					-- Limit is about 99000
				Result.append ("   ")
			else
			end;
			Result.append (to_go_out)
			Result.append ("] ")
		end

	display_degree (deg_nbr: STRING; to_go: INTEGER; a_name: STRING) is
			-- Display degree `deg_nbr' with entity `a_class'.
		do
			io.error.putstring (percentage_output (to_go));
			io.error.putstring (deg_nbr);
			io.error.putstring (a_name);
			io.error.new_line
		end

	percentage_calculation (to_go: INTEGER): INTEGER is
			-- Percentage calcuation based on `to_go' and `total_number'
		do
			Result := 100 - (100 * to_go) // total_number;
			if Result = 100 and then to_go /= 0 then
				Result := 99
			end	
		end

	degree_message (a_degree: INTEGER): STRING is 
			-- Display the message corresponding to degree `a_degree'.
		do
			create Result.make (20)
			Result.append ("Degree ")
			Result.append_integer(a_degree)
			if a_degree = 6 then
				Result.append (" cluster ")
			else
				Result.append (" class ")
			end
		end

feature {NONE} -- Constants

	melting_changes_message: STRING is "Melting changes";
	freezing_system_message: STRING is "Freezing system";
	removing_dead_code_message: STRING is "Removing dead code";
	case_class_message: STRING is "Analyzing class ";
	case_cluster_message: STRING is "Analyzing cluster ";
	document_class_message: STRING is "Generating class ";

end -- class degree_output
