indexing

	description:
		"Resource vategory for the class tool.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_CATEGORY

inherit
	EDITOR_RESOURCE_CATEGORY

create
	make


feature {NONE} -- Initialization

	make is
			-- Initialize Current
		do
			create users.make;
			create modified_resources.make
		end

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			create tool_width.make ("class_tool_width", rt, 490);
			create tool_height.make ("class_tool_height", rt, 500);
			create command_bar.make ("class_tool_command_bar", rt, True);
			create format_bar.make ("class_tool_format_bar", rt, True);
			create parse_class_after_saving.make 
					("parse_class_after_saving", rt, True);

			create feature_clause_order.make ("feature_clause_order", rt,
						<< "Initialization", "Access", "Measurement",
						"Comparison", "Status report", "Status setting",
						"Cursor movement", "Element change", "Removal",
						"Resizing", "Transformation", "Conversion",
						"Duplication", "Miscellaneous",
						"Basic operations", "Obsolete", "Inapplicable",
						"Implementation", "*" >>)
			create excluded_indexing_items.make ("excluded_indexing_items", rt,
						<< "revision", "date", "status" >>)
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

feature -- Resources

	parse_class_after_saving: BOOLEAN_RESOURCE;
	feature_clause_order, excluded_indexing_items: ARRAY_RESOURCE

end -- class CLASS_CATEGORY
