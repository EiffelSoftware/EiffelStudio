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
			l_process_launcher.spawn ("com_wizard.exe", Void)
		end

end -- class ROOT_CLASS
