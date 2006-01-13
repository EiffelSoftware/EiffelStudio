indexing
	description	: "Default widget for viewing and editing font preferences."
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

	font_tool: EV_FONT_DIALOG
			-- Dialog from which we can select a font.

end -- class IDENTIFIED_FONT_PREFERENCE_WIDGET
