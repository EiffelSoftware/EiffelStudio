indexing
	description: "Push_b button containing an application method as %
					% an attribute"
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class

	APPLICATION_METHOD_PUSH_B

inherit

	PUSH_B
		rename
			make as make_push_b
		end

creation

	make

feature {NONE} -- Initialization

	make (an_application_method: APPLICATION_METHOD; a_parent: COMPOSITE) is
			-- Create a push_b button with `an_application method'
			-- as identifier, `a_parent' as parent and call `set_default'.
		require else
			valid_application_method: an_application_method /= Void
		do
			 make_push_b (an_application_method.method_name, a_parent)
			application_method := an_application_method	
		ensure then
			application_method_set: application_method = an_application_method
		end

feature -- Attribute

	application_method: APPLICATION_METHOD	

end -- class APPLICATION_METHOD_PUSH_B
