indexing
	description: "An error abstraction."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR

create
	make
	
feature -- Creation

	make (a_desc: like description) is
			-- New error with description
		require
			description_not_void: a_desc /= Void
			description_not_empty: not a_desc.is_empty
		do
			description := a_desc
		ensure
			has_description: description /= Void
			description_valid: not description.is_empty
		end

feature -- Status Setting

	set_action (a_action: like action) is
			-- Set action
		require
			action_not_void: a_action /= Void
		do
			action := a_action
		ensure
			action_set: action = a_action
		end		

feature -- Access

	description: STRING
			-- Error description
			
	line_number: INTEGER
			-- Line number of error if applicable
	
	line_position: INTEGER
			-- Line position of error if applicable
			
	action: PROCEDURE [ANY, TUPLE]
			-- Response action for error

invariant
	has_description: description /= Void
	description_valid: not description.is_empty

end -- class ERROR
