note
	description: "Summary description for {PS_TEST_NEW_WRITER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TEST_NEW_WRITER

inherit

	PS_REPOSITORY_TESTS

feature {NONE}

	make_repository: PS_REPOSITORY
			-- Create the repository for this test
		local
			factory: PS_IN_MEMORY_REPOSITORY_FACTORY
		do
			create factory.make
			Result := factory.new_repository
		end

feature

	memory_subtypes_quicktest
		local
			obj: TEST_PERSON
			query: PS_QUERY [ANY]
			tr: PS_TRANSACTION
		do
			create obj.make ("a", "b", 3)
			repository.wipe_out
			tr := repository.new_transaction
			tr.insert (obj)

			create query.make
			tr.execute_query (query)

			across
				query as c
			from
				assert ("not empty", not c.after)
			loop
				print (c.item)
				assert ("equal", c.item.is_deep_equal (obj))
			end
			query.close
			tr.commit
			repository.wipe_out

		end

	memory_criteria
		do
			criteria_tests.test_criteria_agents
			criteria_tests.test_criteria_predefined
			criteria_tests.test_criteria_agents_and_predefined
		end

	memory_crud_flat
		do
			crud_tests.all_flat_object_tests
		end

	memory_references
		do
			crud_tests.all_references_tests
		end

	memory_basic_types
		do
			crud_tests.all_basic_type_tests
		end

	memory_collections_easy
		do
			crud_tests.all_easy_collection_tests
		end

	memory_collections_tricky
		do
			crud_tests.all_tricky_collection_tests
		end

	memory_polymorphism
		do
			crud_tests.all_polymorphism_tests
		end

--	memory_transaction_lost
--		do
--			transaction_tests.test_no_lost_update
--		end

--	memory_transaction_dirty
--		do
--			transaction_tests.test_no_dirty_read
--		end

--	memory_transaction_repeatable_read
--		do
--			transaction_tests.test_repeatable_read
--		end

	memory_initialization_depth
		do
			object_graph_tests.test_all_settings
		end


	memory_tuple_queries
		do
			tuple_query_tests.test_simple_query
			tuple_query_tests.test_query_with_criteria
			tuple_query_tests.test_query_projection
			tuple_query_tests.test_query_criteria_not_in_projection
			tuple_query_tests.test_query_references
			tuple_query_tests.test_query_objects_in_projection
			tuple_query_tests.test_query_reference_cycle
		end


	memory_tricky_basic_types
			-- Test basic types such as INTEGER.
		do
			tricky_tests.test_basic_types
		end

	memory_tricky_string_types
			-- Test string types.
		do
			tricky_tests.test_string_types
		end


	memory_tricky_wrapped_basic_types
			-- Test basic types wrapped in CELL [ANY].
		do
			tricky_tests.test_wrapped_basic_types
		end

	memory_tricky_wrapped_string_types
			-- Test string types wrapped in CELL [ANY].
		do
			tricky_tests.test_wrapped_string_types
		end

	memory_tricky_object_graph_simple
			-- Test some simple object graphs.
		do
			tricky_tests.test_object_graph_simple
		end

	memory_tricky_object_graph_complex
			-- Test some complex object graphs containing copy-semantics references.
		do
			tricky_tests.test_object_graph_complex
		end

	memory_tricky_direct_special_basic
			-- Test storing special objects of a basic type.
		do
			tricky_tests.test_direct_special_basic
		end

	memory_tricky_direct_special_simple
			-- Test storing special objects with some normal references.
		do
			tricky_tests.test_direct_special_simple
		end

	memory_tricky_direct_special_complex
			-- Test storing special objects with copy-semantics references and expanded items.
		note
			test: "execution/isolated"
		do
			tricky_tests.test_direct_special_complex
		end


	memory_tricky_wrapped_special_basic
			-- Test storing wrapped special objects of a basic type.
		do
			tricky_tests.test_wrapped_special_basic
		end

	memory_tricky_wrapped_special_simple
			-- Test storing wrapped special objects with some normal references.
		do
			tricky_tests.test_wrapped_special_simple
		end

	memory_tricky_wrapped_special_complex
			-- Test storing wrapped special objects with copy-semantics references and expanded items.
		do
			tricky_tests.test_wrapped_special_complex
		end

	memory_tricky_direct_special_copysemantics
			-- Test storing special objects full of copy-semantics referenes
		do
			tricky_tests.test_direct_special_copysemantics
		end

end
