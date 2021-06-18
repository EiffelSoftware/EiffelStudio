note
	description: "Factory class for generating a bunch of tricky objects, which can be used for testing."
	author: "Roman Schmocker"
	revised_by: "Alexander Kogtenkov"
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
		obsolete
			"This feature calls that obsolete feature `file_name` to test the obsoleete class FILE_NAME. [2019-11-30]"
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
		do
			create Result.make (list.count)
			⟳ item: list ¦ Result.extend (create {CELL [ANY]}.put (item)) ⟲
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
