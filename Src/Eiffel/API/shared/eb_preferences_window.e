indexing
	description: "EiffelStudio preference window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCES_WINDOW

inherit
	PREFERENCES_GRID
		rename
			preferences as view_preferences
		redefine
			make,
			hide,
			on_close,
			preference_name_column,
			preference_value_column
		end

	EB_SHARED_PIXMAPS
		rename
			implementation as px_implementation
		undefine
			copy,
			default_create
		end

	EB_SHARED_PREFERENCES
		undefine
			copy,
			default_create
		end

create
	make, make_with_hidden

feature -- Access

	make (a_preferences: like view_preferences; a_parent_window: like parent_window) is
			-- New window.  Redefined to register EiffelStudio specific preference widgets for
			-- special preference types.
		do
			set_root_icon (icon_pixmaps.tool_preferences_icon)
			set_folder_icon (icon_pixmaps.folder_preference_icon)
			Precursor {PREFERENCES_GRID} (a_preferences, a_parent_window)
			set_icon_pixmap (icon_pixmaps.tool_preferences_icon)
			register_preference_widget (create {IDENTIFIED_FONT_PREFERENCE_WIDGET}.make)
			close_request_actions.extend (agent on_close)
		end

	preference_name_column (a_pref: PREFERENCE): EV_GRID_LABEL_ITEM is
			--
		local
			l_bp: BOOLEAN_PREFERENCE
			l_sp: STRING_PREFERENCE
			l_ip: INTEGER_PREFERENCE
			l_cp: COLOR_PREFERENCE
			l_lp: ARRAY_PREFERENCE
			l_fp: FONT_PREFERENCE
			l_ifp: IDENTIFIED_FONT_PREFERENCE
			l_scp: SHORTCUT_PREFERENCE
		do
			Result := Precursor {PREFERENCES_GRID}(a_pref)
			if Result /= Void then
				l_bp ?= a_pref
				if l_bp = Void then
					l_ip ?= a_pref
					if l_ip = Void then
						l_sp ?= a_pref
						if l_sp = Void then
							l_cp ?= a_pref
							if l_cp = Void then
								l_fp ?= a_pref
								if l_fp = Void then
									l_ifp ?= a_pref
									if l_ifp = Void then
										l_lp ?= a_pref
										if l_lp = Void then
											l_scp ?= a_pref
											if l_scp /= Void then
												Result.set_pixmap (icon_pixmaps.preference_shortcut_icon)
											else
												check False end
											end
										else
											Result.set_pixmap (icon_pixmaps.preference_list_icon)
										end
									else
										Result.set_pixmap (icon_pixmaps.preference_font_icon)
									end
								else
									Result.set_pixmap (icon_pixmaps.preference_font_icon)
								end
							else
								Result.set_pixmap (icon_pixmaps.preference_color_icon)
							end
						else
							Result.set_pixmap (icon_pixmaps.preference_string_icon)
						end
					else
						Result.set_pixmap (icon_pixmaps.preference_numerical_icon)
					end
				else
					Result.set_pixmap (icon_pixmaps.preference_boolean_icon)
				end
			end
		end


	preference_value_column (a_pref: PREFERENCE): EV_GRID_ITEM is
			--
		local
			l_id_font: IDENTIFIED_FONT_PREFERENCE
			l_font_widget: IDENTIFIED_FONT_PREFERENCE_WIDGET
		do
			l_id_font ?= a_pref
			if l_id_font /= Void then
				create l_font_widget.make_with_preference (l_id_font)
				l_font_widget.change_actions.extend (agent on_preference_changed)
				l_font_widget.set_caller (Current)
				Result := l_font_widget.change_item_widget
				Result.set_data (l_font_widget)
			else
				Result := Precursor {PREFERENCES_GRID} (a_pref)
			end
		end

	on_close is
			-- Window was closed
		do
			preferences.misc_data.preference_window_height_preference.set_value (height)
			preferences.misc_data.preference_window_width_preference.set_value (width)
			Precursor
		end

	hide is
			-- Window was closed through cancel button
		do
			preferences.misc_data.preference_window_height_preference.set_value (height)
			preferences.misc_data.preference_window_width_preference.set_value (width)
			Precursor
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class EB_PREFERENCES_WINDOW
