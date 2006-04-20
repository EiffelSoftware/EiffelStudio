indexing
	description: "Info about local variable of a feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LOCAL_INFO 
	
feature -- Access

	position: INTEGER
			-- Position of the local in the sequence of local
			-- declarations

	type: TYPE_A
			-- Local type

	is_used: BOOLEAN
			-- Is local variable used?
			-- Set during type checking.

	actual_type: TYPE_A is
			-- Actual type of `type'.
		require
			type_exists: type /= Void
		do
			Result := type.actual_type
		end

feature -- Setting

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		require
			valid_index: i > 0
		do
			position := i
		ensure
			position_set: position = i
		end

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t
		end

	set_is_used (v: like is_used) is
			-- Assign `v' to `is_used'.
		do
			is_used := v
		end
		
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
