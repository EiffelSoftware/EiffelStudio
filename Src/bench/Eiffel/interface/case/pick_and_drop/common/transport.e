indexing

	description: "Initiates the drag-and-drop.";
	date: "$Date$";
	revision: "$Revision$"

class TRANSPORT

inherit
	
	ONCES;
	EC_COMMAND
		redefine
			--context_data_useful
			--context_data
		end;

feature -- Execution
		
	--context_data: BUTTON_DATA;

	context_data_useful: BOOLEAN is True;

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Initiate transort if `s' is transportable.
		local
			--transporter: TRANSPORTER;
			x0, y0: INTEGER;
		do
		--	s.update_before_transport (context_data);
-- 			if s.transportable then
-- 				if s.want_initial_position then
-- 					x0 := s.initial_x;
-- 					y0 := s.initial_y;
-- 				else
-- 				--	x0 := context_data.absolute_x;
-- 				--	y0 := context_data.absolute_y
-- 				end;
-- 				-- transporter:= Windows.main_graph_window -- 1812
-- 				transporter.set_initial_x_y (x0, y0);
-- 				transporter.transport (s)
-- 			end;
		end;

end
