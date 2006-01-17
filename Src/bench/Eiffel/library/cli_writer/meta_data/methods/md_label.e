indexing
	description: "Representation of an IL label"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_LABEL

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize an empty label.
		do
			position := - 1
		ensure
			not_is_position_set: not is_position_set
		end

feature -- Status Report

	is_position_set: BOOLEAN is
			-- Is current label position known?
		do
			Result := position /= -1
		end
		
feature -- Settings

	mark_branch_position (pos: INTEGER) is
			-- Mark `pos' in current MD_METHOD_BODY as it
			-- will need to be updated once position of current
			-- label is known
		do
			if  mark_offsets = Void then
				create mark_offsets.make (10)
			end
			mark_offsets.extend (pos)
		end

	mark_position (pos: INTEGER; body: MD_METHOD_BODY) is
			-- Set `position' to `pos' and update all previous stored
			-- branch positions in `body'.
		require
			valid_pos: pos >= 0
			body_not_void: body /= Void
		local
			l_list: like mark_offsets
		do
			position := pos
			l_list := mark_offsets
			if l_list /= Void then
				from
					l_list.start
				until
					l_list.after
				loop
					body.set_branch_location (l_list.item, pos - l_list.item)
					l_list.forth
				end
			end
		ensure
			position_set: position = pos
		end
		
feature -- Integer

	position: INTEGER
			-- Position of label in IL stream.
			
	mark_offsets: ARRAYED_LIST [INTEGER];
			-- List all offsets in MD_METHOD_BODY that are performing
			-- a branch instruction on current. We need to store correct
			-- offset as soon as we now current label's position.

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

end -- class MD_LABEL
