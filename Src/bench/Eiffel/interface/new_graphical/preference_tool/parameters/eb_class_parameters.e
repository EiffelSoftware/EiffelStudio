indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_PARAMETERS

inherit
	EB_PARAMETERS

creation
	make

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
		end

feature -- Access

	tool_width: EB_INTEGER_RESOURCE
	tool_height: EB_INTEGER_RESOURCE
	command_bar: EB_BOOLEAN_RESOURCE
	format_bar: EB_BOOLEAN_RESOURCE
	parse_class_after_saving: EB_BOOLEAN_RESOURCE
	feature_clause_order: EB_ARRAY_RESOURCE

end -- class EB_CLASS_PARAMETERS
