indexing

	description: 
		"AST represenation of an instruction node";
	date: "$Date$";
	revision: "$Revision$"

deferred class INSTRUCTION_AS

inherit

	AST_EIFFEL
		redefine
			number_of_stop_points
		end

feature -- Access

	start_position: INTEGER;
			-- Start position of AST

	number_of_stop_points: INTEGER is
			-- Number of stop points for AST
		do
			Result := 1
		end

end -- class INSTRUCTION_AS
