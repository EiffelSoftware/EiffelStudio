indexing

	description:
		"Resource category for the profile tool.";
	date: "$Date$";
	revision: "$Revision$"

class PROFILE_PREF_CAT

inherit
	EB_CONSTANTS
		rename
			Profiler_resources as associated_category
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
			!! query_tool_width.make (associated_category.query_tool_width);
			!! query_tool_height.make (associated_category.query_tool_height);

			resources.extend (tool_width);
			resources.extend (query_tool_width);
			resources.extend (query_tool_height);
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

	name: STRING is "Profile tool preferences"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := Pixmaps.bm_Profiler
		end;

feature {NONE} -- Resources

	tool_width, query_tool_height, query_tool_width: INTEGER_PREF_RES;

end -- class PROFILE_PREF_CAT
