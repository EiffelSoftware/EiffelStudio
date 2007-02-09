indexing

	description:

		"Make sure that we don't have name clashes with features %
		%from PLATFORM inherited from ANY in SE 1.2"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2006, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class KL_ANY

inherit

	ANY

		rename
			Minimum_character_code as se_minimum_character_code,
			Maximum_character_code as se_maximum_character_code,
			Minimum_integer as se_minimum_integer,
			Maximum_integer as se_maximum_integer,
			Boolean_bits as se_boolean_bits,
			Character_bits as se_character_bits,
			Double_bits as se_double_bits,
			Integer_bits as se_integer_bits,
			Pointer_bits as se_pointer_bits,
			Real_bits as se_real_bits
		end


end
