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
		do
			create l_process_launcher
			l_process_launcher.spawn ("com_wizard.exe -g", Void)
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

