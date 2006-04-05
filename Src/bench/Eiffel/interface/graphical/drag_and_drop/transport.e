indexing

	description: "Initiates the drag-and-drop."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class TRANSPORT

inherit
	COMMAND
		redefine
			context_data_useful,
			context_data
		end

	WINDOWS

feature -- Execution
		
	execute (s: DRAG_SOURCE) is
			-- Initiate transport if `s' is transportable.
		local
			coord: COORD_XY
			x0, y0: INTEGER
		do
			if last_warner /= Void then
				last_warner.popdown
			end

			s.update_before_transport (context_data)

			if s.transportable then
				if s.want_initial_position then
					coord := s.initial_coord
					x0 := coord.x
					y0 := coord.y
				else
					x0 := context_data.absolute_x
					y0 := context_data.absolute_y
				end;
				Transporter.transport (s, x0, y0)
			end;
		end;

feature -- Attributes

	context_data: BUTTON_DATA

	context_data_useful: BOOLEAN is True;

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

end -- class TRANSPORT
