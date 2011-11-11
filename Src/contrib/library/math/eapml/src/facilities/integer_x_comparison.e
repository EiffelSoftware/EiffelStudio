note
	description: "Summary description for {INTEGER_X_COMPARISON}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "The marvel of all history is the patience with which men and women submit to burdens unnecessarily laid upon them by their governments. - U.S. Senator William Borah"

deferred class
	INTEGER_X_COMPARISON

inherit
	INTEGER_X_FACILITIES
	SPECIAL_COMPARISON
		rename
			cmp as cmp_special
		end

feature

	compare (op1: READABLE_INTEGER_X; op2: READABLE_INTEGER_X): INTEGER
			-- Compare `op1' and `op2'.
			-- Return a positive value if `op1' > `op2', zero if `op1' = `op2', or a negative value if `op1' < `op2'.
		local
			usize: INTEGER_32
			vsize: INTEGER_32
			dsize: INTEGER_32
			asize: INTEGER_32
			cmp_l: INTEGER_32
		do
			usize := op1.count
			vsize := op2.count
			dsize := usize - vsize
			if dsize /= 0 then
				Result := dsize
			else
				asize := usize.abs
				cmp_l := cmp_special (op1.item, 0, op2.item, 0, asize)
				if usize >= 0 then
					Result := cmp_l
				else
					Result := -cmp_l
				end
			end
		end

	cmp_si (op1: READABLE_INTEGER_X; op: INTEGER_32): INTEGER
			-- Compare `op1' and `op2'.
			-- Return a positive value if `op1' > `op2', zero if `op1' = `op2', or a negative value if `op1' < `op2'.
			-- Is a macro and will evaluate their arguments more than once.
		local
			v_digit: INTEGER_32
			usize: INTEGER_32
			vsize: INTEGER_32
			u_digit: NATURAL_32
		do
			v_digit := op
			usize := op1.count
			vsize := 0
			if v_digit > 0 then
				vsize := 1
			elseif v_digit < 0 then
				vsize := -1
				v_digit := -v_digit
			end
			if usize /= vsize then
				Result := usize - vsize
			else
				if usize = 0 then
					Result := 0
				else
					u_digit := op1.item [0]
					if u_digit = v_digit.to_natural_32 then
						Result := 0
					else
						if u_digit > v_digit.to_natural_32 then
							Result := usize
						else
							Result := -usize
						end
					end
				end
			end
		end

	cmp_ui (op1: READABLE_INTEGER_X; op: NATURAL): INTEGER
			-- Compare `op1' and `op2'.
			-- Return a positive value if `op1' > `op2', zero if `op1' = `op2', or a negative value if `op1' < `op2'.
			-- Is a macro and will evaluate their arguments more than once.
		local
			un: INTEGER_32
			ul: NATURAL_32
			v_digit: NATURAL_32
		do
			v_digit := op
			un := op1.count
			if un = 0 then
				if v_digit /= 0 then
					Result := -1
				else
					Result := 0
				end
			else
				if un = 1 then
					ul := op1.item [0]
					if ul > v_digit then
						Result := 1
					else
						if ul < v_digit then
							Result := -1
						else
							Result := 0
						end
					end
				else
					if un > 0 then
						Result := 1
					else
						Result := -1
					end
				end
			end
		end

	cmpabs (op1: READABLE_INTEGER_X ;op2: READABLE_INTEGER_X): INTEGER
			-- Compare the absolute values of `op1' and `op2'.
			-- Return a positive value if abs(`op1') > abs(`op2'), zero if abs(`op1') = abs(`op2'),
			-- or a negative value if abs(`op1') < abs(`op2').
		local
			usize: INTEGER_32
			vsize: INTEGER_32
			dsize: INTEGER_32
			cmp_l: INTEGER_32
			i: INTEGER_32
			x: NATURAL_32
			y: NATURAL_32
		do
			usize := op1.count.abs
			vsize := op2.count.abs
			dsize := usize - vsize
			if dsize /= 0 then
				Result := dsize
			else
				cmp_l := 0
				from
					i := usize - 1
				until
					i < 0 or cmp_l /= 0
				loop
					x := op1.item [i]
					y := op2.item [i]
					if x /= y then
						if x > y then
							Result := 1
						else
							Result := -1
						end
					end
					i := i - 1
				variant
					i + 2
				end
			end
		end

	cmpabs_ui (op1: READABLE_INTEGER_X; op: NATURAL_32): INTEGER
			-- Compare the absolute values of `op1' and `op2'.
			-- Return a positive value if abs(`op1') > abs(`op2'), zero if abs(`op1') = abs(`op2'),
			-- or a negative value if abs(`op1') < abs(`op2').
		local
			un: INTEGER_32
			ul: NATURAL_32
			v_digit: NATURAL_32
		do
			v_digit := op
			un := op1.count
			if un = 0 then
				if v_digit /= 0 then
					Result := -1
				else
					Result := 0
				end
			else
				un := un.abs
				if un = 1 then
					ul := op1.item [0]
					if ul > v_digit then
						Result := 1
					else
						if ul < v_digit then
							Result := -1
						else
							Result := 0
						end
					end
				else
					Result := 1
				end
			end
		end
end
