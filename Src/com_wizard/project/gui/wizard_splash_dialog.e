indexing
	description: "Splash scree dialog"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SPLASH_DIALOG

inherit
	WEL_MAIN_DIALOG
		redefine
			setup_dialog,
			on_timer
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_HWND_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create the dialog.
		do
			make_by_id (Wizard_splash_dialog_constant)
		end

feature {NONE} -- Behavior

	setup_dialog is
			-- Set timer.
		do
			set_timer (Timer_id, Time_out)
			set_z_order (Hwnd_topmost)
		end

	on_timer (a_timer_id: INTEGER) is
			-- Kill dialog.
		do
			terminate (Idok)
		end

feature {NONE} -- Implementation

	Timer_id: INTEGER is 1
			-- Timer identifier
		
	Time_out: INTEGER is 3750
			-- Time out in milliseconds
		
end -- class WIZARD_SPLASH_DIALOG