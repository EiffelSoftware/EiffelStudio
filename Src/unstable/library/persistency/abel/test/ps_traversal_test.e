note
	description: "Summary description for {PS_TRAVERSAL_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TRAVERSAL_TEST

inherit
	EQA_TEST_SET
		redefine on_prepare end

feature {NONE} -- Implementation

	on_prepare
		do
			create test_data.make
			create traversal.make (create {ANY}, create {PS_METADATA_FACTORY}.make)
		end

	test_data: PS_TEST_DATA

	traversal: PS_OBJECT_GRAPH_TRAVERSAL


feature

	test_reference_cycle
		do
			traversal.set_root_object (test_data.reference_cycle)
			traversal.traverse

			print (traversal.traversed_objects_as_string)
		end

	test_evil_object
		do
			traversal.set_root_object (test_data.evil_object)
			traversal.traverse
			print (traversal.traversed_objects_as_string)
			io.error.put_string (traversal.traversed_objects_as_string)
		end

--	test_expanded_special
--		local
--			test: SPECIAL [EXPANDED_PERSON]
--			person: EXPANDED_PERSON

--			reflector: REFLECTED_REFERENCE_OBJECT
--			item_reflector: PS_REFLECTED_SPECIAL_EXPANDED

--			int: INTERNAL
--			any: ANY
--			sp2: SPECIAL [EXPANDED_PERSON]
--		do
--			create person.make ("some", "name", 42)
--			create test.make_filled (person, 2)
--			--print (test.tagged_out)
--				print (header (test).out + "%N")

--			create reflector.make (test)
--			create item_reflector.make_special_expanded (test, 0)

--			across
--				1 |..| item_reflector.field_count as idx
--			from
--				print (item_reflector.object)
----				print (item_reflector.field_count)
--				io.new_line
--			loop
--				print (item_reflector.field (idx.item))
--				io.new_line
--			end

--			create int
----			print (int.physical_size (create {ANY}))
----			io.new_line
----			print (int.physical_size (create {TEST_PERSON}.make ("A","B",3)))
----			io.new_line
----			print (int.physical_size (create {CELL [INTEGER]}.put (42)))
----			io.new_line
----			print (int.physical_size (create {CELL [BOOLEAN]}.put (True)))
----			io.new_line
----			print (int.physical_size (create {CELL [detachable ANY]}.put (Void)))
----			io.new_line
----			print (int.physical_size (create {PS_PAIR [detachable ANY,detachable ANY]}.make (Void, Void)))
----			io.new_line

--			any := int.new_instance_of (test.generating_type.type_id)
--			print (header (any).out + "%N")
--			fix_header (any)
--			print (header (any).out + "%N")
--			print (any)
--			check attached {SPECIAL [EXPANDED_PERSON]} any as sp then
--				print (sp.count.out + "/" + sp.capacity.out + "%N")
--				sp2 := sp.resized_area (2)

--				fix_header (sp2)

--				print (sp2.count.out + "/" + sp2.capacity.out + "%N")
--				sp2.extend (person)
--				sp2.extend (person)
--				print (deep_equal (test, sp2))
--				print (sp2.tagged_out)
--			end

--			create item_reflector.make_special_expanded (test, 1)

--			item_reflector.set_integer_32_field (3, 10)

--			across
--				1 |..| item_reflector.field_count as idx
--			from
--				print (item_reflector.object)
----				print (item_reflector.field_count)
--				io.new_line
--			loop
--				print (item_reflector.field (idx.item))
--				io.new_line
--			end




--		end

--feature {NONE} -- Special: Object header fix

--	frozen fix_header (object: ANY)
--			-- Add the flags EO_SPEC (indicating a SPECIAL object)
--			-- and EO_COMP (indicating expanded types) to `object'.
--		external
--			"C inline use %"eif_eiffel.h%""
--		alias
--			"HEADER ($object) -> ov_flags = EO_SPEC | EO_COMP;"
--		end

--	frozen header (object: ANY): NATURAL_32
--		external
--			"C inline use %"eif_eiffel.h%""
--		alias
--			"return HEADER ($object) -> ov_flags;"
--		end

end
