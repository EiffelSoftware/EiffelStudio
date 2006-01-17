indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUNDTRIP_DELETION_MODIFIER

inherit
	ROUNDTRIP_MODIFIER

create
	make

feature{NONE} -- Implementation

	make (start_pos, end_pos, a_index: INTEGER) is
			-- Initialize
		do
			set_start_position (start_pos)
			set_end_position (end_pos)
			set_index (a_index)
		end

feature -- Status setting

	modify (a_text: STRING) is
			-- Modify `text' and set `modified_index'.
		do
			modified_index := end_position + 1
		end

feature -- Status reporting

	within_region (a_pos: INTEGER): BOOLEAN is
			-- Is a position `a_pos' in region of this modifier?
		do
			Result := a_pos >= start_position and a_pos <= end_position
		end

	can_add (a_pos: INTEGER): BOOLEAN is
			-- Can some text be added at position `a_pos' due to current modifier?
		do
			Result := not (a_pos >= start_position and a_pos <= end_position)
		end

	can_del (start_pos, end_pos: INTEGER): BOOLEAN is
			--  Can region from `start_pos' to `end_pos' be removed due to current modifier?
		do
			Result := not (
				(start_pos <= start_position and end_pos >= start_position) or
				(start_pos <= end_position and end_pos >= end_position) or
				(start_pos >= start_position and end_pos <= end_position) or
				(start_pos <= start_position and end_pos >= end_position))
		end

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
