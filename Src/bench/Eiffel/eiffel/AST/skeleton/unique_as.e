indexing

	description: "Description of a unique value. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class UNIQUE_AS

inherit
	ATOMIC_AS
		redefine
			is_unique, is_equivalent, type_check
		end
		
	LEAF_AS

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

feature -- Type checking

	type_check is
			-- Type check a unique type
		do
			context.put (Integer_type)
		end

feature -- Output

	string_value: STRING is ""

end -- class UNIQUE_AS
