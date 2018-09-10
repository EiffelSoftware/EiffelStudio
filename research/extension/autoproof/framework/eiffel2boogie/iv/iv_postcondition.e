note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_POSTCONDITION

inherit

	IV_CONTRACT
		undefine
			expression
		redefine
			is_equal
		end

	IV_ASSERTION
		redefine
			is_equal
		end

	IV_INFO_NODE
		redefine
			is_equal
		end

create
	make

feature -- Status report

	is_free: BOOLEAN
			-- Is this a free contract?

feature -- Status setting

	set_free
			-- Set this contract to be free.
		do
			is_free := True
		ensure
			free: is_free
		end

feature -- Comparison

	is_equal (a_other: like Current): BOOLEAN
			-- Is this clause the same as `a_other'?	
		do
			Result := expression.same_expression (a_other.expression)
		end

feature -- Visitor

	process (a_visitor: IV_CONTRACT_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_postcondition (Current)
		end

end
