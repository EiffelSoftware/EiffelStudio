indexing
	description: "Constant class for IL operators"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IL_CONST

feature -- Property

	valid_type_kind (i: INTEGER): BOOLEAN is
			-- Is `i' on of the following values `il_i1', `il_i2', `il_i4', `il_i8',
			-- `il_r4', `il_r8', `il_ref'?
		do
			Result := i = il_i1 or i = il_i2 or i = il_i4 or i = il_i8 or
					 i = il_r4 or i = il_r8 or i = il_ref
		end

feature -- Constants for binary expression

		-- Comparisons operators on numeric and characters.
	Il_lt: INTEGER is 0
	Il_le: INTEGER is 1
	Il_gt: INTEGER is 2
	Il_ge: INTEGER is 3

		-- Numeric operators.
	Il_star: INTEGER is 4
	Il_slash: INTEGER is 5
	Il_power: INTEGER is 6
	Il_plus: INTEGER is 7
	Il_mod: INTEGER is 8
	Il_minus: INTEGER is 9
	Il_div: INTEGER is 10

		-- Boolean comparisons operators.
	Il_xor: INTEGER is 11
	Il_or: INTEGER is 12
	Il_and: INTEGER is 13

		-- Equality operators.
	Il_ne: INTEGER is 14
	Il_eq: INTEGER is 15

		-- Shifting operator
	Il_shl: INTEGER is 20
	Il_shr: INTEGER is 21

feature {NONE} -- Constants for unary expression

	Il_uplus: INTEGER is 16
	Il_not: INTEGER is 17
	Il_uminus: INTEGER is 18
	Il_old: INTEGER is 19

feature {NONE} -- Constants for variable kind

	il_i1: INTEGER is 30
	il_i2: INTEGER is 31
	il_i4: INTEGER is 32
	il_i8: INTEGER is 33
	il_r4: INTEGER is 34
	il_r8: INTEGER is 35
	il_ref: INTEGER is 36
	
end -- class IL_CONST
