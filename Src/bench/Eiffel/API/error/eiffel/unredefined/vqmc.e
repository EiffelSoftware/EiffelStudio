indexing
	description: "Error on type of a constant feature."
	date: "$Date$"
	revision: "$Revision $"

class VQMC 

inherit
	EIFFEL_ERROR
		redefine
			build_explain
		end

	SHARED_TYPES
		export
			{NONE} all
		end
		
	SHARED_WORKBENCH
		export
			{NONE} all
		end

feature -- Properties

	feature_name: STRING
			-- Constant name
			-- [Note that the class id where the constant is written is
			-- `class_id'.]

	code: STRING is "VQMC"
			-- Error code

	constant_type: TYPE_A
			-- Type of constant as defined.

	expected_type: TYPE_A
			-- Type of declaration of constant.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Constant name: ")
			st.add_string (feature_name)
			st.add_new_line
			st.add_string ("Found constant of type: ")
			constant_type.append_to (st)
			st.add_new_line
			st.add_string ("Declared type: ")
			expected_type.append_to (st)
			st.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (i: STRING) is
			-- Assign `i' to `feature_name'.
		do
			feature_name := i
		end

	set_constant_type (a_const: VALUE_I) is
			-- Assign proper type to `constant_type'
		require
			a_const_not_void: a_const /= Void
		local
			bit_value: BIT_VALUE_I
			l_int: INTEGER_CONSTANT
		do
			if a_const.is_bit then
				bit_value ?= a_const
				create {BITS_A} constant_type.make (bit_value.bit_count)
			elseif a_const.is_boolean then
				constant_type := Boolean_type
			elseif a_const.is_character then
				constant_type := Character_type
			elseif a_const.is_double or a_const.is_real then
				constant_type := Double_type
			elseif a_const.is_integer then
				l_int ?= a_const
				inspect
					l_int.size
				when 8 then constant_type := Integer_8_type
				when 16 then constant_type := Integer_16_type
				when 32 then constant_type := Integer_type
				when 64 then constant_type := Integer_64_type
				end
			elseif a_const.is_string then
				create {CL_TYPE_A} constant_type.make (System.string_id)
			else
				check
					not_reached: False
				end
			end
		ensure
			constant_type_set: constant_type /= Void
		end

	set_expected_type (t: TYPE_A) is
			-- Assign `t' to `expected_type'.
		require
			t_not_void: t /= Void
		do
			expected_type := t
		ensure
			expected_type_set: expected_type = t
		end

end -- class VQMC
