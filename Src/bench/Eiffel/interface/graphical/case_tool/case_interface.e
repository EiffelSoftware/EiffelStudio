indexing
	description : "This class support the GUI for CASEGEN generation"
	author : pascalf

class CASE_INTERFACE

inherit

  	EB_TOP_SHELL
		rename 
			make as super_make
		end

	WINDOWS
		export {GENERATE_ALL_REVERSE}
			project_tool
		end

	COMMAND	

	SHARED_WORKBENCH

	WINDOW_ATTRIBUTES

creation

	make

feature

	scroll_list1: SCROLLABLE_LIST;
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
			-- Clusters to be generated

	sep1,sep2 : THREE_D_SEPARATOR

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
			!! scroll_list2.make_fixed_size ("scroll_list2", associated_form);
			!! text_field1.make ("text_field1", associated_form);
			!! label4.make ("label4", associated_form);
			!! arrow_b1.make ("arrow_b1", associated_form);
			!! arrow_b2.make ("arrow_b2", associated_form);
			!! label5.make ("label5", associated_form);
			!! browsw_b.make ("browsw_b", associated_form);
			!! generate_all_b.make ("generate_all_b", associated_form);
			!! generate_selec_b.make ("generate_selec_b", associated_form);
			!! exit_b.make ("exit_b", associated_form)
			!! label6.make ("label6", associated_form)
			!! sep1.make ("ss", associated_form )
			!! sep2.make ("ss", associated_form )

			tooltip_initialize (Current)

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
			scroll_list1.add_default_action (a_command1, Void )

			!! a_command1.make ( scroll_list2,scroll_list1, FALSE)
			arrow_b2.add_activate_action  (a_command1, Void )
			scroll_list2.add_default_action (a_command1, Void )

			!BROWSE_COM!a_command2.make ( Current )
			browsw_b.add_activate_action ( a_command2, Void )

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
		local
			exec : EXECUTION_ENVIRONMENT
		do

			associated_form.set_fraction_base ( 11 )

			label5.set_text ("System clusters");
			associated_form.attach_left ( label5, 10 )
			associated_form.attach_top ( label5, 10 )

			label6.set_text ("Clusters to be generated");
			associated_form.attach_right ( label6, 10 )
			associated_form.attach_top ( label6, 10 )

			associated_form.attach_left ( scroll_list1, 5)
			associated_form.attach_right ( scroll_list2, 5)
			associated_form.attach_right_position ( scroll_list1, 4)
			associated_form.attach_left_position ( scroll_list2, 7)
			associated_form.attach_top_widget ( label5, scroll_list1, 5 )
			associated_form.attach_top_widget ( label6, scroll_list2, 5 )

			arrow_b1.set_right
			arrow_b2.set_left
			associated_form.attach_top_widget ( label6, arrow_b1, 15 )
			associated_form.attach_top_widget ( arrow_b1, arrow_b2, 5)
			associated_form.attach_left_position ( arrow_b1, 5)
			associated_form.attach_left_position ( arrow_b2, 5)
			associated_form.attach_right_position ( arrow_b1, 6)
			associated_form.attach_right_position ( arrow_b2, 6)

			associated_form.attach_left ( sep1, 0)
			associated_form.attach_right ( sep1, 0)
			associated_form.attach_top_widget ( scroll_list1,sep1,  25 )

			associated_form.attach_top_widget ( sep1, text_field1, 10 )
			associated_form.attach_top_widget ( sep1, browsw_b, 8)
			associated_form.attach_top_widget ( sep1, label4, 12 )
			associated_form.attach_left ( label4, 10 ) 

			associated_form.attach_left_widget ( label4, text_field1, 5)
			associated_form.attach_left_widget ( text_field1, browsw_b, 10 )
			!! exec
			text_field1.set_text(exec.current_working_directory)

			label4.set_text ("Generation path :")
			browsw_b.set_text ("Browse")
			
			associated_form.attach_top_widget ( text_field1,sep2 ,10 )
			associated_form.attach_left ( sep2, 0)
			associated_form.attach_right ( sep2, 0)

			associated_form.attach_left ( generate_all_b, 5 )
			associated_form.attach_top_widget ( sep2, generate_all_b , 10 )
			generate_all_b.set_text ("Generate all")

			associated_form.attach_left_position ( generate_selec_b, 4 )
			associated_form.attach_top_widget ( sep2, generate_selec_b , 10 )
			generate_selec_b.set_text ("Generate Selection")
		
			associated_form.attach_right (exit_b, 5 )
			associated_form.attach_top_widget ( sep2, exit_b , 10 )
			exit_b.set_text ("Exit")
		
			set_x_y (165, 19)
		end;

	execute (c : ANY ) is
		do
		end

end -- class PERM_WIND1
