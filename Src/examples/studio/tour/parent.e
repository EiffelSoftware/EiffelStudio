note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class PARENT feature

	display
			-- Display basic information.
		do
			io.put_string ("In class PARENT")
			io.new_line
			io.put_string ("---------------")
			io.new_line
			first_message
		end

	first_message
			-- Display a simple message.
		do
			io.putstring ("Message number 1")
			io.new_line; io.new_line
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class PARENT
