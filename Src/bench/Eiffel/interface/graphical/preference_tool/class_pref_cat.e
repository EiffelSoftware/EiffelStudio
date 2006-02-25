indexing

	description:
		"Resource category for the class tool."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create
	make

feature {NONE} -- Initialization

	update_resources is
			-- Update `resources'.
		do
			create tool_width.make (associated_category.tool_width);
			create tool_height.make (associated_category.tool_height);
			create command_bar.make (associated_category.command_bar);
			create format_bar.make (associated_category.format_bar);
			create parse_class_after_saving.make (associated_category.parse_class_after_saving)
			create private_feature_clause_order.make (associated_category.feature_clause_order);

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
			create att;
			att.set_composite_attributes (Current)
		end

feature {PREFERENCE_TOOL} -- Initialization

	init_visual_aspects (a_menu: MENU_PULL; a_button_parent, a_parent: COMPOSITE) is
			-- Initialize Currrent's visual aspects.
		local
			button: EB_PREFERENCE_BUTTON;
			menu_entry: PREFERENCE_TICKABLE_MENU_ENTRY
		do
			create button.make (Current, a_button_parent);
			create menu_entry.make (Current, a_menu);
			create holder.make (button, menu_entry);
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CLASS_PREF_CAT
