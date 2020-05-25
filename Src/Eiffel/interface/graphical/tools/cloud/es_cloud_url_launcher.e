note
	description: "Summary description for {ES_CLOUD_URL_LAUNCHER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_URL_LAUNCHER

inherit
	ANY

	EB_SHARED_PREFERENCES

	ES_SHARED_FONTS_AND_COLORS

	SHARED_ES_CLOUD_NAMES

create
	make

feature {NONE} -- Initialization

	make (a_location: READABLE_STRING_8)
		do
			location := a_location
		end

feature -- Access

	location: IMMUTABLE_STRING_8

	status_label: detachable EV_TEXTABLE

	associated_widget: detachable EV_WIDGET

feature -- Element change

	set_associated_widget (w: like associated_widget)
		do
			associated_widget := w
			if
				associated_widget = Void and then
				attached {EV_WIDGET} status_label as wid
			then
				associated_widget := wid
			end
		end

	set_status_label (lab: like status_label)
		do
			status_label := lab
			if
				associated_widget = Void and then
				attached {EV_WIDGET} lab as wid
			then
				associated_widget := wid
			end
		end

feature -- Execution

	execute
		local
			popup: EV_POPUP_WINDOW
			t: EV_TIMEOUT
			lab: EV_LABEL
			is_launched: BOOLEAN
			l_was_hidden: BOOLEAN
			m: STRING_32
			l_status_label: like status_label
		do
			l_status_label := status_label
			if l_status_label /= Void then
				if attached {EV_COLORIZABLE} l_status_label as l_col then
					l_col.set_foreground_color (colors.stock_colors.gray)
				end
				if
					attached {EV_WIDGET} l_status_label as l_status_widget and then
					not l_status_widget.is_displayed
				then
					l_was_hidden := True
					l_status_widget.show
				end
				l_status_label.set_text (cloud_names.label_opening_url (location))
			else
				create popup.make_with_shadow
				create lab.make_with_text (cloud_names.label_opening_url (location))
				popup.extend (lab)
				popup.set_size (200, 50)
				lab.pointer_button_release_actions.extend (agent (i_popup: EV_POPUP_WINDOW; x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
					do
						i_popup.destroy
					end (popup, ?, ?, ?, ?, ?, ?, ?, ?))

				if attached associated_widget as w and then attached parent_window_of (w) as win then
					popup.set_position (win.x_position + (win.width - popup.width) // 2, win.y_position + (win.height - popup.height) // 2)
					popup.show_relative_to_window (win)
				else
					popup.show
				end
			end
			if
				attached {STRING_32_PREFERENCE} preferences.misc_data.internet_browser_preference as pref and then
				attached pref.value as l_default_browser and then
				not l_default_browser.is_empty
			then
				is_launched := (create {URI_LAUNCHER}).launch_with_default_app (location, l_default_browser)
			else
				is_launched := (create {URI_LAUNCHER}).launch (location)
					-- This check is here because it lets us know if the preference wasn't initialized.
				check internet_browser_preference_set: False end
			end
			if is_launched then
				if popup /= Void then
					create t.make_with_interval (5_000) -- 5 seconds
					t.actions.extend (agent popup.destroy)
				elseif l_status_label /= Void then
					clear_label_after_delay (5_000, l_status_label, l_was_hidden) -- 5 seconds
				end
			else
				create m.make_from_string_general (cloud_names.label_error_opening_url (location))
				if l_status_label /= Void then
					if attached {EV_COLORIZABLE} l_status_label as l_col then
						l_col.set_foreground_color (colors.stock_colors.red)
					end
					l_status_label.set_text (m)
				elseif popup /= Void and lab /= Void then
					lab.set_text (m)
				end
			end
		end

	clear_label_after_delay (a_timeout_delay: INTEGER; lab: EV_TEXTABLE; a_hide: BOOLEAN)
		local
			t: EV_TIMEOUT
		do
			create t.make_with_interval (a_timeout_delay)
			t.actions.extend (agent lab.remove_text)
			if a_hide and attached {EV_WIDGET} lab as wid then
				t.actions.extend (agent wid.hide)
			end
			t.actions.extend (agent t.destroy)
		end

feature {NONE} -- Implementation

	parent_window_of (w: EV_WIDGET): detachable EV_WINDOW
		do
			if attached w.parent as p then
				if attached {EV_WINDOW} p as win then
					Result := win
				else
					Result := parent_window_of (p)
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
