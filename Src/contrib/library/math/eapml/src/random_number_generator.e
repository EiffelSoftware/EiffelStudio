note
	description: "Summary description for {RANDSTRUCT}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Where men cannot freely convey their thoughts to one another, no other liberty is secure. -  William E. Hocking (1873-1966), Freedom of the Press, 1947"

deferred class
	RANDOM_NUMBER_GENERATOR

inherit
	LIMB_MANIPULATION

feature

	randseed (seed: READABLE_INTEGER_X)
		deferred
		end

	randget (target: SPECIAL [NATURAL_32]; target_offset: INTEGER; count: INTEGER)
		require
			count = 0 or target.valid_index (target_offset)
			count = 0 or target.valid_index (target_offset + bits_to_limbs (count) - 1)
		deferred
		ensure
			target [target_offset + bits_to_limbs (count) - 1] = 0 or else most_significant_one (target [target_offset + bits_to_limbs (count) - 1]) <= bits_top_limb (count)
		end
end
