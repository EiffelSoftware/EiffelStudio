note
	description: "[
		Factory features to create different types of OPERAND
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_OPERAND_FACTORY

feature -- Operand factory features.

	default_operand: CIL_OPERAND
			-- default operand.
		do
			create Result.make
		ensure
			instance_free: class
		end

	complex_operand (v: CIL_VALUE): CIL_OPERAND
			-- Operand is a complex value.
		do
			Result := {CIL_OPERAND_FACTORY}.default_operand
			Result.type := {CIL_OPERAND_TYPE}.t_value
			Result.ref_value := v
			Result.size := {CIL_OPERAND_SIZE}.i8
		ensure
			instance_free: class
		end

	integer64_operand (a_value: INTEGER_64; a_size: CIL_OPERAND_SIZE): CIL_OPERAND
			-- Operand is an integer constant.
		do
			Result := {CIL_OPERAND_FACTORY}.default_operand
			Result.type := {CIL_OPERAND_TYPE}.t_int
			Result.int_value := a_value
			Result.size := a_size
		ensure
			instance_free: class
		end

	integer_operand (a_value: INTEGER; a_size: CIL_OPERAND_SIZE): CIL_OPERAND
			-- Operand is an integer constant.
		do
			Result := {CIL_OPERAND_FACTORY}.integer64_operand (a_value, a_size)
		ensure
			instance_free: class
		end

	natural_operand (a_value: NATURAL; a_size: CIL_OPERAND_SIZE): CIL_OPERAND
			-- Operand is a Natural constant.
		do
			Result := {CIL_OPERAND_FACTORY}.integer64_operand (a_value, a_size)
		ensure
			instance_free: class
		end

	character_operand (a_value: CHARACTER; a_size: CIL_OPERAND_SIZE): CIL_OPERAND
			-- Operand is a Natural constant.
		do
			Result := {CIL_OPERAND_FACTORY}.integer64_operand (a_value.code, a_size)
		ensure
			instance_free: class
		end


	real_operand (a_value: REAL_64; a_size: CIL_OPERAND_SIZE): CIL_OPERAND
			-- Operand is a floating point operand.
		do
			Result := {CIL_OPERAND_FACTORY}.default_operand
			Result.type := {CIL_OPERAND_TYPE}.t_real
			Result.float_value := a_value
			Result.size := a_size
		ensure
			instance_free: class
		end

	string_operand (a_value: READABLE_STRING_GENERAL): CIL_OPERAND
			-- Operand is a String
		do
			Result := {CIL_OPERAND_FACTORY}.default_operand
			Result.type := {CIL_OPERAND_TYPE}.t_string
			Result.string_value := a_value
			Result.size := {CIL_OPERAND_SIZE}.i8
		ensure
			instance_free: class
		end


	label_operand (a_value: READABLE_STRING_GENERAL): CIL_OPERAND
			-- Operand is a label
		do
			Result := {CIL_OPERAND_FACTORY}.default_operand
			Result.type := {CIL_OPERAND_TYPE}.t_label
			Result.string_value := a_value
			Result.size := {CIL_OPERAND_SIZE}.i8
		ensure
			instance_free: class
		end


end
