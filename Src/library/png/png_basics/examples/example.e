indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class EXAMPLE

create
	make

feature -- Init
	make is 
		local
			fi: FILE_NAME
			i: INTEGER
		do 
			Create ex1
			ex1.process	

			Create ex2
			ex2.process
		end


feature -- Access
	
	ex1: EXAMPLE1
		-- Example which create, then draws basic figures on a png image.
		-- Save it at the end.

	ex2: EXAMPLE2;
		-- Example which create, then displays 3-d tunnel on a png image.
		-- Save it at the end

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






end -- EXAMPLE