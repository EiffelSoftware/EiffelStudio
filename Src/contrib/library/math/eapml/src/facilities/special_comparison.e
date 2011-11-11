note
	description: "Summary description for {NUMBER_COMPARISON}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "No nation was ever ruined by trade. -  Benjamin Franklin"

deferred class
	SPECIAL_COMPARISON

feature

	cmp (op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER; op2: SPECIAL [NATURAL_32]; op2_offset: INTEGER; size: INTEGER): INTEGER
		local
			i: INTEGER
			x: NATURAL_32
			y: NATURAL_32
		do
			Result := 0
			from
				i := size - 1
			until
				i < 0 or Result /= 0
			loop
				x := op1 [op1_offset + i]
				y := op2 [op2_offset + i]
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
