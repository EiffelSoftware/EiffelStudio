indexing
	description: "Added functionality to EV_SCREEN which we do not want to export yet to EV_SCREEN."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_STUDIO_SCREEN
	
inherit
	EV_SCREEN
	
feature -- Status report

	virtual_width: INTEGER is
			-- Virtual width of screen
		do
			Result := implementation.virtual_width
		end	

	virtual_height: INTEGER is
			-- Virtual height of screen
		do
			Result := implementation.virtual_height
		end

	virtual_x: INTEGER is
			-- X position of virtual screen in main display coordinates
		do
			Result := implementation.virtual_x
		end

	virtual_y: INTEGER is
			-- Y position of virtual screen in main display coordinates
		do
			Result := implementation.virtual_y
		end
		
	virtual_left: INTEGER is
			-- Left position of virtual screen in main display coordinates
		do
			Result := virtual_x
		end
		
	virtual_top: INTEGER is
			-- Top position of virtual screen in main display coordinates
		do
			Result := virtual_y
		end
		
	virtual_right: INTEGER is
			-- Right position of virtual screen in main display coordinates
		do
			Result := virtual_x + virtual_width
		end

	virtual_bottom: INTEGER is
			-- Bottom position of virtual screen in main display coordinates
		do
			Result := virtual_y + virtual_height
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
