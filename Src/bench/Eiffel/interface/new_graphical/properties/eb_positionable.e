indexing
	description: "Objects that contains information about position shown in Eiffel Studio."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_POSITIONABLE
	
feature -- Access

	position: like position_internal is
			-- Position in current object.
			-- Usually character position in text.
		do
			Result := position_internal
		end
	
	pos_container: like pos_container_internal is		
			-- Where current object is shown. i.e an editor
		do
			Result := pos_container_internal
		end
		
	previous_position: like position_internal is
			-- Possible previous position
		do
			Result := previous_position_internal
		end
			
	previous_pos_container: like pos_container_internal is
			-- Possible previous container
		do
			Result := previous_pos_container_internal
		end

feature -- Element Change

	set_position (p: like position_internal) is
			-- Set `previous_position' with `p'.
		require
			p_larger_than_zero: p >= 0
		do
			position_internal := p
		ensure
			position_set: position_internal = p
		end
		
	set_pos_container (a_container: like pos_container_internal) is
			-- Set `container' with `a_container'.
		do
			pos_container_internal := a_container
		ensure
			container_set: pos_container_internal = a_container
		end
		
	set_previous_position (p: like previous_position_internal) is
			-- Set `previous_position' with `p'.
		require
			p_larger_than_zero: p >= 0
		do
			previous_position_internal := p
		ensure
			position_set: previous_position_internal = p
		end
		
	set_previous_pos_container (a_container: like previous_pos_container_internal) is
			-- Set `container' with `a_container'.
		do
			previous_pos_container_internal := a_container
		ensure
			container_set: previous_pos_container_internal = a_container
		end
		
feature {NONE}

	position_internal : INTEGER
	
	pos_container_internal : ANY
	
	previous_position_internal : like position_internal
	
	previous_pos_container_internal : like pos_container_internal;
	
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

end
