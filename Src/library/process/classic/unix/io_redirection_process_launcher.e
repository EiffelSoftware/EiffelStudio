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
		end;
    PROCESS_UNIX_OS_ACCESS

create 
	make

feature {NONE} -- Initialization

	make (exec: STRING; arg_list: LIST [STRING]; a_working_directory: STRING) is
			-- Create process object with `exec' as executable with `args' 
			-- as arguments, and with `a_working_directory' as its working directory.
			-- Apply Void to `a_working_directory' if no working directory is specified.
			-- Apply Void to `args' if no argument is necessary.		
		require
			exec_not_void : exec /= Void
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
	
feature  -- Control

	terminate is
			-- Terminate independent process
		do
			if child_process /= Void then
				try_to_terminate
				child_process.get_status_block
			end
		end
		
	launch (inf, outf, errf: STRING) is
			-- Lauch process
			-- `inf', `outf' and `errf' are file names used to redirect process' input, output and error respectively.
			-- if `inf' (`outf' or `errf') is Void, a pipe is used to transmit data.
			-- if `inf' (`outf' or `errf') is an empty string, redirection is canceled.
		local
			retried: BOOLEAN
			is_error_same_as_output: BOOLEAN
		do
			if not retried then
				is_error_same_as_output := error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output
				if inf = Void then
					child_process.set_input_piped
				elseif inf.is_empty then
						-- No input redirection
						child_process.set_input_file_name ("")						
				else
					child_process.set_input_file_name (inf)
				end
				if outf = Void then
					child_process.set_output_piped
				elseif outf.is_empty then
						-- No output redirection
					child_process.set_output_file_name ("")						
				else
					child_process.set_output_file_name (outf)
				end
				if is_error_same_as_output then
					child_process.set_error_same_as_output
				else
					if errf = Void then
						child_process.set_error_piped
					elseif errf.is_empty then
								-- No error redirection
						child_process.set_error_file_name ("")
					else
						child_process.set_error_file_name (errf)
					end
				end
				child_process.spawn_nowait
				if child_process.output_piped then
					input := child_process.output_from_child
				else
					input := Void
				end
				if child_process.input_piped then
					output := child_process.input_to_child
				else
					output := Void
				end
				if not is_error_same_as_output then
					if child_process.error_piped then
						error := child_process.error_from_child
					else
						error := Void
					end
				end
				launched := True
			end
		rescue
			retried := True
			launched := False
			retry
		end

	wait_for_exit is
				-- Wait for process to exit.
		require
			process_launched: launched
		do
			child_process.get_status_block
			process_status := child_process.status
		ensure
			process_exited: has_process_exited
		end

	close is
			-- Close file descriptors used to communicate with the launched process.
		do
			close_input
			close_output
			close_error
		end
		
	set_child_process_to_void is
			--  Set child_process to Void, used by terminate
		do
			child_process := Void
		end			
		
feature -- Data transmission

	put_string (s: STRING) is
			--Put string `s' into input stream of launched process.
		require else
			process_launched: launched
			process_not_exited: not has_process_exited
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			child_process.shared_input_unnamed_pipe.put_string (s)
		end

	read_output_stream is
			-- Read the output of launched process.
			-- if no data is read or and error occures, return Void.
		require
			process_launched: launched
		local
			in_progress: BOOLEAN
		do
			if not in_progress then
				if child_process /= Void then
					child_process.shared_output_unnamed_pipe.read_stream_non_block (buffer_size)
					last_output := child_process.shared_output_unnamed_pipe.last_string
					if last_output = Void  then				
					end
				else					
					last_output := void
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
			-- Read the error of launched process.
			-- if no data is read or and error occures, return Void.
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
	
feature -- Status reporting

	buffer_size: INTEGER
			-- Buffer size used to store data from process temporarily
			
	last_output: STRING
			-- Last output received from process

	last_error: STRING			
			-- Last error received from process

	input_direction: INTEGER
			-- Direction of input of process
			
	output_direction: INTEGER
			-- Direction of output of process
	
	error_direction: INTEGER
			-- Direction of error of process

	process_status: INTEGER
			-- Status returned by process

	launched: BOOLEAN
			-- Has process been launched?
			
	has_process_exited: BOOLEAN is
			-- Has child process exited?
		require
			process_launched: launched
		do
			if child_process = Void then
				Result := True
			else
				process_status  := child_process.wait_for_process_noblock (child_process.process_id, $Result)
			end
		end	
				
feature -- Status setting

	set_buffer_size (a_buffer_size: INTEGER) is
			-- Set `buffer_size' with `a_buffer_size'.
		require
			a_buffer_size_positive: a_buffer_size > 0
		do
			buffer_size := a_buffer_size
		ensure
			buffer_size_set: buffer_size = a_buffer_size
		end
		
	
	set_input_direction (direction: INTEGER) is
			-- Set `input_direction' with `direction'.
		do
			input_direction := direction
		ensure
			input_direction_set: input_direction = direction
		end
		
	set_output_direction (direction: INTEGER) is
			-- Set `output_direction' with `direction'
		do
			output_direction := direction
		ensure
			output_direction_set: output_direction = direction
		end
		
	set_error_direction (direction: INTEGER) is
			-- Set `error_direction' with `direction'
		do
			error_direction := direction
		ensure
			error_direction_set: error_direction = direction
		end

feature {NONE} -- Implementation

	input: RAW_FILE;
			-- File for input to process
			
	output: RAW_FILE;
			-- File to store output from process
			
	error: RAW_FILE
			-- File to store error from process
	
	child_process: PROCESS_UNIX_PROCESS_MANAGER_2
			-- Child process object

	working_directory: STRING
			-- Working directory of process
	
feature{NONE} -- Implementation
	close_input is
			-- Close input pipe.
		do
			if input /= Void and then (not input.is_closed) then
				input.close
			end
			if child_process.shared_output_unnamed_pipe /= Void then
				if child_process.shared_output_unnamed_pipe.is_open_read then
					child_process.shared_output_unnamed_pipe.close_read_descriptor
				end
			end
		end

	close_output is
			-- Close output pipe.	
		do
			if output /= Void and then (not output.is_closed) then
				output.close
			end
			if child_process.shared_input_unnamed_pipe /= Void then
				if child_process.shared_input_unnamed_pipe.is_closed = False then
					child_process.shared_input_unnamed_pipe.close
				end
			end
		end

	close_error is
			-- Close error pipe.
		do
			if not (error_direction = {PROCESS_REDIRECTION_CONSTANTS}.to_same_as_output) then
				if error /= Void and then (not error.is_closed) then
					error.close
				end
				if child_process.shared_error_unnamed_pipe /= Void then
					if child_process.shared_error_unnamed_pipe.is_open_read then
						child_process.shared_error_unnamed_pipe.close_read_descriptor
					end
				end				
			end
		end	
		
	try_to_terminate is
			-- Try to terminate independent process, ignoring
			-- any errors since process may not be there.
		local
			tried: BOOLEAN
		do
			if not tried then
				child_process.terminate_hard;
			end
		rescue
			tried := True
			retry
		end;

	Invalid_file_descriptor: INTEGER is -1;
			-- File descriptor which is not valid
	
invariant
	bad_file_desc_not_valid: 
		not unix_os.valid_file_descriptor (Invalid_file_descriptor);		

end -- class IO_REDIRECTION_PROCESS_LAUNCHER
