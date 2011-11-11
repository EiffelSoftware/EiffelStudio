note
	description: "Summary description for {NUMBER_UTILITY}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "If a law is unjust, a man is not only right to disobey it, he is obligated to do so. -  Thomas Jefferson"

deferred class
	SPECIAL_UTILITY

feature

	normalize (op1: SPECIAL [NATURAL_32]; op1_offset: INTEGER; op1_count: INTEGER): INTEGER
		do
			from
				Result := op1_count
			until
				Result <= 0 or op1 [op1_offset + Result - 1] /= 0
			loop
				Result := Result - 1
			end
		end

	reverse (target: SPECIAL [NATURAL_32]; target_offset: INTEGER; source: SPECIAL [NATURAL_32]; source_offset: INTEGER; count: INTEGER)
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i >= count
			loop
				target [target_offset + i] := source [source_offset + count - 1 - i]
				i := i + 1
			end
		end
end
