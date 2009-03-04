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

	build_interface (a_widget: attached G)
			-- Builds the interface for the widget.
			--
			-- `a_widget': The widget to build/initialize.
		require
			is_interface_usable: is_interface_usable
			not_a_widget_is_interface_usable: not a_widget.is_interface_usable
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

	output_window: attached ES_MULTI_OUTPUT_WINDOW
			-- <Precursor>
		local
			l_result: like internal_output_window
		do
			l_result := internal_output_window
			if l_result = Void then
				create {ES_MULTI_OUTPUT_WINDOW} Result.make
				internal_output_window := Result
			else
				Result := l_result
			end
		end

feature {NONE} -- Access: User interface

	widget_table: detachable DS_HASH_TABLE [attached G, NATURAL]
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
			l_cursor: DS_HASH_TABLE_CURSOR [attached G, NATURAL]
		do
			l_table := widget_table
			if not l_table.is_empty then
				l_cursor := l_table.new_cursor
				from l_cursor.start until l_cursor.after loop
					l_cursor.forth
				end
				l_cursor.finish
			end
		end

feature {NONE} -- Query

	widget_output_window (a_widget: attached G; a_window: attached SHELL_WINDOW_I): attached OUTPUT_WINDOW
			-- Retrieves an output window from a created widget.
			--
			-- `a_widget': The widget to fetch the output window from.
			-- `a_window': The window where there widget is displayed.
			-- `Result': A resulting output window.
		require
			is_interface_usable: is_interface_usable
			a_widget_is_interface_usable: a_widget.is_interface_usable
			a_window_is_interface_usable: a_window.is_interface_usable
		deferred
		end

feature -- Query: User interface elements

	widget_for_window (a_window: attached SHELL_WINDOW_I): attached G
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
				if l_table = Void then
					create l_table.make_default
					widget_table := l_table
				end
				l_table.put_last (Result, l_id)

					-- The widget has been requested so we can made the output window
					-- available for use but adding it to the `output_window' object.
				output_window.extend (widget_output_window (Result, a_window))
			end
		ensure then
			widget_table_attached: widget_table /= Void
			widget_table_has_a_window: widget_table.has (a_window.window_id)
			widget_table_contains_result: widget_table.item (a_window.window_id) = Result
			result_consistent: Result = widget_for_window (a_window)
		end

--feature -- Basic operations

--	activate
--			-- <Precursor>
--		do
--			check not_implemented: False end
--		end

feature {NONE} -- Factory

	new_widget (a_window: attached SHELL_WINDOW_I): attached G
			-- Creates a new widget for the output pane.
			--
			-- `a_window': The window where the widget will be displayed.
			-- `Result': A new widget for the output pane.
		require
			is_interface_usable: is_interface_usable
			a_window_is_interface_usable: a_window.is_interface_usable
		deferred
		ensure
			result_is_interface_usable: Result.is_interface_usable
		end

feature {NONE} -- Implementation: Internal cache

	internal_output_window: detachable like output_window
			-- Cached version of `output_window'.
			-- Note: Do not use directly!

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
