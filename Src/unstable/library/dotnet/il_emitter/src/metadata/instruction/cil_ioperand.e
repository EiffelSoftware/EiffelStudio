note
	description: "Instruction Operand Enumeration"
	date: "$Date$"
	revision: "$Revision$"

once class
	CIL_IOPERAND
create
	o_none, o_single, o_rel1, o_rel4, o_index1, o_index2, o_index4,
	o_immed1, o_immed4, o_immed8, o_float4, o_float8, o_switch

feature {NONE} -- Creation

	o_none once  end
	o_single once end
	o_rel1 once end
	o_rel4 once end
	o_index1 once end
	o_index2 once end
	o_index4 once end
	o_immed1 once end
	o_immed4 once end
	o_immed8 once end
	o_float4 once end
	o_float8 once end
	o_switch once end

feature -- Access

	instances: ITERABLE [CIL_IOPERAND]
			-- All known operands.
		do
			Result := <<
					{CIL_IOPERAND}.o_none,
					{CIL_IOPERAND}.o_single,
					{CIL_IOPERAND}.o_rel1,
					{CIL_IOPERAND}.o_rel4,
					{CIL_IOPERAND}.o_index1,
					{CIL_IOPERAND}.o_index2,
					{CIL_IOPERAND}.o_index4,
					{CIL_IOPERAND}.o_immed1,
					{CIL_IOPERAND}.o_immed4,
					{CIL_IOPERAND}.o_immed8,
					{CIL_IOPERAND}.o_float4,
					{CIL_IOPERAND}.o_float8,
					{CIL_IOPERAND}.o_switch
			>>
		ensure
			instance_free: class
		end

	index_of (a_value: CIL_IOPERAND): NATURAL_8
			-- Index of first occurrence of item identical to `a_value'.
			-- -1 if none.
		local
			l_area: SPECIAL [CIL_IOPERAND]
		do
			l_area := (create {ARRAYED_LIST [CIL_IOPERAND]}.make_from_iterable ({CIL_IOPERAND}.instances)).area
			Result :=  l_area.index_of(a_value, l_area.lower).to_natural_8
		ensure
			instance_free: class
		end

end
