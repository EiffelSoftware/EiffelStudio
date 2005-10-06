indexing
	description: "This class does some modification upon the UNIX_PROCESS class to use unname pipe to communicate through different processes."
	author: "Jason Wei"
	date: "$Date$"
	revision: "$Revision$"

class 
	PROCESS_UNIX_PROCESS_MANAGER_2

inherit
	PROCESS_UNIX_PROCESS_MANAGER
		rename
			make as make_unix
		export
			{IO_REDIRECTION_PROCESS_LAUNCHER} input_to_child, output_from_child, error_from_child, wait_for_process_noblock
			{PROCESS_UNIX_PROCESS_MANAGER_2} make_unix
		redefine
			open_files_and_pipes,
			setup_child_process_files,
			setup_parent_process_files,
			spawn_nowait
		end

create 
	make

feature {NONE} 

	make (fname: STRING; working_dir: STRING) is
		do
			make_unix (fname)
			create working_directory.make_from_string (working_dir)
		end

	open_files_and_pipes is
		local
			pipe_fac: UNIX_PIPE_FACTORY
		do
			create pipe_fac
			child_input_file := Void
			shared_input_unnamed_pipe := Void
			in_file := Void
			if input_piped then
				shared_input_unnamed_pipe := pipe_fac.new_unnamed_pipe
			elseif valid_file_descriptor (input_descriptor) then
			elseif input_file_name = Void then
			elseif input_file_name.is_empty then
			else
				create in_file.make_open_read (input_file_name)
			end
			child_output_file := Void
			shared_output_unnamed_pipe := Void
			out_file := Void
			if output_piped then
				shared_output_unnamed_pipe := pipe_fac.new_unnamed_pipe
			elseif valid_file_descriptor (output_descriptor) then
			elseif output_file_name = Void then
			elseif output_file_name.is_empty then
			else
				create out_file.make_open_write (output_file_name)
			end
			child_error_file := Void
			shared_error_unnamed_pipe := Void
			err_file := Void
			if error_same_as_output then
				-- No action.
			elseif error_piped then
				shared_error_unnamed_pipe := pipe_fac.new_unnamed_pipe
			elseif valid_file_descriptor (error_descriptor) then
			elseif error_file_name = Void then
			elseif error_file_name.is_empty then
			else
				create err_file.make_open_write (error_file_name)
			end
		end

	setup_child_process_files is
		do
			if input_piped then
				create child_input_file.make ("a_file")
				move_desc (shared_input_unnamed_pipe.read_descriptor, stdin_descriptor)
				shared_input_unnamed_pipe.close_write_descriptor
			elseif valid_file_descriptor (input_descriptor) then
				duplicate_file_descriptor (input_descriptor, stdin_descriptor)
			elseif input_file_name = Void then
			elseif input_file_name.is_empty then
				--close_file_descriptor (stdin_descriptor)
			else
				move_desc (in_file.descriptor, stdin_descriptor)
			end
			if output_piped then
				create child_output_file.make ("b_file")
				move_desc (shared_output_unnamed_pipe.write_descriptor, stdout_descriptor)
				shared_output_unnamed_pipe.close_read_descriptor
			elseif valid_file_descriptor (output_descriptor) then
				duplicate_file_descriptor (output_descriptor, stdout_descriptor)
			elseif output_file_name = Void then
			elseif output_file_name.is_empty then
				--close_file_descriptor (stdout_descriptor)
			else
				move_desc (out_file.descriptor, stdout_descriptor)
			end
			if error_same_as_output then
				child_error_file := child_output_file
				duplicate_file_descriptor (stdout_descriptor, stderr_descriptor)
			else
				if error_piped then
					create child_error_file.make ("c_file")
					move_desc (shared_error_unnamed_pipe.write_descriptor, stderr_descriptor)
					shared_error_unnamed_pipe.close_read_descriptor
				elseif valid_file_descriptor (error_descriptor) then
					duplicate_file_descriptor (error_descriptor, stderr_descriptor)
				elseif error_file_name = Void then
				elseif error_file_name.is_empty then
					--close_file_descriptor (stderr_descriptor)
				else
					move_desc (err_file.descriptor, stderr_descriptor)
				end
			end
			
			if valid_file_descriptor (input_descriptor) then
				close_file_descriptor (input_descriptor)
			end
			if valid_file_descriptor (output_descriptor) and output_descriptor /= input_descriptor then
				close_file_descriptor (output_descriptor)
			end
			if not error_same_as_output then
				if valid_file_descriptor (error_descriptor) and error_descriptor /= input_descriptor and error_descriptor /= output_descriptor then
					close_file_descriptor (error_descriptor)
				end
			end
		end

	setup_parent_process_files is
		do
			if input_piped then
				create child_input_file.make ("a_file")
				shared_input_unnamed_pipe.close_read_descriptor
			elseif valid_file_descriptor (input_descriptor) then
			elseif input_file_name = Void then
			elseif input_file_name.is_empty then
			else
				in_file.close
			end
			shared_input_pipe := Void
			in_file := Void
			if output_piped then
				create child_output_file.make ("b_file")
				shared_output_unnamed_pipe.close_write_descriptor
			elseif valid_file_descriptor (output_descriptor) then
			elseif output_file_name = Void then
			elseif output_file_name.is_empty then
			else
				out_file.close
			end
			shared_output_pipe := Void
			out_file := Void
			if error_same_as_output then
					-- No action.
			else
				if error_piped then
					create child_error_file.make ("c_file")
					shared_error_unnamed_pipe.close_write_descriptor
				elseif valid_file_descriptor (error_descriptor) then
				elseif error_file_name = Void then
				elseif error_file_name.is_empty then
				else
					err_file.close
				end
			end
			shared_error_pipe := Void
			err_file := Void
		end
	
feature 

	spawn_nowait is
		local
			a, b:INTEGER
			ee: EXECUTION_ENVIRONMENT
			cur_dir: STRING
		do		
			build_argument_list
			open_files_and_pipes	
			create ee
			create cur_dir.make_from_string ( ee.current_working_directory)
			ee.change_working_directory (working_directory)
			process_id := fork_process
			if process_id = 0 then
				in_child := True
				collection_off
				setup_child_process_files
				exec_process (program_file_name, arguments_for_exec, close_nonstandard_files)
			else
				setup_parent_process_files
				arguments_for_exec := Void
				ee.change_working_directory (cur_dir)
			end
			is_executing := True
		end	
					
feature

	shared_input_unnamed_pipe: UNIX_UNNAMED_PIPE

	shared_output_unnamed_pipe: UNIX_UNNAMED_PIPE

	shared_error_unnamed_pipe: UNIX_UNNAMED_PIPE

	working_directory: STRING

end -- class PROCESS_UNIX_PROCESS_MANAGER_2
