indexing
	description : "This class support the GUI for CASGEN generation"
	author : pascalf

class CASE_INTERFACE

inherit

  	EB_TOP_SHELL
		rename 
			make as super_make
		end

	WINDOWS

	COMMAND	

	SHARED_WORKBENCH

	WINDOW_ATTRIBUTES

creation

	make

feature

	scroll_list1: SCROLLABLE_LIST;
	label1: LABEL;
			-- Reverse Engineering

	scroll_list2: SCROLLABLE_LIST;
	text_field1: TEXT_FIELD;
	label4: LABEL;
			-- Generation path :

	arrow_b1: ARROW_B;
	arrow_b2: ARROW_B;
	label5: LABEL;
			-- System clusters:

	launch_ecase_b : TOGGLE_B

	browsw_b: PUSH_B;
			-- Browse

	generate_all_b: PUSH_B;
			-- Generate all

	generate_selec_b: PUSH_B;
			-- Generate Selection

	exit_b: PUSH_B;
			-- Exit

	label6: LABEL;
			-- Clusters to be generated:

	output_window: OUTPUT_WINDOW
	
	reverse_w: DEGREE_OUTPUT

	make (output_w : OUTPUT_WINDOW;rev_w : DEGREE_OUTPUT) is
		local
			exit_com : EXIT_REVERSE
		do
			old_make ( "Reverse engineering", project_tool.screen )
			output_window := output_w
			reverse_w := rev_w	
			!! associated_form.make ("coucou", Current )		
			!! scroll_list1.make_fixed_size ("scroll_list1", associated_form);
			!! label1.make ("label1", associated_form);
			!! scroll_list2.make_fixed_size ("scroll_list2", associated_form);
			!! text_field1.make ("text_field1", associated_form);
			!! label4.make ("label4", associated_form);
			!! arrow_b1.make ("arrow_b1", associated_form);
			!! arrow_b2.make ("arrow_b2", associated_form);
			!! label5.make ("label5", associated_form);
			!! browsw_b.make ("browsw_b", associated_form);
			!! generate_all_b.make ("generate_all_b", associated_form);
			!! generate_selec_b.make ("generate_selec_b", associated_form);
			!! exit_b.make ("exit_b", associated_form);
			!! label6.make ("label6", associated_form);
			!! launch_ecase_b.make ("launch ecase after generation", associated_form)
			initialize_lists
			set_values
			set_commands
			display
			set_composite_attributes (Current)
			!! exit_com.make ( Current )
			set_delete_command ( exit_com )
		end;

	set_commands is 
		local
			a_command1 : ADD_CLUSTER_REVERSE
			a_command2 : CASE_COMMAND2
		do
			!! a_command1.make ( scroll_list1,scroll_list2,TRUE)
			arrow_b1.add_activate_action (a_command1, Void )
			!! a_command1.make ( scroll_list2,scroll_list1, FALSE)
			arrow_b2.add_activate_action  (a_command1, Void )
			! EXIT_REVERSE ! a_command2.make ( Current)
			exit_b.add_activate_action (a_command2, Void )
			! GENERATE_ALL_REVERSE ! a_command2.make ( Current )
			generate_all_b.add_activate_action ( a_command2, Void )
			! GENERATE_SELEC_REVERSE ! a_command2.make ( Current )
			generate_selec_b.add_activate_action ( a_command2, Void )
		end
	

	initialize_lists is
		-- initiliaze the lists of clusters
		local
			el : SCROLLABLE_LIST_CLUSTERS
		do
			from 
				universe.clusters.start
			until
				universe.clusters.after
			loop
				!! el.make (universe.clusters.item)
				scroll_list1.put_right(el)
				universe.clusters.forth
			end
		end

	set_values is
		do
			scroll_list1.set_x_y (10, 58);
			scroll_list1.set_size (220, 290);
			label1.set_text ("Reverse Engineering");
			label1.forbid_recompute_size;
			label1.set_font_name ("-adobe-helvetica-bold-r-normal--18-180-75-75-p-103-iso8859-1");
			label1.set_x_y (172, 1);
			label1.set_size (220, 36);
			scroll_list2.set_x_y (294, 58);
			scroll_list2.set_size (220, 290);
			text_field1.set_x_y (114, 319);
			text_field1.set_size (276, 33);
			label4.set_text ("Generation path :");
			label4.forbid_recompute_size;
			label4.set_x_y (8, 320);
			label4.set_size (104, 27);
			arrow_b1.set_right;
			arrow_b1.set_x_y (240, 68);
			arrow_b1.set_size (47, 40);
			arrow_b2.set_left;
			arrow_b2.set_x_y (240, 114);
			arrow_b2.set_size (47, 40);
			label5.set_text ("System clusters:");
			label5.set_left_alignment;
			label5.forbid_recompute_size;
			label5.set_x_y (10, 29);
			label5.set_size (100, 27);
			launch_ecase_b.set_x_y (13, 280 )
			browsw_b.set_text ("Browse");
			browsw_b.forbid_recompute_size;
			browsw_b.set_x_y (413, 319);
			browsw_b.set_size (73, 35);
			generate_all_b.set_text ("Generate all");
			generate_all_b.forbid_recompute_size;
			generate_all_b.set_x_y (48, 360);
			generate_all_b.set_size (89, 35);
			generate_selec_b.set_text ("Generate Selection");
			generate_selec_b.forbid_recompute_size;
			generate_selec_b.set_x_y (185, 360);
			generate_selec_b.set_size (162, 35);
			exit_b.set_text ("Exit");
			exit_b.forbid_recompute_size;
			exit_b.set_x_y (385, 360);
			exit_b.set_size (79, 35);
			label6.set_text ("Clusters to be generated:");
			label6.set_left_alignment;
			label6.forbid_recompute_size;
			label6.set_x_y (294, 30);
			label6.set_size (182, 25);
			set_x_y (165, 19);
			set_size (524, 411);
		end;

	execute (c : ANY ) is
		do
		end

end -- class PERM_WIND1
