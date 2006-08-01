indexing
	description: "[
					Gtk implementation to draw native looking notebook tabs.
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB_DRAWER_IMP

inherit
	SD_NOTEBOOK_TAB_DRAWER_I

create
	make

feature -- Command

	expose_unselected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO) is
			-- Draw unselected notebook tab.
		do
			internal_expose (a_width, False)
		end

	expose_selected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO) is
			-- Draw selected notebook tab.
		do
			internal_expose (a_width, True)
		end

	expose_hot (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO) is
			-- Draw hot notebook tab.
		do
			internal_expose (a_width, False)
		end

	draw_close_button (a_drawable: EV_DRAWABLE; a_close_pixmap: EV_PIXMAP) is
			-- Redefine
		do
			-- To be implemented.
		end

feature {NONE}  -- Implementation	

	internal_expose (a_width: INTEGER; a_is_selected: BOOLEAN) is
			-- Expose implementation
		local
			l_imp: SD_DRAWING_AREA_IMP
			l_temp_widget, l_style: POINTER
		do
			l_imp ?= internal_tab.parent.implementation
			check not_void: l_imp /= Void end

			l_temp_widget := {EV_GTK_EXTERNALS}.gtk_notebook_new
			l_style := {EV_GTK_EXTERNALS}.gtk_rc_get_style (l_temp_widget)

			c_gtk_paint_extension (l_imp.c_object, l_style, a_is_selected,
									 0, 0 ,a_width, internal_tab.height, is_top_side_tab)
			if a_is_selected then
				draw_pixmap_text_selected (internal_tab.parent, a_width)
			else
				draw_pixmap_text_unselected (internal_tab.parent, a_width)
			end
		end

	c_gtk_paint_extension (a_gtk_widget: POINTER; a_style: POINTER; a_selected: BOOLEAN;
									a_x, a_y, a_width, a_height: INTEGER;
									a_top: BOOLEAN) is
			-- Gtk Draw notebook tabs.
			-- See gdknotebook.c gtk_notebook_draw_tab
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				GtkWidget *l_widget;
				l_widget = GTK_WIDGET ($a_gtk_widget);
				
				GtkStateType l_state_type;
				GtkPositionType l_gap_side;
				GdkRectangle l_area = {$a_x, $a_y, $a_width, $a_height};
				
				if ($a_selected)
					l_state_type = GTK_STATE_NORMAL;
				else 
					l_state_type = GTK_STATE_ACTIVE;
				
				l_gap_side = 0;
				if ($a_top)
					l_gap_side = GTK_POS_BOTTOM;
				else
					l_gap_side = GTK_POS_TOP;
				
				gtk_paint_extension($a_style, l_widget->window,
					l_state_type, GTK_SHADOW_OUT,
					&l_area, l_widget, "tab",
					$a_x, $a_y, $a_width, $a_height,
					l_gap_side);				
			}
			]"
		end

end
