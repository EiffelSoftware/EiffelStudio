indexing
	description: "Code generation manager."
	status: "See notice at end of class";
	date: "$ $"
	revision: "$ $"

class
	WIZARD_PROGRESS_REPORT

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

feature -- Access

	progress_dialog: WIZARD_PROGRESS_DIALOG is
			-- Progress dialog
		do
			Result := progress_dialog_cell.item
		end

	title: STRING is
			-- Progress dialog title
		do
			Result := title_cell.item
		end

	running: BOOLEAN is
			-- Is progress report started?
		do
			Result := running_cell.item
		end

	parent: WEL_COMPOSITE_WINDOW is
			-- Progress dialog parent window
		do
			Result := parent_cell.item
		end

	range: INTEGER is
			-- Initial progress range
		do
			Result :=range_cell.item
		end

	progress: INTEGER is
			-- Current progress
		do
			Result := progress_cell.item
		end

	last_x: INTEGER is
			-- Last progress dialog x coordinate
		do
			Result := last_x_cell.item
		end

	last_y: INTEGER is
			-- Last progress dialog y coordinate
		do
			Result := last_y_cell.item
		end

	Initial_range: INTEGER is 100
			-- Actual progress bar range

feature -- Element Change

	set_title (a_title: STRING) is
			-- Set `title' with `a_title'.
		require
			non_void_title: a_title /= Void
			valid_title: not a_title.empty
		do
			if running then
				progress_dialog.progress_static.set_text (a_title)
			end
			title_cell.replace (a_title)
		ensure
			title_set: title.is_equal (a_title)
		end

	set_range (a_range: INTEGER) is
			-- Set `range' with `a_range'.
		require
			valid_range: a_range >= 0
		do
			range_cell.set_item (a_range)
		ensure
			range_set: range = a_range
		end

	set_parent (a_parent: like parent) is
			-- Set `parent' with `a_parent'.
		require
			non_void_parent: a_parent /= Void
		do
			parent_cell.replace (a_parent)
			progress_dialog_cell.replace (create {WIZARD_PROGRESS_DIALOG}.make (a_parent))
		ensure
			parent_set: parent = a_parent
		end

	set_progress (an_integer: INTEGER) is
			-- Set `progress' with `an_integer'.
		require
			valid_progress: an_integer >= 0 and an_integer <= range
		do
			progress_cell.set_item (an_integer)
			update_progress_bar
		ensure
			progress_set: progress = an_integer
		end

	step is
			-- Increment progress.
		require
			valid_progress: progress < range
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
		require
			non_void_title: title /= Void
			valid_title: not title.empty
			non_void_parent: parent /= Void
			valid_parent: parent.exists
		do
			if not running then
				progress_dialog.activate
				progress_dialog.progress_bar.set_range (0, Initial_range)
				set_range (Initial_range)
				if last_x /= 0 then
					progress_dialog.set_x (last_x)
				end
				if last_y /= 0 then
					progress_dialog.set_y (last_y)
				end
				running_cell.put (True)
			end
			progress_dialog.progress_static.set_text (title)
			set_progress (0)
		ensure
			running: running
		end

	finish is
			-- Terminate report (i.e. terminate dialog)
		require
			running: running
		do
			if progress_dialog.exists then
				last_x_cell.set_item (progress_dialog.x)
				last_y_cell.set_item (progress_dialog.y)
				progress_dialog.terminate (0)
			end
			running_cell.put (False)
		ensure
			not_running: not running
		end

	update_progress_bar is
			-- Update progress bar according to `range' and `progress'.
		do
			if range /= 0 and progress_dialog.progress_bar.exists then
				progress_dialog.progress_bar.set_position (((initial_range * progress) / range).rounded)
			end
		end
			
feature {NONE} -- Implementation

	range_cell: INTEGER_REF is
			-- `range' cell
		once
			create Result
		end

	progress_dialog_cell: CELL [WIZARD_PROGRESS_DIALOG] is
			-- Progress dialog shell
		once
			create Result.put (Void)
		end

	title_cell: CELL [STRING] is
			-- Progress dialog title shell
		once
			create Result.put (Void)
		end

	running_cell: CELL [BOOLEAN] is
			-- Shell for `running'
		once
			create Result.put (False)
		end

	parent_cell: CELL [WEL_COMPOSITE_WINDOW] is
			-- Progress report parent window cell
		once
			create Result.put (Void)
		end

	last_x_cell: INTEGER_REF is
			-- Progress dialog last x
		once
			create Result
		end

	last_y_cell: INTEGER_REF is
			-- Progress dialog last y
		once
			create Result
		end
	
	progress_cell: INTEGER_REF is
			-- Progress cell
		once
			create Result
		end

end -- class WIZARD_PROGRESS_REPORT