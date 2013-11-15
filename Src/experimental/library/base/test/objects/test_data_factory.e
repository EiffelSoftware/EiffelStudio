note
	description: "Factory class for generating a bunch of tricky objects, which can be used for testing."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_DATA_FACTORY

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			-- Initialization for `Current'
		do
			create special_factory
			create string_factory
			create object_graph_factory
		end

feature -- Access

	special_factory: SPECIAL_FACTORY
			-- A factory for SPECIAL objects.

	string_factory: STRING_FACTORY
			-- A factory for string objects.

	object_graph_factory: OBJECT_GRAPH_FACTORY
			-- A factory for general object graphs.

feature -- Test data

	complete_test_data: ARRAYED_LIST[ANY]
			-- A list of all objects from all factories.
		do
			create Result.make(200)
			Result.append (object_graph_factory.all_basic_types)
			Result.append (object_graph_factory.reference_type_graphs)
			Result.append (object_graph_factory.expanded_type_graphs)
			Result.append (string_factory.all_strings)
			Result.append (special_factory.all_special)
		end

	wrap_in_cell (list: ARRAYED_LIST [ANY]): ARRAYED_LIST [CELL [ANY]]
			-- Put each element in `list' into a `CELL [ANY]'.
			-- Useful for testing polymorphic attachment.
		local
			cell: CELL[ANY]
		do
			across
				list as item
			from
				create Result.make (list.count)
			loop
				create cell.put (item.item)
				Result.extend (cell)
			end
		end

end
