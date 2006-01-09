indexing
	description:
		"Abstract description to access to `Current'. %
		%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CURRENT_AS

inherit
	ACCESS_AS
		undefine
			text
		redefine
			is_equivalent
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
			v.process_current_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	access_name: STRING is "Current"

	parameters: EIFFEL_LIST [EXPR_AS] is
			-- No parameters for Current
		do
		end

end -- class CURRENT_AS
