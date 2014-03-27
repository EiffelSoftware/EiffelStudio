note
	description	: "Tool where output and error of external commands are displayed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: ""

class
	ES_WEB_BROWSER_TOOL_PANEL

inherit
	EB_TOOL
		redefine
			show,
			internal_recycle,
			internal_detach_entities
		end

	EB_EXTERNAL_OUTPUT_CONSTANTS

	SHARED_PLATFORM_CONSTANTS

	EB_TEXT_OUTPUT_TOOL

	EB_CONSTANTS

create
	make

feature{NONE} -- Initialization

	build_interface
			-- <Precursor>
		local
			l_main_frame: EV_VERTICAL_BOX
			l_toolbar: SD_TOOL_BAR
			l_button: SD_TOOL_BAR_BUTTON
			l_text_field: EV_TEXT_FIELD
			l_toolbar_box: EV_HORIZONTAL_BOX
		do
			create l_main_frame
			widget := l_main_frame

				-- Toolbar
			create l_toolbar_box
			l_main_frame.extend (l_toolbar_box)
			l_main_frame.disable_item_expand (l_toolbar_box)
			create l_toolbar.make
			l_toolbar_box.extend (l_toolbar)
			l_toolbar_box.disable_item_expand (l_toolbar)

				-- Browser control buttons
				-- Back button
			create l_button.make
			l_button.set_pixel_buffer (pixmaps.icon_pixmaps.general_undo_icon_buffer)
			l_toolbar.extend (l_button)
			l_button.select_actions.extend (agent on_back_button_selected)
				-- Forth button
			create l_button.make
			l_button.set_pixel_buffer (pixmaps.icon_pixmaps.general_redo_icon_buffer)
			l_toolbar.extend (l_button)
			l_button.select_actions.extend (agent on_forth_button_selected)
				-- Refresh button
			create l_button.make
			l_button.set_pixel_buffer (pixmaps.icon_pixmaps.general_refresh_icon_buffer)
			l_toolbar.extend (l_button)
			l_button.select_actions.extend (agent on_refresh_button_selected)
				-- Stop button
			create l_button.make
			l_button.set_pixel_buffer (pixmaps.icon_pixmaps.debug_stop_icon_buffer)
			l_toolbar.extend (l_button)
			l_button.select_actions.extend (agent on_stop_button_selected)
			l_toolbar.compute_minimum_size

				-- Address
			create l_text_field
			l_text_field.key_release_actions.extend (agent on_key_released_on_address_bar)
			address_bar := l_text_field
			l_toolbar_box.extend (l_text_field)

				-- Go button
			create l_toolbar.make
			l_toolbar_box.extend (l_toolbar)
			create l_button.make
			l_button.set_pixel_buffer (pixmaps.icon_pixmaps.debug_run_icon_buffer)
			l_toolbar.extend (l_button)
			l_toolbar.compute_minimum_size
			l_toolbar_box.disable_item_expand (l_toolbar)

			create web_browser
			l_main_frame.extend (web_browser)

			set_proper_size
		end

feature -- Access

	widget: EV_WIDGET
			-- Graphical representation for Current.

	web_browser: EV_WEB_BROWSER
			-- Web brower

feature -- Basic operation

	visit (a_link: READABLE_STRING_GENERAL)
			-- Visit `a_link'.
		require
			a_link_not_empty: not a_link.is_empty
		do
			if not is_shown then
				show
			end
			address_bar.set_text (a_link)
			web_browser.load_uri (a_link)
		end

	set_focus
			-- Give the focus to the editor.		
		local
			l_env: EV_ENVIRONMENT
		do
			create l_env
			l_env.application.do_once_on_idle (agent set_focus_on_idle)
		end

	show
			-- Show tool.
		do
			Precursor {EB_TOOL}
			if widget /= Void and then widget.is_displayed and then widget.is_sensitive then
				set_focus
			end
		end

feature {NONE} -- Actions

	on_key_released_on_address_bar (key: EV_KEY)
			-- Agent called when user press enter in `input_field'
		do
			if key.code = {EV_KEY_CONSTANTS}.key_enter then
				web_browser.load_uri (address_bar.text)
			end
		end

	on_back_button_selected
			-- On back button selected
		do
			web_browser.back
		end

	on_forth_button_selected
			-- On forth button selected
		do
			web_browser.forth
		end

	on_refresh_button_selected
			-- On refresh button selected
		do
			web_browser.refresh
		end

	on_stop_button_selected
			-- On stop button selected
		do
			web_browser.stop
		end

feature {NONE} -- Recycle

	internal_recycle
			-- To be called before destroying this objects
		do
			widget.destroy
			Precursor
		end

	internal_detach_entities
			-- <Precursor>
		do
			widget := Void
			Precursor
		end

feature {NONE} -- Interface

	address_bar: EV_TEXT_FIELD
			-- Address bar

feature {NONE} -- Implementation

	set_focus_on_idle
			-- Set focus on idle actions.
		local
			l_env: EV_ENVIRONMENT
			l_focused_already: BOOLEAN
			l_widget: EV_WIDGET
		do
			create l_env
			if attached {EV_CONTAINER} widget as l_container then
				if not l_env.application.is_destroyed then
					l_widget := l_env.application.focused_widget
				end
				if not l_container.is_destroyed and then l_container.has_recursive (l_widget) then
					-- If out tool has focus already, then we don't need set focus again later.
					l_focused_already := True
				end
			end

			if not l_focused_already then
					-- Set focus to the browser
			end
		end

	set_proper_size
			-- Set a proper size of the window
		local
			l_screen: EV_SCREEN
			l_monitor: EV_RECTANGLE
		do
			create l_screen
			l_monitor := l_screen.monitor_area_from_position (web_browser.screen_x, web_browser.screen_y)
			if attached content as l_content then
				l_content.set_floating_width (init_floating_width.min (l_monitor.width))
				l_content.set_floating_height (init_floating_height.min (l_monitor.height))
			end
		end

	toolbar_title: STRING = "Web Browser Toolbar"

	init_floating_width: INTEGER = 1100
	init_floating_height: INTEGER = 800

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_EXTERNAL_OUTPUT_TOOL
