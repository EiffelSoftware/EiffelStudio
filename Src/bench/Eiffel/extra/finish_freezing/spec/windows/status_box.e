indexing
	description: "Windows version of Status Box"

class
	STATUS_BOX 
	
inherit
	WEL_MB_CONSTANTS
		export
			{NONE} all
		end
	
	WEL_ID_CONSTANTS
		export
			{NONE} all
		end
		
create
	make
	
feature -- Initialization

	make (msg: STRING; error, c_error, config_error: BOOLEAN; mapped_path: BOOLEAN) is
			-- show message as error or non-error message
		require
			has_error: error implies c_error or else config_error
			valid_error: error implies not (c_error and then config_error)
		local
			message: ANY
			msg_string: STRING
			title: ANY
			box_style: INTEGER
			message_box_result: INTEGER
			comspec: STRING
		do
			title := ("Finish Freezing Status").to_c
			
			if error then
				box_style := Mb_iconexclamation
				msg_string := ("Makefile translation completed with errors.%N")
				if c_error then
					append_c_error_msg (msg, msg_string)
				else
					msg_string.append (msg)
				end
			else
				box_style := Mb_iconinformation
				msg_string := ("Makefile translation completed successfully.%N")
				if c_error then
					box_style := Mb_iconexclamation
					append_c_error_msg (msg, msg_string)
				else
					msg_string.append("C-compilation completed successfully.%N")
				end
			end

			if c_error then
				if not mapped_path then
					box_style := box_style | Mb_okcancel
					msg_string.append (Click_cancel_message)
				end
			end
			
			box_style := box_style | Mb_topmost
			
			message := msg_string.to_c
			message_box_result := cwin_message_box(default_pointer, $message, $title, box_style)
			
				-- Display Command Line Console if asked
			if c_error and then message_box_result = Idcancel then
				comspec := env.get ("COMSPEC")
				if comspec /= Void then
					(create {PROCESS_LAUNCHER}).launch (comspec, env.current_working_directory)
				end
			end
		end

feature {NONE} -- Implementation

	Click_cancel_message: STRING is "%N%
		%Click Ok to terminate.%N%
		%Click Cancel to open a command line console.%N"

	append_c_error_msg (make_util, msg: STRING) is
			-- Append C-compilation error message to `msg'.
		do
			msg.append("C-compilation produced errors.%N")
			msg.append("Run '")
			msg.append(make_util)
			msg.append("' from the directory '")
			msg.append(env.current_working_directory)
			msg.append("'%Nto see what went wrong.%N")
		end
		
	env: EXECUTION_ENVIRONMENT is
		once
			create Result
		end

feature {NONE} -- Externals

	cwin_message_box (hwnd, msg, title: POINTER; icon: INTEGER): INTEGER is
			-- SDK MessageBox
		external
			"C [macro <windows.h>] (HWND, LPCSTR, LPCSTR, UINT): int"
		alias
			"MessageBox"
		end

end -- class STATUS_BOX
