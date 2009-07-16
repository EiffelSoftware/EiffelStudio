note
	description: "[
		A specialized output ({OUTPUT_I}) for use with EiffelStudio's output tool ({ES_OUTPUTS_TOOL}).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_OUTPUT_PANE_I

inherit
	OUTPUT_I

feature -- Access

	text: STRING_32
			-- Text of contents generated to date.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Access: User interface

	icon: EV_PIXEL_BUFFER
			-- An icon representing the output pane.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
		end

	icon_pixmap: EV_PIXMAP
			-- A pixmap icon representing the output pane.
		require
			is_interface_usable: is_interface_usable
		do
			Result := icon.to_pixmap
		ensure
			result_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
		end

	icon_active: EV_PIXEL_BUFFER
			-- An icon representing the output pane, in a post unlocked state.
		require
			is_interface_usable: is_interface_usable
		do
			Result := icon
		ensure
			not_result_is_destroyed: attached Result implies not Result.is_destroyed
		end

	icon_active_pixmap: EV_PIXMAP
			-- A pixmap icon representing the output pane, in a post unlocked state.
		require
			is_interface_usable: is_interface_usable
		do
			Result := icon_pixmap
		ensure
			not_result_is_destroyed: attached Result implies not Result.is_destroyed
		end

	icon_animations: ARRAY [EV_PIXEL_BUFFER]
			-- An list of animation icons representing the output pane is active.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			not_result_is_destroyed: not Result.there_exists (agent {EV_PIXEL_BUFFER}.is_destroyed)
			result_consistent: Result = icon_animations
		end

	icon_pixmap_animations: ARRAY [EV_PIXMAP]
			-- An list of animation pixmap icons representing the output pane is active.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			not_result_is_destroyed: not Result.there_exists (agent {EV_PIXMAP}.is_destroyed)
			result_consistent: Result = icon_pixmap_animations
		end

feature -- Status report

	is_searchable: BOOLEAN
			-- Indicates if the output pane is searchable.
		deferred
		end

	is_auto_scrolled: BOOLEAN assign set_is_auto_scrolled
			-- Indicates if the editor should auto scroll the content.
		deferred
		end

feature -- Status setting

	set_is_auto_scrolled (a_auto: BOOLEAN)
			-- Set auto scroll nature of the output pane.
			--
			-- `a_auto': True to auto-scroll the output pane; False otherwise.
		deferred
		ensure
			is_auto_scrolled_set: is_auto_scrolled = a_auto
		end

feature -- Query

	text_from_window (a_window: SHELL_WINDOW_I): STRING_32
			-- Retrieves current text for a given shell window.
			--
			-- `a_window': A window to retrieve an text for.
			-- `Result': The text for the given shell window.
		require
			is_interface_usable: is_interface_usable
			a_window_attached: a_window /= Void
			a_window_is_interface_usable: a_window.is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
		end

	formatter_from_window (a_window: SHELL_WINDOW_I): TEXT_FORMATTER
			-- Retrieves a formatter for a given shell window.
			--
			-- `a_window': A window to retrieve an output window for.
			-- `Result': An output window for the given shell window.
		require
			is_interface_usable: is_interface_usable
			a_window_attached: a_window /= Void
			a_window_is_interface_usable: a_window.is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result = formatter_from_window (a_window)
		end

feature {NONE} -- Query

	formatter_from_widget (a_widget: ES_WIDGET [EV_WIDGET]): TEXT_FORMATTER
			-- Retrieve a formatter from a widget.
			--
			-- `a_widget': A widget to retrieve a formatter from.
			--  `Result': A formatter retrieve from the widget.
		require
			is_interface_usable: is_interface_usable
			a_widget_attached: a_widget /= Void
			a_widget_is_interface_usable: a_widget.is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Query: User interface

	widget_from_window (a_window: SHELL_WINDOW_I): ES_WIDGET [EV_WIDGET]
			-- Retrieves a graphical widget reprentation of the output for a given shell window.
			--
			-- `a_window': A window to retrieve an output window for.
			-- `Result': An output window widget for the given shell window.
		require
			is_interface_usable: is_interface_usable
			a_window_attached: a_window /= Void
			a_window_is_interface_usable: a_window.is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result = widget_from_window (a_window)
			result_is_interface_usable: Result.is_interface_usable
		end

feature -- Basic operations

	clear_window (a_window: SHELL_WINDOW_I)
			-- Clears any cached output.
			--
			-- `a_window': A window to clear the output on.
		require
			is_interface_usable: is_interface_usable
			a_window_attached: a_window /= Void
			a_window_is_interface_usable: a_window.is_interface_usable
		deferred
		end

	search_window (a_window: SHELL_WINDOW_I)
			-- Search the output window.
			--
			-- `a_window': A window to search the output on.
		require
			is_searchable: is_searchable
			is_interface_usable: is_interface_usable
			a_window_attached: a_window /= Void
			a_window_is_interface_usable: a_window.is_interface_usable
		deferred
		end

feature -- Actions

	new_line_actions: ACTION_SEQUENCE [TUPLE [sender: ES_NOTIFIER_FORMATTER; lines: NATURAL]]
			-- Actions called when a new line has been added to the output
			--
			-- 'sender': The sender (Current) of the action.
			-- 'lines': Number of new lines added.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result = new_line_actions
		end

	text_changed_actions: ACTION_SEQUENCE [TUPLE [sender: ES_NOTIFIER_FORMATTER]]
			-- Actions called when the text has changed.
			--
			-- 'sender': The sender (Current) of the action.
			-- 'count': Number of new lines added.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result = text_changed_actions
		end

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
