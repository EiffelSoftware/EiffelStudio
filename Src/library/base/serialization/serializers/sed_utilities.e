indexing
	description: "Utilities for serializing/deserializing objects"
	date: "$Date$"
	revision: "$Revision$"

class
	SED_UTILITIES

feature {NONE} -- Implementation

	is_special_flag: NATURAL_8 is 0x01
	is_tuple_flag: NATURAL_8 is 0x02
			-- Various flags for storing objects

	special_type_mapping: HASH_TABLE [INTEGER, INTEGER] is
			-- Mapping betwwen dynamic type of SPECIAL instances
			-- to abstract element types.
		local
			l_int: INTERNAL
		once
			create l_int
			create Result.make (10)
			Result.put ({INTERNAL}.boolean_type, l_int.dynamic_type_from_string ("BOOLEAN"))
			Result.put ({INTERNAL}.character_type, l_int.dynamic_type_from_string ("CHARACTER"))

			Result.put ({INTERNAL}.natural_8_type, l_int.dynamic_type_from_string ("NATURAL_8"))
			Result.put ({INTERNAL}.natural_16_type, l_int.dynamic_type_from_string ("NATURAL_16"))
			Result.put ({INTERNAL}.natural_32_type, l_int.dynamic_type_from_string ("NATURAL_32"))
			Result.put ({INTERNAL}.natural_64_type, l_int.dynamic_type_from_string ("NATURAL_64"))

			Result.put ({INTERNAL}.integer_8_type, l_int.dynamic_type_from_string ("INTEGER_8"))
			Result.put ({INTERNAL}.integer_16_type, l_int.dynamic_type_from_string ("INTEGER_16"))
			Result.put ({INTERNAL}.integer_32_type, l_int.dynamic_type_from_string ("INTEGER"))
			Result.put ({INTERNAL}.integer_64_type, l_int.dynamic_type_from_string ("INTEGER_64"))

			Result.put ({INTERNAL}.real_32_type, l_int.dynamic_type_from_string ("REAL"))
			Result.put ({INTERNAL}.real_64_type, l_int.dynamic_type_from_string ("DOUBLE"))

			Result.put ({INTERNAL}.pointer_type, l_int.dynamic_type_from_string ("POINTER"))
		ensure
			special_type_mapping_not_void: Result /= Void
		end

end
