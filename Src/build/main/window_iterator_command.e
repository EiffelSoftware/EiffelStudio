class WINDOW_ITERATOR_COMMAND 
	inherit
		ITER_COMMAND
			redefine
				execute
			end;

creation

	make

feature

	make (a_perm_wind: PERM_WIND_C) is
		do
			perm_window := a_perm_wind;
		end;

	perm_window: PERM_WIND_C;

	execute (arg: ANY) is
		do
			perm_window.hide;
			iterate;
		end

end -- class WINDOW_ITERATOR_COMMAND
