note
	description: "Provides tests for the CRUD (Create, Read, Update, Delete) operations"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_CRUD_TESTS

inherit

	PS_TEST_PROVIDER

create
	make

feature {PS_REPOSITORY_TESTS} -- References

	all_references_tests
			-- All tests that work on REFERENCE_CLASS_1
		do
			test_insert_void_reference
			test_insert_one_reference
			test_insert_reference_cycle
			test_crud_reference_cycle
			test_crud_update_on_reference
		end

	test_insert_void_reference
			-- Test inserting an object with a Void reference
		local
			test: PS_GENERIC_CRUD_TEST [REFERENCE_CLASS_1]
		do
			create test.make (repository)
			test.test_insert (test_data.void_reference)
			repository.clean_db_for_testing
		end

	test_insert_one_reference
			-- Test inserting an object that references another object
		local
			test: PS_GENERIC_CRUD_TEST [REFERENCE_CLASS_1]
		do
			create test.make (repository)
			test.test_insert (test_data.reference_to_single_other)
			assert ("The result does not have exactly two items", test.count_results = 2)
			repository.clean_db_for_testing
		end

	test_insert_reference_cycle
			-- Test inserting some objects that reference each other, forming a reference cycle
		local
			test: PS_GENERIC_CRUD_TEST [REFERENCE_CLASS_1]
		do
			create test.make (repository)
			test.test_insert (test_data.reference_cycle)
			assert ("The wrong number of items has been inserted", test.count_results = 3)
			repository.clean_db_for_testing
		end

	test_crud_reference_cycle
			-- Test the CRUD operations on objects with a reference cycle
		local
			test: PS_GENERIC_CRUD_TEST [REFERENCE_CLASS_1]
		do
			create test.make (repository)
			test.test_crud_operations (test_data.reference_cycle, agent {REFERENCE_CLASS_1}.update)
			repository.clean_db_for_testing
		end

	test_crud_update_on_reference
			-- Test an update operation on a referenced object
		local
			test: PS_GENERIC_CRUD_TEST [REFERENCE_CLASS_1]
		do
			create test.make (repository)
			test.test_crud_operations (test_data.reference_to_single_other, agent update_reference)
		end

feature {PS_REPOSITORY_TESTS} -- Flat objects

	all_flat_object_tests
			-- All tests that use FLAT_CLASS_1
		do
			test_empty_object
			test_flat_class_store
			test_flat_class_all_crud
		end

	test_empty_object
			-- Test if an object that contains no attributes (e.g. an instance of ANY), is stored as well
		local
			test: PS_GENERIC_CRUD_TEST [ANY]
			obj: ANY
		do
			create test.make (repository)
			create obj
			test.test_crud_operations (obj, agent test.default_update_operation(?))
				-- repository is clean after delete...
		end

	test_flat_class_store
			-- Test if a simple store-and-retrieve returns the same result
		local
			test: PS_GENERIC_CRUD_TEST [FLAT_CLASS_1]
		do
			create test.make (repository)
			test.test_insert_special_equality (test_data.flat_class, agent {FLAT_CLASS_1}.is_almost_equal(?, 0.00001))
			repository.clean_db_for_testing
		end

	test_flat_class_all_crud
			-- Test all CRUD operations on a flat class
		local
			test: PS_GENERIC_CRUD_TEST [FLAT_CLASS_1]
		do
			create test.make (repository)
			test.test_crud_operations_special_equality (test_data.flat_class, agent {FLAT_CLASS_1}.update, agent {FLAT_CLASS_1}.is_almost_equal(?, 0.00001))
			repository.clean_db_for_testing
		end

feature {PS_REPOSITORY_TESTS} -- Collections

	all_collection_tests
			-- All collection tests
		do
			test_referenced_collection_store
			test_referenced_collection_update_known_object
			test_referenced_collection_new_object
			test_direct_collection_store
			test_direct_collection_update_known_object
			test_direct_collection_new_object
			test_collection_basic_type_store
			test_shared_special
			test_data_structures_store
			test_update_on_reference
		end

	test_referenced_collection_store
			-- Test if a SPECIAL collection, that is referenced by an ARRAY object, gets stored correctly
		local
			test: PS_GENERIC_CRUD_TEST [ARRAY [PERSON]]
		do
			create test.make (repository)
			test.test_insert (test_data.array_of_persons)
			repository.clean_db_for_testing
		end

	test_referenced_collection_update_known_object
			-- Test if a reference change to a known object is correctly adjusted.
		local
			test: PS_GENERIC_CRUD_TEST [ARRAY [PERSON]]
		do
			create test.make (repository)
			test.test_crud_operations (test_data.array_of_persons, agent {ARRAY [PERSON]}.put(test_data.array_of_persons.item (1), 2))
			repository.clean_db_for_testing
		end

	test_referenced_collection_new_object
			-- Test if a newly inserted collection item gets correctly inserted
		local
			test: PS_GENERIC_CRUD_TEST [ARRAY [PERSON]]
			new: PERSON
		do
			create new.make ("some", "new_guy", 20)
			create test.make (repository)
			test.test_crud_operations (test_data.array_of_persons, agent {ARRAY [PERSON]}.force(new, 5))
			repository.clean_db_for_testing
		end

	test_direct_collection_store
			-- Test if a direct collection store is supported
		local
			test: PS_GENERIC_CRUD_TEST [SPECIAL [PERSON]]
		do
			create test.make (repository)
			test.test_insert (test_data.special_of_persons)
			repository.clean_db_for_testing
		end

	test_direct_collection_update_known_object
			-- Test if a reference change to a known object is correctly adjusted.
		local
			test: PS_GENERIC_CRUD_TEST [SPECIAL [PERSON]]
		do
			create test.make (repository)
			test.test_crud_operations (test_data.special_of_persons, agent {SPECIAL [PERSON]}.put(test_data.special_of_persons.item (0), 1))
			repository.clean_db_for_testing
		end

	test_direct_collection_new_object
			-- Test if a newly inserted collection item gets correctly inserted
		local
			test: PS_GENERIC_CRUD_TEST [SPECIAL [PERSON]]
			new: PERSON
		do
			create new.make ("some", "new_guy", 20)
			create test.make (repository)
			test.test_crud_operations (test_data.special_of_persons, agent {SPECIAL [PERSON]}.extend(new))
			repository.clean_db_for_testing
		end

	test_collection_basic_type_store
			-- Test if a collection can store basic types
		local
			test: PS_GENERIC_CRUD_TEST [ARRAY [INTEGER]]
		do
			create test.make (repository)
				--			print ("adsf")
				--			test.test_insert (test_data.array_of_integers)
			test.test_crud_operations (test_data.array_of_integers, agent {ARRAY [INTEGER]}.put(20, 10))
		end

	test_data_structures_store
			-- Test if a simple store-and-retrieve returns the same result
		local
			test: PS_GENERIC_CRUD_TEST [DATA_STRUCTURES_CLASS_1]
		do
			create test.make (repository)
			test.test_insert (test_data.data_structures_1)
				-- TODO: They are probably not equal, as DATA_STRUCTURES uses FLAT_CLASS, which uses REALs that have a rounding error.
			repository.clean_db_for_testing
		end

	test_update_on_reference
			-- test if an update on a referenced object works
		local
			query: PS_OBJECT_QUERY [DATA_STRUCTURES_CLASS_1]
			retrieved: DATA_STRUCTURES_CLASS_1
			testdata_copy: DATA_STRUCTURES_CLASS_1
		do
			repository.clean_db_for_testing
			create query.make
			executor.execute_insert (test_data.data_structures_1)
			executor.execute_query (query)
			assert ("The query doesn't return a result", not query.result_cursor.after)
			retrieved := query.result_cursor.item
			assert ("The results are not equal", retrieved.is_deep_equal (test_data.data_structures_1))
				-- perform update
			retrieved.array_1 [1].update
			executor.execute_update (retrieved.array_1 [1])
				-- check if update worked
			create query.make
			executor.execute_query (query)
			assert ("The query doesn't return a result", not query.result_cursor.after)
			retrieved := query.result_cursor.item
			assert ("The results are equal", not retrieved.is_deep_equal (test_data.data_structures_1))
				-- check that only the updated part really is different
			testdata_copy := test_data.data_structures_1.deep_twin
			testdata_copy.array_1 [1].update
			assert ("There was more than just one update", retrieved.is_deep_equal (testdata_copy))
			repository.clean_db_for_testing
		end

	test_shared_special
			-- test if an update on a shared special instance works
		local
			a,b: SHARED_SPECIAL
			special: SPECIAL[INTEGER]
			query: PS_OBJECT_QUERY[SHARED_SPECIAL]
			query2: PS_OBJECT_QUERY[SPECIAL[INTEGER]]
		do
			repository.clean_db_for_testing
			create special.make_filled (0, 2)
			create a.make(special)
			create b.make(special)

			executor.execute_insert (a)
			executor.execute_insert (b)

			special[0] := 1
			executor.execute_update (special)

			create query.make
			executor.execute_query (query)
			assert ("no result", not query.result_cursor.after)
			across query as c loop
				assert ("not void", attached c.item.special)
				assert ("equal", c.item.is_deep_equal (a) and c.item.is_deep_equal (b))
			end

--			create query2.make
--			executor.execute_query (query2)
--			assert ("returned_special", not query2.result_cursor.after and then query2.result_cursor.item.is_deep_equal (special))
--			query2.result_cursor.forth
--			assert ("too many special objects", query2.result_cursor.after)

		end


feature {PS_REPOSITORY_TESTS} -- Polymorphism

	all_polymorphism_tests
		do
			test_no_polymorphism
			test_basic_polymorphism
			test_expanded_object
			test_generic_object
			test_referenced_list
			test_subtype_of_string
		end

	test_no_polymorphism
			-- A normal test with ANY_BOX not involving polymorphism
		local
			link: ANY_BOX
			test: PS_GENERIC_CRUD_TEST[ANY_BOX]
		do
			create link.set_item (create {ANY}.default_create)
			create test.make (repository)
			test.test_insert (link)
			repository.clean_db_for_testing
		end


	test_basic_polymorphism
			-- A test with an ANY_BOX, and a PERSON attached at runtime
		local
			link: ANY_BOX
			test: PS_GENERIC_CRUD_TEST[ANY_BOX]
		do
			create link.set_item (test_data.people.first)
			create test.make (repository)
			test.test_insert (link) -- BUG: at the moment ANY_BOX.item is Void during retrieval
			repository.clean_db_for_testing
		end

	test_expanded_object
			-- A test with ANY_BOX and an INTEGER attached at runtime
		local
			link: ANY_BOX
			test: PS_GENERIC_CRUD_TEST[ANY_BOX]
		do
			create link.set_item (3)
			create test.make (repository)
			test.test_insert (link) -- BUG: at the moment ANY_BOX.item is Void during retrieval
			repository.clean_db_for_testing
		end

	test_generic_object
			-- Test a store with a generic object
		local
			list: LINKED_LIST[ANY]
			test: PS_GENERIC_CRUD_TEST[LINKED_LIST[ANY]]
		do
			create list.make
			list.fill (test_data.people)
			create test.make (repository)
			test.test_insert (list) -- BUG: the elements don't get loaded.
			repository.clean_db_for_testing
		end

	test_referenced_list
			-- Test when an attribute has declared type LINKED_LIST[ANY] but dynamic type LINKED_LIST[PERSON]
		local
			box: ANY_LIST_BOX
			list: LINKED_LIST[PERSON]
			test: PS_GENERIC_CRUD_TEST[ANY_LIST_BOX]
		do
			create list.make
			list.fill (test_data.people)
			create box.set_items (list)
			create test.make (repository)
			test.test_insert (box) -- BUG: the list within box gets initialized as LINKED_LIST[ANY], and the list is empty.
			repository.clean_db_for_testing
		end

	test_subtype_of_string
			-- Check if the correct runtime type gets generated
		local
			first, last: FILE_NAME
			person: PERSON
			test: PS_GENERIC_CRUD_TEST[PERSON]
		do
			create first.make_from_string ("some")
			create last.make_from_string ("string")
			create person.make (first, last, 0)
			create test.make (repository)

			test.test_insert (person) -- BUG: instead of creating FILE_NAME objects, a STRING object is created.
			test.test_crud_operations (person, agent (p:PERSON) do p.add_item end)
			repository.clean_db_for_testing
		end

feature {NONE} -- Update agents

	update_reference (obj: REFERENCE_CLASS_1)
			-- An update on a reference in `obj'
		local
			ref_obj: REFERENCE_CLASS_1
		do
			ref_obj := attach (obj.refer)
			ref_obj.update
			executor.execute_update (ref_obj)
		end

end
