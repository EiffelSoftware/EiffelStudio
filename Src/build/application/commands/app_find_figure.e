
deferred class APP_FIND_FIGURE
	
feature {NONE}

	figures: APP_FIGURES is
		deferred
		end;

	find_figure (state: BUILD_STATE) is
			-- Move figures cursor to position 
			-- where figure data
			-- is equal to `state'; go off right if none.
		do
			from
				figures.start
			until
				figures.after or 
				(figures.figure.data 
					= state.data)
			loop
				figures.forth
			end;
		end; -- find_figure

end 
