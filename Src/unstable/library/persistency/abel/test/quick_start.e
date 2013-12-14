note
	description: "Summary description for {APPLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QUICK_START

inherit
	PS_ABEL_EXPORT

	INTERNAL

	MEMORY

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			factory: PS_IN_MEMORY_REPOSITORY_FACTORY
--			executor: PS_EXECUTOR
			data: PS_TEST_DATA
--			query: PS_OBJECT_QUERY [SPECIAL [TEST_PERSON]]

--			query2: PS_OBJECT_QUERY [REFERENCE_CLASS_1]

			factory2: TEST_DATA_FACTORY
			sp_factory: SPECIAL_FACTORY
			any: ANY
			reflector: REFLECTED_REFERENCE_OBJECT

--			special: SPECIAL [detachable ANY]
--			special: detachable ANY
			person: EXPANDED_PERSON
			str: STRING

			int: INTERNAL
		do
			new_special
--			create int

--			create special.make_filled (person, 4)
			print (special.item (0).first_name)
			--create special.make_empty (4)
--			special := new_special_any_instance (({detachable SPECIAL [ANY]}).type_id, 2)
--			special := int.new_instance_of (({detachable SPECIAL [EXPANDED_PERSON]}).type_id)
--			fix_header (special)
--			print ("header: " + header (special).out + "%N ")

--			print ("new: " + eo_new (special).out + "%N ")
--			print ("spec: " + eo_spec (special).out + "%N ")
--			print ("ref: " + eo_ref (special).out + "%N ")
--			print ("comp: " + eo_comp (special).out + "%N ")

			create int
			create int

			full_collect
			full_coalesce

--			str := special.tagged_out
			print (special.item (0).first_name)

		end

	new_special
		local
			person: EXPANDED_PERSON
		do
			create special.make_filled (person, 4)
		end

	special: SPECIAL [EXPANDED_PERSON]


	frozen fix_header (object: ANY)
			-- Add the flags EO_SPEC (indicating a SPECIAL object)
			-- and EO_COMP (indicating expanded types) to `object'.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"HEADER (eif_access ($object)) -> ov_flags |= (EO_SPEC | EO_COMP | EO_REF);"
		end

	frozen header (object: ANY): NATURAL_16
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"return (HEADER (eif_access ($object)) -> ov_flags) ;"
		end

	frozen eo_new (object: ANY): NATURAL_16
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"return (HEADER (eif_access ($object)) -> ov_flags) & EO_NEW;"
		end

	frozen eo_spec (object: ANY): NATURAL_16
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"return (HEADER (eif_access ($object)) -> ov_flags) & EO_SPEC;"
		end

	frozen eo_comp (object: ANY): NATURAL_16
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"return (HEADER (eif_access ($object)) -> ov_flags) & EO_COMP;"
		end

	frozen eo_ref (object: ANY): NATURAL_16
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"return (HEADER (eif_access ($object)) -> ov_flags) & EO_REF;"
		end
end
