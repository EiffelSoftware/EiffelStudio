indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class HEIR inherit

	PARENT
		redefine
			display
		end

feature

	display is
			-- Output message saying where we are.
		do
			io.putstring ("In class HEIR")
			io.new_line
			io.putstring ("-------------------")
			io.new_line
			display_routine
			io.putstring (a_string)
			io.new_line
			io.new_line
		end

	display_routine is 
			-- Output simple message.
		do 
			io.putstring ("Calling a routine of class HEIR")
			io.new_line 
		end

	a_string: STRING is 
			-- Simple text string
		do 
			create Result.make (0)
			Result.append ("Showing an attribute of class HEIR")
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


end
