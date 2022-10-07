note
	description: "[
		Factory features to create different types of OPERAND
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	OPERAND_FACTORY

feature -- Operand factory features.

	default_operand: OPERAND
			-- default operand.
		do
			create Result.make
		ensure
			instance_free: class
		end

	complex_operand (v: VALUE): OPERAND
			-- Operand is a complex value.
		do
			Result := {OPERAND_FACTORY}.default_operand
			Result.type := {OPERAND_TYPE}.t_value
			Result.ref_value := v
			Result.size := {OPERAND_SIZE}.i8
		ensure
			instance_free: class
		end

	integer64_operand (a_value: INTEGER_64; a_size: OPERAND_SIZE): OPERAND
			-- Operand is an integer constant.
		do
			Result := {OPERAND_FACTORY}.default_operand
			Result.type := {OPERAND_TYPE}.t_int
			Result.int_value := a_value
			Result.size := a_size
		ensure
			instance_free: class
		end

	integer_operand (a_value: INTEGER; a_size: OPERAND_SIZE): OPERAND
			-- Operand is an integer constant.
		do
			Result := {OPERAND_FACTORY}.integer64_operand (a_value, a_size)
		ensure
			instance_free: class
		end

	natural_operand (a_value: NATURAL; a_size: OPERAND_SIZE): OPERAND
			-- Operand is a Natural constant.
		do
			Result := {OPERAND_FACTORY}.integer64_operand (a_value, a_size)
		ensure
			instance_free: class
		end

	character_operand (a_value: CHARACTER; a_size: OPERAND_SIZE): OPERAND
			-- Operand is a Natural constant.
		do
			Result := {OPERAND_FACTORY}.integer64_operand (a_value.code, a_size)
		ensure
			instance_free: class
		end


	real_operand (a_value: REAL_64; a_size: OPERAND_SIZE): OPERAND
			-- Operand is a floating point operand.
		do
			Result := {OPERAND_FACTORY}.default_operand
			Result.type := {OPERAND_TYPE}.t_real
			Result.float_value := a_value
			Result.size := a_size
		ensure
			instance_free: class
		end

	string_operand (a_value: READABLE_STRING_GENERAL): OPERAND
			-- Operand is a String
		do
			Result := {OPERAND_FACTORY}.default_operand
			Result.type := {OPERAND_TYPE}.t_string
			Result.string_value := a_value
			Result.size := {OPERAND_SIZE}.i8
		ensure
			instance_free: class
		end


	label_operand (a_value: READABLE_STRING_GENERAL): OPERAND
			-- Operand is a label
		do
			Result := {OPERAND_FACTORY}.default_operand
			Result.type := {OPERAND_TYPE}.t_label
			Result.string_value := a_value
			Result.size := {OPERAND_SIZE}.i8
		ensure
			instance_free: class
		end


end
