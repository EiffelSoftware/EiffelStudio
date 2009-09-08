note
	description: "[
		Widget showing state of a single test session.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_SESSION_STATUS_WIDGET

inherit
	ES_WIDGET [EV_STATUS_BAR]
		rename
			make as make_widget
		redefine
			on_after_initialized,
			internal_recycle
		end

	TEST_SESSION_OBSERVER
		redefine
			on_proceeded
		end

	ES_SHARED_TEST_SESSION_LABELS
		rename
			stock_pixmaps as label_stock_pixmaps
		end

	EV_STOCK_PIXMAPS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_session: like session)
			-- Initialize `Current'.
			--
			-- `a_session': Session displayed by `Current'.
		do
			session := a_session
			make_widget
			session.connection.connect_events (Current)
		end

	build_widget_interface (a_widget: EV_STATUS_BAR)
			-- <Precursor>
		local
			l_frame: EV_FRAME
			l_label: like label
			l_progress_bar: like progress_bar
			l_pixmap: like stop_pixmap
		do

			create l_frame
			create l_label
			l_label.align_text_left
			l_frame.extend (l_label)
			a_widget.extend (l_frame)
			label := l_label

			create l_frame
			create l_progress_bar.make_with_value_range (1 |..| 100)
			l_progress_bar.disable_segmentation
			l_progress_bar.set_minimum_width (150)
			l_frame.extend (l_progress_bar)
			a_widget.extend (l_frame)
			a_widget.disable_item_expand (l_frame)
			progress_bar := l_progress_bar

			create l_frame
			l_pixmap := stock_pixmaps.debug_stop_icon.twin
			l_pixmap.set_pointer_style (hyperlink_cursor)
			l_pixmap.pointer_button_release_actions.force_extend (agent on_stop)
			l_frame.extend (l_pixmap)
			a_widget.extend (l_frame)
			a_widget.disable_item_expand (l_frame)
			stop_pixmap := l_pixmap
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor
			update_label
			update_progress_bar
		end

feature -- Access

	session: TEST_SESSION_I
			-- Session displayed by `Current'

feature {NONE} -- Access: widget

	label: EV_LABEL
			-- Label containing text describing `session'

	progress_bar: EV_HORIZONTAL_PROGRESS_BAR
			-- Progress bar

	stop_pixmap: EV_PIXMAP
			-- Button for stopping `session'

feature {TEST_SESSION_I} -- Events

	on_proceeded (a_session: TEST_SESSION_I)
			-- <Precursor>
		do
			update_label
			update_progress_bar
		end

feature {NONE} -- Events

	on_stop
			-- Called when user clicks on `stop_pixmap'.
		local
			l_session: like session
		do
			l_session := session
			if l_session.is_interface_usable and then l_session.has_next_step then
				l_session.cancel
			end
		end

feature {NONE} -- Implementation

	update_label
			-- Update text of `label'.
		do
			label.set_text (session_label (session))
		end

	update_progress_bar
			-- Update progress in `progress_bar'.
		local
			l_session: like session
		do
			l_session := session
			if l_session.has_next_step then
				progress_bar.set_proportion (l_session.progress)
			else
				progress_bar.set_proportion ({REAL_32} 0.0)
			end
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			Precursor
			session.connection.disconnect_events (Current)
		end

feature {NONE} -- Factory

	create_widget: like widget
			-- <Precursor>
		do
			create Result
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
