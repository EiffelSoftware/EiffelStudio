indexing
	description: "Element one can click on to select `node': an indirect clicking"
	date: "$Date$"
	revision: "$Revision$"

class
	CLICK_STONE 

creation
	make

feature -- Initialization

	make (a_node: like node; s, e: INTEGER) is
			-- Initialize all attributes with arguments.
		do
			node := a_node
			start_position := s
			end_position := e
		end;

feature -- Attributes

	node: STONE

	start_position: INTEGER

	end_position: INTEGER

end
