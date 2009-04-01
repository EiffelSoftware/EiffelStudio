note
	description: "[
		Tool for viewing the EiffelStudio twitter feed.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TWITTER_FEED_TOOL_PANEL

inherit
	ES_DOCKABLE_TOOL_PANEL [EV_VERTICAL_BOX]
		redefine
			on_after_initialized,
			is_tool_bar_separated,
			create_right_tool_bar_items
		end

	ES_TOOL_ICONS_PROVIDER_I [ES_TWITTER_FEED_TOOL_ICONS]
		rename
			tool as tool_descriptor
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization: User interface

    build_tool_interface (a_widget: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_utilities: ES_TOOL_UTILITIES
			l_hbox: EV_HORIZONTAL_BOX
			l_feed: like twitter_feed
			l_icon: EV_PIXMAP
			l_spacer: EV_CELL
			l_tool_path: PATH_NAME
			l_logo_file: FILE_NAME
			l_bird_file: FILE_NAME
			l_spacer_file: FILE_NAME
		do
			create l_utilities
			a_widget.set_padding (0)
			a_widget.set_background_color (colors.stock_colors.white)

				--
				-- `twitter_feed'
				--
			create l_feed
			l_feed.hide_header
			l_feed.set_column_count_to (1)
			l_feed.set_auto_resizing_column (1, True)
			l_feed.disable_selection_on_click
			l_feed.set_separator_color (colors.grid_line_color)
			l_feed.set_row_height (status_user_font.height.max (status_font.height) + status_timestamp_font.height + 6 + {ES_UI_CONSTANTS}.vertical_padding)
			a_widget.extend (l_feed)
			twitter_feed := l_feed

				-- Bottom logo
			l_tool_path := l_utilities.tool_associated_path (tool_descriptor)
			create l_logo_file.make_from_string (l_tool_path)
			l_logo_file.set_file_name (logo_file_name)
			create l_bird_file.make_from_string (l_tool_path)
			l_bird_file.set_file_name (bird_file_name)
			create l_spacer_file.make_from_string (l_tool_path)
			l_spacer_file.set_file_name (spacer_file_name)
			if
				(create {RAW_FILE}.make (l_logo_file.string)).exists and then
				(create {RAW_FILE}.make (l_bird_file.string)).exists and then
				(create {RAW_FILE}.make (l_spacer_file.string)).exists
			then
				create l_hbox
				l_hbox.set_background_color (colors.stock_colors.white)
				l_hbox.set_border_width (0)
				l_hbox.set_padding (0)

				create l_icon.default_create
				l_icon.set_with_named_file (l_spacer_file.string)
				create l_spacer
				l_spacer.set_background_pixmap (l_icon)
				l_spacer.set_minimum_width ({ES_UI_CONSTANTS}.frame_border)
				l_hbox.extend (l_spacer)
				l_hbox.disable_item_expand (l_spacer)

				create l_icon.default_create
				l_icon.set_with_named_file (l_logo_file.string)
				l_hbox.extend (l_icon)
				l_hbox.disable_item_expand (l_icon)

					-- Set up icon hyper-linking properties
				register_action (l_icon.pointer_enter_actions, agent (ia_icon: EV_PIXMAP)
					do
						ia_icon.set_pointer_style (create {EV_POINTER_STYLE}.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.hyperlink_cursor))
					end (l_icon))
				register_action (l_icon.pointer_leave_actions, agent (ia_icon: EV_PIXMAP)
					do
						ia_icon.set_pointer_style (create {EV_POINTER_STYLE}.make_predefined ({EV_POINTER_STYLE_CONSTANTS}.standard_cursor))
					end (l_icon))
				register_action (l_icon.pointer_button_press_actions, agent (ia_x, ia_y, ia_button: INTEGER; ia_x_tilt, ia_y_tilt, ia_pressure: REAL_64; ia_screen_x, ia_screen_y: INTEGER)
					do
						if ia_button = 1 then
							on_launch_twitter
						end
					end)

				create l_icon.default_create
				l_icon.set_with_named_file (l_spacer_file.string)
				create l_spacer
				l_spacer.set_background_pixmap (l_icon)
				l_hbox.extend (l_spacer)

				create l_icon.default_create
				l_icon.set_with_named_file (l_bird_file.string)
				l_hbox.extend (l_icon)
				l_hbox.disable_item_expand (l_icon)

				a_widget.extend (l_hbox)
				a_widget.disable_item_expand (l_hbox)
			else
				check corrupted_installation: False end
			end

			if attached refresh_button as l_button then
				register_action (l_button.select_actions, agent on_refresh_feed)
			end
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor

				-- Refreshes the twitter feed.
			refresh_feed
		end

feature {NONE} -- Access: User interface

	twitter_feed: detachable ES_GRID
			-- Twitter feed grid to display feed information.

	refresh_button: detachable SD_TOOL_BAR_BUTTON
			-- Button used to refresh the twitter feed

feature {NONE} -- Access: User interface defaults

	status_font: EV_FONT
			-- Font used to display the status information.
		once
			Result := fonts.prompt_text_font.twin
			Result.set_height (13)
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
			Result.set_shape ({EV_FONT_CONSTANTS}.shape_regular)
		ensure
			result_attached: Result /= Void
		end

	status_foreground_color: EV_COLOR
			-- Text color used to display status information.
		once
			Result := colors.prompt_text_foreground_color
		ensure
			result_attached: Result /= Void
		end

	status_user_font: EV_FONT
			-- Font used to display the status user information.
		once
			Result := fonts.prompt_text_font.twin
			Result.set_height (13)
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
			Result.set_shape ({EV_FONT_CONSTANTS}.shape_regular)
		ensure
			result_attached: Result /= Void
		end

	status_user_foreground_color: EV_COLOR
			-- Text color used to display status user information.
		once
			Result := colors.prompt_sub_title_foreground_color
		ensure
			result_attached: Result /= Void
		end

	status_timestamp_font: EV_FONT
			-- Font used to display the status timestamp information.
		once
			Result := fonts.prompt_text_font.twin
			Result.set_height (12)
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
			Result.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
		ensure
			result_attached: Result /= Void
		end

	status_timestamp_foreground_color: EV_COLOR
			-- Text color used to display status information.
		once
			Result := colors.disabled_foreground_color
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Status report

	is_tool_bar_separated: BOOLEAN = True
			-- <Precursor>

	is_refreshing: BOOLEAN
			-- Indcates if the feed is currently being refreshed

feature {NONE} -- Basic operations

	refresh_feed
			-- Refreshes the twitter feed.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_is_refreshing: not is_refreshing
		local
			l_reader: ES_TWITTER_FEED_REQUEST
			l_sensitive: BOOLEAN
		do
			is_refreshing := True
			l_sensitive := refresh_button.is_sensitive
			refresh_button.disable_sensitive

				-- Clear the current grid.
			twitter_feed.clear
			twitter_feed.set_row_count_to (0)

			create l_reader
			l_reader.request_tweets_aync (12, agent (ia_tweet: ES_TWEET)
					-- Agent to add a new tweet
				do
						-- Threaded call, so add a synchronizing action.
					ev_application.add_idle_action_kamikaze (agent on_new_tweet (ia_tweet))
				end,

				agent (ia_enable: BOOLEAN)
					-- Completion agent, restore refresh button and change status flag
				do
					check is_refreshing: is_refreshing end
					if ia_enable and is_interface_usable then
						refresh_button.enable_sensitive
					end
					is_refreshing := False
				end (l_sensitive))
		rescue
			is_refreshing := False
		end

feature {NONE} -- Action handlers

	on_new_tweet (a_tweet: ES_TWEET)
			-- Call to add a new tweet to the list.
			--
			-- `a_tweet': A new twitter tweet object.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_tweet_attached: a_tweet /= Void
		local
			l_item: EV_GRID_DRAWABLE_ITEM
			l_row: EV_GRID_ROW
			i: INTEGER
		do
			create l_item.make_with_expose_action_agent (agent on_draw_tweet (?, a_tweet))
			i := twitter_feed.row_count + 1
			twitter_feed.set_row_count_to (i)
			l_row := twitter_feed.row (i)
			l_row.set_item (1, l_item)
			l_row.set_height (35)
		end

	on_draw_tweet (a_drawable: EV_DRAWABLE; a_tweet: ES_TWEET)
			-- Received a draw request for a twitter tweet.
			--
			-- `a_drawable': The drawable region to draw a tweet on to.
			-- `a_tweet': The tweet to draw.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_drawable_attached: a_drawable /= Void
			not_a_drawable_is_destroyed: not a_drawable.is_destroyed
			a_tweet_attached: a_tweet /= Void
		local
			l_text: STRING_32
			l_font: EV_FONT
			l_x: INTEGER
			l_y: INTEGER
			l_height: INTEGER
		do
			a_drawable.set_background_color (twitter_feed.background_color)
			a_drawable.clear
			l_x := {ES_UI_CONSTANTS}.horizontal_padding
			l_y := {ES_UI_CONSTANTS}.vertical_padding

			l_text := a_tweet.user.as_string_32
			l_font := status_user_font
			a_drawable.set_font (l_font)
			a_drawable.set_foreground_color (status_user_foreground_color)
			a_drawable.draw_text_top_left (l_x, l_y, l_text)

			l_height := l_font.height
			l_x := l_x + l_font.string_width (l_text) + 4

			l_text := a_tweet.text.as_string_32
			l_font := status_font
			a_drawable.set_font (l_font)
			a_drawable.set_foreground_color (status_foreground_color)
			a_drawable.draw_text_top_left (l_x, l_y, l_text)

			l_y := l_y + l_font.height.max (l_height) + 2
			l_x := l_x + l_font.string_width (l_text) + 4

			l_x := {ES_UI_CONSTANTS}.horizontal_padding
			l_text := a_tweet.date.as_string_32
			l_text.append_string_general (" (from ")
			l_text.append_string_general (a_tweet.source)
			l_text.append_string_general (")")
			l_font := status_timestamp_font
			a_drawable.set_font (l_font)
			a_drawable.set_foreground_color (status_timestamp_foreground_color)
			a_drawable.draw_text_top_left (l_x, l_y, l_text)
		end

	on_refresh_feed
			-- Called to refresh the twitter feed.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			not_is_refreshing: not is_refreshing
		do
			refresh_feed
		end

	on_launch_twitter
			-- Called when the user selects the twitter icon pixmap.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_launched: BOOLEAN
		do
			l_launched := (create {URI_LAUNCHER}).launch (twitter_url)
		end

feature {NONE} -- Factory

    create_widget: EV_VERTICAL_BOX
			-- <Precursor>
		do
			create Result
		end

    create_tool_bar_items: detachable DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
		end

    create_right_tool_bar_items: detachable DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_button: SD_TOOL_BAR_BUTTON
		do
			create Result.make (1)

			create l_button.make
			l_button.set_pixel_buffer (stock_pixmaps.general_refresh_icon_buffer)
			l_button.set_pixmap (stock_pixmaps.general_refresh_icon)
			l_button.set_tooltip (locale_formatter.translation (tt_refresh_feed))
			Result.put_last (l_button)
			refresh_button := l_button
		end

feature {NONE} -- Constants

	logo_file_name: STRING = "logo.png"
			-- Twitter logo file name.

	bird_file_name: STRING = "bird.png"
			-- Twitter bird file name.

	spacer_file_name: STRING = "spacer.png"
			-- Twitter logo file name.

	twitter_url: STRING = "http://twitter.com/"
			-- URL to launch twitter.

feature {NONE} -- Internationalization

	tt_refresh_feed: STRING = "Refreshes the twitter feed"

invariant
	twitter_feed_attached: (is_interface_usable and is_initialized) implies twitter_feed /= Void
	refresh_button_attached: (is_interface_usable and is_initialized) implies refresh_button /= Void

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end
