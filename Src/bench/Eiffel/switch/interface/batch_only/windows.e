
-- Pseudo windows for degenerated input output
--	$Id$	

class WINDOWS

feature

	error_window: TERM_WINDOW is
		once
			!!Result
		end

	info_window: TERM_WINDOW is
		once
			Result := error_window
		end

	debug_window: TERM_WINDOW is
		once
			Result := error_window
		end

	Progress_dialog: DEGREE_OUTPUT is
		once
			!! Result
		end

end
