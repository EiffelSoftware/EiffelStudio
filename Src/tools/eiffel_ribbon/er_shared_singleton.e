note
	description: "Summary description for {ER_SHARED_SINGLETON}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SHARED_SINGLETON

feature -- Query

	object_editor_cell: CELL [detachable ER_OBJECT_EDITOR]
			--
		once
			create Result.put (void)
		end

	layout_constructor_list: ARRAYED_LIST [ER_LAYOUT_CONSTRUCTOR]
			--
		once
			create Result.make (10)
		end

	project_info_cell: CELL [detachable ER_PROJECT_INFO]
			--
		once
			create Result.put (void)
		end

	tool_info_cell: CELL [detachable ER_TOOL_INFO]
			--
		once
			create Result.put (void)
		end

	size_definition_cell: CELL [detachable ER_SIZE_DEFINITION_EDITOR]
			--
		once
			create Result.put (void)
		end

	main_window_cell: CELL [detachable ER_MAIN_WINDOW]
			--
		once
			create Result.put (void)
		end

	xml_tree_manager: CELL [ER_XML_TREE_MANAGER]
			--
		local
			l_manger: ER_XML_TREE_MANAGER
		once
			create l_manger
			create Result.put (l_manger)
		end
end
