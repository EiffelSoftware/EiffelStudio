indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MY_ARRAY [G]
inherit
	ARRAY [G]
create
	make	
feature	-- Display

	display is
			-- Display all items
		local
			i: INTEGER
		do
			io.put_string ("Display an Eiffel Array: %N")
			from 
				i := lower
			until
				i > upper
			loop
				io.put_string ("@")
				io.put_integer (i);
				io.put_string (" = ")
				print (item (i))
				io.new_line
				i := i + 1
			end
		end
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class MY_ARRAY 

