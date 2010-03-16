note
	description: "Carbon SD_TOOL_BAR_DRAWER implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DRAWER_IMP

inherit
	SD_TOOL_BAR_DRAWER_I

	EV_BUTTON_IMP
		rename
			make as make_not_use
		export
			{NONE} all
		end

create
	make

feature{NONE} -- Initlization

	make
			-- Creation method
		do
		end

feature -- Redefine

	start_draw (a_rectangle: EV_RECTANGLE)
			-- Redefine
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_item_rect, l_rect: EV_RECTANGLE
		do
			is_start_draw_called := True

			from
				l_items := tool_bar.items
				l_rect := a_rectangle.twin
				l_items.start
			until
				l_items.after
			loop
				l_item_rect := l_items.item.rectangle
				if l_item_rect.intersects (a_rectangle) then
					-- We find the maximum area we should clear.
					l_rect.merge (l_item_rect)
				end
				l_items.forth
			end
			if not tool_bar.is_destroyed then
				tool_bar.clear_rectangle (l_rect.left, l_rect.top, l_rect.width, l_rect.height)
			end
		end

	end_draw
			-- Redefine
		do
			is_start_draw_called := False
		end

	is_start_draw_called: BOOLEAN
			-- Redefine

	draw_item (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS)
			-- Redefine
		local
			l_tool_bar_imp: EV_DRAWING_AREA_IMP
			l_rect: EV_RECTANGLE
			l_button: SD_TOOL_BAR_BUTTON
		do
			if not tool_bar.is_destroyed then
				l_tool_bar_imp ?= a_arguments.tool_bar.implementation
				check not_void: l_tool_bar_imp /= Void end
				l_rect := a_arguments.item.rectangle
				l_button ?= a_arguments.item
				if l_button /= Void then
					-- Paint background
					if a_arguments.item.state /= {SD_TOOL_BAR_ITEM_STATE}.normal then
--						c_gtk_paint_box (button_style, l_tool_bar_imp.c_object, to_gtk_state (a_arguments.item.state), gtk_shadow_type (a_arguments.item.state), l_rect.x, l_rect.y, l_rect.width, l_rect.height, True)
					end

					-- Paint pixmap
					draw_pixmap (a_arguments, l_tool_bar_imp.c_object)

					-- Paint text
					draw_text (a_arguments, l_tool_bar_imp.c_object)
				else
					if a_arguments.item.is_wrap then
--						c_gtk_paint_line (l_tool_bar_imp.c_object, l_rect.left, l_rect.right, l_rect.top + a_arguments.item.width // 2, False)
					else
--						c_gtk_paint_line (l_tool_bar_imp.c_object, l_rect.top, l_rect.bottom, l_rect.left + a_arguments.item.width // 2, True)
					end
				end
			end
		end

	on_theme_changed
			-- Redefine
		do
		end

	desatuation (a_pixmap: EV_PIXMAP; a_k: REAL)
			-- Redefine
		do
		end

	set_tool_bar (a_tool_bar: SD_TOOL_BAR)
			-- Redefine
		do
			tool_bar := a_tool_bar
		end

feature {SD_NOTEBOOK_TAB_DRAWER_IMP} -- Command

	draw_button_background (a_gtk_widget: POINTER; a_rect: EV_RECTANGLE; a_state: INTEGER)
			-- Draw button background.
		require
			exist: a_gtk_widget /= default_pointer
			not_void: a_rect /= Void
			vaild: (create {SD_TOOL_BAR_ITEM_STATE}).is_valid (a_state)
		do
--			c_gtk_paint_box (button_style, a_gtk_widget, to_gtk_state (a_state), gtk_shadow_type (a_state), a_rect.x, a_rect.y, a_rect.width, a_rect.height, False)
		end

feature {NONE} -- Implementation

	button_style: POINTER
			-- Default theme style from resource.
		do
		end

	style_source: POINTER
			-- Button for query theme style.
		once
		end

	draw_pixmap (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS; a_gtk_object: POINTER)
			-- Draw pixmap on tool bar.
		require
			not_void: a_arguments /= Void
			exist: a_gtk_object /= default_pointer
		local
			l_button: SD_TOOL_BAR_BUTTON
			l_position: EV_COORDINATE
			l_temp_pixmap: EV_PIXMAP
			l_temp_imp: EV_PIXMAP_IMP
			l_pixbuf: POINTER
		do
			l_button ?= a_arguments.item
			if l_button /= Void and l_button.pixmap /= Void and l_button.tool_bar /= Void then
				-- We should render pixmap by theme.

				l_position := l_button.pixmap_position

				if a_arguments.item.is_sensitive then
					a_arguments.tool_bar.draw_pixmap (l_position.x, l_position.y, l_button.pixmap)
				else
					l_temp_pixmap := l_button.pixmap.sub_pixmap (create {EV_RECTANGLE}.make (0, 0, l_button.pixmap.width, l_button.pixmap.height))
					l_temp_imp ?= l_temp_pixmap.implementation
					a_arguments.tool_bar.draw_pixmap (l_position.x, l_position.y, l_temp_pixmap)
				end
			end
		end

	draw_text (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS; a_gtk_object: POINTER)
			-- Draw text on tool bar.
		require
			not_void: a_arguments /= Void
			exist: a_gtk_object /= default_pointer
		local
			l_pango_layout: POINTER
			l_env: EV_ENVIRONMENT
			l_app_imp: EV_APPLICATION_IMP
			l_button: SD_TOOL_BAR_BUTTON
			l_text_rect: EV_RECTANGLE
			l_state: INTEGER
			l_width_button: SD_TOOL_BAR_WIDTH_BUTTON
			l_font_button: SD_TOOL_BAR_FONT_BUTTON
			l_orignal_font: EV_FONT
			l_tool_bar: EV_DRAWING_AREA
		do
			l_button ?= a_arguments.item
			l_width_button ?= a_arguments.item
			l_font_button ?= a_arguments.item

			if l_font_button /= Void and then l_font_button.text /= Void and l_font_button.font /= Void and a_arguments.tool_bar /= Void then
				l_tool_bar := a_arguments.tool_bar
				l_orignal_font := l_tool_bar.font
				l_text_rect := l_font_button.text_rectangle
				l_tool_bar.set_font (l_font_button.font)
				l_tool_bar.draw_text_top_left (l_text_rect.x, l_text_rect.y, l_font_button.text)
				l_tool_bar.set_font (l_orignal_font)
			elseif l_width_button /= Void and then l_width_button.text /= Void and a_arguments.tool_bar /= Void then
				l_text_rect := l_width_button.text_rectangle
				a_arguments.tool_bar.draw_ellipsed_text_top_left (l_text_rect.x, l_text_rect.y, l_width_button.text, l_text_rect.width)
			elseif l_button /= Void and then l_button.tool_bar /= Void and then l_button.text /= Void then
				create l_env
				l_app_imp ?= l_env.application.implementation
				check not_void: l_app_imp /= Void end
--				l_c_string := l_app_imp.c_string_from_eiffel_string (l_button.text)
--				l_pango_layout := l_app_imp.pango_layout

--				{EV_GTK_EXTERNALS}.pango_layout_set_text (l_pango_layout, l_c_string.item, l_c_string.string_length)

--				l_text_rect := l_button.text_rectangle
--				if a_arguments.item.is_sensitive then
--					l_state := to_gtk_state (a_arguments.item.state)
--				else
--					l_state := {EV_GTK_EXTERNALS}.gtk_state_insensitive_enum
--				end
--				c_gtk_paint_layout (a_gtk_object, l_state, l_text_rect.left, l_text_rect.top, l_text_rect.width, l_text_rect.height, l_pango_layout)
			end

		end

	desaturation (a_pixmap: EV_PIXMAP; a_k: REAL)
			-- Do nothing on Linux.
		do
		end

	to_sepcial_state (a_state: INTEGER): INTEGER
			-- Convert SD_TOOL_BAR_ITEM_STATE to system specific state.
		do
		end


note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
