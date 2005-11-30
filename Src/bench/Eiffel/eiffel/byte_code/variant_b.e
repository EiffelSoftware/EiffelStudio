indexing
	description	: "Byte code for instruction inside a loop variant"
	date		: "$Date$"
	revision	: "$Revision$"

class VARIANT_B

inherit
	ASSERT_B
		redefine
			enlarged, process
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_variant_b (Current)
		end

feature -- Access

	enlarged: VARIANT_BL is
			-- Enlarge current node
		do
			create Result
			Result.fill_from (Current)
		end

end
