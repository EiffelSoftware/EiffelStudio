indexing
	description	: "COM Wizard launcher, hides DOS console and launch COM wizard graphically"

class
	ROOT_CLASS

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			l_process_launcher: WEL_PROCESS_LAUNCHER
			l_args: ARGUMENTS
			l_path: STRING
			l_index: INTEGER
		do
			create l_args
			l_path := l_args.argument (0)
			l_index := l_path.last_index_of (operating_environment.Directory_separator, l_path.count)
			if l_index > 0 then
				l_path.keep_head (l_index)
			else
				l_path := ""
			end
			l_path.append ("com_wizard.exe -g")
			create l_process_launcher
			l_process_launcher.spawn (l_path, Void)
		end

end -- class ROOT_CLASS

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

