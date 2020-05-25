note
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ACCOUNT_LOGIN_REGISTER_BOX

inherit
	EB_CONSTANTS

	EB_SHARED_PREFERENCES

	ES_SHARED_FONTS_AND_COLORS

	SHARED_ES_CLOUD_SERVICE

	SHARED_ES_CLOUD_NAMES

create
	make_cloud_required,
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Initialization

	make (cld: ES_CLOUD_S)
			-- Initialize `Current'.
		local
			w: EV_VERTICAL_BOX
		do
			cloud_service := cld
			create w
			widget := w

			create next_actions
			build_interface (w)
		end

	make_cloud_required (cld: ES_CLOUD_S)
		do
			is_cloud_required := True
			make (cld)
		end

feature -- Access

	cloud_service: ES_CLOUD_S
			-- Eiffel Cloud service.

feature {NONE} -- Initialization

	build_interface (a_box: EV_VERTICAL_BOX)
		local
			l_main: EV_VERTICAL_BOX
			vb,vb_learn,vb_terms: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			l_learn_more_box: EV_FRAME
			txt: EVS_LABEL
			lnk: EVS_LINK_LABEL
			l_weblnk: EVS_HIGHLIGHT_LINK_LABEL
			but: EV_BUTTON
			cbut: EV_CHECK_BUTTON
			s: STRING_32
			frame: EV_FRAME
		do
			create l_main
			a_box.extend (l_main)
			a_box.disable_item_expand (l_main)

			create vb
			vb.set_padding_width (layout_constants.default_padding_size)

			create vb_terms
			vb_terms.set_padding_width (layout_constants.default_padding_size)
			vb_terms.set_minimum_width (50)

			s :=
				if is_cloud_required then
					cloud_names.prompt_sign_to_edition_cloud_services ({ES_IDE_SETTINGS}.edition_title)
				else
					cloud_names.prompt_sign_to_cloud_services
				end
			s.append_character ('%N')
			s.append (cloud_names.prompt_registering_and_agree_terms_of_use_and_rules)
			create txt
			txt.set_text (s)
			txt.set_is_text_wrapped (True); txt.align_text_left; txt.align_text_top
			vb.extend (txt)

				-- learn more
			create l_learn_more_box
			create vb_learn
			vb_learn.set_padding_width (layout_constants.default_padding_size)
			vb_learn.set_border_width (layout_constants.default_border_size)
			create txt
			txt.set_text (cloud_names.prompt_learn_more_about_data_collection (cloud_service.associated_website_url))
			txt.set_tooltip (cloud_names.label_double_click_to_collapse)
			txt.set_is_text_wrapped (True); txt.align_text_left; txt.align_text_top
			vb_learn.extend (txt)
			create l_weblnk.make_with_text (cloud_names.label_terms_of_use)
			l_weblnk.select_actions.extend (agent open_url (cloud_service.associated_website_url + "/site/terms", Void))
			vb_learn.extend (l_weblnk)
			vb_learn.disable_item_expand (l_weblnk)

			l_learn_more_box.extend (vb_learn)
			l_learn_more_box.hide
			create lnk.make_with_text (cloud_names.label_learn_more)
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
			vb.extend (vb_terms)
			vb.disable_item_expand (vb_terms)


				-- Main frame to hold sign, ... widgets
			create frame

				-- Layout
			create hb
			hb.extend (frame); hb.disable_item_expand (frame)
			hb.extend (create {EV_CELL})

			vb.extend (hb)
			vb.disable_item_expand (hb)

			if attached es_cloud_s.service as cld then
				create lnk.make_with_text (cloud_names.label_open_eiffelstudio_account_web_site)
				lnk.align_text_left
				lnk.select_actions.extend (agent open_account_url (cld, Void))
				vb.extend (lnk)
				vb.disable_item_expand (lnk)
			end

				-- Offline access token.
			if is_offline_allowed then
				create cbut.make_with_text (locale.translation_in_context ("Offline?", "cloud.auth"))
				cbut.select_actions.extend (agent (i_cb: EV_CHECK_BUTTON; fr: EV_FRAME)
						do
							if i_cb.is_selected then
								set_offline_mode (fr)
							else
								set_sign_in_mode (fr)
							end
						end(cbut, frame)
					)

				vb.extend (cbut)
				vb.disable_item_expand (cbut)
			end -- end of offline

			if not is_guest_signed_in and then attached remaining_allowed_guest_days as l_days and then l_days > 0 then
				create but.make_with_text_and_action (cloud_names.button_guest, agent on_guest)
				layout_constants.set_default_width_for_button (but)
				append_label_and_item_horizontally (cloud_names.label_can_continue_as_guest_for_n_days (l_days), but, vb)
				debug
					if attached guest_mode_sign_in_count as nb and then nb > 0 then
						append_label_and_item_horizontally ("(" + nb.out + ")", create {EV_CELL}, vb)
					end
				end
			end
			a_box.set_background_color (colors.stock_colors.white)
			a_box.propagate_background_color

			set_sign_in_mode (frame)
		end

	set_sign_in_mode (fr: EV_FRAME)
		local
			b: like new_sign_box
			lnk: EVS_HIGHLIGHT_LINK_LABEL
			hb: EV_HORIZONTAL_BOX
			lab: EV_LABEL
		do
			fr.remove_text

			b := new_sign_box
			create hb

			create lab.make_with_text (cloud_names.label_no_account_text)
			hb.extend (lab)
			hb.disable_item_expand (lab)
			create lab.make_with_text (" ")
			hb.extend (lab)
			hb.disable_item_expand (lab)

			b.extend (hb)
			b.disable_item_expand (hb)

			create lab
			lab.hide
			b.extend (lab)
			b.disable_item_expand (lab)

			create lnk.make_with_text (cloud_names.label_create_new_account)
			lnk.align_text_left
			lnk.select_actions.extend (agent open_url (cloud_service.new_account_website_url, lab))
--			lnk.select_actions.extend (agent set_register_mode (fr))
			hb.extend (lnk)
			hb.disable_item_expand (lnk)



			fr.wipe_out
			fr.extend (b)
			b.show
			fr.propagate_background_color
		end

	set_offline_mode (fr: EV_FRAME)
		local
			vb_off: EV_VERTICAL_BOX
			w: EV_TEXT_FIELD
			but: EV_BUTTON
			l_field_width: INTEGER
			l_scaler: EVS_DPI_SCALER
		do
			create l_scaler.make
			l_field_width := l_scaler.scaled_size (300)
			fr.wipe_out
			fr.set_text ("Offline access")

			create vb_off
			vb_off.set_border_width (layout_constants.default_border_size)
			vb_off.set_padding_width (layout_constants.default_padding_size)


			create {EV_TEXT_FIELD} w
			w.set_minimum_width (l_field_width)
			append_label_and_item_horizontally (locale.translation_in_context ("Offline token", "cloud.auth"), w, vb_off)
			vb_off.extend (create {EV_LABEL}.make_with_text (locale.translation_in_context ("You can get that token from the web site.", "cloud.auth")))

			create but.make_with_text_and_action (cloud_names.button_submit, agent do end)
			layout_constants.set_default_width_for_button (but)
			append_label_and_item_horizontally ("", but, vb_off)

			fr.extend (vb_off)
			fr.propagate_background_color
		end

	set_register_mode (fr: EV_FRAME)
		local
			b: like new_register_link_box
			lnk: EVS_HIGHLIGHT_LINK_LABEL
		do
			fr.remove_text
			b := new_register_link_box
			create lnk.make_with_text (cloud_names.label_sign_in_with_existing_account)
			lnk.align_text_left
			lnk.select_actions.extend (agent set_sign_in_mode (fr))
			b.extend (lnk)
			b.disable_item_expand (lnk)
			fr.wipe_out
			fr.extend (b)
			b.show
			fr.propagate_background_color
		end

	new_sign_box: EV_VERTICAL_BOX
		local
			lab: EV_LABEL
			l_field_width: INTEGER
			w: EV_WIDGET
			tf_password: EV_PASSWORD_FIELD
			tf_username: EV_TEXT_FIELD
			but: EV_BUTTON
			cb: EV_CHECK_BUTTON
			l_focus: detachable EV_WIDGET
			l_scaler: EVS_DPI_SCALER
			l_kept_credential: detachable TUPLE [username, password: READABLE_STRING_32]
		do
			create l_scaler.make
			l_field_width := l_scaler.scaled_size (300)

			if attached es_cloud_s.service as cld then
				l_kept_credential := cld.kept_credential
			end

			create Result
			Result.set_border_width (layout_constants.default_border_size)
			Result.set_padding_width (layout_constants.default_padding_size)
			create tf_username
			username_input := tf_username
			create tf_password
			password_input := tf_password
			w := tf_username
			w.set_minimum_width (l_field_width)
			append_label_and_item_horizontally (cloud_names.label_user_name, w, Result)
			l_focus := w
			w := tf_password
			w.set_minimum_width (l_field_width)
			append_label_and_item_horizontally (cloud_names.label_password, w, Result)

			create lab
			lab.hide
			Result.extend (lab)
			Result.disable_item_expand (lab)

			create cb.make_with_text (cloud_names.button_remember_credentials)
			cb.set_tooltip (cloud_names.tooltip_do_not_use_on_public_machine)
			layout_constants.set_default_width_for_button (cb)
			create but.make_with_text_and_action (
					cloud_names.button_sign_in,
					agent process_account_sign_in (new_gui_form ({ARRAY [TUPLE [name: READABLE_STRING_GENERAL; widget: EV_ANY]]} <<
								["user_name", tf_username], ["password", tf_password], ["remember", cb]
							>>), lab)
				)
			layout_constants.set_default_width_for_button (but)
			append_label_and_item_horizontally ("", but, Result)
			append_label_and_item_horizontally ("", cb, Result)


			create lab.make_with_text (cloud_names.prompt_note_support_account_usage)
			lab.set_foreground_color (colors.stock_colors.dark_grey)
			lab.set_font (fonts.italic_label_font)
			lab.align_text_left
			Result.extend (lab)
			Result.disable_item_expand (lab)

			tf_username.return_actions.extend (agent tf_password.set_focus)
			tf_password.return_actions.extend (agent (i_but: EV_BUTTON) do i_but.select_actions.call (Void) end(but))

			if l_kept_credential /= Void then
				cb.enable_select
				tf_username.set_text (l_kept_credential.username)
				tf_password.set_text (l_kept_credential.password)
			elseif attached username as u then
				tf_username.set_text (u)
				if attached password as p then
					tf_password.set_text (p)
				end
			end
		end

	new_register_form_box: EV_VERTICAL_BOX
		local
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
			append_label_and_item_horizontally (cloud_names.label_user_name, w, Result)
			w := tf_password
			w.set_minimum_width (l_field_width)
			append_label_and_item_horizontally (cloud_names.label_password, w, Result)

			w := tf_firstname
			w.set_minimum_width (l_field_width)
			append_label_and_item_horizontally (cloud_names.label_first_name, w, Result)
			w := tf_lastname
			w.set_minimum_width (l_field_width)
			append_label_and_item_horizontally (cloud_names.label_last_name, w, Result)

			w := tf_email
			w.set_minimum_width (l_field_width)
			append_label_and_item_horizontally (cloud_names.label_email, w, Result)
			create but.make_with_text_and_action (cloud_names.button_register, agent process_account_registration (new_gui_form (<<
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

	new_register_link_box: EV_VERTICAL_BOX
		local
			l_field_width: INTEGER
--			but: EV_BUTTON
			l_scaler: EVS_DPI_SCALER
			l_weblnk: EVS_HIGHLIGHT_LINK_LABEL
			lab: EV_LABEL
		do
			create l_scaler.make
			l_field_width := l_scaler.scaled_size (300)

			create Result
			Result.set_border_width (layout_constants.default_border_size)
			Result.set_padding_width (layout_constants.default_padding_size)
			create l_weblnk.make_with_text (cloud_names.link_create_new_account)
			l_weblnk.set_minimum_width (l_field_width)
			Result.extend (l_weblnk)
			Result.disable_item_expand (l_weblnk)

			create lab
			Result.extend (lab)
			Result.disable_item_expand (lab)

			l_weblnk.select_actions.extend (agent open_url (cloud_service.new_account_website_url, lab))

		end

feature -- Status report

	is_cloud_required: BOOLEAN
			-- Is cloud required?

	is_community_edition: BOOLEAN
			-- Is Current EiffelStudio the community edition?

	is_enterprise_edition: BOOLEAN
			-- Is Current EiffelStudio the enterprise edition?

	is_offline_allowed: BOOLEAN
		do
			Result := False  -- FIXME: for now, let's disable offline access.
		end

	is_guest_signed_in: BOOLEAN
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

	guest_mode_sign_in_count: INTEGER
		do
			if attached es_cloud_s.service as cld then
				Result := cld.guest_mode_signed_in_count
			else
				check es_cloud_service_available: False end
			end
		end

feature -- Optional properties

	username_input: detachable EV_TEXT_FIELD

	password_input: detachable EV_TEXT_FIELD

	username: detachable IMMUTABLE_STRING_32

	password: detachable IMMUTABLE_STRING_32

feature -- Optional element change

	set_username (a_username: detachable READABLE_STRING_GENERAL)
		do
			if a_username = Void then
				username := Void
				if attached username_input as tf then
					tf.remove_text
				end
			else
				create username.make_from_string_general (a_username)
				if attached username_input as tf then
					tf.set_text (username)
				end
			end
		end

	set_password (a_pwd: detachable READABLE_STRING_GENERAL)
		do
			if a_pwd = Void then
				password := Void
				if attached password_input as tf then
					tf.remove_text
				end
			else
				create password.make_from_string_general (a_pwd)
				if attached password_input as tf then
					tf.set_text (password)
				end
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

	on_user_signed_in (acc: ES_ACCOUNT)
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
				cld.continue_as_guest
			end
			on_next
		end

	process_account_sign_in (a_form: like new_gui_form; a_report_label: detachable EV_LABEL)
		local
			l_style: detachable EV_POINTER_STYLE
			s32: STRING_32
		do
			if a_report_label /= Void then
				a_report_label.remove_text
				a_report_label.hide
			end
			if
				attached gui_form_string_item ("user_name", a_form) as u and then
				attached gui_form_string_item ("password", a_form) as p
			then
				l_style := widget.pointer_style
				widget.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)
				if attached es_cloud_s.service as cld then
					if cld.is_available	then
						cld.sign_in_with_credential (u, p)
						if cld.has_error then
							create s32.make_from_string_general (locale.translation_in_context ("Service error (try again later)!", "cloud.error"))
							if attached cld.last_error_message as err then
								s32.append_character ('%N')
								s32.append (err)
							end
							s32.append_character ('%N')
							on_system_error (s32, a_report_label)
						elseif attached cld.active_account as acc then
							if gui_form_boolean_item ("remember", a_form) then
								cld.keep_credential (u, p)
							end
							if attached cld.installation as inst then
								if inst.is_active then
									on_user_signed_in (acc)
								else
									on_user_expired_plan_error (a_form, a_report_label)
								end
							else
								on_user_expired_plan_error (a_form, a_report_label)
							end
						elseif cld.is_guest then
								-- Continue
							on_guest
						else
							on_user_sign_in_refused (a_form, a_report_label)
						end
					else
						on_cloud_service_not_available (cld.last_error_message, a_report_label)
						cld.check_cloud_availability
					end
				else
					on_system_error (locale.translation_in_context ("Cloud service not activated!", "cloud.error"), a_report_label)
				end
				widget.set_pointer_style (l_style)
			else
				check valid_form: True end
			end
		end

	on_system_error (msg: READABLE_STRING_GENERAL; a_report_label: detachable EV_LABEL)
		do
			if a_report_label /= Void then
				a_report_label.set_foreground_color (colors.stock_colors.red)
				a_report_label.set_text (msg)
--				clear_label_after_delay (5_000, a_report_label, not a_report_label.is_displayed ) -- 5 seconds
				if not a_report_label.is_displayed then
					a_report_label.show
				end
			else
				popup_message (msg, True)
			end
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
					if attached {EV_TEXTABLE} ic.item as tt then
						tb.force (tt.text, ic.key)
					end
				end
				l_style := widget.pointer_style
				widget.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)

				if attached es_cloud_s.service as cld then
					if cld.is_available	then
						if l_email.is_valid_as_string_8 then
							cld.register_account (u, p, l_email.to_string_8, tb)
						end
						if attached cld.active_account as acc then
							on_user_registered (acc, Void)
						else
							on_user_registration_error (a_form, Void)
						end
					else
						on_cloud_service_not_available (cld.last_error_message, Void)
					end
				else
					on_cloud_service_not_activated_error (Void)
				end
				widget.set_pointer_style (l_style)
			else
				check valid_form: True end
			end
		end

	on_user_expired_plan_error (a_form: like new_gui_form; a_report_label: detachable EV_LABEL)
		do
			on_system_error (locale.translation_in_context ("Your plan is expired, please renew or purchase a new one.", "cloud.error"), a_report_label)
		end

	on_user_sign_in_refused (a_form: like new_gui_form; a_report_label: detachable EV_LABEL)
		do
			on_system_error (locale.translation_in_context ("Error: invalid username or password!", "cloud.error"), a_report_label)
		end

	on_user_registered (acc: ES_ACCOUNT; a_report_label: detachable EV_LABEL)
		do
			on_system_error (locale.translation_in_context ("Thank you for the registration", "cloud.message"), a_report_label)
		end

	on_user_registration_error (a_form: like new_gui_form; a_report_label: detachable EV_LABEL)
		do
			on_system_error (locale.translation_in_context ("Error while registering", "cloud.error"), a_report_label)
		end

	on_cloud_service_not_available (a_msg: detachable READABLE_STRING_GENERAL; a_report_label: detachable EV_LABEL)
		local
			s: STRING_32
		do
			create s.make_from_string (locale.translation_in_context ("Account service is not available for now (try again later)!", "cloud.error"))
			if a_msg /= Void then
				s.append_character ('%N')
				s.append (a_msg)
			end
			on_system_error (s, a_report_label)
		end

	on_cloud_service_not_activated_error (a_report_label: detachable EV_LABEL)
		do
			on_system_error (locale.translation_in_context ("Cloud service not activated!", "cloud.error"), a_report_label)
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

	new_gui_form (arr: ITERABLE [TUPLE [name: READABLE_STRING_GENERAL; widget: EV_ANY]]): STRING_TABLE [EV_ANY]
		do
			create Result.make_caseless (1)
			across
				arr as ic
			loop
				Result.force (ic.item.widget, ic.item.name)
			end
		end

	gui_form_string_item (a_name: READABLE_STRING_GENERAL; a_form: like new_gui_form): detachable READABLE_STRING_32
		do
			if attached {EV_TEXTABLE} a_form.item (a_name) as t then
				Result := t.text
			end
		end

	gui_form_boolean_item (a_name: READABLE_STRING_GENERAL; a_form: like new_gui_form): BOOLEAN
		do
			if attached {EV_CHECK_BUTTON} a_form.item (a_name) as cb then
				Result := cb.is_selected
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

	popup_message (msg: READABLE_STRING_GENERAL; a_is_error: BOOLEAN)
		local
			popup: EV_POPUP_WINDOW
			lab: EV_LABEL
			l_scaler: EVS_DPI_SCALER
		do
			create l_scaler.make
			create popup.make_with_shadow
			create lab.make_with_text (msg)
			lab.set_minimum_height (3 * lab.font.height)
			lab.align_text_vertical_center
			if a_is_error then
				lab.set_foreground_color (colors.stock_colors.red)
			end
			popup.extend (lab)

			popup.set_size (l_scaler.scaled_size (200), 3 * lab.font.height)
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

	open_account_url (cld: ES_CLOUD_S; a_report_label: detachable EV_LABEL)
		do
			open_url (cld.view_account_website_url, a_report_label)
		end

	open_url (a_url: READABLE_STRING_8; a_report_label: detachable EV_LABEL)
		local
			l_launcher: ES_CLOUD_URL_LAUNCHER
		do
			create l_launcher.make (a_url)
			l_launcher.set_status_label (a_report_label)
			l_launcher.set_associated_widget (widget)
			l_launcher.execute
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
