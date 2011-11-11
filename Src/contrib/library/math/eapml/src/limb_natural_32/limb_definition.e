note
	description: "Summary description for {LIMB_DEFINITION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	LIMB_DEFINITION

feature

	limb_high_bit: INTEGER = 31
			-- Index of the high bit of a limb

	limb_bits: INTEGER = 32
			-- Number of bits in a limb
end
