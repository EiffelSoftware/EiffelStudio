
-- Pseudo windows for degenerated input output

class WINDOWS

feature

	error_window: TERM_WINDOW is once !!Result end;

	info_window: TERM_WINDOW is once Result := error_window end;

	debug_window: TERM_WINDOW is once Result := error_window end;

feature -- Compilation Mode

	batch_mode: BOOLEAN is True

end
