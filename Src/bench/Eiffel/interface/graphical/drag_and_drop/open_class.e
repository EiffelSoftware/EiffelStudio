indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	OPEN_CLASS

inherit
	WINDOWS
	COMMAND
		redefine
			context_data_useful,
			context_data
		end

feature -- Execution
		
	context_data: BUTTON_DATA;

	context_data_useful: BOOLEAN is True;

	execute (s: DRAG_SOURCE) is
			-- Initiate transort if `s' is transportable.
		local
			coord: COORD_XY;
			x0, y0: INTEGER
		do
			if last_warner /= Void then
				last_warner.popdown
			end

--			s.update_before_transport (context_data)

		end;

end -- class OPEN_CLASS
