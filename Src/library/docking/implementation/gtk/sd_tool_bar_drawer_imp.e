indexing
	description: "GTK SD_TOOL_BAR_DRAWER implementation."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DRAWER_IMP

inherit
	SD_TOOL_BAR_DRAWER_I
		rename
			to_sepcial_state as to_gtk_state
		end

	EV_BUTTON_IMP
		rename
			make as make_not_use
		export
			{NONE} all
		end

create
	make

feature{NONE} -- Initlization

	make (a_tool_bar: SD_TOOL_BAR) is
			-- Creation method
		require
			not_void: a_tool_bar /= Void
		do
			tool_bar := a_tool_bar
		ensure
			set: tool_bar = a_tool_bar
		end

feature -- Redefine

	start_draw (a_rectangle: EV_RECTANGLE) is
			-- Redefine
		do
			is_start_draw_called := True
			tool_bar.clear_rectangle (a_rectangle.left, a_rectangle.top, a_rectangle.width, a_rectangle.height)
		end

	end_draw is
			-- Redefine
		do
			is_start_draw_called := False
		end

	is_start_draw_called: BOOLEAN
			-- Redefine

	draw_item (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS) is
			-- Redefine
		local
			l_tool_bar_imp: EV_DRAWING_AREA_IMP
			l_rect: EV_RECTANGLE
			l_button: SD_TOOL_BAR_BUTTON
			l_temp_widget, l_style: POINTER
			l_c_string: EV_GTK_C_STRING
		do
			l_tool_bar_imp ?= a_arguments.tool_bar.implementation
			check not_void: l_tool_bar_imp /= Void end
			l_rect := a_arguments.item.rectangle
			l_button ?= a_arguments.item
			if l_button /= Void then

				-- Paint background
				l_temp_widget := {EV_GTK_EXTERNALS}.gtk_button_new
				l_style := {EV_GTK_EXTERNALS}.gtk_rc_get_style (l_temp_widget)

				if a_arguments.item.state /= {SD_TOOL_BAR_ITEM_STATE}.normal then
					c_gtk_paint_box (l_style, l_tool_bar_imp.c_object, to_gtk_state (a_arguments.item.state), gtk_shadow_type (a_arguments.item.state), l_rect.x, l_rect.y, l_rect.width, l_rect.height)
				end

				-- Paint pixmap
				draw_pixmap (a_arguments, l_tool_bar_imp.c_object)
				-- Paint text
				draw_text (a_arguments, l_tool_bar_imp.c_object)
			else
				if a_arguments.item.is_wrap then
					c_gtk_paint_line (l_tool_bar_imp.c_object, l_rect.left, l_rect.right, l_rect.top + a_arguments.item.width // 2, False)
				else
					c_gtk_paint_line (l_tool_bar_imp.c_object, l_rect.top, l_rect.bottom, l_rect.left + a_arguments.item.width // 2, True)
				end
			end
		end

	on_theme_changed is
			-- Redefine
		local
		do
			-- FIXIT: how to receive theme change actions?
		end

feature {NONE} -- Implementation

	gtk_shadow_type (a_state: INTEGER): INTEGER is
			-- Get correspond shadow type base on `a_state'
		do
			inspect
				a_state
			when {SD_TOOL_BAR_ITEM_STATE}.checked then
				Result := {EV_GTK_EXTERNALS}.gtk_shadow_etched_in_enum
			when {SD_TOOL_BAR_ITEM_STATE}.disabled then
				Result := {EV_GTK_EXTERNALS}.gtk_shadow_none_enum
			when {SD_TOOL_BAR_ITEM_STATE}.hot then
				Result := {EV_GTK_EXTERNALS}.gtk_shadow_out_enum
			when {SD_TOOL_BAR_ITEM_STATE}.hot_checked then
				Result := {EV_GTK_EXTERNALS}.gtk_shadow_out_enum
			when {SD_TOOL_BAR_ITEM_STATE}.normal then
				Result := {EV_GTK_EXTERNALS}.gtk_shadow_none_enum
			when {SD_TOOL_BAR_ITEM_STATE}.pressed then
				Result := {EV_GTK_EXTERNALS}.gtk_shadow_in_enum
			end
		end

	to_gtk_state (a_state: INTEGER): INTEGER is
			-- Convert from SD_TOOL_BAR_ITEM_STATE to WEL_THEME_TS_CONSTANTS.
		do
			inspect
				a_state
			when {SD_TOOL_BAR_ITEM_STATE}.checked then
				Result := {EV_GTK_EXTERNALS}.gtk_state_active_enum
			when {SD_TOOL_BAR_ITEM_STATE}.disabled then
				Result := {EV_GTK_EXTERNALS}.gtk_state_insensitive_enum
			when {SD_TOOL_BAR_ITEM_STATE}.hot then
				Result := {EV_GTK_EXTERNALS}.gtk_state_prelight_enum
			when {SD_TOOL_BAR_ITEM_STATE}.hot_checked then
				Result := {EV_GTK_EXTERNALS}.gtk_state_prelight_enum
			when {SD_TOOL_BAR_ITEM_STATE}.normal then
				Result := {EV_GTK_EXTERNALS}.gtk_state_normal_enum
			when {SD_TOOL_BAR_ITEM_STATE}.pressed then
				Result := {EV_GTK_EXTERNALS}.gtk_state_active_enum
			end
		end

	draw_pixmap (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS; a_gtk_object: POINTER) is
			-- Draw pixmap on tool bar.
		require
			not_void: a_arguments /= Void
			exist: a_gtk_object /= default_pointer
		local
			l_button: SD_TOOL_BAR_BUTTON
			l_position: EV_COORDINATE
		do
			l_button ?= a_arguments.item
			if l_button /= Void and l_button.pixmap /= Void then
				-- We should render pixmap by theme.

				l_position := l_button.pixmap_position
				a_arguments.tool_bar.draw_pixmap (l_position.x, l_position.y, l_button.pixmap)
			end
		end

	draw_text (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS; a_gtk_object: POINTER) is
			-- Draw text on tool bar.
		require
			not_void: a_arguments /= Void
			exist: a_gtk_object /= default_pointer
		local
			l_c_string: EV_GTK_C_STRING
			l_pango_layout: POINTER
			l_env: EV_ENVIRONMENT
			l_app_imp: EV_APPLICATION_IMP
			l_button: SD_TOOL_BAR_BUTTON
			l_text_rect: EV_RECTANGLE
		do
			l_button ?= a_arguments.item
			if l_button /= Void and then l_button.text /= Void then
				create l_env
				l_app_imp ?= l_env.application.implementation
				check not_void: l_app_imp /= Void end
				l_c_string := l_app_imp.c_string_from_eiffel_string (l_button.text)
				l_pango_layout := l_app_imp.pango_layout

				{EV_GTK_EXTERNALS}.pango_layout_set_text (l_pango_layout, l_c_string.item, l_c_string.string_length)

				l_text_rect := l_button.text_rectangle
				c_gtk_paint_layout (a_gtk_object, to_gtk_state (a_arguments.item.state), l_text_rect.left, l_text_rect.top, l_text_rect.width, l_text_rect.height, l_pango_layout)
			end

		end

	tool_bar: SD_TOOL_BAR
			-- Tool bar which to draw.
feature {NONE} -- Externals

	c_gtk_paint_line (a_gtk_widget: POINTER; a_start, a_end, a_position: INTEGER; a_vertical: BOOLEAN) is
			-- Draw vertical separator line.
		require
			exist: a_gtk_widget /= default_pointer
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				GtkWidget* l_widget;
				l_widget = GTK_WIDGET ($a_gtk_widget);
				if ($a_vertical)
					gtk_paint_vline (l_widget->style, l_widget->window, GTK_STATE_NORMAL, NULL, l_widget, "toolbar", $a_start, $a_end, $a_position);
				else
					gtk_paint_hline (l_widget->style, l_widget->window, GTK_STATE_NORMAL, NULL, l_widget, "toolbar", $a_start, $a_end, $a_position);
			}
			]"
		end


	c_gtk_paint_box (a_style: POINTER; a_gtk_widget: POINTER; a_gtk_state_type: INTEGER; a_gtk_shadow_type: INTEGER; a_x, a_y, a_width, a_height: INTEGER) is
			-- Paint background.
		require
			exist: a_gtk_widget /= default_pointer
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				GtkWidget* l_widget;
				l_widget = GTK_WIDGET ($a_gtk_widget);

				gtk_paint_box ($a_style, l_widget->window,
					$a_gtk_state_type, $a_gtk_shadow_type,
					NULL, l_widget, "toolbar",
					$a_x, $a_y, $a_width, $a_height);
			}
			]"
		end

	c_gtk_paint_layout (a_gtk_widget: POINTER; a_gtk_state_type: INTEGER; a_rect_x, a_rect_y, a_rect_width, a_rect_height: INTEGER; a_pango_layout: POINTER) is
			-- Paint texts.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				GtkWidget* l_widget;
				l_widget = GTK_WIDGET ($a_gtk_widget);

				GdkRectangle l_rect = {$a_rect_x, $a_rect_y, $a_rect_width, $a_rect_height};
				PangoLayout* l_pango_layout = (PangoLayout*) $a_pango_layout;

				gtk_paint_layout (l_widget->style, l_widget->window,
					GTK_STATE_NORMAL, FALSE, &l_rect, l_widget, "label",
					$a_rect_x, $a_rect_y, l_pango_layout);
			}
			]"
		end

end
