indexing
	description: "Objects that stores all the info needed for validity checking of a declaration%N%
			%of a generic class with its generic creation constraint part"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Emmanuel STAPF"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTRAINT_CHECKING_INFO

create
	make

feature -- Initialization

	make (
			c_class: like context_class;
			p: like action) is
				-- Initialize all the fields.
		require
			c_class_not_void: c_class /= Void
			p_not_void: p /= Void
		do
			context_class := c_class
			action := p
		ensure
			context_class_set: context_class = c_class
			action_set: action = p
		end

feature -- Access

	context_class: CLASS_C
			-- Class where the occurrence of generic type to be checked appears
			
	action: PROCEDURE [ANY, TUPLE]
			-- Action launched in context of current to check validity of constraint
			
invariant
	context_class_not_void: context_class /= Void
	action_not_void: action /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class CONSTRAINT_CHECKING_INFO
