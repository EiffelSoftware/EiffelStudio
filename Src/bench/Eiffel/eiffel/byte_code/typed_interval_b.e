indexing
	description: "Inspect interval of particular type."
	date: "$Date$"
	revision: "$Revision$"

class TYPED_INTERVAL_B [reference G -> INTERVAL_VAL_B]

inherit
	INTERVAL_B
		redefine
			lower
		end

create
	make

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_typed_interval_b (Current)
		end

feature -- Access

	lower: G
			-- Lower bound

end
