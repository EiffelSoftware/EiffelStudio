indexing
	description: "Used by SD_NOTEBOOK_TAB_AREA, to hold SD_NOTEBOOK_TAB_HIDE_LABELs."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_HIDE_TAB_DIALOG

inherit
	EV_POPUP_WINDOW
		rename
			extend as extend_dialog
		end
create
	make

feature {NONE}  -- Initlization
	make (a_note_book: SD_NOTEBOOK) is
			-- Creation method
		require
			a_note_book_not_void: a_note_book /= Void
		do
			default_create
			internal_notebook := a_note_book
			create internal_vertical_box
			create internal_tabs.make (1)
			extend_dialog (internal_vertical_box)

			pointer_motion_actions.extend (agent on_pointer_motion)
			pointer_button_press_actions.extend (agent on_pointer_button_press)

			enable_border
		ensure
			set: internal_notebook = a_note_book
		end

feature

	extend (a_tab: SD_NOTEBOOK_TAB) is
			--
		local
			l_tab_indicator: SD_NOTEBOOK_TAB_HIDE_LABEL
		do
			create l_tab_indicator.make
			l_tab_indicator.set_pixmap (a_tab.pixmap)
			l_tab_indicator.set_text (a_tab.text)
			internal_vertical_box.extend (l_tab_indicator)
			internal_tabs.extend (a_tab)
		end


feature {NONE} -- Implementation

	on_pointer_button_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--  Handle pointer button press
		do
			disable_capture
			from
				internal_vertical_box.start
			until
				internal_vertical_box.after
			loop
				if widget_has_x_y (internal_vertical_box.item, a_screen_x, a_screen_y) then
					internal_notebook.select_item (internal_notebook.content_by_tab (internal_tabs.i_th (internal_vertical_box.index)))
				end
				internal_vertical_box.forth
			end
			destroy
		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer motion
		local
			l_tab_label: SD_NOTEBOOK_TAB_HIDE_LABEL
		do
			from
				internal_vertical_box.start
			until
				internal_vertical_box.after
			loop
				l_tab_label ?= internal_vertical_box.item
				check only_has_tab_label: l_tab_label /= Void end
				if widget_has_x_y (internal_vertical_box.item, a_screen_x, a_screen_y) then
					l_tab_label.enable_focus_color
				else
					l_tab_label.disable_focus_color
				end
				internal_vertical_box.forth
			end
		end

	internal_vertical_box: EV_VERTICAL_BOX
			-- Vertical box hold SD_NOTEBOOK_TAB_HIDE_LABELs.

	internal_notebook: SD_NOTEBOOK
			-- Notebook which current is belong to.

	internal_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			-- All tabs.

	widget_has_x_y (a_widget: EV_WIDGET;  a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- If a_widget has a_screen_x, a_screen_y?
		require
			a_widget_not_void: a_widget /= Void
		do
			Result := a_widget.screen_x <= a_screen_x and a_widget.screen_y <= a_screen_y and
				a_widget.screen_x + a_widget.width >= a_screen_x and a_widget.screen_y + a_widget.height >= a_screen_y
		end

invariant
	internal_vertical_box_not_void:	internal_vertical_box /= Void
	internal_tabs_not_void: internal_tabs /= Void

end
