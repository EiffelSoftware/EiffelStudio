indexing
	description: "Actual type for bits_symbol."
	date: "$Date$"
	revision: "$Revision $"

class BITS_SYMBOL_A

inherit
	BITS_A
		rename
			make as make_with_count
		redefine
			solved_type, dump, ext_append_to,
			is_equivalent, is_full_named_type
		end

create {COMPILER_EXPORTER}
	make

feature {NONE} -- Initialization

	make (f: FEATURE_I; c: like bit_count) is
		do
			make_with_count (c)
			feature_name := f.feature_name
			current_class_id := System.current_class.class_id
			rout_id := f.rout_id_set.first
		end

feature -- Properties

	feature_name: STRING

	rout_id: INTEGER

	current_class_id: INTEGER
			-- Class declaring current

	is_full_named_type: BOOLEAN is False
			-- Current is not fully named

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := bit_count = other.bit_count and then
				rout_id = other.rout_id and then
				feature_name.is_equal (other.feature_name) and then
				current_class_id = other.current_class_id
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		do
			create Result.make (9)
			Result.append ("BIT ")
			Result.append (feature_name)
		end

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		do
			st.add (ti_Bit_class)
			st.add_space
			st.add_string (feature_name)
		end

feature {COMPILER_EXPORTER}

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): BITS_SYMBOL_A is
			-- Calculated type in function of the feauure `f' which has
			-- the type Current and the feautre table `feat_table
		local
			origin_table: HASH_TABLE [FEATURE_I, INTEGER]
			anchor_feature: FEATURE_I
			vtbt: VTBT
			veen: VEEN
			constant: CONSTANT_I
			bits_value: INTEGER
			error: BOOLEAN
			int_value: INTEGER_CONSTANT
		do
			origin_table := feat_table.origin_table
			if not (System.current_class.class_id = current_class_id) then
				anchor_feature := System.class_of_id (current_class_id).feature_table
								.item (feature_name)
			else
				anchor_feature := feat_table.item (feature_name)
			end
			if anchor_feature = Void then
				create veen
				veen.set_class (System.current_class)
				veen.set_feature (f)
				veen.set_identifier (feature_name)
				Error_handler.insert_error (veen)
				Error_handler.raise_error
			else
				constant ?= anchor_feature
				error := constant = Void
				if not error then
					int_value ?= constant.value
					error := int_value = Void
					if not error then
						bits_value := int_value.integer_32_value
						error :=
							bits_value <= 0 or else
							bits_value > feature {EIFFEL_SCANNER_SKELETON}.Maximum_bit_constant
					end
				end
				if error then
					create vtbt
					vtbt.set_class (feat_table.associated_class)
					vtbt.set_feature (f)
					vtbt.set_value (bits_value)
					Error_handler.insert_error (vtbt)
						-- Cannot go on here
					Error_handler.raise_error
				end
				bit_count := bits_value
			end
			rout_id := anchor_feature.rout_id_set.first
			Result := twin
		end

end -- class BITS_SYMBOL_A
