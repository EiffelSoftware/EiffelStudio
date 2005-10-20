indexing
	description: "Object that manipulate the process launching on UNIX and LINUX"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class 
	IO_REDIRECTION_PROCESS_LAUNCHER

inherit
	EXCEPTIONS
		export
			{NONE} all
		end

	EXCEP_CONST
		export
			{NONE} all
		end

create 
	make

feature {NONE} 

	make (exec: STRING; arg_list: LIST [STRING]; a_working_directory: STRING) is
		require
			exec_not_void: exec /= Void
			exec_not_empty: not exec.is_empty
		local
			args: ARRAY [STRING]
			count: INTEGER
			i: INTEGER
		do
			if a_working_directory = Void then
				working_directory := ""
			else
				create working_directory.make_from_string (a_working_directory)
			end
			if arg_list /= Void then
				count := arg_list.count
				create args.make (1, count)
				from
					i := 1
					arg_list.start
				until
					arg_list.exhausted
				loop
					args.put (arg_list.item, i)
					arg_list.forth
					i := i + 1
				end
			else
				args := Void
			end
			create child_process.make (exec, working_directory)
			child_process.set_arguments (args)
			child_process.set_close_nonstandard_files (True)
		end
	
feature 

	terminate is
		do
			if child_process /= Void then
				try_to_terminate
				child_process.get_status_block
			end
		end

	launch (inf, outf, errf: STRING) is
		local
			retried: BOOLEAN
			is_error_same_as_output: BOOLEAN
		do
			if not retried then
				is_error_same_as_output := error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output
				child_process.set_input_file_name (inf)
				child_process.set_output_file_name (outf)
				if is_error_same_as_output then
					child_process.set_error_same_as_output
				else
					child_process.set_error_file_name (errf)
				end
				child_process.spawn_nowait
				launched := True
			end
		rescue
			retried := True
			launched := False
			retry
		end

	wait_for_exit is
		require
			process_launched: launched
		do
			child_process.get_status_block
			process_status := child_process.status
		ensure
			process_exited: has_process_exited
		end

	close is
		do
			close_input
			close_output
			close_error
		end

	set_child_process_to_void is
		do
			child_process := Void
		end
	
feature 

	put_string (s: STRING) is
		require else
			process_launched: launched
			process_not_exited: not has_process_exited
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			child_process.shared_input_unnamed_pipe.put_string (s)
		end

	read_output_stream is
		require
			process_launched: launched
		local
			in_progress: BOOLEAN
		do
			if not in_progress then
				if child_process /= Void then
					child_process.shared_output_unnamed_pipe.read_stream_non_block (buffer_size)
					last_output := child_process.shared_output_unnamed_pipe.last_string
					if last_output = Void then
					end
				else
					last_output := Void
				end
			end
		rescue
			if exception = io_exception then
				in_progress := True
				last_output := Void
				retry
			end
		end

	read_error_stream is
		require
			process_launched: launched
		local
			in_progress: BOOLEAN
		do
			if not in_progress then
				if child_process /= Void then
					child_process.shared_error_unnamed_pipe.read_stream_non_block (buffer_size)
					last_error := child_process.shared_error_unnamed_pipe.last_string
					if last_error = Void then
					end
				else
					last_error := Void
				end
			end
		rescue
			if exception = io_exception then
				in_progress := True
				last_error := Void
				retry
			end
		end
	
feature 

	buffer_size: INTEGER

	last_output: STRING

	last_error: STRING

	input_direction: INTEGER

	output_direction: INTEGER

	error_direction: INTEGER

	process_status: INTEGER

	launched: BOOLEAN

	has_process_exited: BOOLEAN is
		require
			process_launched: launched
		do
			if child_process = Void then
				Result := True
			else
				process_status := child_process.wait_for_process_noblock (child_process.process_id, $Result)
			end
		end
	
feature 

	set_buffer_size (a_buffer_size: INTEGER) is
		require
			a_buffer_size_positive: a_buffer_size > 0
		do
			buffer_size := a_buffer_size
		ensure
			buffer_size_set: buffer_size = a_buffer_size
		end

	set_input_direction (direction: INTEGER) is
		do
			input_direction := direction
		ensure
			input_direction_set: input_direction = direction
		end

	set_output_direction (direction: INTEGER) is
		do
			output_direction := direction
		ensure
			output_direction_set: output_direction = direction
		end

	set_error_direction (direction: INTEGER) is
		do
			error_direction := direction
		ensure
			error_direction_set: error_direction = direction
		end
	
feature {NONE} 

	child_process: PROCESS_UNIX_PROCESS_MANAGER

	working_directory: STRING
	
feature {NONE} 

	close_input is
		do
			if child_process.shared_input_unnamed_pipe /= Void then
				if child_process.shared_input_unnamed_pipe.is_closed = False then
					child_process.shared_input_unnamed_pipe.close
				end
			end
		end

	close_output is
		do
			if child_process.shared_output_unnamed_pipe /= Void then
				if child_process.shared_output_unnamed_pipe.is_open_read then
					child_process.shared_output_unnamed_pipe.close_read_descriptor
				end
			end
		end

	close_error is
		do
			if not (error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output) then
				if child_process.shared_error_unnamed_pipe /= Void then
					if child_process.shared_error_unnamed_pipe.is_open_read then
						child_process.shared_error_unnamed_pipe.close_read_descriptor
					end
				end
			end
		end

	try_to_terminate is
		local
			tried: BOOLEAN
		do
			if not tried then
				child_process.terminate_hard
			end
		rescue
			tried := True
			retry
		end

	Invalid_file_descriptor: INTEGER is -1
	
end
