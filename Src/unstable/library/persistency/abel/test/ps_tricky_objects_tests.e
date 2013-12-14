note
	description: "Summary description for {PS_TRICKY_OBJECTS_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_TRICKY_OBJECTS_TESTS

inherit
	PS_TEST_PROVIDER
		redefine
			initialize
		end

create
	make

feature {NONE} -- Initialization

	initialize
			-- Initialize every other field
		do
			create factory
		end

	factory: TEST_DATA_FACTORY
			-- The test data source.


feature {PS_REPOSITORY_TESTS} -- Basic types


	test_basic_types
			-- Test basic types such as INTEGER.
		local
			objects: ARRAYED_LIST [ANY]
		do
			objects := factory.object_graph_factory.all_basic_types
			objects.do_all (agent test_read_write_cycle_with_root (?, Void))
		end

	test_string_types
			-- Test string types.
		local
			objects: ARRAYED_LIST [ANY]
		do
			objects := factory.string_factory.all_strings
			objects.do_all (agent test_read_write_cycle_with_root (?, Void))
		end

feature {PS_REPOSITORY_TESTS} -- References

	test_wrapped_basic_types
			-- Test basic types wrapped in CELL [ANY].
		local
			objects: ARRAYED_LIST [ANY]
		do
			objects := factory.wrap_in_cell (factory.object_graph_factory.all_basic_types)
			objects.do_all (agent test_read_write_cycle_with_root (?, Void))
		end

	test_wrapped_string_types
			-- Test string types wrapped in CELL [ANY].
		local
			objects: ARRAYED_LIST [ANY]
		do
			objects := factory.wrap_in_cell (factory.string_factory.all_strings)
			objects.do_all (agent test_read_write_cycle_with_root (?, Void))
		end

	test_object_graph_simple
			-- Test some simple object graphs.
		local
			objects: ARRAYED_LIST [ANY]
		do
			objects := factory.object_graph_factory.reference_type_graphs
			objects.do_all (agent test_read_write_cycle_with_root (?, Void))
		end

	test_object_graph_complex
			-- Test some complex object graphs containing copy-semantics references.
		local
			objects: ARRAYED_LIST [ANY]
		do
			objects := factory.object_graph_factory.expanded_type_graphs
			objects.do_all (agent test_read_write_cycle_with_root (?, Void))
		end


feature {PS_REPOSITORY_TESTS} -- SPECIAL

	test_direct_special_basic
			-- Test storing special objects of a basic type.
		local
			objects: ARRAYED_LIST [ANY]
		do
			objects := factory.special_factory.all_basic_special
			objects.do_all (agent test_read_write_cycle_with_root (?, Void))
		end

	test_direct_special_simple
			-- Test storing special objects with some normal references.
		local
			objects: ARRAYED_LIST [ANY]
		do
			objects := factory.special_factory.all_reference_special
			objects.do_all (agent test_read_write_cycle_with_root (?, Void))
		end

	test_direct_special_complex
			-- Test storing special objects with copy-semantics references and expanded items.
		local
			objects: ARRAYED_LIST [ANY]
		do
			objects := factory.special_factory.all_copysemantics_special
			objects.do_all (agent test_read_write_cycle_with_root (?, Void))
		end

	test_direct_special_copysemantics
			-- Test storing special objects full of copy-semantics referenes
		local
			objects: ARRAYED_LIST [ANY]
		do
			create objects.make (2)
			objects.extend (factory.special_factory.special_any_with_integer)
			objects.extend (factory.special_factory.special_any_with_expanded)
			objects.do_all (agent test_read_write_cycle_with_root (?, Void))
		end

	test_wrapped_special_basic
			-- Test storing wrapped special objects of a basic type.
		local
			objects: ARRAYED_LIST [ANY]
		do
			objects := factory.wrap_in_cell (factory.special_factory.all_basic_special)
			objects.do_all (agent test_read_write_cycle_with_root (?, Void))
		end

	test_wrapped_special_simple
			-- Test storing wrapped special objects with some normal references.
		local
			objects: ARRAYED_LIST [ANY]
		do
			objects := factory.wrap_in_cell (factory.special_factory.all_reference_special)
			objects.do_all (agent test_read_write_cycle_with_root (?, Void))
		end

	test_wrapped_special_complex
			-- Test storing wrapped special objects with copy-semantics references and expanded items.
		local
			objects: ARRAYED_LIST [ANY]
		do
			objects := factory.wrap_in_cell (factory.special_factory.all_copysemantics_special)
			objects.do_all (agent test_read_write_cycle_with_root (?, Void))
		end
end
