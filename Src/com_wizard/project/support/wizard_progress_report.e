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

	title: STRING
			-- Progress dialog title

	running: BOOLEAN
			-- Is progress report started?

	parent: WEL_COMPOSITE_WINDOW
			-- Progress dialog parent window

	range: INTEGER
			-- Initial progress range

	progress: INTEGER
			-- Current progress

	last_x: INTEGER
			-- Last progress dialog x coordinate

	last_y: INTEGER
			-- Last progress dialog y coordinate

	Initial_range: INTEGER is 100
			-- Actual progress bar range

feature -- Element Change

	set_title (a_title: STRING) is
			-- Set `title' with `a_title'.
		require
			non_void_title: a_title /= Void
			valid_title: not a_title.empty
		do
			if running and then progress_dialog.progress_static.exists then
				progress_dialog.progress_static.set_text (a_title)
			end
			title := clone (a_title)
		ensure
			title_set: title.is_equal (a_title)
		end

	set_range (a_range: INTEGER) is
			-- Set `range' with `a_range'.
		require
			valid_range: a_range >= 0
		do
			range := a_range
		ensure
			range_set: range = a_range
		end

	set_progress (an_integer: INTEGER) is
			-- Set `progress' with `an_integer'.
		require
			valid_progress: an_integer >= 0 and an_integer <= range
		do
			progress := an_integer
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
		ensure
			running: running
		end

	finish is
			-- Terminate report (i.e. terminate dialog)
		require
			non_void_parent: parent /= Void
			valid_parent: parent.exists
		do
			if progress_dialog.exists then
				last_x := progress_dialog.x
				last_y := progress_dialog.y
				progress_dialog.terminate (0)
			end
			running := False
			parent.enable
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
			
invariant

	non_void_parent: parent /= Void

	valid_parent: parent.exists

end -- class WIZARD_PROGRESS_REPORT