-- Callback used when window is closed
-- through the window manager (delete callback)
class DELETE_WINDOW 

inherit

	COMMAND

creation

	make

feature {NONE}

	top_window: CLOSEABLE;

	make (win: like top_window) is
		require
			valid_win: win /= Void
		do
			top_window := win
		end;

	execute (arg: ANY) is
		do
			top_window.close
		end

end
