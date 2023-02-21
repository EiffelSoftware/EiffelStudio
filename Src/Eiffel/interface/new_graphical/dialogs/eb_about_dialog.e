note
	description	: "About Dialog, displaying general information about EiffelStudio"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ABOUT_DIALOG

inherit
	EB_DIALOG

	SYSTEM_CONSTANTS
		undefine
			default_create, copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EV_STOCK_COLORS
		rename
			implementation as stock_colors_imp
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	SHARED_NOTIFICATION_SERVICE
		export
			{NONE} all
		undefine
			default_create, copy
		end

	SHARED_EIFFEL_EDITION
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature -- Initialization

	make
		local
			eiffel_image: EV_PIXMAP
			eiffel_image_box: EV_VERTICAL_BOX
			eiffel_text_box: EV_VERTICAL_BOX
			texts_box: EV_VERTICAL_BOX
			vbox: EV_VERTICAL_BOX
			button_box: EV_HORIZONTAL_BOX
			hbox: EV_HORIZONTAL_BOX
			version_label: EV_LABEL
			copyright_label: EV_LABEL
			registration_label: EV_TEXT
			info_label: EV_LABEL
			l_update_check_link, l_license_link: EV_HIGHLIGHT_LINK_LABEL
			hsep: EV_HORIZONTAL_SEPARATOR
			ok_button: EV_BUTTON
			white_cell: EV_CELL
			bg: EV_COLOR
		do
			default_create
			set_title (Interface_names.t_About)

			bg := Color_read_write

				-- Create controls.
			eiffel_image := Pixmaps.bm_About.twin
			eiffel_image.set_minimum_size (eiffel_image.width, eiffel_image.height)
			eiffel_image.set_background_color (bg)
			create eiffel_image_box
			eiffel_image_box.extend (eiffel_image)
			eiffel_image_box.disable_item_expand (eiffel_image)
			create white_cell
			white_cell.set_background_color (bg)
			eiffel_image_box.extend (white_cell)

			create info_label.make_with_text (t_info)
			info_label.align_text_left
			info_label.set_background_color (bg)
			create version_label.make_with_text (t_Version_info (False))
			version_label.align_text_left
			version_label.set_background_color (bg)

			if {ES_GRAPHIC}.is_standard_edition then
					-- Check for update ...
				create l_update_check_link.make_with_text ("Check for update (channel: " + preferences.misc_data.update_channel + ")")
				l_update_check_link.select_actions.extend (agent check_for_update (l_update_check_link))
			end

			create l_license_link.make_with_text (interface_names.l_read_license_text)
			l_license_link.select_actions.extend (agent do (create {EB_LICENSE_COMMAND}).execute end)

			create copyright_label.make_with_text (t_Copyright_info)
			copyright_label.align_text_left
			copyright_label.set_background_color (bg)
			create registration_label.make_with_text (registration_info)
			registration_label.set_background_color (bg)
			registration_label.disable_edit
			registration_label.set_minimum_height (100)
			create ok_button.make_with_text_and_action (Interface_names.b_Ok, agent destroy)
			Layout_constants.set_default_width_for_button (ok_button)

				-- Box with text.
			create eiffel_text_box
			eiffel_text_box.set_background_color (bg)
			eiffel_text_box.set_padding (Layout_constants.Default_padding_size)
			eiffel_text_box.extend (version_label)
			eiffel_text_box.disable_item_expand (version_label)
			if l_update_check_link /= Void then
				eiffel_text_box.extend (l_update_check_link)
				eiffel_text_box.disable_item_expand (l_update_check_link)
			end
			eiffel_text_box.extend (copyright_label)
			eiffel_text_box.disable_item_expand (copyright_label)

			eiffel_text_box.extend (info_label)
			eiffel_text_box.disable_item_expand (info_label)

			eiffel_text_box.extend (l_license_link)
			eiffel_text_box.disable_item_expand (l_license_link)
			l_license_link.align_text_left
			l_license_link.set_background_color (eiffel_text_box.background_color)

			eiffel_text_box.extend (registration_label)

				-- Texts box			
			create texts_box
			texts_box.set_background_color (bg)
			texts_box.extend (eiffel_text_box)

				-- Box with left image + text
			create hbox
			hbox.set_padding (Layout_constants.Default_padding_size)
			hbox.set_border_width (Layout_constants.Default_border_size)
			hbox.set_background_color (bg)
			hbox.extend (eiffel_image_box)
			hbox.disable_item_expand (eiffel_image_box)
			hbox.extend (texts_box)

				-- Box where the Ok button is
			create button_box
			button_box.set_border_width (Layout_constants.Default_border_size)
			button_box.extend (create {EV_CELL})
			button_box.extend (ok_button)
			button_box.disable_item_expand (ok_button)

				-- Box with everything in it.
			create vbox
			vbox.extend (hbox) -- Expandable item
			create hsep
			vbox.extend (hsep)
			vbox.disable_item_expand (hsep)
			vbox.extend (button_box)
			vbox.disable_item_expand (button_box)

			extend (vbox)
			set_default_push_button (ok_button)
			set_default_cancel_button (ok_button)

				-- Show hidden debug menu
			eiffel_image.pointer_button_release_actions.extend (agent (i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER; a_count: CELL [INTEGER])
					do
						if a_count.item = 1 then
							if not preferences.development_window_data.estudio_dbg_menu_enabled_preference.value then
								preferences.development_window_data.estudio_dbg_menu_enabled_preference.set_value (True)
							end
						else
							a_count.replace (a_count.item - 1)
						end
					end(?,?,?,?,?,?,?,?,create {CELL [INTEGER]}.put (10))
				)
		end

feature {NONE} -- Implementation

	check_for_update (a_link: EV_LINK_LABEL)
		local
			ch: ES_RELEASE_UPDATE_CHECKER
			l_pointer: like pointer_style
		do
			a_link.set_text ("Checking for update ...")
			a_link.refresh_now
			a_link.select_actions.pause
			l_pointer := pointer_style
			set_pointer_style (pixmaps.stock_pixmaps.busy_cursor)

			create ch.make (preferences.misc_data.update_channel, eiffel_layout.eiffel_platform, eiffel_layout.version_name)
			ch.check_for_update (agent (a_rel: detachable ES_UPDATE_RELEASE; i_lnk: EV_LINK_LABEL)
					local
						m: NOTIFICATION_MESSAGE_WITH_ACTIONS
					do
						if a_rel /= Void then
							if attached notification_s.service as s_notif then
								create m.make ({STRING_32} "Update is available: " + a_rel.filename, "version_check")
								m.register_action (agent (i_link: READABLE_STRING_GENERAL)
										local
											b: BOOLEAN
										do
											b := (create {ES_URI_LAUNCHER}).launch (i_link)
										end(a_rel.link)
									, "Try it now!")
								s_notif.notify (m)
							end
							i_lnk.set_text ("An update is available: " + a_rel.number)
							i_lnk.select_actions.wipe_out
							i_lnk.select_actions.extend (agent (i_url: READABLE_STRING_8)
								local
									b: BOOLEAN
								do
									b := (create {ES_URI_LAUNCHER}).launch (i_url)
								end(a_rel.link))
						else
							if attached notification_s.service as s_notif then
								s_notif.notify (create {NOTIFICATION_MESSAGE}.make ("The latest version is already installed.", "version_check"))
							end
							i_lnk.set_text ("Latest %"" + preferences.misc_data.update_channel + "%" version is installed")
						end
						i_lnk.select_actions.resume
					end(?, a_link)
				)

			if l_pointer /= Void then
				set_pointer_style (l_pointer)
			end
		end

	registration_info: STRING_32
			-- Clause in the about dialog concerning the license.
		local
			l_edition: READABLE_STRING_8
			l_eiffel_edition: like eiffel_edition
		do
			create Result.make (50)
			Result.append ("Installation information")
			l_eiffel_edition := eiffel_edition
			if l_eiffel_edition /= Void then
				l_edition := l_eiffel_edition.edition_name
			else
				l_edition := {ES_IDE_SETTINGS}.edition_title
			end
			if not l_edition.is_whitespace then
				Result.append (" (" + l_edition + ")")
			end
			Result.append (":%N")
			Result.append ({STRING_32} "Version = ")
			Result.append (t_version_info (True))
			Result.append_character ('%N')
			if l_eiffel_edition /= Void then
				if l_eiffel_edition.is_branded_edition and attached l_eiffel_edition.edition_title as l_title then
					Result.append ({STRING_32} "Edition: " + l_title)
					Result.append_character ('%N')
				end
				if attached l_eiffel_edition.edition_license_key as lic_key then
					Result.append ({STRING_32} "License key: " + lic_key)
					Result.append_character ('%N')
				end
				if attached l_eiffel_edition.edition_expiration as l_exp_date then
					Result.append ({STRING_32} "The license expires in " + l_eiffel_edition.number_of_remaining_days.out + " day(s) (" + date_time_local_representation (l_exp_date) + ").")
					Result.append_character ('%N')
				end
			end
			Result.append ("Monitor DPI = " + {EV_MONITOR_DPI_DETECTOR_IMP}.dpi.out + "%N")
			Result.append ("%N")
			Result.append (eiffel_layout.environment_info)
		end

feature {NONE} -- Implementation

	local_time (dt: DATE_TIME): DATE_TIME
		do
    		create Result.make_by_date_time (dt.date, dt.time)
			Result.add ((create {DATE_TIME}.make_now).relative_duration (create {DATE_TIME}.make_now_utc))
		end

	date_time_local_representation (dt: DATE_TIME): STRING
		do
			Result := local_time (dt).formatted_out ("yyyy-[0]mm-[0]dd [0]hh:[0]mi:[0]ss")
			Result.replace_substring_all (" ", "T")
		end

feature {NONE} -- Constant strings

	t_version_info (a_full: BOOLEAN): STRING_32
		once
			create Result.make (100)
			Result.append (Interface_names.t_Project)
			Result.append (" ")
			compiler_version_number.append_major (Result)
			Result.append (".")
			compiler_version_number.append_minor (Result)
			Result.append (" (")
			Result.append (Version_number)
			Result.append (")")
			if
				a_full and then
				Version_info /= Void and then not Version_info.is_empty
			then
				Result.append ("%N")
				Result.append (Version_info)
			end
		end

	t_Copyright_info: STRING
		local
			c_date: C_DATE
		once
			create c_date
			Result :=
				"Copyright (C) 1985-" + c_date.year_now.out + " Interactive Software Engineering Inc.%N%
				%All rights reserved"
		end

	t_info: STRING
		once
			create Result.make (500)
			Result.append ("[
					Eiffel Software
					5949 Hollister Ave., Goleta, CA 93117 USA
					Telephone: 805-685-1006
					Fax: 805-685-6869
				]")
			Result.append_character ('%N')
			Result.append_character ('%N')
			Result.append ("[
					Web Customer Support: https://support.eiffel.com
					Visit Eiffel on the Web: https://www.eiffel.com
				]")
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
