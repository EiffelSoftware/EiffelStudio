indexing
	description: "This class support the GUI for CASEGEN generation"
	author: pascalf
	date: "$Date$"
	revision: "$Revision$"

class CASE_INTERFACE

inherit
  	EB_TOP_SHELL
		rename 
			make as eb_make
		end

	WINDOWS
		export
			{GENERATE_ALL_REVERSE, GENERATE_SELEC_REVERSE} project_tool
		end

	COMMAND	

	SHARED_WORKBENCH

	WINDOW_ATTRIBUTES

creation
	make

feature -- Initialization

	make (output_w: OUTPUT_WINDOW; rev_w: DEGREE_OUTPUT) is
		local
			exit_com: EXIT_REVERSE
		do
			output_window := output_w
			reverse_w := rev_w

			eb_make (1, project_tool.screen)
			set_title ("Reverse engineering tool")

			!! scroll_form.make ("", associated_form)
			!! scroll_list1.make ("scroll_list1", scroll_form);
			scroll_list1.set_multiple_selection
			!! scroll_list2.make ("scroll_list2", scroll_form);
			scroll_list2.set_multiple_selection
			!! arrow_b1.make ("arrow_b1", scroll_form);
			!! arrow_b2.make ("arrow_b2", scroll_form);
			!! label5.make ("label5", scroll_form);
			!! label6.make ("label6", scroll_form)
			!! sep1.make ("ss", scroll_form)

			!! nested_form.make ("", associated_form)
			!! text_field1.make ("text_field1", nested_form);
			!! label4.make ("label4", nested_form);
			!! browsw_b.make ("browsw_b", nested_form);
			!! generate_all_b.make ("generate_all_b", nested_form);
			!! generate_selec_b.make ("generate_selec_b", nested_form);
			!! exit_b.make ("exit_b", nested_form)
			!! sep2.make ("ss", nested_form)

			initialize_lists
			set_values
			set_commands
			display
			set_composite_attributes (Current)
			!! exit_com.make (Current)
			set_delete_command (exit_com)
		end;

feature -- Access

	scroll_form: FORM
			-- Form used for the scrollable lists.

	nested_form: FORM
			-- Form used for everything bellow the scrollable lists.

	scroll_list1: SCROLLABLE_LIST;
			-- Reverse Engineering

	scroll_list2: SCROLLABLE_LIST;
	text_field1: TEXT_FIELD;
	label4: LABEL;
			-- Generation path:

	arrow_b1: ARROW_B;
	arrow_b2: ARROW_B;
	label5: LABEL;
			-- System clusters:

	launch_ecase_b: TOGGLE_B

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

	sep1,sep2: THREE_D_SEPARATOR

	output_window: OUTPUT_WINDOW
	
	reverse_w: DEGREE_OUTPUT

feature -- Initialization specific

	set_commands is 
		local
			a_command1: ADD_CLUSTER_REVERSE
			a_command2: CASE_COMMAND2
		do
			!! a_command1.make (scroll_list1,scroll_list2,TRUE)
			arrow_b2.add_activate_action (a_command1, Void)
			scroll_list1.add_default_action (a_command1, Void)

			!! a_command1.make (scroll_list2,scroll_list1, FALSE)
			arrow_b1.add_activate_action  (a_command1, Void)
			scroll_list2.add_default_action (a_command1, Void)

			!BROWSE_COM!a_command2.make (Current)
			browsw_b.add_activate_action (a_command2, Void)

			!EXIT_REVERSE! a_command2.make (Current)
			exit_b.add_activate_action (a_command2, Void)

			!GENERATE_ALL_REVERSE! a_command2.make (Current)
			generate_all_b.add_activate_action (a_command2, Void)

			!GENERATE_SELEC_REVERSE! a_command2.make (Current)
			generate_selec_b.add_activate_action (a_command2, Void)
		end

	initialize_lists is
		-- initiliaze the lists of clusters
		local
			el: SCROLLABLE_LIST_CLUSTERS
		do
			from 
				universe.clusters.start
			until
				universe.clusters.after
			loop
				!! el.make (universe.clusters.item)
				scroll_list1.extend(el)
				scroll_list1.forth
				universe.clusters.forth
			end
		end

	set_values is
		local
			exec: EXECUTION_ENVIRONMENT
		do
			associated_form.attach_left (scroll_form, 0)
			associated_form.attach_right (scroll_form, 0)
			associated_form.attach_top (scroll_form, 0)
			associated_form.attach_bottom_widget (nested_form, scroll_form, 0)

			associated_form.attach_left (nested_form, 0)
			associated_form.attach_right (nested_form, 0)
			associated_form.attach_bottom (nested_form, 0)

				-- Scroll Form
			scroll_form.set_fraction_base (24)

			label5.set_text ("Included clusters:");
			scroll_form.attach_left (label5, 10)
			scroll_form.attach_top (label5, 10)

			label6.set_text ("Excluded clusters:");
			scroll_form.attach_right (label6, 10)
			scroll_form.attach_top (label6, 10)

				-- Attachement of the left scrollable list
			scroll_form.attach_right (scroll_list1, 5)
			scroll_form.attach_top_widget (label6, scroll_list1, 5)
			scroll_form.attach_left_position (scroll_list1, 14)
			scroll_form.attach_bottom_widget (sep1, scroll_list1, 5)

				-- Attachement of the right scrollable list
			scroll_form.attach_left (scroll_list2, 5)
			scroll_form.attach_top_widget (label5, scroll_list2, 5)
			scroll_form.attach_right_position (scroll_list2, 10)
			scroll_form.attach_bottom_widget (sep1, scroll_list2, 5)

				-- Attachements of the left and right arrows
			arrow_b1.set_right
			arrow_b2.set_left
			scroll_form.attach_top_widget (arrow_b2, arrow_b1, 5)
			scroll_form.attach_top_widget (label6, arrow_b2, 15)
			scroll_form.attach_left_position (arrow_b1, 11)
			scroll_form.attach_left_position (arrow_b2, 11)
			scroll_form.attach_right_position (arrow_b1, 13)
			scroll_form.attach_right_position (arrow_b2, 13)

				-- First separator
			scroll_form.attach_left (sep1, 1)
			scroll_form.attach_right (sep1, 1)
			scroll_form.attach_bottom (sep1, 2)

				-- First row of buttons in nested form
			nested_form.attach_top (text_field1, 10)
			nested_form.attach_top (browsw_b, 2)
			nested_form.attach_top (label4, 12)
			nested_form.attach_left (label4, 5) 
			nested_form.attach_left_widget (label4, text_field1, 5)
			nested_form.attach_right_widget (browsw_b, text_field1, 10)
			nested_form.attach_right (browsw_b, 5)
			!! exec
			text_field1.set_text(exec.current_working_directory)
			text_field1.set_height (24)

			label4.set_text ("Generation path:")
			browsw_b.set_text ("Browse")
			
			nested_form.attach_left (sep2, 0)
			nested_form.attach_right (sep2, 0)
			nested_form.attach_top_widget (text_field1, sep2 ,5)
			nested_form.attach_top_widget (browsw_b, sep2 ,8)
			nested_form.attach_top_widget (label4, sep2 ,10)

			nested_form.attach_left (generate_all_b, 5)
			nested_form.attach_top_widget (sep2, generate_all_b, 5)
			nested_form.attach_bottom (generate_all_b, 5)
			generate_all_b.set_text ("Generate all clusters")

			nested_form.attach_left_widget (generate_all_b, generate_selec_b, 3)
			nested_form.attach_top_widget (sep2, generate_selec_b, 5)
			nested_form.attach_bottom (generate_selec_b, 5)
			generate_selec_b.set_text ("Generate selection")
		
			nested_form.attach_left_widget (generate_selec_b, exit_b, 3)
			nested_form.attach_right (exit_b, 5)
			nested_form.attach_top_widget (sep2, exit_b, 5)
			nested_form.attach_bottom (exit_b, 5)
			exit_b.set_text ("Cancel")
		
			set_x_y (165, 19)
			set_height (400)
			set_width (350)
		end;

	execute (c: ANY) is
		do
		end

end -- class PERM_WIND1
