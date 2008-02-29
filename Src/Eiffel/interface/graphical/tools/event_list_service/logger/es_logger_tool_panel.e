indexing
	description: "[
		Tool panel to display logged event list items.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_LOGGER_TOOL_PANEL

inherit
	ES_EVENT_LIST_TOOL_PANEL_BASE
		redefine
			internal_recycle,
			is_appliable_event,
			update_content_applicable_widgets
		end

create
	make

feature {NONE} -- Iniitalization

	 build_tool_interface (a_widget: ES_GRID) is
			-- Builds the tools user interface elements.
			-- Note: This function is called prior to showing the tool for the first time.
			--
			-- `a_widget': A widget to build the tool interface using.
		local
			l_col: EV_GRID_COLUMN
		do
			a_widget.set_column_count_to (message_column)

				-- Create columns
			l_col := a_widget.column (category_column)
			l_col.set_width (20)
			l_col := a_widget.column (level_column)
			l_col.set_width (20)
			l_col := a_widget.column (message_column)
			l_col.set_title (interface_names.l_description)
			l_col.set_width (300)

			a_widget.enable_last_column_use_all_width

				-- Enable copying to clipboard
			enable_copy_to_clipboard

				-- Bind redirecting pick and drop actions
			stone_director.bind (a_widget)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- Recycle tool.
		do
			if is_initialized then
				stone_director.unbind (grid_events)
			end
			Precursor {ES_EVENT_LIST_TOOL_PANEL_BASE}
		end

feature {NONE} -- Query

	is_appliable_event (a_event_item: EVENT_LIST_ITEM_I): BOOLEAN
			-- Determines if event `a_event_item' can be shown with the current event list tool
		do
			Result := a_event_item.type = {EVENT_LIST_ITEM_TYPES}.log and then (({EVENT_LIST_LOG_ITEM_I}) #? a_event_item) /= Void
		end

feature {NONE} -- Basic operations

	do_default_action (a_row: EV_GRID_ROW)
			-- Performs a default actions for a given row.
			--
			-- `a_row': The row the user requested an action to be performed on.
		local
			l_item: EVENT_LIST_LOG_ITEM_I
			l_prompt: ES_INFORMATION_PROMPT
		do
			l_item ?= a_row.data
			check l_item_attached: l_item /= Void end

			create l_prompt.make_standard (l_item.description)
			l_prompt.set_sub_title ("Log Message")
			l_prompt.show_on_active_window
		end

feature {NONE} -- User interface items

	clear_button: SD_TOOL_BAR_BUTTON
			-- Button to clear log

feature {NONE} -- Action handlers

	on_clear_log
			-- Call when a request is made to clear the log
		local
			l_service: SERVICE_CONSUMER [LOGGER_S]
		do
			create l_service
			if l_service.is_service_available then
					-- Should never be Void if we have log items, but we have to
					-- respect the service might not exist.
				l_service.service.clear_log
			end
		end

feature {NONE} -- UI manipulation

	update_content_applicable_widgets (a_enable: BOOLEAN)
			-- Updates widgets on tool that require content to exist
			--
			-- `a_enable': True to indicate there is content available, False otherwise
		do
			if is_initialized then
				if a_enable then
					clear_button.enable_sensitive
				else
					clear_button.disable_sensitive
				end
			end
		end

feature {NONE} -- Factory

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display at the top of the tool.
		do
			create clear_button.make
			clear_button.set_text (interface_names.l_clean)
			clear_button.set_pixmap (stock_pixmaps.general_reset_icon)
			clear_button.set_pixel_buffer (stock_pixmaps.general_reset_icon_buffer)
			clear_button.select_actions.extend (agent on_clear_log)
			clear_button.disable_sensitive

			create Result.make (1)
			Result.put_last (clear_button)
		ensure then
			clear_button_attached: clear_button /= Void
		end

	populate_event_grid_row_items (a_event_item: EVENT_LIST_ITEM_I; a_row: EV_GRID_ROW)
			-- Populates a grid row's item on a given row using the event `a_event_item'.
			--
			-- `a_event_item': A event to base the creation of a grid row on.
			-- `a_row': The row to create items on.
		local
			l_item: EV_GRID_LABEL_ITEM
			l_log: EVENT_LIST_LOG_ITEM_I
			l_pixmap: EV_PIXMAP
			l_font: EV_FONT
		do
			l_log ?= a_event_item
			check l_log_attached: l_log /= Void end

				-- Category
			create l_item
			l_pixmap := category_icon_from_event_item (a_event_item)
			if l_pixmap /= Void then
				l_item.set_pixmap (l_pixmap)

					-- Set string data for pixmap index, so it can be sorted.
				l_item.set_data (a_event_item.category.out)
			end
			a_row.set_item (category_column, l_item)

				-- Level of severity
			create l_item
			l_pixmap := priority_icon_from_event_item (a_event_item)
			if l_pixmap /= Void then
				l_item.set_pixmap (l_pixmap)

					-- Set string data for pixmap index, so it can be sorted.
				l_item.set_data (a_event_item.priority.out)
			end
			a_row.set_item (level_column, l_item)

				-- Description
			create l_item.make_with_text (a_event_item.description)
				-- Set item color and font based on level of sevrity
			inspect a_event_item.priority
			when {PRIORITY_LEVELS}.high then
				l_font := fonts.standard_label_font.twin
				l_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
				l_item.set_foreground_color (colors.high_priority_foreground_color)
				l_item.set_font (l_font)
			when {PRIORITY_LEVELS}.low then
				l_item.set_foreground_color (colors.low_priority_foreground_color)
			else
			end
			a_row.set_item (message_column, l_item)

			a_row.set_data (a_event_item)
		end

feature {NONE} -- Constants

	category_column: INTEGER = 1
	level_column: INTEGER = 2
	message_column: INTEGER = 3

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
