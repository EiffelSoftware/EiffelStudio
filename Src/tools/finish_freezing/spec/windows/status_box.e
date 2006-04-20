indexing
	description: "Windows version of Status Box"
	legal: "See notice at end of class."
	status: "See notice at end of class."

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
	make, make_fatal
	
feature -- Initialization

	make_fatal (msg: STRING) is
			-- Show fatal error.
		require
			msg_not_void: msg /= Void
		local
			l_msg, l_title: WEL_STRING
			l_result: INTEGER
		do
			create l_msg.make (msg)
			create l_title.make ("Finish Freezing Status")
			
			l_result := cwin_message_box (default_pointer, l_msg.item, l_title.item,
				Mb_iconerror | Mb_ok | Mb_topmost)
		end

	make (msg: STRING; error, c_error, config_error: BOOLEAN; mapped_path: BOOLEAN) is
			-- show message as error or non-error message
		require
			has_error: error implies c_error or else config_error
			valid_error: error implies not (c_error and then config_error)
		local
			message: WEL_STRING
			msg_string: STRING
			title: WEL_STRING
			box_style: INTEGER
			message_box_result: INTEGER
			comspec: STRING
		do
			create title.make ("Finish Freezing Status")
			
			if error then
				box_style := Mb_iconexclamation
				msg_string := ("Makefile translation completed with errors.%N")
				if c_error then
					append_c_error_msg (msg, msg_string)
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
			
			create message.make (msg_string)
			message_box_result := cwin_message_box(default_pointer, message.item, title.item, box_style)
			
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
		%Click OK to terminate.%N%
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class STATUS_BOX
