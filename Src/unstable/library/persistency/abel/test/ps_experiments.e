note
	description: "Some experiments done during the development of ABEL."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_EXPERIMENTS

inherit

	EQA_TEST_SET

feature

	experiment_immutable_strings
		local
			t1, t2: TYPE [detachable ANY]
			init: IMMUTABLE_STRING_8
			criterion: PS_PREDEFINED_CRITERION
		do
			t1 := {ANY}
			init := t1.name
			t2 := {PS_EXPERIMENTS}
			init := t2.name

			create criterion.make ("internal_name", "=", "!ANY")
			assert ("equal_satisfied", criterion.is_satisfied_by (t1))

			create criterion.make ("internal_name", "like", "*EXP?RIM*")
			assert ("like_satisfied", criterion.is_satisfied_by (t2))

		end

	experiment_reflector
		local
			factory: OBJECT_GRAPH_FACTORY

			reflector: REFLECTED_REFERENCE_OBJECT
			item_reflector: REFLECTED_REFERENCE_OBJECT

			cell: CELL [E_DOUBLE_CELL [ANY, ANY]]
			any: ANY
		do
			create factory
			cell := factory.embedded_expanded

			create reflector.make (cell)
			any := reflector.expanded_field (1).object

				-- This works
			check attached {E_DOUBLE_CELL [ANY, ANY]} any as cell_item then
				assert ("Equal objects", reflector.expanded_field (1).object = cell_item)

					--or this:
				item_reflector := reflector.expanded_field (1)
				assert ("Equal objects", item_reflector.object = cell_item)
			end

				-- Fails when frozen (probably because some flags ar missing when using {REFLECTED_OBJECT}.object)
			check attached any as cell_item then

--				assert ("Equal objects", reflector.expanded_field (1).object = cell_item)

					--Also failing:
				item_reflector := reflector.expanded_field (1)
--				assert ("Equal objects", item_reflector.object = cell_item)
			end


		end


	experiment_expanded_types
		local
			reflection: REFLECTED_REFERENCE_OBJECT
			reflection2: REFLECTED_REFERENCE_OBJECT
			container: EXPANDED_PERSON_CONTAINER
			internal: INTERNAL
			traversal: OBJECT_GRAPH_BREADTH_FIRST_TRAVERSABLE
			box: GENERIC_BOX [TEST_PERSON, EXPANDED_PERSON]
		do
			create traversal
			create container.set_item (5)
			create internal
			create reflection.make (container)
			create box.set_item (create {TEST_PERSON}.make ("some", "name", 22), create {EXPANDED_PERSON})

			across
				1 |..| reflection.field_count as i
			loop
				print (reflection.field_name (i.item))
				println

				print (internal.type_name_of_type (reflection.field_static_type (i.item)))

				if reflection.field_type (i.item) = reflection.reference_type then
					print (" -> reference ")
					if reflection.is_copy_semantics_field (i.item) then
						print ("(with copy semantics)")
					end
				end

				if reflection.is_field_statically_expanded (i.item) then
					print (" -> expanded ")
					print (reflection.field_type (i.item))
					println

					reflection2 := reflection.expanded_field (i.item)

					across
						1 |..| reflection2.field_count as i2
					loop
						print ("%T")
						print (reflection2.field (i2.item))
						println
					end

--					reflection2.set_integer_32_field (3, 2)
--					print (container.person.items_owned)

				else
					println
					print (reflection.field (i.item))
				end
				println
				println

			end

			traversal.set_root_object (container)
			traversal.set_on_processing_object_action (agent (a:REFLECTED_OBJECT) do print (a) end)
			traversal.traverse

			reflection.set_object (box)
			print (reflection.field_type (1))
			println
			print (reflection.field_type (2))
			println



		end

	experiment_none_expanded
		local
			type: TYPE [NONE]
		do
			type := {NONE}
			print (type.name)
			print (type.is_expanded)
			println
		end

	experiment_integer_interval
		local
			int: INTEGER_INTERVAL
			int2: PS_INTEGER_INTERVAL
		do

			int := 3 |..| 5
			print (int.count)
			int.extend (8)
			print (int.count)

			int := 3 |..| 1
			print (int)
			int.extend (5)
			print (int)

			create int2.make_new (5, 4)
			print (int2)
			int2.extend (5)
			print (int2)
		end

--	experiment_trasient
--		local
--			p1, p2: PERSON
--		do
--			create p1.make ("Albo", "Bitossi", 3)
--			create p2.make ("Albo", "Bitossi", 3)
--			assert ("equal", p1.is_deep_equal (p2))
--			p1.set (24)
--			assert ("not equal", not p1.is_deep_equal (p2))
--		end

	experiment_agent_failure_with_arg (list: LINKED_LIST [detachable ANY])
		do
			check list.for_all (agent experiment_agent_failure_test_agent (?, True, create {ANY})) end
		ensure
			list.for_all (agent experiment_agent_failure_test_agent (?, True, create {ANY}))
		end

	experiment_agent_failure_test_agent (any: ANY; bool: BOOLEAN; third_arg: ANY): BOOLEAN
		do
			if bool then
				Result := attached any
				any.do_nothing
			end
		end

	generate_void (any: detachable ANY): detachable ANY
		do
		end

	experiment_dynamic_any_type
			-- What is the dynamic type of ANY and detachable ANY?
		local
			reflection: INTERNAL
		do
			create reflection
			print (reflection.dynamic_type_from_string ("attached ANY"))
			println
			print (reflection.dynamic_type_from_string ("detachable ANY"))
			println

			assert ("detachable ANY is 0, aka Pointer type",
				reflection.dynamic_type_from_string ("detachable ANY") = reflection.dynamic_type_from_string ("ANY")
				and reflection.pointer_type  = reflection.dynamic_type_from_string ("ANY"))

		end

	experiment_internal
			-- An experiment about the runtime attached/detachable type situation
		local
			reflection: INTERNAL
			ref1: REFERENCE_CLASS_1
			list: LINKED_LIST [REFERENCE_CLASS_1]
			i: INTEGER
		do
			create reflection
			create ref1.make (1)
			check attached {REFERENCE_CLASS_1} reflection.new_instance_of (reflection.detachable_type (reflection.dynamic_type (ref1))) as ref2 and attached {REFERENCE_CLASS_1} reflection.new_instance_of (reflection.attached_type (reflection.dynamic_type (ref1))) as ref3 then
				from
					i := 1
				until
					i > reflection.field_count (ref2)
				loop
					if reflection.field_name (i, ref2).is_case_insensitive_equal ("ref_class_id") then
						reflection.set_integer_32_field (i, ref2, 1)
						reflection.set_integer_32_field (i, ref3, 1)
					elseif reflection.field_name (i, ref2).is_case_insensitive_equal ("references") then
						create list.make
						reflection.set_reference_field (i, ref2, list)
						create list.make
						reflection.set_reference_field (i, ref3, list)
					end
					i := i + 1
				end
					--				print (ref2.tagged_out + ref3.tagged_out)
				assert ("both_types_detachable", ref1.is_deep_equal (ref2))
				assert ("attached_and_detachable_wont_work", not ref1.is_deep_equal (ref3))
			end
		end

	experiment_internal_special
		local
			person_special: SPECIAL [TEST_PERSON]
			ref_special: SPECIAL [REFERENCE_CLASS_1]
			detached_ref_special: SPECIAL [detachable REFERENCE_CLASS_1]
			generated_special: ANY
			reflection: INTERNAL
		do
			create reflection
			create person_special.make_empty (10)
			create ref_special.make_empty (10)
			print (reflection.dynamic_type (person_special).out + "%N")
			print (reflection.dynamic_type (ref_special).out + "%N")
			print (reflection.generic_dynamic_type (person_special, 1).out + "%N")
			print (reflection.generic_dynamic_type (ref_special, 1).out + "%N")
				--generated_special:= reflection.new_special_any_instance (reflection.generic_dynamic_type (person_special, 1), 10)
			generated_special := reflection.new_special_any_instance (reflection.dynamic_type (person_special), 10)
			print (reflection.dynamic_type (generated_special).out + "%N")
			print (generated_special.is_deep_equal (person_special))
			print (person_special.out)
			print (ref_special.out)
			create detached_ref_special.make_filled (Void, 10)
			print (detached_ref_special.out)
		end

	experiment_generic_objects_type
		local
			list: LIST [ANY]
		do
			create {LINKED_LIST [ANY]} list.make
			print (attached {LIST [TEST_PERSON]} list)
			list.extend (create {TEST_PERSON}.make ("a", "b", 0))
			print (attached {LIST [TEST_PERSON]} list)
		end

	experiment_sqlite_failure_for_multiple_open_connections
		local
			conn1, conn2: detachable SQLITE_DATABASE
			file: STRING
			retried: BOOLEAN
		do
			if not retried then
				file := "test.db"
				create conn1.make_create_read_write (file)
				create conn2.make_create_read_write (file)
				conn1.begin_transaction (False)
				conn2.begin_transaction (False)
			end
		rescue
			check attached conn2 as c and then attached c.last_exception as ex then
				print (ex.tag)
			end
			retried:= True
			retry
		end

	experiment_constant_initialized
		local
			reflection: INTERNAL
			test_obj: ANY
			i: INTEGER
		do
			create reflection
			test_obj := reflection.new_instance_of (reflection.dynamic_type_from_string ("ESCHER_TEST_CLASS"))
			from
				i := 1
			until
				i > reflection.field_count (test_obj)
			loop
				print (reflection.field (i, test_obj))
				i := i + 1
			end
			check attached {VERSIONED_CLASS} test_obj as escher_obj then
				assert ("version not correct", escher_obj.version = 3)
			end
		end

	experiment_reflective_tuple_creation
			-- Investigate the relationship between reflection and tuples
		local
			reflection:INTERNAL
			string_integer_tuple: TUPLE [STRING, INTEGER]
			string_integer_tuple_2: TUPLE [STRING, INTEGER]
			tuple: TUPLE
			det_tuple: detachable TUPLE
			i:INTEGER
			special: SPECIAL [detachable ANY]
		do
			create reflection
			create string_integer_tuple -- generates detachable TUPLE [attached STRING, INTEGER]
			string_integer_tuple_2 := ["hello", 2] -- generates attached TUPLE [attached STRING, INTEGER] when molten, but detachable when frozen.

			print (reflection.dynamic_type (string_integer_tuple).out + " " + reflection.type_name (string_integer_tuple))
			println
			print (reflection.dynamic_type (string_integer_tuple_2).out + " " + reflection.type_name (string_integer_tuple))
			println
--			print (reflection.is_attached_type (reflection.dynamic_type (string_integer_tuple_2)))

			assert ("attached vs detachable", reflection.dynamic_type (string_integer_tuple) = reflection.dynamic_type (string_integer_tuple_2))

			create tuple
			print ("attached: "+(reflection.attached_type (reflection.dynamic_type (tuple))).out + ", detachable: " + (reflection.dynamic_type (tuple)).out)
			println
--			tuple.put (20, 3) -- fails, not enough space...


			-- check if dynamic type generation via strings works
			print (reflection.dynamic_type_from_string ("attached TUPLE [attached STRING, INTEGER]"))
			println
			assert ("dynamic type from string equal", reflection.dynamic_type_from_string ("attached TUPLE [attached STRING, INTEGER]") = reflection.attached_type (reflection.dynamic_type (string_integer_tuple_2)))

			-- unknown types..
			i := reflection.dynamic_type_from_string ("attached TUPLE [INTEGER, INTEGER, INTEGER, INTEGER, detachable CHAIN_HEAD]")
			print (i.out + " " + reflection.class_name_of_type (i)) -- apparently the eiffel runtime generates the type
			println

			-- Generation of known tuples
			special := reflection.new_special_any_instance (reflection.dynamic_type_from_string ("attached SPECIAL [detachable ANY]"), 2)
			special.extend ("test")
			special.extend (2)
			det_tuple := reflection.new_tuple_from_special (reflection.dynamic_type_from_string ("attached TUPLE [attached STRING, INTEGER]"), special)

			check attached det_tuple as t then
				tuple := t
			end
			print (tuple)
			println

			-- Generation of "unknown" tuples
			special := reflection.new_special_any_instance (reflection.dynamic_type_from_string ("attached SPECIAL [detachable ANY]"), 5)
			special.extend (1)
			special.extend (2)
			special.extend (3)
			special.extend (4)
			special.extend (Void)
			det_tuple := reflection.new_tuple_from_special (i, special)

			check attached det_tuple as t then
				tuple := t
			end
			print (tuple)
			println
		end

--	experiment_tuple_generation_metadata_factory
--		local
--			factory: PS_METADATA_FACTORY
--			type: PS_TYPE_METADATA
--			p:TEST_PERSON
--			id: INTEGER
--		do
--			create factory.make
--			create p.make ("a", "b", 0)
--			type := factory.create_metadata_from_object (p)

--			id := factory.generate_tuple_type (type.type, create {ARRAYED_LIST [STRING]}.make_from_array (<<"first_name", "items_owned">>))
--			print (id.out + " ")
--			print (type.reflection.type_name_of_type (id))
--			println

--			print (type.reflection.new_instance_of (id))

--		end

	experiment_converter
		local
			conv:PS_SQLSTATE_CONVERTER
		do
			create conv
			assert ("not correct", attached {PS_CONNECTION_SETUP_ERROR} conv.convert_error ("08xxx"))
		end

feature {NONE} -- Utilities

	println
		do
			print ("%N")
		end

end
