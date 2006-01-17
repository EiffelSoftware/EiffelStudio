indexing
	description: "Object that represents a modifier to roundtrip-parsed class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROUNDTRIP_MODIFIER

inherit
	COMPARABLE

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := start_position < other.start_position or
		 			((start_position = other.start_position) and (index < other.index))
		end

feature -- Status reporting

	start_position: INTEGER assign set_start_position
			-- Start position of this modifier

	end_position: INTEGER
			-- End position of this modifier

	within_region (a_pos: INTEGER): BOOLEAN is
			-- Is a position `a_pos' in region of this modifier?
		require
			a_pos_non_negative: a_pos >=0
		deferred
		end

	can_add (a_pos: INTEGER): BOOLEAN is
			-- Can some text be added at position `a_pos' due to current modifier?
		require
			position_valid: a_pos > 0
		deferred
		end

	can_del (start_pos, end_pos: INTEGER): BOOLEAN is
			--  Can region from `start_pos' to `end_pos' be removed due to current modifier?
		require
			position_valid: start_pos > 0 and start_pos <= end_pos
		deferred
		end

feature -- Status setting

	set_start_position (pos: INTEGER) is
			-- Set `start_position' with `pos'.
		do
			start_position := pos
		ensure
			start_position_set: start_position = pos
		end

	set_end_position (pos: INTEGER) is
			-- Set `end_position' with `pos'.
		do
			end_position := pos
		ensure
			end_position_set: end_position = pos
		end

	set_index (a_index: INTEGER) is
			-- Set `index' with `a_index'.
		do
			index := a_index
		ensure
			index_set: index = a_index
		end

feature -- Modification

	modify (a_text: STRING) is
			-- Modify `text' and set `modified_index'.
		deferred
		end

	index: INTEGER
			-- This is the `index'-th modification

	modified_index: INTEGER;
			-- Last modified index
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
