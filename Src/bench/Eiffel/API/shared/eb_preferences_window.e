indexing
	description: "EiffelStudio preference window."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCES_WINDOW

inherit
	PREFERENCES_TREE_WINDOW
		redefine
			make,
			on_list_double_clicked
		end

	EB_SHARED_PIXMAPS
		rename
			implementation as px_implementation
		undefine
			copy,
			default_create			
		end

create
	make

feature -- Access

	make (a_preferences: like preferences; a_parent_window: like parent_window) is
			-- New window.  Redefined to register EiffelStudio specific resource widgets for
			-- special resource types.
		do			
			set_root_icon (icon_preference_root)
			set_folder_icon (icon_preference_folder)
			Precursor {PREFERENCES_TREE_WINDOW} (a_preferences, a_parent_window)
			set_icon_pixmap (icon_preference_window)
			register_resource_widget (create {IDENTIFIED_FONT_PREFERENCE_WIDGET}.make)			
		end

	on_list_double_clicked is
			-- Preference was double clicked in list
		local
			sel_item: EV_MULTI_COLUMN_LIST_ROW
			font_pref: IDENTIFIED_FONT_PREFERENCE
			l_font_widget: IDENTIFIED_FONT_PREFERENCE_WIDGET
		do
			sel_item := right_list.selected_item
			if sel_item /= Void then
				font_pref ?= sel_item.data
				if font_pref /= Void then
					font_pref ?=sel_item.data
					if font_pref /= Void then
						l_font_widget ?= resource_widget (font_pref)
						l_font_widget.set_caller (Current)
						l_font_widget.change
					end
				else
					Precursor {PREFERENCES_TREE_WINDOW}
				end			
			end
		end		


end -- class EB_PREFERENCES_WINDOW
