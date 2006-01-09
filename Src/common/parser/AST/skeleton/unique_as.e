indexing

	description: "Description of a unique value. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class UNIQUE_AS

inherit
	ATOMIC_AS
		undefine
			text
		redefine
			is_unique, is_equivalent
		end

	KEYWORD_AS
		undefine
			number_of_breakpoint_slots,
			is_equivalent,
			process
		end

create
	make_with_location

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_unique_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	is_unique: BOOLEAN is True
			-- Is the terminal a unique constant ?

feature -- Output

	string_value: STRING is ""

end -- class UNIQUE_AS
