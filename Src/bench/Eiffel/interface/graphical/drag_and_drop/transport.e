indexing

	description: "Initiates the drag-and-drop.";
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

	context_data_useful: BOOLEAN is True

end -- class TRANSPORT
