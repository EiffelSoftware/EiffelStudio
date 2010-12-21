note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class THREE_D_SEPARATOR

inherit

	SEPARATOR
		redefine
			implementation, set_default
		end

create
	make

feature -- Access

	implementation: SEPARATOR_IMP

feature -- Update

	set_default
		do
			implementation.set_3d_separator
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




end -- class THREE_D_SEPARATOR

