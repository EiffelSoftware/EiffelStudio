indexing
	description: "Object that represents an invariant part used in EQL"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_INVARIANT

inherit
	EQL_CALLER
		rename
			data as invariant_part
		redefine
			is_invariant_scope
		end

	EQL_INVARIANT_CELL
		undefine
			is_equal
		end

create
	make_with_invariant

feature -- Status reporting

	is_invariant_scope: BOOLEAN is True

	name: STRING is
			-- Name of current feature
		do
			Result := invariant_name
		end

feature -- Context

	context: EQL_CONTEXT is
			-- Context containing information of current
		do
			create Result.make_with_invariant (invariant_part)
		end


feature	-- Constant

	invariant_name: STRING is "_invariant"
			-- Name from `invariant_part'

invariant
	invariant_part_not_void: invariant_part /= Void

end
