note
	description: "Helper class to popropate color into widgets"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_COLOR_PROPAGATOR

feature -- Query

	is_widget_applicable_for_color_propagation (a_widget: attached EV_COLORIZABLE; a_fg: BOOLEAN; a_bg: BOOLEAN): BOOLEAN
			-- Determines if a widget is applicable for propagation of either a foreground or background color.
			--
			-- `a_widget': The widget to determine if the applicable colors can be propagated.
			-- `a_fg': True if a request is being made to change the foreground color; False otherwise.
			-- `a_bg': True if a request is being made to change the background color; False otherwise.
		require
			a_fg_a_gb_exclusive: (a_fg and not a_bg) or (a_bg and not a_fg)
		do
			if a_fg then
				Result := True
			elseif a_bg then
				Result := attached {EV_CELL} a_widget as l_cell or
					attached {EV_CHECK_BUTTON} a_widget as l_check or
					attached {EV_RADIO_BUTTON} a_widget as l_rbutton or
					attached {EV_LABEL} a_widget as l_label or
					attached {EV_HORIZONTAL_BOX} a_widget as l_hbox or
					attached {EV_VERTICAL_BOX} a_widget as l_vbox or
					attached {EV_DRAWABLE} a_widget as l_drawable or
					attached {EV_SEPARATOR} a_widget as l_separator
			end
		end

feature -- Query

	propagate_colors (a_start_widget: EV_WIDGET; a_fg_color: EV_COLOR; a_bg_color: EV_COLOR; a_excluded: ARRAY [EV_WIDGET])
			-- Propagates setting of foreground and background colors to applicable widgets. The propagation respects the type of
			-- widget and will only perform setting of background colors on "transparent" style widgets.
			--
			-- `a_start_widget': The starting widget to apply an action, as well as to all it's children widgets.
			-- `a_fg_color': A foreground color. Can be Void to skip setting of a foreground color.
			-- `a_bg_color': A background color. Can be Void to skip setting of a background color.
			-- `a_excluded': An array of widgets to exluding the the propagation of colors, or Void to include all applicable widgets (see is applicable color widget)
		require
			a_start_widget_attached: a_start_widget /= Void
			not_a_start_widget_is_destroyed: not a_start_widget.is_destroyed
			color_change: a_fg_color /= Void or a_bg_color /= Void
		local
			l_cursor: CURSOR
			l_propagate: BOOLEAN
		do
			if a_excluded = Void or else not a_excluded.has (a_start_widget) then
				if attached {EV_COLORIZABLE} a_start_widget as l_colorizable then
					if a_fg_color /= Void and then is_widget_applicable_for_color_propagation (l_colorizable, True, False) then
						l_colorizable.set_foreground_color (a_fg_color)
						l_propagate := True
					end
					if a_bg_color /= Void and then is_widget_applicable_for_color_propagation (l_colorizable, False, True) then
						l_colorizable.set_background_color (a_bg_color)
						l_propagate := True
					end
				end
			end

			if l_propagate and then attached {EV_WIDGET_LIST} a_start_widget as l_list then
				l_cursor := l_list.cursor
				from l_list.start until l_list.after loop
					if attached l_list.item as l_widget and then not l_widget.is_destroyed then
						propagate_colors (l_widget, a_fg_color, a_bg_color, a_excluded)
					end
					l_list.forth
				end
				l_list.go_to (l_cursor)
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
