indexing

	description:
		"Resource category for the class tool.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_PREF_CAT

inherit
	EB_CONSTANTS
		rename
			Class_resources as associated_category
		export
			{NONE} all
		end;
	PREFERENCE_CATEGORY
		redefine
			init_colors
		end

creation
	make

feature {NONE} -- Initialization

	update_resources is
			-- Update `resources'.
		do
			!! tool_width.make (associated_category.tool_width);
			!! tool_height.make (associated_category.tool_height);
			!! command_bar.make (associated_category.command_bar);
			!! format_bar.make (associated_category.format_bar);
			!! parse_class_after_saving.make (associated_category.parse_class_after_saving)
			!! private_feature_clause_order.make (associated_category.feature_clause_order);

			resources.extend (tool_width);
			resources.extend (tool_height);
			resources.extend (command_bar);
			resources.extend (format_bar);
			resources.extend (parse_class_after_saving);
			resources.extend (private_feature_clause_order)
		end;

	init_colors is
			-- Initialize the colors of the page.
		local
			att: WINDOW_ATTRIBUTES
		do
			!! att;
			att.set_composite_attributes (Current)
		end

feature {PREFERENCE_TOOL} -- Initialization

	init_visual_aspects (a_menu: MENU_PULL; a_button_parent, a_parent: COMPOSITE) is
			-- Initialize Currrent's visual aspects.
		local
			button: EB_PREFERENCE_BUTTON;
			menu_entry: PREFERENCE_TICKABLE_MENU_ENTRY
		do
			!! button.make (Current, a_button_parent);
			!! menu_entry.make (Current, a_menu);
			!! holder.make (button, menu_entry);
			make_row_column (name, a_parent)
		end

feature -- Properties

	name: STRING is "Class tool preferences"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := Pixmaps.bm_Class
		end;

feature {NONE} -- Resources

	tool_width, tool_height: INTEGER_PREF_RES;
	command_bar, format_bar: BOOLEAN_PREF_RES;
	parse_class_after_saving: BOOLEAN_PREF_RES;
	private_feature_clause_order: ARRAY_PREF_RES;

end -- class CLASS_PREF_CAT
