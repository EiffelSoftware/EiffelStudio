note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class INVALID feature

	attribute_value: INTEGER;

	display
			-- Attempt (in an invalid way) to call a procedure of
			-- class PARENT.
		local
			p: PARENT
		do
			create p
			p.first_message (1)
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


end -- class INVALID
