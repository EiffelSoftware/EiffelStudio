class BITS_AS

inherit
	BASIC_TYPE
		rename
			initialize as initialize_basic_type
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (v: like bits_value) is
			-- Create a new BITS AST node.
		require
			v_not_void: v /= Void
		local
			vtbt: VTBT_SIMPLE
		do
			bits_value := v
			if (bits_value.value <= 0) then
				create vtbt
				vtbt.set_class (System.current_class)
				vtbt.set_value (bits_value.value)
				Error_handler.insert_error (vtbt)
					-- Cannot go on here
				Error_handler.raise_error
			end
		ensure
			bits_value_set: bits_value = v
		end

feature -- Attributes

	bits_value: INTEGER_AS
			-- Bits value

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (bits_value, other.bits_value)
		end

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): BITS_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		local
			vtbt: VTBT
		do
			if (bits_value.value <= 0) then
				!!vtbt
				vtbt.set_class (feat_table.associated_class)
				vtbt.set_feature (f)
				vtbt.set_value (bits_value.value)
				Error_handler.insert_error (vtbt)
					-- Cannot go on here
				Error_handler.raise_error
			end
			Result := actual_type
		end

	actual_type: BITS_A is
			-- Actual bits type
		do
			create Result.make (bits_value.value)
		end

feature -- Output

	dump: STRING is
			-- Debug purpose
		do
			!! Result.make (10)
			Result.append ("BIT ")
			Result.append_integer (bits_value.value)
		end

end -- class BITS_AS
