indexing
	description:"Atomic node: strings, integers, reals etc. %
				%Version for Bench version."
	date: "$Date$"
	revision: "$Revision$"

deferred class ATOMIC_AS

inherit
	EXPR_AS

feature -- Properties

	is_unique: BOOLEAN is
			-- Is the terminal a unique constant ?
		do
			-- Do nothing
		end

	is_id: BOOLEAN is
			-- Is the atomic an id value ?
		do
			-- Do nothing
		end

feature -- Output

	string_value: STRING is
		deferred
		end;

end -- class ATOMIC_AS
