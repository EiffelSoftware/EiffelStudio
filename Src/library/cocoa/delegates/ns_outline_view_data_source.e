note
	description: "Summary description for {NS_OUTLINE_VIEW_DATA_SOURCE}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NS_OUTLINE_VIEW_DATA_SOURCE [ITEM_TYPE]

feature {NONE}

--	make
--		do
--			item := outline_view_data_source_class.create_instance.item
--		end

	make
			-- Must be called for initialization
		do
			item := outline_view_data_source_new ($Current, $number_of_children_of_item, $is_item_expandable, $child_of_item, $object_value_for_table_column_by_item)
		end

feature -- Objective-C callbacks

	number_of_children_of_item (an_item: detachable ITEM_TYPE): INTEGER
		deferred
		end

	is_item_expandable (an_item: detachable ITEM_TYPE): BOOLEAN
		deferred
		end

	child_of_item (an_index: INTEGER; an_item: detachable ITEM_TYPE): ITEM_TYPE
		deferred
		end

	object_value_for_table_column_by_item (a_table_column: POINTER; an_item: ITEM_TYPE): POINTER
		deferred
		end

feature {NONE} -- Objective-C implementation

	frozen outline_view_data_source_new (an_object: POINTER; a_number_of_children_of_item, a_is_item_expandable, a_child_of_item, a_object_value_for_table_column_by_item: POINTER): POINTER
		external
			"C inline use %"ns_outline_view_data_source.h%""
		alias
			"return [[OutlineViewDataSource new] initWithCallbackObject: $an_object andMethod1: $a_number_of_children_of_item andMethod2: $a_is_item_expandable andMethod3: $a_child_of_item andMethod4: $a_object_value_for_table_column_by_item];"
		end

feature {NS_OUTLINE_VIEW}

	frozen outline_view_date_source_item_to_any (an_item: POINTER): ANY
		external
			"C inline use %"ns_outline_view_data_source.h%""
		alias
			"return [(DSItem*)$an_item eiffelObject];"
		end

feature {NS_OBJECT} -- Implementation

--	outline_view_data_source_class: OBJC_CLASS
--			-- An Objective-C class which has the selectors of the data source
--		do
--			create Result.make_with_name (generate_name)
--			Result.set_superclass (create {OBJC_CLASS}.make_with_name ("NSObject"))
--			Result.add_method ("outlineView:numberOfChildrenOfItem:", outline_view_number_of_children_of_item)
--			Result.add_method ("outlineView:isItemExpandable:", agent (a_ptr: POINTER) do window_did_move end)
--			Result.add_method ("outlineView:child:ofItem:", agent (a_ptr: POINTER) do window_did_move end)
--			Result.add_method ("outlineView:objectValueForTableColumn:byItem:", agent (a_ptr: POINTER) do window_did_move end)
--			Result.register
--		end

--	outline_view_number_of_children_of_item (a_outline_view: POINTER; a_item: POINTER)

--		do

--		end

--	counter: SPECIAL [INTEGER]
--		once
--			create Result.make_empty (1)
--			Result.extend (0)
--		end

--	generate_name: STRING
--		do
--			Result := "EiffelWrapperOutlineViewDataSource" + counter.item (0).out
--			counter.put (counter.item (0) + 1, 0)
--		end

	item: POINTER
	 	-- The C-pointer to the Cocoa object
end
