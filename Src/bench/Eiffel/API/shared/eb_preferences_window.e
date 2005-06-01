indexing
	description: "EiffelStudio preference window."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCES_WINDOW

inherit
	PREFERENCES_GRID_WINDOW
		rename
			preferences as view_preferences
		redefine
			make,
			hide,
			on_close,
			on_item_selected,
			add_resource_change_item,
			on_set_resource_default
		end

	EB_SHARED_PIXMAPS
		rename
			implementation as px_implementation
		undefine
			copy,
			default_create			
		end

	EB_SHARED_PREFERENCES
		undefine
			copy,
			default_create
		end

create
	make

feature -- Access

	make (a_preferences: like view_preferences; a_parent_window: like parent_window) is
			-- New window.  Redefined to register EiffelStudio specific resource widgets for
			-- special resource types.
		do			
			set_root_icon (icon_preference_root)
			set_folder_icon (icon_preference_folder)
			Precursor {PREFERENCES_GRID_WINDOW} (a_preferences, a_parent_window)
			set_icon_pixmap (icon_preference_window)
			register_resource_widget (create {IDENTIFIED_FONT_PREFERENCE_WIDGET}.make)
			close_request_actions.extend (agent on_close)
		end

	add_resource_change_item (l_resource: PREFERENCE; row_index: INTEGER) is
			-- Add the correct resource change widget item at `row_index' of `grid'
		local
			l_id_font: IDENTIFIED_FONT_PREFERENCE
			l_color_item: EV_GRID_DRAWABLE_ITEM
			l_font_item: EV_GRID_LABEL_ITEM
		do
			l_id_font ?= l_resource
			if l_id_font /= Void then
				create l_font_item
				l_font_item.set_text (l_id_font.string_value)
				l_font_item.set_font (l_id_font.value.font)
				grid.set_item (4, row_index, l_font_item)
				l_font_item.pointer_button_press_actions.force_extend (agent on_item_selected (l_font_item, l_resource))
			else
				Precursor {PREFERENCES_GRID_WINDOW} (l_resource, row_index)
			end
		end

	on_item_selected (a_item: EV_GRID_ITEM; a_pref: PREFERENCE) is
			-- (from PREFERENCES_GRID_WINDOW)
			-- (export status {NONE})
		local
			font_pref: IDENTIFIED_FONT_PREFERENCE
			l_font_widget: IDENTIFIED_FONT_PREFERENCE_WIDGET
			l_label_item: EV_GRID_LABEL_ITEM
		do
			font_pref ?= a_pref
			if font_pref /= Void then
				l_label_item ?= a_item
				l_font_widget ?= resource_widget (font_pref)
				l_font_widget.set_caller (Current)
				l_font_widget.change
				if l_font_widget.last_selected_value /= Void then
					font_pref.set_value (l_font_widget.last_selected_value)
				end
				l_label_item.set_font (font_pref.value.font)
				on_item_value_changed (a_item, a_pref)
			else
				Precursor {PREFERENCES_GRID_WINDOW} (a_item, a_pref)
			end
		end

	on_set_resource_default (a_item: EV_GRID_LABEL_ITEM; a_pref: PREFERENCE) is
			-- Set the resource value to the original default.
		local
			l_label_item: EV_GRID_LABEL_ITEM
			l_font: IDENTIFIED_FONT_PREFERENCE
		do
			l_font ?= a_pref
			if l_font /= Void then
				a_pref.reset
				a_item.set_text ("default")
				a_item.row.set_foreground_color (default_color)
				l_label_item ?= a_item.row.item (1)
				if l_label_item /= Void then
						-- Font label item
					l_label_item.set_font (l_font.value.font)
				end
			else
				Precursor {PREFERENCES_GRID_WINDOW} (a_item, a_pref)
			end
		end	

	on_close is
			-- Window was closed
		do
			preferences.misc_data.preference_window_height_preference.set_value (height)
			preferences.misc_data.preference_window_width_preference.set_value (width)
			Precursor
		end

	hide is
			-- Window was closed through cancel button
		do
			preferences.misc_data.preference_window_height_preference.set_value (height)
			preferences.misc_data.preference_window_width_preference.set_value (width)
			Precursor
		end

end -- class EB_PREFERENCES_WINDOW
