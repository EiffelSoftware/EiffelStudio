indexing
	description: "Class representing a precondition."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	APPLICATION_PRECONDITION

creation
	make

feature -- Initialization

	make (an_expression: STRING) is
			-- Create a precondition with 'an_expression'.
		require
			valid_precondition_expression: an_expression /= Void
		do
			precondition := an_expression			
		end

feature -- Attribute

	precondition: STRING
			-- Precondition expression

end -- class APPLICATION_PRECONDITION
