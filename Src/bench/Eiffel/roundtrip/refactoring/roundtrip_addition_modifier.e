indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUNDTRIP_ADDITION_MODIFIER

inherit
	ROUNDTRIP_MODIFIER

create
	make

feature
	make (start_pos: INTEGER; a_index: INTEGER; a_text: STRING) is
			-- Initialize.
		do
			set_start_position (start_pos)
			set_end_position (start_pos)
			set_index (a_index)
			set_text (a_text)
		end


feature -- Status reporting

	within_region (a_pos: INTEGER): BOOLEAN is
			-- Is a position `a_pos' in region of this modifier?
		do
			Result := a_pos = start_position
		end

	can_add (a_pos: INTEGER): BOOLEAN is
			-- Can some text be added at position `a_pos' due to current modifier?
		do
			Result := a_pos /= start_position
		end

	can_del (start_pos, end_pos: INTEGER): BOOLEAN is
			--  Can region from `start_pos' to `end_pos' be removed due to current modifier?
		do
			Result := (start_pos >= start_position) or (end_pos < start_position)
		end

feature

	text: STRING assign set_text
			-- `Text' to be added.

	set_text (a_text: STRING) is
			-- Set `text' with `a_text'.
		do
			text := a_text.twin
		ensure
			text_set: text.is_equal (a_text)
		end

	modify (a_text: STRING) is
			-- Modify `a_text' and set `modified_index'.
		do
			a_text.append (text)
			modified_index := start_position
		end

invariant
	start_position_equal_to_end_position: start_position = end_position

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
