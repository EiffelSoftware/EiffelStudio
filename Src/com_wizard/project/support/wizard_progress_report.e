indexing
	description: "Code generation manager."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_PROGRESS_REPORT


feature -- Access

	title: STRING
			-- Progress dialog title

	running: BOOLEAN
			-- Is progress report started?

	range: INTEGER
			-- Initial progress range

	progress: INTEGER
			-- Current progress

feature -- Element Change

	set_title (a_title: STRING) is
			-- Set `title' with `a_title'.
		require
			non_void_title: a_title /= Void
			valid_title: not a_title.empty
		deferred
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
		deferred
		ensure
			progress_set: progress = an_integer
		end

	step is
			-- Increment progress.
		require
			valid_progress: progress < range
		deferred
		end

feature -- Basic Operations

	start is
			-- Start report (i.e. activate dialog).
		require
			non_void_title: title /= Void
			valid_title: not title.empty
		deferred
		ensure
			running: running
		end

	finish is
			-- Terminate report (i.e. terminate dialog)
		deferred
		ensure
			not_running: not running
		end
			
end -- class WIZARD_PROGRESS_REPORT