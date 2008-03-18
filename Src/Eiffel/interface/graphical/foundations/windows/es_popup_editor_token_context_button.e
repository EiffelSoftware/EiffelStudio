indexing
	description: "[
		An editor based popup window, using an editor token to render a button used to present a popup widget or process an action.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_POPUP_EDITOR_TOKEN_CONTEXT_BUTTON

inherit
	ES_POPUP_BUTTON_WINDOW
		rename
			make as make_popup_button_window
		redefine
			set_popup_widget,
			set_popup_widget_fetch_action,
			window_on_screen_position,
			on_popup_widget_show_requested,
			on_popup_widget_hidden,

			active_border_color,
			border_color
		end

create
	make,
	make_with_widget

feature {NONE} -- Initialization

	frozen make (a_editor: like editor; a_token: like editor_token)
			-- Initialize a editor token context button.
			--
			-- `a_editor': The editor where the popup editor token context button is to be display.
			-- `a_token': The token used to render the context button.
		require
			a_token_is_applicable_editor_token: is_applicable_editor_token (a_token)
		do
			editor := a_editor
			editor_token := a_token
			make_popup_button_window (False)
		ensure
			editor_set: editor = a_editor
			editor_token_set: editor_token = a_token
		end

	frozen make_with_widget (a_editor: like editor; a_token: like editor_token; a_popup_widget: !EV_WIDGET)
			-- Initialize a editor token context button using a popup widget structure, to be shown when the drop down arrow is
			-- selected.
			--
			-- `a_editor': The editor where the popup editor token context button is to be display.
			-- `a_token': The token used to render the context button.
			-- `a_popup_widget': The widget structure to display when the user selects the drop down arrow.
		require
			a_token_is_applicable_editor_token: is_applicable_editor_token (a_token)
		do
			set_popup_widget (a_popup_widget)
			make (a_editor, a_token)
		ensure
			popup_widget_set: popup_widget = a_popup_widget
			editor_set: editor = a_editor
			editor_token_set: editor_token = a_token
		end

	build_popup_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the popup window's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended.
		local
			l_box: EV_HORIZONTAL_BOX
		do
			widget_container := a_container

			create l_box

				-- Token image		
			create token_image
			redraw_token_image

			l_box.extend (token_image)
			l_box.disable_item_expand (token_image)

				-- Padding
			l_box.extend (create {EV_CELL})

			a_container.extend (l_box)
			a_container.disable_item_expand (l_box)

				-- Propagate background color to set widget structure.
			propagate_colors (a_container, Void, background_color, Void)
		ensure then
			widget_container_set: widget_container = a_container
		end

	bind_select_actions (a_action: PROCEDURE [ANY, TUPLE])
			-- Binds the selection actions the the window's widgets to ensure the pop up widget is display
			-- Note: `propagate_action' can be used to bind the actions to a widget structure, if the struture is deep and all widgets need to process
			--       the show action.
			--
			-- `a_action': The action to beind to any widget select actions of any widgets placed on the popup window.
		do
			register_action (token_image.pointer_button_press_actions, agent on_pointer_pressed_in_token_image)
		end

feature -- Access

	editor: !EB_EDITOR
			-- The source editor where the context button will be displayed.
			-- In addition, the editor is needed to propagate events to when the user tries to modify the token
			-- shown.

	editor_token: !EDITOR_TOKEN
			-- The template token to display as the context button

feature {ES_EDITOR_TOKEN_HANDLER} -- Access

	token_x_offset: INTEGER
			-- X offset position from drawn token to window left edge

	token_y_offset: INTEGER
			-- Y offset position from drawn token to window top edge

feature {NONE} -- Access

	background_color: EV_COLOR
			-- Pop up window background color, as well as the token background color
		once
			--Result := colors.tooltip_color
			create Result.make_with_8_bit_rgb (255, 255, 255)
		ensure
			result_attached: Result /= Void
		end

	border_color: EV_COLOR
			-- <Precursor>
		once
			create Result.make_with_8_bit_rgb (58, 123, 252)
		end

	active_border_color: EV_COLOR
			-- <Precursor>
		once
			create Result.make_with_8_bit_rgb (58, 123, 252)
		end

feature -- Element change

	set_popup_widget (a_widget: like popup_widget)
			-- Assign popup widget to be displayed when the popup button is select
			-- Note: Already displayed widgets will have the UI replaced and reshown.
			--
			-- `a_widget': The widget to display in the popup window, when the popup up widget is requested to be shown.
			--             Use Void to remove the widget.
		do
			Precursor {ES_POPUP_BUTTON_WINDOW} (a_widget)
			if is_initialized then
				redraw_token_image
			end
		end

	set_popup_widget_fetch_action (a_action: like popup_widget_fetch_action)
			-- Assign popup widget to be displayed when the popup button is select.
			--
			-- `a_action': An action used to fetch a popup widget strucutre, shown when `popup_widget' is called.
		do
			Precursor {ES_POPUP_BUTTON_WINDOW} (a_action)
			if is_initialized then
				redraw_token_image
			end
		end

feature -- Status report

	is_token_hidden_on_popup_widget_shown: BOOLEAN
			-- Indicates if the token image should be hidden when the popup widget is shown.

feature -- Status setting

	set_is_token_hidden_on_popup_widget_shown (a_hide: like is_token_hidden_on_popup_widget_shown)
			-- Shows/hides the token when the pop up widget is displayed.
			--
			-- `a_hide': True to hide the token when the popup widget is displayed; False to ensure it's always visible it.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initialized
		do
			is_token_hidden_on_popup_widget_shown := a_hide
			if is_popup_widget_shown then
				if a_hide then
					token_image.hide
				else
					token_image.show
				end
			end
		ensure
			is_token_hidden_on_popup_widget_shown_set: is_token_hidden_on_popup_widget_shown = a_hide
		end

feature -- Actions

	token_select_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE [x, y, screen_x, screen_y: INTEGER]]
			-- Actions called when the token part of the popup window was selected
		do
			if {l_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE [x, y, screen_x, screen_y: INTEGER]]} internal_token_select_actions then
				Result := l_actions
			else
				create Result
				internal_token_select_actions := Result
			end
		ensure
			result_consistent: Result = token_select_actions
		end

feature -- Query

	is_applicable_editor_token (a_token: !EDITOR_TOKEN): BOOLEAN
			-- Determines if a token is an applicable editor token for a context button.
			--
			-- `a_token': A editor token to determine applicablity.
			-- `Result': True if the editor token is applicable; False otherwise.
		do
			Result := not a_token.is_fake and not a_token.is_blank
		end

feature {NONE} -- Query

	window_on_screen_position (a_widget: EV_WIDGET; a_constrain_to_widget: BOOLEAN): TUPLE [x, y: INTEGER]
			-- Fetches the on-screen position based on the requested X and Y positions.
			--
			-- `a_widget': The parent widget/window to fetch the top-level window for.
			-- `a_constrain_to_widget': True if the popup window should remain within the bounds of the specified widget/window.
		local
			l_widget: EV_WIDGET
			l_window: like popup_window
		do
			l_window := popup_window
			if a_constrain_to_widget then
				l_widget := a_widget
			else
				l_widget := l_window
			end

			Result := helpers.suggest_pop_up_widget_location_with_size (editor.widget,
				requested_x_position + (l_window.screen_x - token_image.screen_x) + token_x_offset,
				requested_y_position + (l_window.screen_y - token_image.screen_y) + token_y_offset,
				l_window.width,
				l_window.height)

			if {PLATFORM}.is_windows then
					-- Currently a hack
				Result := [Result.x, Result.y + 1]
			end
		end

feature -- Status report

	is_recycled_on_closing: BOOLEAN
			-- Indicates if the foundation should be recycled on closing.
		do
			Result := False
		end

feature {NONE} -- Action handlers

	on_pointer_pressed_in_token_image (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Called when the pointer was pressed in the token image.
			--
			-- `a_x': The relative X position of the pointer pressed action.
			-- `a_y': The relative Y position of the pointer pressed action.
			-- `a_button': The button index of the pointer pressed action.
			-- `a_x_tilt': Unused.
			-- `a_y_tilt': Unused.
			-- `a_pressure': Unused.
			-- `a_screen_x': Screen X position of the pointer pressed action.
			-- `a_screen_y': Screen Y position of the pointer pressed action.
		require
			is_interface_usable: is_interface_usable
			is_initialize: is_initialized
		do
			if a_button = 1 then
--				if
--					is_popup_widget_available and then                -- Only when widgets are available can the popup widget be shown.
--					not (token_image_rectangle.x <= a_x and a_x <= token_image_rectangle.x + token_image_rectangle.width and then
--					     token_image_rectangle.y <= a_y and a_y <= token_image_rectangle.y + token_image_rectangle.height)
--				then
--					show_popup_widget
--				else
--					on_token_selected (a_x, a_y, a_screen_x, a_screen_y)
--					if internal_token_select_actions /= Void then
--						internal_token_select_actions.call ([a_x, a_y, a_screen_x, a_screen_y])
--					end
--				end
				on_token_selected (a_x, a_y, a_screen_x, a_screen_y)
			end
		end

	on_token_selected (a_x: INTEGER; a_y: INTEGER; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Called when the user selects the token in the popup context button.
			--
			-- `a_x': Relative X position to the token image `token_image'.
			-- `a_y': Relative Y position to the token image `token_image'.
			-- `a_screen_x': Window screen X position.
			-- `a_screen_y': Window screen Y position.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if not is_popup_widget_shown then
				on_cancel_popup
			end
		end

	on_popup_widget_show_requested
			-- Called when a show of the popup widget is requested.
		local
			l_widget: like popup_widget
		do
			l_widget := popup_widget
			if l_widget.has_parent then
				l_widget.show
			else
				widget_container.extend (l_widget)

					-- Set the background color to match the token color
				propagate_colors (l_widget, Void, background_color, Void)

				if not widget_container.is_displayed then
					widget_container.show
				end
			end

			if is_token_hidden_on_popup_widget_shown then
				redraw_token_image
				token_image.hide
			end

			popup_window.set_y_position (popup_window.y_position - editor_token.height)
		end

	on_popup_widget_hidden
			-- Called when the popup widget is hidden
		do
			Precursor {ES_POPUP_BUTTON_WINDOW}
			redraw_token_image
			token_image.show
		end

feature {NONE} -- User interface elements

	widget_container: EV_VERTICAL_BOX
			-- The container to extend a popup widget with.

	token_image: !EV_PIXMAP
			-- Custom drawing area

	token_image_rectangle: !EV_RECTANGLE
			-- The rectangle coordinates representing the token in the `token_image' drawing
			-- area. When select the editor should be focused and the context button should be
			-- hidden.

feature {NONE} -- Basic operations

	redraw_token_image
			-- Redraws the token image (`token_image') and set the applicable offsets.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initializing
		local
			l_window: like popup_window
			l_coords: like render_smart_token
			l_old_ox: like token_x_offset
			l_old_oy: like token_y_offset
		do
			if is_initialized and is_shown then
					-- Store for window position adjustment, if any
				l_old_ox := token_x_offset
				l_old_oy := token_y_offset
			end

				-- Token image
			l_coords := render_smart_token (editor_token, token_image, 0, 0, False)
			token_image.set_minimum_size (l_coords.coords.width, l_coords.coords.height)
			token_image.set_size (l_coords.coords.width, l_coords.coords.height)
			token_image_rectangle := l_coords.token_coords

			l_coords := render_smart_token (editor_token, token_image, 0, 0, True)
			token_x_offset := 0 - l_coords.token_coords.x
			token_y_offset := 0 - l_coords.token_coords.y

			token_x_offset := 1
			token_y_offset := editor_token.height

			if is_initialized and is_shown then
				if l_old_ox /= token_x_offset or l_old_oy /= token_y_offset then
						-- Reposition window based on new offsets
					l_window := popup_window
					l_window.set_position (l_window.x_position + (token_x_offset - l_old_ox), l_window.y_position + (token_y_offset - l_old_oy))
				end
			end
		end

	render_smart_token (a_token: !EDITOR_TOKEN; a_dc: !EV_DRAWABLE; a_x: INTEGER; a_y: INTEGER; a_paint: BOOLEAN): TUPLE [coords: !EV_RECTANGLE; token_coords: !EV_RECTANGLE] is
			-- Renders a smart token image on a drawing area, at the specified coordinates.
			--
			-- `a_token': The editor token to render on a drawable area.
			-- `a_dc': A device context (drawable area) to draw the specified token on.
			-- `a_x': The X position to being the drawing of the token.
			-- `a_y': The Y position to being the drawing of the token.
			-- `a_paint': True to actually perform the drawing; False to retrieve the Result coordinates only.
			-- `Result': A tuple containing the result coordinates of the total area drawn as well as the coordinates for just the drawn token.
		require
			not_a_dc_is_destroyed: not a_dc.is_destroyed
			a_x_positive: a_x >= 0
			a_y_positive: a_y >= 0
		local
			l_font: EV_FONT
			l_fg_color: EV_COLOR
			l_bg_color: EV_COLOR
			l_size: TUPLE [width, height, left_offset, right_offset: INTEGER]
			l_x_offset: INTEGER
			l_y_offset: INTEGER
			l_width: INTEGER
			l_height: INTEGER
			l_buffer: EV_PIXEL_BUFFER
			l_glyph: EDITOR_TOKEN_GLYPH
			l_border: INTEGER
			l_has_popup_widget: like is_popup_widget_available
			l_token_rect: !EV_RECTANGLE
			l_rect: !EV_RECTANGLE
		do
			l_has_popup_widget := is_popup_widget_available and then not is_popup_widget_shown

			if a_paint then
					-- Hold on to existing information for later restore.
				l_font := a_dc.font
				l_fg_color := a_dc.foreground_color
				l_bg_color := a_dc.background_color

					-- Set token and font information for render
				a_dc.set_font (a_token.font)
				a_dc.set_foreground_color (a_token.text_color)
				a_dc.set_background_color (background_color)
			end

--			l_glyph ?= a_token
--			if l_glyph = Void then
--				l_size := a_token.font.string_size (a_token.image)
--			else
--				l_size := [l_glyph.glyph.width, l_glyph.glyph.height, 0, 0]
--			end

--				-- Image border width
--			l_border := 2

--				-- Set token coords, for result
--			create l_token_rect.make (a_x + l_border + 1, a_y, l_size.width + l_size.left_offset + l_size.right_offset, l_size.height)

--				-- Calculate size and offset information
--			l_x_offset := l_token_rect.x + l_token_rect.width
--			if l_has_popup_widget then
--					-- Calculate offsets and extended widths for a drop down arrow.
--				l_x_offset := l_x_offset + 3
--				l_buffer := (create {EB_SHARED_PIXMAPS}).mini_pixmaps.toolbar_dropdown_icon_buffer
--				l_width := l_x_offset + l_buffer.width + l_border
--				l_height := (l_token_rect.height + l_border).max (l_buffer.height)
--				l_y_offset := (l_height - l_buffer.height)
--			else
--					-- There is no popup widget
--				l_width := l_x_offset + l_border + 1
--				l_height := l_token_rect.height
--				l_y_offset := l_height
--			end

--				-- Set coords for drawing area, and for result
--			create l_rect.make (a_x, a_y, l_width, l_height)
--			if a_paint then
--				a_dc.set_clip_area (l_rect)

--					-- Perform drawing
--				a_dc.clear_rectangle (a_x, a_y, l_width, l_height)
--				if l_glyph = Void then
--					a_dc.draw_text_top_left (l_token_rect.x, l_token_rect.y, a_token.image)
--				else
--					a_dc.draw_sub_pixel_buffer (l_token_rect.x, l_token_rect.y, l_glyph.glyph, create {EV_RECTANGLE}.make (0, 0, l_glyph.glyph.width, l_glyph.glyph.height))
--				end
--				if l_has_popup_widget then
--					a_dc.draw_sub_pixel_buffer (l_x_offset + a_x, (l_y_offset + a_y) - (l_border + 1), l_buffer, create {EV_RECTANGLE}.make (0, 0, l_buffer.width, l_buffer.height))
--				end
--			end

			l_width := a_token.width - (border_width * 2)
			l_height := 1
			create l_rect.make (a_x, a_y, l_width, l_height)
			create l_token_rect.make (a_x, a_y, l_width, l_height)

				-- Set result
			Result := [l_rect, l_token_rect]

			if a_paint then
					-- Reset font and color information			
				a_dc.set_font (l_font)
				a_dc.set_foreground_color (l_fg_color)
				a_dc.set_background_color (l_bg_color)
			end
		end

feature {NONE} -- Internal implementation cache

	internal_token_select_actions: ?EV_LITE_ACTION_SEQUENCE [TUPLE [x, y: INTEGER]]
			-- Cached version of `token_select_actions'.
			-- Note: do not use directly!

invariant
	editor_is_interface_usable: editor.is_interface_usable

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
