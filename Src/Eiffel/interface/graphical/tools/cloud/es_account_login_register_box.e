note
	description: "Summary description for {ES_ACCOUNT_LOGIN_REGISTER_BOX}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ACCOUNT_LOGIN_REGISTER_BOX

inherit
	EB_CONSTANTS

	EB_SHARED_PREFERENCES

	ES_SHARED_FONTS_AND_COLORS

	SHARED_ES_CLOUD_SERVICE

create
	make_community,
	make_enterprise,
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			w: EV_VERTICAL_BOX
		do
			create w
			widget := w

			create next_actions
			build_interface (w)
		end

	make_community
		do
			is_community_edition := True
			is_enterprise_edition := False
			make
		end

	make_enterprise
		do
			is_enterprise_edition := True
			is_community_edition := False
			make
		end

feature {NONE} -- Initialization

	build_interface (a_box: EV_VERTICAL_BOX)
		local
			l_main: EV_VERTICAL_BOX
			vb,vb_learn,vb_off,vb_terms: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			fr_login, fr_register, l_learn_more_box, fr_off: EV_FRAME
			box_login: like new_register_box
			box_register: like new_login_box
			txt: EVS_LABEL
			lnk: EVS_LINK_LABEL
			l_weblnk: EVS_HIGHLIGHT_LINK_LABEL
			l_field_width: INTEGER
			w: EV_WIDGET
			but: EV_BUTTON
			cbut: EV_CHECK_BUTTON
			s: STRING_32
		do
			create l_main
			a_box.extend (l_main)
			a_box.disable_item_expand (l_main)

			create vb
			vb.set_padding_width (layout_constants.default_padding_size)

			create vb_terms
			vb_terms.set_padding_width (layout_constants.default_padding_size)
			vb_terms.set_minimum_width (50)

			if is_community_edition then
				create txt
				s := "Please login, to use the EiffelStudio Community Edition."
			elseif is_enterprise_edition then
				create txt
				s := "To use additional online services, please login."
			end
			if s /= Void then
				s.append ("%NBy registering EiffelStudio you agree to the terms of use and the rules on user-provided information.")
				create txt
				txt.set_text (s)
				txt.set_is_text_wrapped (True); txt.align_text_left; txt.align_text_top
				vb.extend (txt)
			end

				-- learn more
			create l_learn_more_box
			create vb_learn
			vb_learn.set_padding_width (layout_constants.default_padding_size)
			vb_learn.set_border_width (layout_constants.default_border_size)
			create txt
			txt.set_text ("User information provided during the registration process is used solely for the purpose of creating a user account at //cloud.eiffel.com and enforcing the usage rules (number of concurrent sessions) according to the terms of the EiffelStudio license. Eiffel Software does not share such information with any third party.")
			txt.set_is_text_wrapped (True); txt.align_text_left; txt.align_text_top
			vb_learn.extend (txt)
			create l_weblnk.make_with_text ("Terms of use")
			l_weblnk.select_actions.extend (agent
				do
					open_url ("https://cloud.eiffel.com/site/terms")
				end)
			vb_learn.extend (l_weblnk)
			vb_learn.disable_item_expand (l_weblnk)

			l_learn_more_box.extend (vb_learn)
			l_learn_more_box.hide
			create lnk.make_with_text (interface_names.l_learn_more)
			lnk.align_text_left
			lnk.select_actions.extend (agent (i_learn_more_box: EV_WIDGET; i_lnk: EV_WIDGET)
				do
					i_learn_more_box.show
					i_lnk.hide
				end(l_learn_more_box, lnk))
			txt.pointer_double_press_actions.extend (agent (i_learn_more_box: EV_WIDGET; i_lnk: EV_WIDGET; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
					do
						i_learn_more_box.hide
						i_lnk.show
					end(l_learn_more_box, lnk,?,?,?,?,?,?,?,?)
				)
			vb_terms.extend (lnk)
			vb_terms.disable_item_expand (lnk)
			vb_terms.extend (l_learn_more_box)

				-- Main layout			
			l_main.extend (vb)
			l_main.disable_item_expand (vb)
--			l_main.extend (vb_terms)
--			l_main.disable_item_expand (vb_terms)
--			vb_terms.set_border_width (layout_constants.default_border_size)
			vb.extend (vb_terms)
			vb.disable_item_expand (vb_terms)


				-- Login vs Register					
			create fr_login.make_with_text (interface_names.l_login_with_credentials)
			create fr_register.make_with_text (interface_names.l_register_new_account)
			fr_login.hide
			fr_register.hide

			box_login := new_login_box
			fr_login.extend (box_login)

			box_register := new_register_box
			fr_register.extend (box_register)

			create lnk.make_with_text (interface_names.l_register_new_account)
			lnk.align_text_left
			lnk.select_actions.extend (agent (i_fr_login, i_fr_register: EV_WIDGET)
					do
						i_fr_login.hide
						i_fr_register.show
					end(fr_login, fr_register)
				)
			box_login.extend (lnk)
			box_login.disable_item_expand (lnk)

			create lnk.make_with_text (interface_names.l_login_with_existing_account)
			lnk.align_text_left
			lnk.select_actions.extend (agent (i_fr_login, i_fr_register: EV_WIDGET)
					do
						i_fr_register.hide
						i_fr_login.show
					end(fr_login, fr_register)
				)
			box_register.extend (lnk)
			box_register.disable_item_expand (lnk)

				-- Layout
			create hb
			hb.extend (fr_login); hb.disable_item_expand (fr_login)
			hb.extend (fr_register); hb.disable_item_expand (fr_register)
			hb.extend (create {EV_CELL})

			vb.extend (hb)
			vb.disable_item_expand (hb)

--			fr_register.show
			fr_login.show

			if attached es_cloud_s.service as cld then
				create lnk.make_with_text (interface_names.l_open_eiffelstudio_account_web_site)
				lnk.align_text_left
				lnk.select_actions.extend (agent open_url (cld.associated_website_url))
				vb.extend (lnk)
				vb.disable_item_expand (lnk)
			end


				-- Offline access token.
			if is_offline_allowed then
				create cbut.make_with_text ("Offline?")

				create fr_off.make_with_text ("Offline access")
				fr_off.set_minimum_height (fr_login.height)
				fr_login.set_minimum_height (fr_off.height)

				create vb_off
				vb_off.set_border_width (layout_constants.default_border_size)
				vb_off.set_padding_width (layout_constants.default_padding_size)

				cbut.select_actions.extend (agent (i_cb: EV_CHECK_BUTTON; i_login, i_off: EV_WIDGET)
						do
							if i_cb.is_selected then
								i_login.hide
								i_off.show
							else
								i_off.hide
								i_login.show
							end
						end(cbut, fr_login, fr_off)
					)

				create {EV_TEXT_FIELD} w
				w.set_minimum_width (l_field_width)
				append_label_and_item_horizontally ("Offline token", w, vb_off)
				vb_off.extend (create {EV_LABEL}.make_with_text ("You can get that token from the web site."))

				create but.make_with_text_and_action ("Submit", agent do end)
				layout_constants.set_default_width_for_button (but)
				append_label_and_item_horizontally ("", but, vb_off)

				fr_off.extend (vb_off)

				fr_off.hide
				vb.extend (fr_off)
				vb.disable_item_expand (fr_off)
				vb.extend (cbut)
				vb.disable_item_expand (cbut)
			end -- end of offline

			if not is_guest_logged_in and then attached remaining_allowed_guest_days as l_days and then l_days > 0 then
				create but.make_with_text_and_action (interface_names.b_guest, agent on_guest)
				layout_constants.set_default_width_for_button (but)
				append_label_and_item_horizontally (interface_names.l_can_login_as_guest_for_n_days (l_days), but, vb)
				debug
					if attached guest_mode_loging_count as nb and then nb > 0 then
						append_label_and_item_horizontally ("(" + nb.out + ")", create {EV_CELL}, vb)
					end
				end
			end
			a_box.set_background_color (colors.stock_colors.white)
			a_box.propagate_background_color
		end

	new_login_box: EV_VERTICAL_BOX
		local
			vb_login: EV_VERTICAL_BOX
			lab: EV_LABEL
			lnk: EVS_LINK_LABEL
			l_field_width: INTEGER
			w: EV_WIDGET
			tf_password: EV_PASSWORD_FIELD
			tf_username: EV_TEXT_FIELD
			but: EV_BUTTON
			l_focus: detachable EV_WIDGET
			l_scaler: EVS_DPI_SCALER
		do
			create l_scaler.make
			l_field_width := l_scaler.scaled_size (300)

			create Result
			Result.set_border_width (layout_constants.default_border_size)
			Result.set_padding_width (layout_constants.default_padding_size)
			create tf_username
			create tf_password
			w := tf_username
			w.set_minimum_width (l_field_width)
			append_label_and_item_horizontally (interface_names.l_user_name, w, Result)
			l_focus := w
			w := tf_password
			w.set_minimum_width (l_field_width)
			append_label_and_item_horizontally (interface_names.l_password, w, Result)

			create but.make_with_text_and_action (interface_names.b_login, agent process_account_loging (new_gui_form (<<["user_name", tf_username], ["password", tf_password]>>)))

			layout_constants.set_default_width_for_button (but)
			append_label_and_item_horizontally ("", but, Result)

			create lab.make_with_text ("note: you can use https://support.eiffel.com/ account.")
			lab.set_foreground_color (colors.stock_colors.dark_grey)
			lab.set_font (fonts.italic_label_font)
			lab.align_text_right
			Result.extend (lab)
			Result.disable_item_expand (lab)

			tf_username.return_actions.extend (agent tf_password.set_focus)
			tf_password.return_actions.extend (agent (i_but: EV_BUTTON) do i_but.select_actions.call (Void) end(but))
		end

	new_register_box: EV_VERTICAL_BOX
		local
			lnk: EVS_LINK_LABEL
			l_field_width: INTEGER
			w: EV_WIDGET
			tf_password: EV_PASSWORD_FIELD
			tf_username, tf_email, tf_firstname, tf_lastname: EV_TEXT_FIELD
			but: EV_BUTTON
			l_scaler: EVS_DPI_SCALER
		do
			create l_scaler.make
			l_field_width := l_scaler.scaled_size (300)

			create Result
			Result.set_border_width (layout_constants.default_border_size)
			Result.set_padding_width (layout_constants.default_padding_size)
			create tf_username
			create tf_password
			create tf_firstname
			create tf_lastname
			create tf_email
			w := tf_username
			w.set_minimum_width (l_field_width)
			append_label_and_item_horizontally (interface_names.l_user_name, w, Result)
			w := tf_password
			w.set_minimum_width (l_field_width)
			append_label_and_item_horizontally (interface_names.l_password, w, Result)

			w := tf_firstname
			w.set_minimum_width (l_field_width)
			append_label_and_item_horizontally (interface_names.l_first_name, w, Result)
			w := tf_lastname
			w.set_minimum_width (l_field_width)
			append_label_and_item_horizontally (interface_names.l_last_name, w, Result)

			w := tf_email
			w.set_minimum_width (l_field_width)
			append_label_and_item_horizontally (interface_names.l_email, w, Result)
			create but.make_with_text_and_action (interface_names.b_register, agent process_account_registration (new_gui_form (<<
						["user_name", tf_username],
						["password", tf_password],
						["first_name", tf_firstname],
						["last_name", tf_lastname],
						["email", tf_email]
					>>)))
			layout_constants.set_default_width_for_button (but)
			append_label_and_item_horizontally ("", but, Result)

			tf_username.return_actions.extend (agent tf_password.set_focus)
			tf_password.return_actions.extend (agent (i_but: EV_BUTTON) do i_but.select_actions.call (Void) end(but))
		end

feature -- Status report

	is_community_edition: BOOLEAN
			-- Is Current EiffelStudio the community edition?

	is_enterprise_edition: BOOLEAN
			-- Is Current EiffelStudio the enterprise edition?

	is_offline_allowed: BOOLEAN
		do
			Result := not is_community_edition and False  -- FIXME: for now, let's disable offline access.
		end

	is_guest_logged_in: BOOLEAN
		do
			if attached es_cloud_s.service as cld then
				Result := cld.is_guest
			else
				check es_cloud_service_available: False end
			end
		end

	remaining_allowed_guest_days: INTEGER
		do
			if attached es_cloud_s.service as cld then
				Result := cld.remaining_days_for_guest
			else
				check es_cloud_service_available: False end
			end
		end

	guest_mode_loging_count: INTEGER
		do
			if attached es_cloud_s.service as cld then
				Result := cld.guest_mode_loging_count
			else
				check es_cloud_service_available: False end
			end
		end

feature -- Conversion

	widget: EV_VERTICAL_BOX

feature -- Next actions

	next_actions: ACTION_SEQUENCE [TUPLE]

	on_next
		do
			next_actions.call
		end

feature -- UI callbacks

	on_user_logged_in (acc: ES_ACCOUNT)
		require
			acc: attached es_cloud_s.service as cld and then
				acc.same_as (cld.active_account) and then
				not acc.is_expired
		do
			on_next
		end

	on_guest
		do
			if attached es_cloud_s.service as cld then
				cld.login_as_guest
			end
			on_next
		end

	process_account_loging (a_form: like new_gui_form)
		local
			l_style: detachable EV_POINTER_STYLE
		do
			if
				attached gui_form_string_item ("user_name", a_form) as u and then
				attached gui_form_string_item ("password", a_form) as p
			then
				l_style := widget.pointer_style
				widget.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)
				if
					attached es_cloud_s.service as cld and then
					cld.is_available
				then
					cld.login_with_credential (u, p)
					if attached cld.active_account as acc then
						on_user_logged_in (acc)
					else
						on_user_loging_error (a_form)
					end
				else
					on_system_error ("Account service is not available for now (try again later)!")
				end
				widget.set_pointer_style (l_style)
			else
				check valid_form: True end
			end
		end

	on_system_error (msg: READABLE_STRING_GENERAL)
		do
			popup_message (msg)
		end

	process_account_registration (a_form: like new_gui_form)
		local
			l_style: detachable EV_POINTER_STYLE
			tb: STRING_TABLE [READABLE_STRING_GENERAL]
		do
			if
				attached gui_form_string_item ("user_name", a_form) as u and then
				attached gui_form_string_item ("password", a_form) as p and then
				attached gui_form_string_item ("email", a_form) as l_email
			then
				create tb.make (0)
				across
					a_form as ic
				loop
					tb.force (ic.item.text, ic.key)
				end
				l_style := widget.pointer_style
				widget.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)

				if
					attached es_cloud_s.service as cld and then
					cld.is_available
				then
					if l_email.is_valid_as_string_8 then
						cld.register_account (u, p, l_email.to_string_8, tb)
					end
					if attached cld.active_account as acc then
						on_user_registered (acc)
					else
						on_user_registration_error (a_form)
					end
				else
					on_system_error ("Account service is not available for now (try again later)!")
				end
				widget.set_pointer_style (l_style)
			else
				check valid_form: True end
			end
		end

	on_user_loging_error (a_form: like new_gui_form)
		do
			popup_message ("Error while loging ...")
		end

	on_user_registered (acc: ES_ACCOUNT)
		do
			popup_message ("Thank you for the registration ...")
		end

	on_user_registration_error (a_form: like new_gui_form)
		do
			popup_message ("Error while registrating ...")
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

	new_gui_form (arr: ITERABLE [TUPLE [name: READABLE_STRING_GENERAL; text: EV_TEXTABLE]]): STRING_TABLE [EV_TEXTABLE]
		do
			create Result.make_caseless (1)
			across
				arr as ic
			loop
				Result.force (ic.item.text, ic.item.name)
			end
		end

	gui_form_string_item (a_name: READABLE_STRING_GENERAL; a_form: like new_gui_form): detachable READABLE_STRING_32
		do
			if attached a_form.item (a_name) as t then
				Result := t.text
			end
		end

	append_label_and_item_horizontally (a_label_text: READABLE_STRING_GENERAL; a_item: EV_WIDGET; a_container: EV_VERTICAL_BOX)
		local
			hb: EV_HORIZONTAL_BOX
			lab: EV_LABEL
		do
			create hb
			hb.set_padding_width (layout_constants.default_padding_size)
			a_container.extend (hb)
			a_container.disable_item_expand (hb)

			create lab.make_with_text (a_label_text)
			lab.align_text_right
			hb.extend (lab)
--			hb.disable_item_expand (lab)
			hb.extend (a_item)
			hb.disable_item_expand (a_item)
		end

	popup_message (msg: READABLE_STRING_GENERAL)
		local
			popup: EV_POPUP_WINDOW
			lab: EV_LABEL
		do
			create popup.make_with_shadow
			create lab.make_with_text (msg)
			popup.extend (lab)
			popup.set_size (200, 50)
			if attached parent_window_of (widget) as win then
				popup.set_position (win.x_position + (win.width - popup.width) // 2, win.y_position + (win.height - popup.height) // 2)
				lab.pointer_button_release_actions.extend (agent (i_popup: EV_POPUP_WINDOW; x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
					do
						i_popup.destroy
					end (popup, ?, ?, ?, ?, ?, ?, ?, ?))
				popup.show_relative_to_window (win)
			else
				popup.show
			end
		end

	open_url (a_url: READABLE_STRING_8)
		local
			popup: EV_POPUP_WINDOW
			t: EV_TIMEOUT
			lab: EV_LABEL
			is_launched: BOOLEAN
		do

			create popup.make_with_shadow
			create lab.make_with_text ("Open link " + a_url)
			popup.extend (lab)
			popup.set_size (200, 50)
			lab.pointer_button_release_actions.extend (agent (i_popup: EV_POPUP_WINDOW; x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER)
				do
					i_popup.destroy
				end (popup, ?, ?, ?, ?, ?, ?, ?, ?))

			if attached parent_window_of (widget) as win then
				popup.set_position (win.x_position + (win.width - popup.width) // 2, win.y_position + (win.height - popup.height) // 2)
				popup.show_relative_to_window (win)
			else
				popup.show
			end

			if
				attached {STRING_32_PREFERENCE} preferences.misc_data.internet_browser_preference as pref and then
				attached pref.value as l_default_browser and then
				not l_default_browser.is_empty
			then
				is_launched := (create {URI_LAUNCHER}).launch_with_default_app (a_url, l_default_browser)
			else
				is_launched := (create {URI_LAUNCHER}).launch (a_url)
					-- This check is here because it lets us know if the preference wasn't initialized.
				check internet_browser_preference_set: False end
			end
			if is_launched then
				create t.make_with_interval (5_000) -- 5 seconds
				t.actions.extend (agent popup.destroy)
			end
		end


;note
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
