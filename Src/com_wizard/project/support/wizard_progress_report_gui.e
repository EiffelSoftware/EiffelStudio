indexing
	description: "Code generation manager."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROGRESS_REPORT_GUI

inherit
	WIZARD_PROGRESS_REPORT
	
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

create
	make


feature {NONE} -- Initialization

	make (a_parent: like parent) is
			-- Set `parent' to `a_parent'.
		require
			non_void_parent: a_parent /= Void
			valid_parent: a_parent.exists
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

feature -- Access

	progress_dialog: WIZARD_PROGRESS_DIALOG is
			-- Progress dialog
		once
			create Result.make (parent)
		end

	parent: WEL_COMPOSITE_WINDOW
			-- Progress dialog parent window

	last_x: INTEGER
			-- Last progress dialog x coordinate

	last_y: INTEGER
			-- Last progress dialog y coordinate

	Initial_range: INTEGER is 100
			-- Actual progress bar range

feature -- Element Change

	set_title (a_title: STRING) is
			-- Set `title' with `a_title'.
		do
			if running and then progress_dialog.progress_static.exists then
				progress_dialog.progress_static.set_text (a_title)
			end
			title := clone (a_title)
		end
		
	set_progress (an_integer: INTEGER) is
			-- Set `progress' with `an_integer'.
		do
			progress := an_integer
			update_progress_bar
		end

	step is
			-- Increment progress.
		do
			set_progress (progress + 1)
			update_progress_bar
		end

	progress_in_percentage: INTEGER is
			-- Progress in %
		do
			Result := ((progress / range) * 100).rounded
		end

feature -- Basic Operations

	start is
			-- Start report (i.e. activate dialog).
		do
			parent.disable
			if not progress_dialog.exists then
				progress_dialog.activate
			end
			if not running then
				progress_dialog.progress_bar.set_range (0, Initial_range)
				set_range (Initial_range)
				if last_x /= 0 then
					progress_dialog.set_x (last_x)
				end
				if last_y /= 0 then
					progress_dialog.set_y (last_y)
				end
				running := True
			end
			progress_dialog.progress_static.set_text (title)
			set_progress (0)
		end

	finish is
			-- Terminate report (i.e. terminate dialog)
		do
			if progress_dialog.exists then
				last_x := progress_dialog.x
				last_y := progress_dialog.y
				progress_dialog.terminate (0)
			end
			running := False
			parent.enable
		end

	update_progress_bar is
			-- Update progress bar according to `range' and `progress'.
		do
			if range /= 0 and progress_dialog.progress_bar.exists then
				progress_dialog.progress_bar.set_position (((initial_range * progress) / range).rounded)
			end
		end
			
invariant

	non_void_parent: parent /= Void

	valid_parent: parent.exists

end -- class WIZARD_PROGRESS_REPORT_GUI