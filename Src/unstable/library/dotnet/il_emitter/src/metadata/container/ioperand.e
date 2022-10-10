note
	description: "Instruction Operand Enumeration"
	date: "$Date$"
	revision: "$Revision$"

once class
	IOPERAND
create
	o_none, o_single, o_rel1, o_rel4, o_index1, o_index2, o_index4,
    o_immed1, o_immed4, o_immed8, o_float4, o_float8, o_switch

feature {NONE} -- Creation

	  o_none once index :=  0 end
	  o_single once index :=  1 end
	  o_rel1 once index :=  2 end
	  o_rel4 once index :=  3 end
	  o_index1 once index :=  4 end
	  o_index2 once index :=  5 end
	  o_index4 once index :=  6 end
      o_immed1 once index :=  7 end
      o_immed4 once index :=  8 end
      o_immed8 once index :=  9 end
      o_float4 once index :=  10 end
      o_float8 once index :=  11 end
      o_switch once index :=  12 end

feature -- Access

	index: NATURAL_8
		-- Index of the current index.

end
