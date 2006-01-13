indexing
	description	: "Default widget for viewing and editing font preferences."
	date		: "$Date$"
	revision	: "$Revision$"

class
	FONT_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			preference, 
			set_preference,
			change_item_widget,
			update_changes
		end

create
	make,
	make_with_preference

feature -- Status Setting
	
	set_preference (new_preference: like preference) is
			-- Set the preference.
		do
			Precursor (new_preference)
		end

feature -- Access

	graphical_type: STRING is
			-- Graphical type identifier.
		do
			Result := "FONT"
		end	

	preference: FONT_PREFERENCE
			-- Actual preference.

	last_selected_value: EV_FONT
			-- Value last selected by user.

	change_item_widget: EV_GRID_LABEL_ITEM
			-- Font change label.
	
feature {PREFERENCE_VIEW} -- Commands

	change is
			-- Change the value.
		require
			preference_exists: preference /= Void
			in_view: caller /= Void
		do
				-- Create Font Tool.
			create font_tool
			font_tool.set_font (preference.value)

			font_tool.ok_actions.extend (agent update_changes)
			font_tool.cancel_actions.extend (agent cancel_changes)
			font_tool.show_modal_to_window (caller.parent_window)
		end 

feature {NONE} -- Commands

	update_changes is
			-- Commit the result of Font Tool.
		local
			l_font: EV_FONT
		do
			last_selected_value := font_tool.font
			l_font := last_selected_value.twin
			if last_selected_value /= Void then
				preference.set_value (last_selected_value)
				l_font := preference.value.twin
				l_font.set_height_in_points (default_font_height)
				change_item_widget.set_font (l_font)
				change_item_widget.set_text (preference.string_value)
			end
			Precursor {PREFERENCE_WIDGET}
		end

	cancel_changes is
			-- Commit the result of Font Tool.
		do
			last_selected_value := Void
		end

	update_preference is
			-- Update preference to reflect recently chosen value
		do
			if last_selected_value /= Void then
				preference.set_value (last_selected_value)	
			end
		end		

	show is
			-- Show the widget in its editable state
		do			
			show_change_item_widget
		end

feature {NONE} -- Implementation

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		local
			l_font: EV_FONT
		do
			create change_item_widget
			change_item_widget.set_text (preference.string_value)
			
			l_font := preference.value.twin
			l_font.set_height_in_points (default_font_height)
			change_item_widget.set_font (l_font)
			change_item_widget.pointer_double_press_actions.force_extend (agent show_change_item_widget)
		end
		
	show_change_item_widget is
			-- Show the font change dialog.
		do
			change			
		end		

	font_tool: EV_FONT_DIALOG
			-- Dialog from which we can select a font.

	default_font_height: INTEGER is 9
			-- Default font height in points (for display only)

end -- class FONT_PREFERENCE_WIDGET
