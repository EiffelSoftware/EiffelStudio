indexing

	description: 
		"Degree messages output during compilation. %
		%By default, all output is redirected to `io'.";
	date: "$Date$";
	revision: "$Revision $"

class GRAPHICAL_DEGREE_OUTPUT

inherit

	MEL_FORM_DIALOG;
	WINDOWS;
	INTERFACE_W;
	SET_WINDOW_ATTRIBUTES;
	SHARED_CURSORS;
	G_ANY;
	DEGREE_OUTPUT
		redefine
			put_start_degree_6, put_end_degree_6, put_start_degree, 
			put_end_degree, put_melting_changes_message, put_freezing_message, 
			put_start_dead_code_removal_message, put_end_dead_code_removal_message,
			put_degree_6, put_degree_5, put_degree_4, put_degree_3, 
			put_degree_2, put_degree_1, put_degree_minus_1, 
			put_degree_minus_2, put_degree_minus_3,
			put_degree_minus_4, put_degree_minus_5, 
			put_dead_code_removal_message, finish_degree_output
		end 

feature -- Start output features

	put_start_degree_6 (total_nbr: INTEGER) is
			-- Put message indicating the start of degree six
			-- with `total_nbr' passes to be done.
		local
			just_created: BOOLEAN;
			cursor_imp: SCREEN_CURSOR_X;
			i_name: STRING
		do
			icon_name := Project_tool.icon_name;
			if is_destroyed then	
				just_created := True;
				create_window
			end;
			total_number := total_nbr;
			nbr_of_clusters := total_nbr;
			current_degree := 6;

			entity_l.unmanage;
			nbr_to_go_l.unmanage;
			current_nbr_to_go_l.unmanage;
			current_degree_l.unmanage;
			current_entity_l.unmanage;

			degree_l.set_label_as_string (l_Degree);
			entity_l.set_label_as_string (l_Compilation_cluster);
			nbr_to_go_l.set_label_as_string (l_Clusters_to_go);
			current_nbr_to_go_l.set_label_as_string (total_nbr.out);
			current_degree_l.set_label_as_string (current_degree.out)
			current_entity_l.set_label_as_string (Empty_string);
			percentage_l.set_label_as_string (Zero_percent);

			entity_l.manage;
			nbr_to_go_l.manage;
			current_nbr_to_go_l.manage;
			current_degree_l.manage;
			current_entity_l.manage;

			manage;
			progress_bar.reset_percentage;
			if just_created then
				cursor_imp ?= cur_Watch.implementation;
				define_cursor (cursor_imp);
				parent.set_max_height (height);
				parent.set_max_width (width);
				parent.set_min_height (height);
				parent.set_min_width (width);
			end;
			i_name := clone (icon_name);
			i_name.extend (' ');
			i_name.append (l_Degree);
			i_name.append (current_degree.out);
			Project_tool.set_icon_name (i_name);
			update_display;
		end;

	put_end_degree_6 is
			-- Put message indicating the end of degree six.
		do
			current_degree := 0;
			nbr_of_clusters := 0
			current_nbr_to_go_l.set_label_as_string (nbr_of_clusters.out);
			update_interface (Empty_string, 0, 100);
			progress_bar.increase_percentage (100);
			update_display
		end;

	put_start_degree (degree_nbr: INTEGER; total_nbr: INTEGER) is
			-- Put message indicating the start of a degree 
			-- with `total_nbr' passes to be done.
		local
			i_name: STRING
		do
			total_number := total_nbr;
			current_degree := degree_nbr;
			processed := 0;

			degree_l.set_label_as_string (l_Degree);
			entity_l.unmanage;
			entity_l.set_label_as_string (l_Compilation_class);
			entity_l.manage;
			nbr_to_go_l.set_label_as_string (l_Classes_to_go);

			current_nbr_to_go_l.set_label_as_string (total_nbr.out);
			current_degree_l.set_label_as_string (degree_nbr.out)
			current_entity_l.set_label_as_string (Empty_string);

			percentage_l.set_label_as_string (Zero_percent);
			progress_bar.reset_percentage;
			i_name := clone (icon_name);
			i_name.extend (' ');
			i_name.append (l_Degree);
			i_name.append (current_degree.out);
			Project_tool.set_icon_name (i_name);
			update_display
		end;

	put_end_degree is
			-- Put message indicating the end of a degree.
		do
			current_degree := 0;
			update_interface (Empty_string, 0, 100);
			progress_bar.increase_percentage (100);
			update_display;
			total_number := 0;
		end;

	put_melting_changes_message  is
			-- Put message indicating that melting changes is ocurring.
		local
			i_name: STRING
		do
			set_project_icon_name (melting_changes_message)
            put_non_degree_message (melting_changes_message);
		end;

	put_freezing_message is
			-- Put message indicating that freezing is occurring.
		do
			set_project_icon_name (freezing_system_message)
			put_non_degree_message (freezing_system_message);
		end;

    put_start_dead_code_removal_message  is
            -- Put message indicating the start of dead code removal.
        do
			set_project_icon_name (removing_dead_code_message)
            put_non_degree_message (removing_dead_code_message);
			entity_l.unmanage;
			entity_l.set_label_as_string (l_features_processed);
			entity_l.manage;
        end;

	put_end_dead_code_removal_message  is
			-- Put message indicating the start of dead code removal.
		do
			put_non_degree_message (finished_removing_dead_code_message);
		end;

	finish_degree_output is
			-- Process end degree output.
		do
			Project_tool.set_icon_name (icon_name);
			unmanage
		end;

feature -- Output on per class

	put_degree_6 (a_cluster: CLUSTER_I) is
			-- Put message to indicate that `a_cluster' is being
			-- compiled during degree six' clusters to go. 
		local
			a_per: INTEGER
		do
			a_per := 100 - (nbr_of_clusters*100//total_number);

			update_interface (a_cluster.cluster_name, nbr_of_clusters, a_per);
			progress_bar.increase_percentage (a_per);
			update_display;
			nbr_of_clusters := nbr_of_clusters - 1;
		end;

	put_degree_5, put_degree_4 (a_class: E_CLASS; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_class' is being
			-- compiled during a degree four and five pass with `nbr_to_go' 
			-- classes to go.
		local
			a_per: INTEGER;
			a_per_out: STRING
		do
			processed := processed + 1;
			a_per := 100 - (nbr_to_go*100//(nbr_to_go + processed));
			update_interface (a_class.name_in_upper, nbr_to_go, a_per);
			progress_bar.update_percentage (a_per);
			update_display;
		end;

	put_degree_3,
	put_degree_2,
	put_degree_1, 
	put_degree_minus_1, 
	put_degree_minus_2, 
	put_degree_minus_3,
	put_degree_minus_4, 
	put_degree_minus_5 (a_class: E_CLASS; nbr_to_go: INTEGER) is
			-- Put message to indicate that `a_class' is being
			-- compiled during a degree pass with `nbr_to_go' 
			-- classes to go.
		local
			a_per: INTEGER;
			a_per_out: STRING
		do
			a_per := 100 - (nbr_to_go*100//total_number);

			update_interface (a_class.name_in_upper, nbr_to_go, a_per);
			progress_bar.increase_percentage (a_per);
			update_display
		end;

	put_dead_code_removal_message (features_done, nbr_to_go: INTEGER) is
			-- Put message progress of dead code removal with
			-- `features_done' in last cycle with `nbr_to_go'
			-- features to go.
		local
			a_per: INTEGER
		do
			processed := features_done + processed;
			current_entity_l.set_label_as_string (processed.out);
			a_per := 100 * (features_done // nbr_to_go + features_done);
			update_interface (Empty_string, nbr_to_go, a_per);
		end;

feature {NONE} -- Implementation

	update_interface (a_name: STRING; nbr_to_go: INTEGER; a_per: INTEGER) is
			-- Update the interface for entity `a_name' with `nbr_to_go'
			-- and `a_per' done.
		local
			a_per_out: STRING
		do
			current_nbr_to_go_l.set_label_as_string (nbr_to_go.out);
			current_entity_l.set_label_as_string (a_name);
			a_per_out := a_per.out;
			a_per_out.extend ('%%');
			percentage_l.set_label_as_string (a_per_out);
		end;

	put_non_degree_message (a_message: STRING) is
			-- Put a non degree message.
		require
			valid_message: a_message /= Void
		do
			progress_bar.reset_percentage;
			degree_l.unmanage;
			degree_l.set_label_as_string (a_message);
			degree_l.manage;
			current_degree_l.set_label_as_string (Empty_string);
			entity_l.set_label_as_string (Empty_string);
			nbr_to_go_l.set_label_as_string (Empty_string);
			current_nbr_to_go_l.set_label_as_string (Empty_string);
			current_entity_l.set_label_as_string (Empty_string);
			percentage_l.set_label_as_string (Zero_percent);
			update_display
		end;

feature {NONE} -- Implementation

	icon_name: STRING;
			-- Icon name of project tool

	Zero_percent: STRING is "0%%    ";

	Empty_string: STRING is "  ";

	finished_removing_dead_code_message: STRING is
				"Removing dead code completed"

	degree_l: MEL_LABEL_GADGET;
			-- Degree: label

	entity_l: MEL_LABEL_GADGET;
			-- Class/Cluster: label

	nbr_to_go_l: MEL_LABEL_GADGET;
			-- Number of entities to go: label

	current_degree_l: MEL_LABEL_GADGET;
			-- Label indicating current degree

	current_entity_l: MEL_LABEL_GADGET;
			-- Label indicating current class/cluster

	current_nbr_to_go_l: MEL_LABEL_GADGET;
			-- Label indicating number of entities to go

	progress_bar: PROGRESS_BAR;
			-- Progress bar indicating percentage done

	percentage_l: MEL_LABEL_GADGET;
			-- Percentage label

	create_window is
			-- Create the compilation progress window.
		require
			destroyed: is_destroyed;
		local
			frame: MEL_FRAME;
			mel_parent: MEL_COMPOSITE;	
		do
			mel_parent ?= Project_tool.implementation;
			make (l_Compilation_progress, mel_parent);
			parent.set_title (l_Compilation_progress);
			!! degree_l.make ("", Current, True);	
			!! entity_l.make ("", Current, True);	
			!! nbr_to_go_l.make ("", Current, True);	
			!! current_degree_l.make ("", Current, True);	
			!! current_entity_l.make ("", Current, True);	
			!! current_nbr_to_go_l.make ("", Current, True);	
			!! frame.make ("", Current, True);	
			!! progress_bar.make ("", frame);	
			!! percentage_l.make ("", Current, True);	

			degree_l.attach_top;
			degree_l.attach_left;
			degree_l.set_top_offset (10);
			degree_l.set_left_offset (10);
			current_degree_l.attach_top;
			current_degree_l.set_top_offset (10);
			current_degree_l.attach_left_to_widget (degree_l);
			current_degree_l.set_left_offset (10);

			entity_l.attach_left;
			entity_l.set_left_offset (10);
			entity_l.attach_top_to_widget (degree_l);
			entity_l.set_top_offset (10);
			current_entity_l.attach_top_to_widget (current_degree_l);
			current_entity_l.attach_left_to_widget (entity_l);
			current_entity_l.set_top_offset (10);
			current_entity_l.set_left_offset (10);

			nbr_to_go_l.attach_left;
			nbr_to_go_l.attach_top_to_widget (entity_l);
			nbr_to_go_l.set_top_offset (10);
			nbr_to_go_l.set_left_offset (10);
			current_nbr_to_go_l.attach_top_to_widget (current_entity_l);
			current_nbr_to_go_l.attach_left_to_widget (nbr_to_go_l);
			current_nbr_to_go_l.set_top_offset (10);
			current_nbr_to_go_l.set_left_offset (10);
			current_nbr_to_go_l.set_bottom_offset (10);

			percentage_l.attach_left_to_widget (frame);
			percentage_l.attach_bottom;
			percentage_l.set_left_offset (5);
			percentage_l.set_right_offset (10);
			percentage_l.set_bottom_offset (10);

			frame.attach_top_to_widget (nbr_to_go_l);
			frame.attach_left;
			frame.attach_bottom;
			frame.set_top_offset (10);
			frame.set_left_offset (10);
			frame.set_right_offset (10);
			frame.set_bottom_offset (10);
			set_dialog_full_application_modal;
			update_resources;
		end

	update_resources is
			-- Update the font/color of progress window.
		local
			imp: COLOR_X;
			font_x: FONT_X;
			a_font_list: MEL_FONT_LIST;
			an_entry: MEL_FONT_LIST_ENTRY
		do
			if bg_color /= Void then
				imp ?= bg_color.implementation;
				set_background_color (imp);
				progress_bar.set_background_color (imp);
			end;
			if fg_color /= Void then
				imp ?= fg_color.implementation;
				set_foreground_color (imp);
			end;
			if global_font /= Void then
				font_x ?= global_font.implementation;
				!! an_entry.make_default_from_font_struct (font_x);
				!! a_font_list.append_entry (an_entry);
				if a_font_list.is_valid then
					degree_l.set_font_list (a_font_list);
					entity_l.set_font_list (a_font_list);
					nbr_to_go_l.set_font_list (a_font_list);
					current_degree_l.set_font_list (a_font_list);
					current_entity_l.set_font_list (a_font_list);
					percentage_l.set_font_list (a_font_list);
					a_font_list.free
				else
					io.error.putstring ("Warning can not allocate font%N")
;
				end;
				an_entry.free
			end
		end;

	set_project_icon_name (message: STRING) is
			-- Set icon name of project_tool to `message'.
		local
			i_name: STRING
		do
			i_name := clone (icon_name);
			i_name.extend (' ');
			i_name.append (message);
			Project_tool.set_icon_name (i_name)
		end;

end -- class GRAPHICAL_DEGREE_OUTPUT
