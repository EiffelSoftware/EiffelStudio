
deferred class APP_FIND_FIGURE
	
feature {NONE}

	figures: APP_FIGURES is
		deferred
		end;

	find_figure (state: STATE) is
			-- Move figures cursor to position 
			-- where figure original_stone
			-- is equal to `state'; go off right if none.
		do
			from
				figures.start
			until
				figures.after or 
				(figures.figure.original_stone 
					= state.original_stone)
			loop
				figures.forth
			end;
		end; -- find_figure

end 
