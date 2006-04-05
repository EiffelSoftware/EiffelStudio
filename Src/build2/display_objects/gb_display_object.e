indexing
	description: "Objects that represent a visible representation of an%
		%invisible container in the display window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DISPLAY_OBJECT

inherit
	EV_FRAME
	
create
	
	make_with_name_and_child

feature -- Initialization
		
	make_with_name_and_child (a_name: STRING; a_child: EV_CONTAINER) is
			-- Create `Current' and assign `a_name' to `text' and `a_child'
			-- to `child'.
		require
			a_child_not_void: a_child /= Void
		do
			default_create
			set_text (a_name)
			child := a_child
			extend (child)
		ensure
			child_assigned_correctly: child = a_child
			text_assigned_correctly: text.is_equal (a_name)
			count_now_one: count = 1
		end		

feature -- Access

	child: EV_CONTAINER
		-- Real container contained in and
		-- made visible by `Current'.
		
feature {GB_TITLED_WINDOW_OBJECT} -- Implementation

	set_child (a_child: EV_CONTAINER) is
			-- Assign `a_child' to `child. This is necessary as we must
			-- rebuild windows when we reset the objects.
		do
			child := a_child
		ensure
			child_set: child = a_child
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


end -- class GB_DISPLAY_OBJECT
