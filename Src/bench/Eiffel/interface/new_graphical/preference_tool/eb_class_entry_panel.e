indexing

	description:
		"Resource category for the class tool. Used only in the preference tool"
	revision: "$Revision$"

class
	EB_CLASS_ENTRY_PANEL

inherit
	EB_ENTRY_PANEL
		redefine
			make
		end
	EB_DEVELOPMENT_TOOL_DATA
		rename
			Class_resources as parameters
		export
			{NONE} all
		end
	NEW_EB_CONSTANTS

creation
	make 

feature {NONE} -- Initialization

	make (par: EV_CONTAINER; a_tool: like tool) is
		do
			Precursor (par, a_tool)

			create tool_width.make_with_resource (Current, parameters.tool_width)
			create tool_height.make_with_resource (Current, parameters.tool_height)
			create command_bar.make_with_resource (Current, parameters.command_bar)
			create format_bar.make_with_resource (Current, parameters.format_bar)
			create parse_class_after_saving.make_with_resource
				(Current, parameters.parse_class_after_saving)
			create feature_clause_order.make_with_resource
				(Current, parameters.feature_clause_order)

			resources.extend (tool_width)
			resources.extend (tool_height)
			resources.extend (command_bar)
			resources.extend (format_bar)
			resources.extend (parse_class_after_saving)
			resources.extend (feature_clause_order)
		end

feature -- Access

	name: STRING is "Class tool preferences"
			-- Current's name

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.bm_Class
		end

feature {NONE} -- Implementation

	tool_width, tool_height: EB_INTEGER_RESOURCE_DISPLAY
	command_bar, format_bar,
	parse_class_after_saving: EB_BOOLEAN_RESOURCE_DISPLAY
	feature_clause_order: EB_ARRAY_RESOURCE_DISPLAY



end -- class EB_CLASS_ENTRY_PANEL
