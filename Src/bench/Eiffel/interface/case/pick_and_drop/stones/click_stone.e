indexing

	description: 
		"Element one can click on in text area. Contains stone%
		%with start and end position in text area.";
	date: "$Date$";
	revision: "$Revision $"

class CLICK_STONE

inherit
	CONSTANTS

creation

	make

feature -- Initialization

	make (a_data: DATA; s, e: INTEGER) is
			-- Initialize all attributes with arguments.
		do
			data := a_data
			type := stone_types.any_type_pnd
			start_position := s
			end_position := e
		end

feature -- Properties

	type: EV_PND_TYPE  --is deferred end

	data: DATA
		-- Data associated with Current

	start_position: INTEGER
		-- Start position of Current

	end_position: INTEGER
		-- End position of Current
 
end -- class CLICK_STONE
