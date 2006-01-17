indexing
	description	: "Default widget for viewing and editing font preferences."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	IDENTIFIED_FONT_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			preference,
			change_item_widget,
			update_changes
		end

	EV_SHARED_SCALE_FACTORY
		undefine
			default_create
		end

create
	make,
	make_with_preference

feature -- Access

	graphical_type: STRING is
			-- Graphical type identifier.
		do
			Result := "IDENTIFIED_FONT"
		end

	preference: IDENTIFIED_FONT_PREFERENCE
			-- Actual preference.

	last_selected_value: EV_IDENTIFIED_FONT

	change_item_widget: EV_GRID_LABEL_ITEM

feature -- Commands

	show is
			-- Show the widget in its editable state
		do
			show_change_item_widget
		end

feature {PREFERENCE_VIEW} -- Commands

	change is
			-- Change the value.
		require
			preference_exists: preference /= Void
			in_view: caller /= Void
		do
				-- Create Font Tool.
			create font_tool
			font_tool.set_font (preference.value.font)

			font_tool.ok_actions.extend (agent update_changes)
			font_tool.show_modal_to_window (caller.parent_window)
		end

feature {NONE} -- Commands

	update_changes is
			-- Commit the result of Font Tool.
		do
			last_selected_value := font_factory.registered_font (font_tool.font)
			if last_selected_value /= Void then
				preference.set_value (last_selected_value)
				change_item_widget.set_font (last_selected_value.font)
				change_item_widget.set_text (preference.string_value)
			end
			Precursor {PREFERENCE_WIDGET}
		end

	update_preference is
			--
		do
			if last_selected_value /= Void then
				preference.set_value (last_selected_value)
			end
		end

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do

			create change_item_widget
			change_item_widget.set_text (preference.string_value)
			change_item_widget.set_font (preference.value.font)
			change_item_widget.pointer_double_press_actions.force_extend (agent show_change_item_widget)
		end

	show_change_item_widget is
			--
		do
			change
			if last_selected_value /= Void then
				preference.set_value (last_selected_value)
			end
		end

	font_tool: EV_FONT_DIALOG;
			-- Dialog from which we can select a font.

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

end -- class IDENTIFIED_FONT_PREFERENCE_WIDGET
