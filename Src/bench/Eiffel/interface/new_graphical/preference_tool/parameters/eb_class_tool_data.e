indexing
	description: "All shared attributes specific to the class tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_TOOL_DATA

inherit
	SHARED_RESOURCES

feature -- Access

	class_tool_width: INTEGER is
		do
			Result := resources.get_integer ("class_tool_width", 490)
		end

	class_tool_height: INTEGER is
		do
			Result := resources.get_integer ("class_tool_height", 500)
		end

	class_tool_command_bar: BOOLEAN is
		do
			Result := resources.get_boolean ("class_tool_command_bar", True)
		end

	class_tool_format_bar: BOOLEAN is
		do
			Result := resources.get_boolean ("class_tool_format_bar", True)
		end

	parse_class_after_saving: BOOLEAN is
		do
			Result := resources.get_boolean ("parse_class_after_saving", True)
		end

--	feature_close_order is
--		do
--			Result := resources.get_list ("feature_clause_order",
--				<< "Initialization", "Access", "Measurement",
--				"Comparison", "Status report", "Status setting",
--				"Cursor movement", "Element change", "Removal",
--				"Resizing", "Transformation", "Conversion",
--				"Duplication", "Miscellaneous",
--				"Basic operations", "Obsolete", "Inapplicable",
--				"Implementation", "*" >>)
--		end

end -- class EB_CLASS_TOOL_DATA
