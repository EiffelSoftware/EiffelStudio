indexing
	description: "Code generation manager."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROGRESS_REPORT_CMD

inherit 
	WIZARD_PROGRESS_REPORT

feature -- Element Change

	set_title (a_title: STRING) is
			-- Set `title' with `a_title'.
		do
			title := clone (a_title)
		end

	set_progress (an_integer: INTEGER) is
			-- Set `progress' with `an_integer'.
		do
			progress := an_integer
		end

	step is
			-- Increment progress.
		do
		end

feature -- Basic Operations

	start is
			-- Start report (i.e. activate dialog).
		do
			running := True
		end

	finish is
			-- Terminate report (i.e. terminate dialog)
		do
			running := False
		end
			
end -- class WIZARD_PROGRESS_REPORT_CMD