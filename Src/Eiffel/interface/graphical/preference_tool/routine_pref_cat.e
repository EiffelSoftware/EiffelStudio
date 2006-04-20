indexing

	description:
		"Resource category for the feature tool."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_PREF_CAT

inherit
	EB_CONSTANTS
		rename
			Feature_resources as associated_category
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
			create keep_toolbar.make (associated_category.keep_toolbar)
			create double_line_toolbar.make (associated_category.double_line_toolbar)
			create private_show_all_callers.make (associated_category.show_all_callers);
			create do_flat_in_breakpoints.make (associated_category.do_flat_in_breakpoints);

			resources.extend (tool_width);
			resources.extend (tool_height);
			resources.extend (keep_toolbar);
			resources.extend (double_line_toolbar);
			resources.extend (private_show_all_callers);
			resources.extend (do_flat_in_breakpoints)
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

	name: STRING is "Feature tool preferences"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := Pixmaps.bm_Routine
		end;

feature {NONE} -- Resources

	tool_width, tool_height: INTEGER_PREF_RES;
	double_line_toolbar, keep_toolbar: BOOLEAN_PREF_RES;
	private_show_all_callers: BOOLEAN_PREF_RES;
	do_flat_in_breakpoints: BOOLEAN_PREF_RES;


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class ROUTINE_PREF_CAT
