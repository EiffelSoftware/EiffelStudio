indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Byte code for reverse assignment

class REVERSE_B

inherit
	ASSIGN_B
		redefine
			enlarged, process
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_reverse_b (Current)
		end

feature -- Access

	info: CREATE_INFO
			-- Keep info about `target' type.
			-- Never Void.

feature -- Settings

	set_info (a_info: like info) is
			-- Set `info' to `a_info'.
		require
			a_info_not_void: a_info /= Void
		do
			info := a_info
		ensure
			info_set: info = a_info
		end

feature -- Enlarging

	enlarged: REVERSE_BL is
			-- Enlarge current node.	
		do
			create Result.make (Current)
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
