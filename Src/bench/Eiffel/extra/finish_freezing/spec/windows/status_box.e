class STATUS_BOX -- Windows version
	
creation
	make
	
feature -- Initialization

	make(make_util: STRING; error, c_error: BOOLEAN) is
			-- show message as error or non-error message
		local
			message: ANY
			msg_string: STRING
			title: ANY
			icon: INTEGER
			
		do
			title := ("Finish Freezing Status").to_c
			
			if error then
				icon := Mb_iconexclamation
				msg_string := ("Makefile translation completed with errors.%N")
				if c_error then
					append_c_error_msg(make_util, msg_string)
				end
			else
				icon := Mb_iconinformation
				msg_string := ("Makefile translation completed successfully.%N")
				if c_error then
					icon := Mb_iconexclamation
					append_c_error_msg(make_util, msg_string)
				else
					msg_string.append("C-compilation completed successfully.%N")
				end
			end
			
			icon := icon + Mb_topmost
			
			message := msg_string.to_c
			cwin_message_box(default_pointer, $message, $title, icon)
		end

feature {NONE} -- Implementation

	append_c_error_msg (make_util, msg: STRING) is
			-- Append C-compilation error message to `msg'.
		do
			msg.append("C-compilation produced errors.%N")
			msg.append("Run ")
			msg.append(make_util)
			msg.append(" from the directory ")
			msg.append(env.current_working_directory)
			msg.append("%Nto see what went wrong.%N")
		end
		
	env: EXECUTION_ENVIRONMENT is
		once
			!!Result
		end

feature {NONE} -- Externals

	cwin_message_box (hwnd, msg, title: POINTER; icon: INTEGER) is
			-- SDK MessageBox
		external
			"C [macro <windows.h>] (HWND, LPCSTR, LPCSTR, UINT)"
		alias
			"MessageBox"
		end
		
	Mb_iconinformation: INTEGER is
			-- Information icon
		external
			"C [macro <windows.h>]"
		alias
			"MB_ICONINFORMATION"
		end
		
	Mb_iconexclamation: INTEGER is
			-- Exclamation icon
		external
			"C [macro <windows.h>]"
		alias
			"MB_ICONEXCLAMATION"
		end
		
	Mb_topmost: INTEGER is
			-- Make window topmost
		external
			"C [macro <windows.h>]"
		alias
			"MB_TOPMOST"
		end	
end -- class STATUS_BOX
