indexing
	description: "[
			A lable have pixmap and text.
			Used by SD_NOTEBOOK_TAB_AREA when show auto hide zones, and SD_ZONE_NAVIGATION_DIALOG.
																					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_CONTENT_LABEL

inherit
	EV_HORIZONTAL_BOX

create
	make

feature {NONE}  -- Initlization

	make (a_bold_label: BOOLEAN; a_focus_widget: EV_WIDGET) is
			-- Creation method.
		require
			a_focus_widget_not_void: a_focus_widget /= Void
		do
			default_create
			create internal_shared
			create enable_color_actions
			create internal_pixmap_area
			extend (internal_pixmap_area)
			internal_pixmap_area.pointer_enter_actions.extend (agent on_pointer_enter)
			internal_pixmap_area.pointer_button_press_actions.extend (agent on_pointer_press)
			internal_pixmap_area.pointer_button_release_actions.extend (agent on_pointer_release)
			disable_item_expand (internal_pixmap_area)
			create internal_label
			internal_label.set_background_color (internal_shared.tool_tip_color)
			internal_label.pointer_enter_actions.extend (agent on_pointer_enter)
			internal_label.pointer_button_press_actions.extend (agent on_pointer_press)
			internal_label.pointer_button_release_actions.extend (agent on_pointer_release)
			if a_bold_label then
				internal_label.font.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)
			else
				internal_label.font.set_weight ({EV_FONT_CONSTANTS}.Weight_regular)
			end
			internal_label.align_text_left

			extend (internal_label)

			internal_pixmap_area.expose_actions.extend (agent on_expose)
			set_minimum_height (internal_shared.title_bar_height + 2)
			internal_focus_widget := a_focus_widget
		ensure
			has: has (internal_pixmap_area) and has (internal_label)
			set: internal_focus_widget = a_focus_widget
		end

feature -- Command

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `pixmap'
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			internal_pixmap_area.set_minimum_size (a_pixmap.minimum_width, a_pixmap.minimum_height)
			pixmap := a_pixmap

		ensure
			set: pixmap = a_pixmap
		end

	set_text (a_text: STRING) is
			-- Set `a_text'
		require
			a_text_not_void: a_text /= Void
		do
			internal_label.set_text (a_text)
		ensure
			set: internal_label.text.is_equal (a_text)
		end

	enable_focus_color is
			-- Enable focus color.
		do
			internal_label.set_background_color (internal_shared.focused_color)
			set_text_color_internal (internal_shared.focused_color)
		ensure
			internal_label.background_color.is_equal (internal_shared.focused_color)
		end

	enable_non_focus_color is
			-- Enable non focus selection color.
		do
			internal_label.set_background_color (internal_shared.non_focused_color)
			set_text_color_internal (internal_shared.non_focused_color)
		ensure
			internal_label.background_color.is_equal (internal_shared.non_focused_color)
		end

	disable_focus_color is
			-- Disable focus color.
		do
			internal_label.set_background_color (internal_shared.tool_tip_color)
			set_text_color_internal (internal_shared.tool_tip_color)
		ensure
			internal_label.background_color.is_equal (internal_shared.tool_tip_color)
		end

feature -- Query

	pixmap: EV_PIXMAP
			-- Pixmap on current.

	text: STRING is
			-- Text on current.
		do
			Result := internal_label.text
		ensure
			not_void: Result /= Void
		end

	is_bold: BOOLEAN is
			-- If current show text with bold font?
		do
			Result := internal_label.font.weight = {EV_FONT_CONSTANTS}.Weight_bold
		end

	is_focus_color_enabled: BOOLEAN is
			-- If Current focus color enabled?
		do
			Result := internal_label.background_color.is_equal (internal_shared.focused_color)
		end

	is_non_focus_color_enabled: BOOLEAN is
			-- If Current non-focus color enabled?
		do
			Result := internal_label.background_color.is_equal (internal_shared.non_focused_color)
		end

	enable_color_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions when enable focus color or non-focus color.

feature -- Implementation

	on_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer press actions on `internal_pixmap_area' and `internal_label'.
		do
			pointer_button_press_actions.call ([a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
		end

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release actions on `internal_pixmap_area' and `internal_label'.
		do
			pointer_button_release_actions.call ([a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
		end

	on_pointer_enter is
			-- Handle pointer enter.
		do
			if internal_focus_widget.has_focus then
				enable_focus_color
			else
				enable_non_focus_color
			end
			enable_color_actions.call ([])
		end

	on_expose (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle expose actions of `internal_pixmap_area'.
		do
			internal_pixmap_area.clear
			internal_pixmap_area.draw_pixmap (internal_shared.drawing_area_icons_start_x, internal_shared.drawing_area_icons_start_y, pixmap)
		end

	set_text_color_internal (a_background_color: EV_COLOR) is
			-- Set `internal_label' color base on a_background_color.
		local
			l_color_helper: SD_COLOR_HELPER
		do
			create l_color_helper
			internal_label.set_foreground_color (l_color_helper.text_color_by (a_background_color))
		end

	internal_focus_widget: EV_WIDGET
			-- Widget which we care it whether it has focus.

	internal_label: EV_LABEL
			-- Label which hold `text'.

	internal_pixmap_area: EV_DRAWING_AREA
			-- Drawing area which draw `pixmap'.

	internal_shared: SD_SHARED
			-- All singletons.

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_pixmap_area_not_void: internal_pixmap_area /= Void
	internal_label_not_void: internal_label /= Void
	enable_color_actions_not_void: enable_color_actions /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
