class SHIFTER 

inherit 

	STRING
		rename make as string_make,out as string_out,count as string_count
		export {NONE} all	
	end

creation

	make

feature {NONE} -- Creation

	make is
		-- Creates a string with one tab
		do
			string_make(0)
			init_shifter
		end -- make

feature -- Initialization

	init_shifter is 
		-- initialise separator with tab char
		do
			wipe_out append(" ")
		ensure 
			not_empty : count = 1
		end -- init_separator

feature -- Element Change

	increase is
		-- adds a tab at the end of the shifterstring 
		do
			extend('%T')
		ensure
 			correct_shifter :  count = old count + 1
		end -- increase

	decrease is
		-- removes tab from tail of separator
		require
			shifter_large_enough : count >=1
		do
			head(count-1)
		ensure
			shifter_size_decreased :  count = old count -1 
		end -- decrease

feature -- Access

	out : STRING is
		-- Tabs
		do
			Result := string_out
		end -- out
	
	count : INTEGER is
		-- Tabs in shifter
		do
			Result := string_count
		end -- count

end -- class SHIFTER
