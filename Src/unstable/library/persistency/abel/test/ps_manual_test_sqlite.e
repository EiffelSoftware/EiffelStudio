note
	description: "Tests for the SQLite repository."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_MANUAL_TEST_SQLITE

inherit

	PS_REPOSITORY_TESTS
		redefine
			on_clean
		end

feature -- Tests

	sqlite_criteria
		do
			criteria_tests.test_criteria_agents
			criteria_tests.test_criteria_predefined
			criteria_tests.test_criteria_agents_and_predefined
		end

	sqlite_crud_flat
		do
			crud_tests.all_flat_object_tests
		end

	sqlite_references
		do
			crud_tests.all_references_tests
		end

	sqlite_tuple_queries
		do
			tuple_query_tests.test_simple_query
			tuple_query_tests.test_query_with_criteria
			tuple_query_tests.test_query_projection
			tuple_query_tests.test_query_criteria_not_in_projection
			tuple_query_tests.test_query_references
			tuple_query_tests.test_query_objects_in_projection
			tuple_query_tests.test_query_reference_cycle
		end

	sqlite_collections_easy
		do
			crud_tests.all_easy_collection_tests
		end

	sqlite_collections_tricky
		do
			crud_tests.all_tricky_collection_tests
		end

	sqlite_polymorphism
		do
			crud_tests.all_polymorphism_tests
		end

	sqlite_object_graph_settings
		do
			object_graph_tests.test_all_settings
		end

	sqlite_tricky_basic_types
			-- Test basic types such as INTEGER.
		do
			tricky_tests.test_basic_types
		end

	sqlite_tricky_string_types
			-- Test string types.
		do
			tricky_tests.test_string_types
		end


	sqlite_tricky_wrapped_basic_types
			-- Test basic types wrapped in CELL [ANY].
		do
			tricky_tests.test_wrapped_basic_types
		end

	sqlite_tricky_wrapped_string_types
			-- Test string types wrapped in CELL [ANY].
		do
			tricky_tests.test_wrapped_string_types
		end

	sqlite_tricky_object_graph_simple
			-- Test some simple object graphs.
		do
			tricky_tests.test_object_graph_simple
		end

	sqlite_tricky_object_graph_complex
			-- Test some complex object graphs containing copy-semantics references.
		do
			tricky_tests.test_object_graph_complex
		end

	sqlite_tricky_direct_special_basic
			-- Test storing special objects of a basic type.
		do
			tricky_tests.test_direct_special_basic
		end

	sqlite_tricky_direct_special_simple
			-- Test storing special objects with some normal references.
		do
			tricky_tests.test_direct_special_simple
		end

	sqlite_tricky_direct_special_complex
			-- Test storing special objects with copy-semantics references and expanded items.
		do
			tricky_tests.test_direct_special_complex
		end


	sqlite_tricky_wrapped_special_basic
			-- Test storing wrapped special objects of a basic type.
		do
			tricky_tests.test_wrapped_special_basic
		end

	sqlite_tricky_wrapped_special_simple
			-- Test storing wrapped special objects with some normal references.
		do
			tricky_tests.test_wrapped_special_simple
		end

	sqlite_tricky_wrapped_special_complex
			-- Test storing wrapped special objects with copy-semantics references and expanded items.
		do
			tricky_tests.test_wrapped_special_complex
		end


	sqlite_tricky_direct_special_copysemantics
			-- Test storing special objects full of copy-semantics referenes
		do
			tricky_tests.test_direct_special_copysemantics
		end

feature {NONE} -- Initialization

	make_repository: PS_REPOSITORY
			-- Create the repository for this test
		local
			factory: PS_SQLITE_REPOSITORY_FACTORY
		do
			create factory.make
			factory.set_database (sqlite_file)
			Result := factory.new_repository
		end

	on_clean
			-- Called before `clean' performs any cleaning up.
		do
			repository.close
		end

	sqlite_file: STRING = "abel_sqlite_test.db"
			-- The SQLite database file
end
