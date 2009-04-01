note
	description: "[
		The base implementation for {ES_OUTPUT_PANE_I}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_OUTPUT_PANE [G -> ES_WIDGET [EV_WIDGET]]

inherit
	LOCKABLE
		redefine
			is_interface_usable
		end

	ES_OUTPUT_PANE_I
		redefine
			activate
		end

	ES_RECYCLABLE
		redefine
			is_interface_usable
		end

	ES_SHARED_FOUNDATION_HELPERS
		export
			{NONE} all
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make
			-- Initializes the output pane
		do
			create notifier_formatter.make
		end

	build_interface (a_widget: attached G)
			-- Builds the interface for the widget.
			--
			-- `a_widget': The widget to build/initialize.
		require
			is_interface_usable: is_interface_usable
			a_widget_is_interface_usable: a_widget.is_interface_usable
		deferred
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		local
			l_table: like widget_table
			l_widget: EB_RECYCLABLE
		do
			l_table := widget_table
			if l_table /= Void then
				from l_table.start until l_table.after loop
					l_widget := l_table.item_for_iteration
					if l_widget.is_interface_usable then
						l_widget.recycle
					end
					l_table.forth
				end
			end
		ensure then
			widget_table_is_empty: widget_table.is_empty
		end

feature -- Access

	text: STRING_32
			-- <Precursor>
		do
			Result := notifier_formatter.string
		end

	formatter: ES_MULTI_OUTPUT_WINDOW
			-- <Precursor>
		do
			if attached internal_formatter as l_result then
				Result := l_result
			else
				create {ES_MULTI_OUTPUT_WINDOW} Result.make
					-- Add the notifier window to ensure clients have access to the cached
					-- string contents and actions.
				Result.extend (notifier_formatter)
				internal_formatter := Result
			end
		ensure then
			result_has_notifier_formatter: Result.had_formatter (notifier_formatter)
		end

feature {NONE} -- Access

	notifier_formatter: ES_NOTIFIER_OUTPUT_WINDOW
			-- Ouptut window use to notify clients of changes.

feature -- Access

	icon_animations: LIST [EV_PIXEL_BUFFER]
			-- <Precursor>
		do
			if attached internal_icon_animations as l_result then
				Result := l_result
			else
				Result := new_icon_animations
				internal_icon_animations := Result
			end
		end

	icon_pixmap_animations: LIST [EV_PIXMAP]
			-- <Precursor>
		do
			if attached internal_icon_pixmap_animations as l_result then
				Result := l_result
			else
				Result := new_icon_pixmap_animations
				internal_icon_pixmap_animations := Result
			end
		end

feature {NONE} -- Access: User interface

	icon_animation_overlay_coords: LINEAR [TUPLE [x, y: NATURAL_8]]
			-- Animation icons coordinates for drawing an overlay icon.
		local
			l_result: ARRAYED_LIST [TUPLE [NATURAL_8, NATURAL_8]]
		once
			create l_result.make (7)
--			l_result.extend ([{NATURAL_8} 1, {NATURAL_8} 1])
--			l_result.extend ([{NATURAL_8} 2, {NATURAL_8} 1])
--			l_result.extend ([{NATURAL_8} 3, {NATURAL_8} 1])
--			l_result.extend ([{NATURAL_8} 4, {NATURAL_8} 1])
--			l_result.extend ([{NATURAL_8} 5, {NATURAL_8} 1])
--			l_result.extend ([{NATURAL_8} 6, {NATURAL_8} 1])

			l_result.extend ([{NATURAL_8} 1, {NATURAL_8} 3])
			l_result.extend ([{NATURAL_8} 2, {NATURAL_8} 3])
			l_result.extend ([{NATURAL_8} 3, {NATURAL_8} 3])
			l_result.extend ([{NATURAL_8} 4, {NATURAL_8} 3])
			l_result.extend ([{NATURAL_8} 5, {NATURAL_8} 3])
			l_result.extend ([{NATURAL_8} 6, {NATURAL_8} 3])
			l_result.extend ([{NATURAL_8} 6, {NATURAL_8} 3])

--			l_result.extend ([{NATURAL_8} 5, {NATURAL_8} 2])
--			l_result.extend ([{NATURAL_8} 3, {NATURAL_8} 2])
--			l_result.extend ([{NATURAL_8} 2, {NATURAL_8} 1])
			Result := l_result
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	widget_table: detachable DS_HASH_TABLE [G, NATURAL]
			-- Table of requested widgets, indexed by a window ID.
			--
			-- Key: Window ID
			-- Value: A widget displayed on key window.

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {LOCKABLE} and then Precursor {ES_RECYCLABLE}
		end

	is_active: BOOLEAN
			-- <Precursor>
		local
			l_table: like widget_table
			l_cursor: DS_HASH_TABLE_CURSOR [G, NATURAL]
		do
			l_table := widget_table
			if not l_table.is_empty then
				l_cursor := l_table.new_cursor
				from l_cursor.start until l_cursor.after or Result loop
					Result := l_cursor.item.is_shown
					l_cursor.forth
				end
				l_cursor.finish
			end
		end

feature -- Query: User interface

	widget_from_window (a_window: SHELL_WINDOW_I): attached G
			-- <Precursor>
		local
			l_table: like widget_table
			l_id: NATURAL
		do
			l_table := widget_table
			l_id := a_window.window_id
			if l_table /= Void and then l_table.has (l_id) then
				Result := l_table.item (l_id)
			else
				Result := new_widget (a_window)
				build_interface (Result)
				if l_table = Void then
					create l_table.make_default
					widget_table := l_table
				end
				l_table.put_last (Result, l_id)

					-- The widget has been requested so we can made the output window
					-- available for use but adding it to the `output_window' object.
				formatter.extend (formatter_from_widget (Result))
			end
		ensure then
			widget_table_attached: widget_table /= Void
			widget_table_has_a_window: widget_table.has (a_window.window_id)
			widget_table_contains_result: widget_table.item (a_window.window_id) = Result
			result_consistent: Result = widget_from_window (a_window)
		end

feature -- Basic operations

	clear
			-- <Precursor>
		do
			notifier_formatter.reset
		ensure then
			notifier_formatter_string_is_empty: notifier_formatter.string.is_empty
		end

	activate
			-- <Precursor>
		do
			if attached window_manager.last_focused_development_window as l_window then
				if l_window.is_interface_usable then
						-- Show the output pane on the active window.
					if attached {ES_OUTPUTS_TOOL} l_window.shell_tools.tool ({ES_OUTPUTS_TOOL}) as l_tool then
							-- Set the output and show the tool.
						l_tool.set_output (Current)
						l_tool.show (False)
					else
						check tool_removed: False end
					end
				end
			end
		end

feature -- Actions

	new_line_actions: ACTION_SEQUENCE [TUPLE [sender: ES_NOTIFIER_OUTPUT_WINDOW; lines: NATURAL]]
			-- <Precursor>
		do
			Result := notifier_formatter.new_line_actions
		end

	text_changed_actions: ACTION_SEQUENCE [TUPLE [sender: ES_NOTIFIER_OUTPUT_WINDOW]]
			-- <Precursor>
		do
			Result := notifier_formatter.text_changed_actions
		end

feature {NONE} -- Factory

	new_widget (a_window: SHELL_WINDOW_I): attached G
			-- Creates a new widget for the output pane.
			--
			-- `a_window': The window where the widget will be displayed.
			-- `Result': A new widget for the output pane.
		require
			is_interface_usable: is_interface_usable
			a_window_attached: a_window /= Void
			a_window_is_interface_usable: a_window.is_interface_usable
		deferred
		ensure
			result_is_interface_usable: Result.is_interface_usable
		end

	new_icon_animations: ARRAYED_LIST [EV_PIXEL_BUFFER]
			-- Creates a new series of animation icons when the output is currently processing output.
		local
			l_coords: like icon_animation_overlay_coords
			l_base_icon: like icon
			l_icon: EV_PIXEL_BUFFER
			l_pixmaps: like stock_pixmaps
			l_mini_pixmaps: like mini_stock_pixmaps
		do
			l_coords := icon_animation_overlay_coords
			l_base_icon := icon
			l_pixmaps := stock_pixmaps
			l_mini_pixmaps := mini_stock_pixmaps
			create Result.make (5)
			from l_coords.start until l_coords.after loop
				if attached l_coords.item as l_coord then
					l_icon := l_pixmaps.icon_buffer_with_overlay (l_base_icon, l_mini_pixmaps.general_edit_icon_buffer, l_coord.x, l_coord.y)
					--l_icon.set_size (l_base_icon.width, l_base_icon.height)
					Result.extend (l_icon)
				end
				l_coords.forth
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			not_result_is_destroyed: not Result.there_exists (agent {EV_PIXEL_BUFFER}.is_destroyed)
		end

	new_icon_pixmap_animations: ARRAYED_LIST [EV_PIXMAP]
			-- Creates a new series of animation icon pixmaps when the output is currently processing output.
		local
			l_coords: like icon_animation_overlay_coords
			l_base_icon: like icon
			l_icon: EV_PIXMAP
			l_pixmaps: like stock_pixmaps
			l_mini_pixmaps: like mini_stock_pixmaps
		do
			l_coords := icon_animation_overlay_coords
			l_base_icon := icon
			l_pixmaps := stock_pixmaps
			l_mini_pixmaps := mini_stock_pixmaps
			create Result.make (5)
			from l_coords.start until l_coords.after loop
				if attached l_coords.item as l_coord then
					l_icon := l_pixmaps.icon_with_overlay (l_base_icon, l_mini_pixmaps.general_edit_icon_buffer, l_coord.x, l_coord.y)
					l_icon.set_size (l_base_icon.width, l_base_icon.height)
					Result.extend (l_icon)
				end
				l_coords.forth
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			not_result_is_destroyed: not Result.there_exists (agent {EV_PIXMAP}.is_destroyed)
		end

feature {NONE} -- Implementation: Internal cache

	internal_formatter: detachable like formatter
			-- Cached version of `formatter'.
			-- Note: Do not use directly!

	internal_icon_animations: detachable like icon_animations
			-- Cached version of `icon_animations'
			-- Note: DO not use directly!

	internal_icon_pixmap_animations: detachable like icon_pixmap_animations
			-- Cached version of `icon_pixmap_animations'
			-- Note: DO not use directly!

invariant
	notifier_formatter_attached: notifier_formatter /= Void

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
