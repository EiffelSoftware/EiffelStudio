indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class BIN_NE_BL 

inherit

	BIN_NE_B
		redefine
			left_register, set_left_register,
			right_register, set_right_register
		end;

create
	make
	
feature {NONE} -- Initialization

	make (a_left: like left; a_right: like right) is
			-- Create new BIN_NE_BL instance with `a_left' and `a_right'.
		require
			a_left_not_void: a_left /= Void
			a_right_not_void: a_right /= Void
		do
			left := a_left
			right := a_right
		ensure
			left_set: left = a_left
			right_set: right = a_right
		end
		
feature

	left_register: REGISTRABLE;
			-- Where metamorphosed left value is kept
		
	right_register: REGISTRABLE;
			-- Where metamorphosed right value is kept
	
	set_left_register (r: REGISTRABLE) is
			-- Assign `r' to `left_register'
		do
			left_register := r;
		end;
	
	set_right_register (r: REGISTRABLE) is
			-- Assign `r' to `right_register'
		do
			right_register := r;
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
