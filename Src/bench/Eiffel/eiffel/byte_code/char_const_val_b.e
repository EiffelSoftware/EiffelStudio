indexing
	description: "Representation of a character constant"
	date: "$Date$"
	revision: "$Revision$"

class
	CHAR_CONST_VAL_B 

inherit
	CHAR_VAL_B
		rename
			make as old_make
		redefine
			generation_value
		end
	
creation
	make

feature {NONE} -- Initialization

	make (context_class: CLASS_C; i: CHARACTER; c: CONSTANT_I) is
		require
			context_class_not_void: context_class /= Void
			good_argument: c /= Void
		do
			old_make (i)
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
			-- Class ID where constant is defined from.
			
feature -- Generation

	generation_value: CHARACTER is
			-- Value to generate
		local
			constant_i: CONSTANT_I
			char_value: CHAR_VALUE_I
			current_feature_table: FEATURE_TABLE
		do
			current_feature_table := System.class_of_id (written_in).feature_table
			constant_i ?= current_feature_table.origin_table.item (rout_id)
			char_value ?= constant_i.value
			Result := char_value.char_val
		end

end
