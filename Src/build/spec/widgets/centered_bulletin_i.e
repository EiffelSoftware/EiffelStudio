indexing
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class

	CENTERED_BULLETIN_I

inherit

	BULLETIN_I

feature 

	implementation_set_size (new_width, new_height: INTEGER) is
			-- Effective set size.
		deferred
		end

end -- class CENTERED_BULLETIN_I
