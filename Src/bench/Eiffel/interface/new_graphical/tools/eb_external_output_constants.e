indexing
	description: "String constants used in external output tool"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_OUTPUT_CONSTANTS

feature
	t_command_name: STRING is 				 "Command name: "
	l_no_command_is_running: STRING is 		 "No command is running"
	f_Input_text_field: STRING is 			 "Type input data here"
	f_Input_send_button: STRING is    		 "Send input data into the running command"
	f_Terminate_command_button: STRING is 	 "Terminate running command"
	f_start_command_button: STRING is 		 "Start command"
	f_run_process_hidden_button: STRING is	 "Run command hidden"
	f_edit_cmd_detail_button: STRING is		 "Edit command"
	f_send_input_button: STRING is			 "Send input to command"
	f_delete_command: STRING is				 "Delete command"
	f_clear_output: STRING is				 "Clear output"
	l_launching: STRING is					 "Launching..."
	l_command_has_been_terminated: STRING is "Command terminated"
	l_launch_failed: STRING is				 "Launch failed"
	l_command_is_running: STRING is			 "Command is running"
	l_command_has_exited: STRING is 		 "Command has exited"
	l_command: STRING is					 "Command"
	l_output: STRING is						 "Output"
	l_input: STRING is						 "Input"
	f_save_output_button: STRING is 		 "Save output to file"
	f_new_cmd_detail_button: STRING is		 "Add a new command"
	State_bar_height: INTEGER is 20
	
	Red_color: EV_COLOR is
			-- Red color
		once
			create Result.make_with_8_bit_rgb (255, 0, 0)
		end
		
	Black_color: EV_COLOR is
			-- Black color
		once
			create Result.make_with_8_bit_rgb (0, 0, 0)			
		end
		
end
