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

	implementation_set_width (new_width: INTEGER) is
			-- Effective set width.
		deferred
		end

	implementation_set_height (new_height: INTEGER) is
			-- Effective set height.
		deferred
		end

end -- class CENTERED_BULLETIN_I
