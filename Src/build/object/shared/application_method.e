indexing
	description: "Class representing a method (same meaning %
				% as 'routine' i.e. feature with or without %
				% argument that doesn't return any value)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_METHOD

feature -- Attribute

	method_name: STRING
			-- Name of the corresponding method

	precondition_list: LINKED_LIST [APPLICATION_PRECONDITION]
			-- List of preconditions

feature -- Setting

	add_precondition (a_precondition: APPLICATION_PRECONDITION) is
			-- Add `a_precondition'.
		require
			valid_list: precondition_list /= Void
		do
			precondition_list.extend (a_precondition)
		end

end -- class APPLICATION_METHOD
