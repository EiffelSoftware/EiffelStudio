indexing
	description: "Representation of an integer constant"
	date: "$Date$"
	revision: "$Revision$"

class
	INT_CONST_VAL_B 

inherit
	INT_VAL_B
		rename
			make as old_make
		redefine
			generation_value
		end

creation
	make
	
feature {NONE} -- Initialization

	make (context_class: CLASS_C; i: INTEGER; c: CONSTANT_I) is
			-- Creare a new constant access value for constant `c'
			-- written in `context_class'.
		require
			context_class_not_void: context_class /= Void
			c_not_void: c /= Void
		do
			value := i
			rout_id := c.rout_id_set.first
			feature_id := c.feature_id
			written_in := context_class.class_id
		end

feature -- Access

	rout_id: INTEGER
			-- Routine id of the constant

	feature_id: INTEGER
			-- Feature id of the constant

	written_in: INTEGER
			-- Class id where constant is used.

feature -- Code generation

	generation_value: INTEGER is
			-- Value to generate
		local
			constant_i: CONSTANT_I
			integer_value: INTEGER_CONSTANT
			current_feature_table: FEATURE_TABLE
		do
			current_feature_table := System.class_of_id (written_in).feature_table
			constant_i ?= current_feature_table.origin_table.item (rout_id)
			integer_value ?= constant_i.value
			Result := integer_value.value
		end

end
