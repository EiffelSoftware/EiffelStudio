indexing

	description:
		"Degree messages output during compilation. %
		%By default, all output is redirected to `io'.";
	date: "$Date$";
	revision: "$Revision $"

class GRAPHICAL_DEGREE_OUTPUT

inherit

	WEL_MODELESS_DIALOG
		redefine
			setup_dialog, on_cancel
		end;
	WINDOWS;
	INTERFACE_W;
	DEGREE_OUTPUT
		redefine
			put_start_degree_6, put_end_degree_6, put_degree_6,
			put_start_degree, put_end_degree, put_degree_5,
			put_degree_4, put_degree_3, put_degree_2,
			put_degree_1, put_degree_minus_1, put_degree_minus_2,
			put_degree_minus_3, put_degree_minus_4,
			put_degree_minus_5, put_melting_changes_message,
			put_freezing_message, finish_degree_output,
			put_start_dead_code_removal_message,
			put_end_dead_code_removal_message,
			put_dead_code_removal_message,
			put_start_reverse_engineering, put_case_cluster_message,
			put_case_class_message, put_case_message, put_string,
			put_resynchronizing_breakpoints_message
		end

feature -- Start output

	put_start_degree_6 (total_nbr: INTEGER) is
			-- Put message indicating the start of degree six
			-- with `total_nbr' passes to be done.
		local
			i_name: STRING
		do
			icon_name := Project_tool.icon_name;
			create_window;

			total_number := total_nbr;
			nbr_of_clusters := total_nbr;
			current_degree := 6;

			degree_text.set_width (saved_width);
			degree_text.set_text (l_Degree);
			entity_text.set_text (l_Compilation_cluster);
			nbr_to_go_text.set_text (l_Clusters_to_go);
			current_degree_text.set_text (current_degree.out);
			current_entity_text.set_text (Empty_string);
			current_nbr_to_go_text.set_text (total_nbr.out);
			percentage_text.set_text (Zero_percent);

			i_name := clone (icon_name);
			i_name.extend (' ');
			i_name.append (l_Degree);
			i_name.append (current_degree.out);
			Project_tool.set_icon_name (i_name);

			process_messages
		end;

	put_start_degree (degree_nbr: INTEGER; total_nbr: INTEGER) is
			-- Put message indicating the start of a degree
			-- with `total_nbr' to be done.
		local
			i_name: STRING
		do
			total_number := total_nbr;
			current_degree := degree_nbr;
			processed := 0;

			degree_text.set_width (saved_width);
			degree_text.set_text (l_Degree);

			entity_text.set_text (l_Compilation_class);
			nbr_to_go_text.set_text (l_Classes_to_go);

			current_nbr_to_go_text.set_text (total_nbr.out);
			current_degree_text.set_text (degree_nbr.out);
			current_entity_text.set_text (Empty_string);

			percentage_text.set_text (Zero_percent);
			progress_bar.set_position (0);
			i_name := clone (icon_name);
			i_name.extend (' ');
			i_name.append (l_Degree);
			i_name.append (current_degree.out);
			Project_tool.set_icon_name (i_name);

			process_messages
		end;

	put_melting_changes_message is
			-- Put message indicating that the changes
			-- are being melted.
		do
			set_project_icon_name (melting_changes_message);
			put_non_degree_message (melting_changes_message);

			process_messages
		end;

	put_freezing_message is
			-- Put message indicating that the system is
			-- being frozen.
		do
			set_project_icon_name (freezing_system_message);
			put_non_degree_message (freezing_system_message);

			process_messages
		end;

	put_start_dead_code_removal_message is
			-- Put message indicating the start of dead code removal.
		do
			set_project_icon_name (removing_dead_code_message);
			put_non_degree_message (removing_dead_code_message);
			nbr_to_go_text.set_text (l_features_processed);

			process_messages
		end

	put_start_reverse_engineering (total_num: INTEGER) is
			-- Initialize the reverse engineering part.
		do
			set_text (l_Reverse_engineering);
			icon_name := Project_tool.icon_name;
			total_number := total_num;
			processed := 0;

			degree_text.set_text (l_Compilation_cluster);
			entity_text.set_text (l_Compilation_class);
			nbr_to_go_text.set_text (l_Classes_to_go);
			current_nbr_to_go_text.set_text (total_num.out);
			current_entity_text.set_text (Empty_string)

			progress_bar.set_position (0);

			process_messages
		end;

	put_case_message (a_message: STRING) is
			-- Put `a_message' in the output window.
		do
			if not exists then
				create_window;
				degree_text.set_text (Empty_string);
				entity_text.set_text (Empty_string);
				nbr_to_go_text.set_text (Empty_string);
				current_degree_text.set_text (Empty_string);
				current_entity_text.set_text (Empty_string);
				current_nbr_to_go_text.set_text (Empty_string);
				percentage_text.set_text (Zero_percent)
			end;

			put_non_degree_message (a_message);

			process_messages
		end

	put_resynchronizing_breakpoints_message is
			-- Put a message to indicate that the
			-- breakpoints are being resynchronized.
		do
			put_non_degree_message (l_Resynchronizing_breakpoints)
		end

feature -- End output

	put_end_degree_6 is
			-- Put message indicating the end of degree six.
		do
			current_degree := 0;
			nbr_of_clusters := 0;
			update_interface (Empty_string, 0, 100);
			progress_bar.set_position (0);
			total_number := 0;

			process_messages
		end;

	put_end_degree is
			-- Put message indeicating the end of `current_degree'.
		do
			current_degree := 0;
			update_interface (Empty_string, 0, 100);
			progress_bar.set_position (100);
			total_number := 0;

			process_messages
		end;

	finish_degree_output is
			-- Process end degree output.
		do
			if icon_name /= Void then
				Project_tool.set_icon_name (icon_name)
			end;

			if exists then
				hide;
				destroy
			end;

			process_messages
		end;

	put_end_dead_code_removal_message is
			-- Put message indicating the end of dead code removal.
		do
			set_project_icon_name (finished_removing_dead_code_message);

			process_messages
		end

feature -- Per entity output

	put_degree_6 (a_cluster: CLUSTER_I) is
			-- Put message to indicate that a_cluster' is being
			-- compiled during degree six.
		local
			a_per: INTEGER
		do
			a_per := 100 - (nbr_of_clusters * 100 // total_number);

			update_interface (a_cluster.cluster_name, nbr_of_clusters, a_per);
			progress_bar.set_position (a_per);
			nbr_of_clusters := nbr_of_clusters - 1;

			process_messages
		end;

	put_degree_5, put_degree_4 (a_class: E_CLASS; nbr_to_go: INTEGER) is
			-- Put message indicating that `a_class' is being
			-- compiled during `current_degree' with `nbr_to_go'
			-- classes to go.
		local
			a_per: INTEGER
		do
			processed := processed + 1;
			a_per := 100 - (nbr_to_go * 100 // (nbr_to_go + processed));
			update_interface (a_class.name_in_upper, nbr_to_go, a_per);
			progress_bar.set_position (a_per);

			process_messages
		end;

	put_degree_3,
	put_degree_2,
	put_degree_1,
	put_degree_minus_1,
	put_degree_minus_2,
	put_degree_minus_3,
	put_degree_minus_4,
	put_degree_minus_5 (a_class: E_CLASS; nbr_to_go: INTEGER) is
			-- Put message to inidcate that `a_class' is_being
			-- compiled during `current_degree' with `nbr_to_go'
			-- classes to go.
		local
			a_per: INTEGER
		do
			a_per := 100 - (nbr_to_go * 100 // total_number);

			update_interface (a_class.name_in_upper, nbr_to_go, a_per);
			progress_bar.set_position (a_per);

			process_messages
		end;

	put_dead_code_removal_message (features_done, nbr_to_go: INTEGER) is
			-- Put message progress of dead code removal with
			-- `features_done' in last cycle with `nbr_to_go'
			-- features to go.
		local
			a_per: INTEGER
		do
			processed := processed + features_done;
			current_entity_text.set_text (processed.out);
			a_per := 100 - ((features_done * 100) // (nbr_to_go + features_done));
			update_interface (Empty_string, nbr_to_go, a_per);
			progress_bar.set_position (a_per);

			process_messages
		end;

	put_case_cluster_message (a_name: STRING) is
			-- Put message to indicate that `a_name' is being
			-- analyzed.
		local
			str: STRING
		do
			str := clone (a_name);
			str.to_lower;
			current_degree_text.set_text (str);

			process_messages
		end;

	put_case_class_message (a_class: E_CLASS) is
			-- Put message to indicate that `a_class' is being
			-- analyzed for ECase.
		local
			a_per: INTEGER
		do
			a_per := ((100 * processed) // total_number);
			processed := processed + 1;
			progress_bar.set_position (a_per);
			update_interface (a_class.name_in_upper, total_number - processed, a_per);

			process_messages
		end

feature {NONE} -- Implementation

	create_window is
			-- Create the dialog box.
		local
			wi: WEL_COMPOSITE_WINDOW
		do
			wi ?= Project_tool.implementation;
			make_by_id (wi, Dlg_graphical_degree_output);
			!! progress_bar.make_by_id (Current, Prg_compilation_progress);
			!! degree_text.make_by_id (Current, Txt_degree);
			!! entity_text.make_by_id (Current, Txt_entity);
			!! nbr_to_go_text.make_by_id (Current, Txt_nbr_to_go);
			!! current_degree_text.make_by_id (Current, Txt_current_degree);
			!! current_entity_text.make_by_id (Current, Txt_current_entity);
			!! current_nbr_to_go_text.make_by_id (Current, Txt_current_nbr_to_go);
			!! percentage_text.make_by_id (Current, Txt_percentage);

			activate
		end;

	update_interface (a_name: STRING; nbr_to_go: INTEGER; a_per: INTEGER) is
			-- Update the interface for entity `a_name' with `nbr_to_go'
			-- and `a_per' done.
		local
			a_per_out: STRING
		do
			current_nbr_to_go_text.set_text (nbr_to_go.out);
			current_entity_text.set_text (a_name);
			a_per_out := a_per.out;
			a_per_out.append (" %%");
			percentage_text.set_text (a_per_out);
		end;

	put_string (a_message: STRING) is
			-- Put `a_message' in the output window.
		do
			put_non_degree_message (a_message)
		end;

	put_non_degree_message (a_msg: STRING) is
			-- Put `a_msg' in Current.
		require
			valid_message: a_msg /= Void
		do
			progress_bar.set_position (0);
			saved_width := degree_text.width;
			degree_text.resize (width, degree_text.height);
			current_degree_text.set_text (Empty_string);
			nbr_to_go_text.set_text (Empty_string);
			current_nbr_to_go_text.set_text (Empty_string);
			entity_text.set_text (Empty_string);
			current_entity_text.set_text (Empty_string);
			percentage_text.set_text (Empty_string)
			degree_text.set_text (a_msg);
		end;

	set_project_icon_name (msg: STRING) is
			-- Set icon name of `Project_tool' to `msg'.
		local
			i_name: STRING
		do
			i_name := clone (icon_name);
			i_name.extend (' ');
			i_name.append (msg);
			Project_tool.set_icon_name (i_name)
		end;

	setup_dialog is
			-- Setting up Current.
		do
			progress_bar.set_range (0, 100);
			progress_bar.set_step (5);
			progress_bar.set_position (0);

			saved_width := degree_text.width
		end;

	process_messages is
			-- Process messages in the msg queue of current app.
		do
			from
				win_msg.peek_all
			until
				not win_msg.last_boolean_result
			loop
				if win_msg.last_boolean_result then
					win_msg.translate;
					win_msg.dispatch
				end;
				win_msg.peek_all
			end
		end

feature {NONE} -- Dialog IDs

	Dlg_graphical_degree_output: INTEGER is 105;
	Prg_compilation_progress: INTEGER is 106;
	Txt_degree: INTEGER is 107;
	Txt_entity: INTEGER is 108;
	Txt_current_degree: INTEGER is 109;
	Txt_current_entity: INTEGER is 110;
	Txt_percentage: INTEGER is 111;
	Txt_nbr_to_go: INTEGER is 112;
	Txt_current_nbr_to_go: INTEGER is 113

feature {NONE} -- Properties

	finished_removing_dead_code_message: STRING is
				"Removing dead code completed"

	Zero_percent: STRING is "0%%   ";

	Empty_string: STRING is "    ";

	icon_name: STRING;
			-- Name of the icon for the Porject tool

	saved_width: INTEGER;
			-- Saved width of `degree_text' when used
			-- for `non_degree_messages'

	win_msg: WEL_MSG is
			-- Used by `process_messages'
		once
			!! Result.make
		end

feature {NONE} -- Windows Message Handlers

	on_cancel is
			-- Button Cancel has been pressed.
		do
			process_messages
		end

feature {NONE} -- User Interface Objects

	progress_bar: WEL_PROGRESS_BAR;
	degree_text,
	entity_text,
	nbr_to_go_text,
	current_degree_text,
	current_entity_text,
	current_nbr_to_go_text,
	percentage_text: WEL_STATIC

end -- class GRAPHICAL_DEGREE_OUTPUT
	
