note
	description: "Cocoa SD_TOOL_BAR_DRAWER implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DRAWER_IMP

inherit
	SD_TOOL_BAR_DRAWER_I
		rename
			to_sepcial_state as to_cocoa_state
		end

	EV_ANY_HANDLER

create
	make

feature{NONE} -- Initlization

	make
			-- Creation method
		do
			-- Make user not break the invariant from EV_ANY_I
			--set_state_flag (base_make_called_flag, True)

			create internal_shared
			create l_button_cell.make
			l_button_cell.set_bezel_style ({NS_BUTTON_CELL}.shadowless_square_bezel_style)
		end

feature -- Redefine

	start_draw (a_rectangle: EV_RECTANGLE)
			-- <Precursor>
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_item_rect, l_rect: EV_RECTANGLE
			trans: NS_AFFINE_TRANSFORM
		do
			is_start_draw_called := True

			if not tool_bar.is_destroyed then
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
				internal_shared.setter.clear_background_for_theme (tool_bar, l_rect)

				tool_bar_imp.prepare_drawing
--				create trans.make
--				trans.translate_by_xy (0.0, tool_bar.height)
--				trans.scale_by_xy (1.0, -1.0)
--				trans.concat
			end
		end

	end_draw
			-- Redefine
		do
			tool_bar_imp.finish_drawing
			is_start_draw_called := False
		end

	is_start_draw_called: BOOLEAN
			-- Redefine

	draw_item (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS)
			-- Redefine
		local
			l_rect: EV_RECTANGLE
			l_pixmap: EV_PIXMAP
		do
			if not tool_bar.is_destroyed and then tool_bar.is_displayed then
				l_rect := a_arguments.item.rectangle
				if attached {SD_TOOL_BAR_BUTTON} a_arguments.item as l_button then
--					io.put_string ("Drawing Button item at (" + l_rect.x.out + ", " + l_rect.y.out + ") size (" + l_rect.width.out + "," + l_rect.height.out + ")%N")
					-- Paint button background
					if a_arguments.item.state = {SD_TOOL_BAR_ITEM_STATE}.pressed then
						l_button_cell.set_highlighted (True)
					else
						l_button_cell.set_highlighted (False)
					end
					l_button_cell.draw_bezel (create {NS_RECT}.make_rect (l_rect.x, l_rect.y, l_rect.width, l_rect.height), tool_bar_imp.cocoa_view)

					draw_pixmap (a_arguments)
					draw_text (a_arguments)
				elseif attached {SD_TOOL_BAR_SEPARATOR} a_arguments.item as l_separator then
					tool_bar_imp.set_foreground_color (create {EV_COLOR}.make_with_rgb (1.0, 1.0, 1.0))
					tool_bar_imp.fill_rectangle (l_rect.x, l_rect.y, l_rect.width, l_rect.height)
					if l_rect.width < l_rect.height then
						l_rect.move_and_resize (l_rect.x + l_rect.width // 2, l_rect.y + 1, 1, l_rect.height - 1)
					else
						l_rect.set_y (l_rect.y + l_rect.height // 2)
						l_rect.set_height (1)
					end
					tool_bar_imp.set_foreground_color (create {EV_COLOR}.make_with_rgb (0.5, 0.5, 0.5))
					tool_bar_imp.fill_rectangle (l_rect.x, l_rect.y, l_rect.width, l_rect.height)
				else
					io.put_string ("Drawing other item at (" + l_rect.x.out + ", " + l_rect.y.out + ") size (" + l_rect.width.out + "," + l_rect.height.out + ")%N")
					io.put_string ("  name:" + a_arguments.item.name + "%N")

					tool_bar_imp.set_foreground_color (create {EV_COLOR}.make_with_rgb (1.0, 1.0, 0.0))
					tool_bar_imp.fill_rectangle (l_rect.x, l_rect.y, l_rect.width, l_rect.height)
					if a_arguments.item.is_wrap then
					else

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

feature {NONE} -- Implementation

	l_button_cell: NS_BUTTON_CELL

	draw_pixmap (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS)
			-- Draw pixmap
		local
			l_coordinate: EV_COORDINATE
			l_image: NS_IMAGE
			l_pixmap_imp: EV_PIXMAP_IMP
		do
			if attached {SD_TOOL_BAR_BUTTON} a_arguments.item as l_button and then ((l_button.pixmap /= Void or l_button.pixel_buffer /= Void) and l_button.tool_bar /= Void) then
				l_coordinate := l_button.pixmap_position
				if attached l_button.pixmap then
					l_button.pixmap.stretch (20, 20)
					--a_arguments.tool_bar.draw_pixmap (l_coordinate.x, l_coordinate.y, l_button.pixmap)
					l_pixmap_imp ?= l_button.pixmap.implementation

					l_button_cell.draw_image (l_pixmap_imp.image, create {NS_RECT}.make_rect (l_coordinate.x, l_coordinate.y, 20, 20), tool_bar_imp.cocoa_view)
				end
			end
		end

	draw_text (a_arguments: SD_TOOL_BAR_DRAWER_ARGUMENTS)
			-- Draw text
		local
			l_text_vision_rect: EV_RECTANGLE
			l_string: NS_ATTRIBUTED_STRING
			l_rect: NS_RECT
		do
			if attached {SD_TOOL_BAR_BUTTON} a_arguments.item as l_button and then (l_button.text /= Void and l_button.tool_bar /= Void) then
				if attached {EV_DRAWING_AREA} a_arguments.tool_bar as da then
					l_text_vision_rect := l_button.text_rectangle
					--da.draw_text_top_left (l_text_vision_rect.x, l_text_vision_rect.y, l_button.text)

					create l_string.make_with_string (create {NS_STRING}.make_with_string(l_button.text))
					l_rect := l_button_cell.draw_title (l_string, create {NS_RECT}.make_rect (l_text_vision_rect.x, l_text_vision_rect.y, l_text_vision_rect.width, l_text_vision_rect.height), tool_bar_imp.cocoa_view)
				end
			end
		end

	tool_bar_imp: EV_DRAWING_AREA_IMP
		local
			l_tool_bar_imp: EV_DRAWING_AREA_IMP
		do
			l_tool_bar_imp ?= tool_bar.implementation
			check not_void: l_tool_bar_imp /= Void end
			Result := l_tool_bar_imp
		end


	to_cocoa_state (a_state: INTEGER): INTEGER
			-- Convert from SD_TOOL_BAR_ITEM_STATE to WEL_THEME_TS_CONSTANTS.
		do
		end

	internal_shared: SD_SHARED;
			-- Shared singleton

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
end
