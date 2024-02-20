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
			create scaler.make

			create next_actions
			build_interface (w)
			set_default_mode
		end

	make_cloud_required (cld: ES_CLOUD_S)
		do
			is_cloud_required := True
			make (cld)
		end

feature -- Access

	cloud_service: ES_CLOUD_S
			-- Eiffel Cloud service.

	scaler: EVS_DPI_SCALER

	sign_in_frame: EV_FRAME

feature {NONE} -- Initialization

	build_interface (a_box: EV_VERTICAL_BOX)
		local
			l_main: EV_VERTICAL_BOX
			vb,vb_learn,vb_terms: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			l_learn_more_box: EV_FRAME
			txt: EVS_LABEL
			lnk: EV_LINK_LABEL
			lab_collapse: EV_LABEL
			l_weblnk: EV_HIGHLIGHT_LINK_LABEL
			but: EV_BUTTON
			s: STRING_32
			l_frame: EV_FRAME
		do
			create l_main
			a_box.extend (l_main)
			a_box.disable_item_expand (l_main)

			create vb
			vb.set_padding_width (layout_constants.default_padding_size)

			create vb_terms
			vb_terms.set_padding_width (layout_constants.default_padding_size)
			vb_terms.set_minimum_width (50)
			create s.make_empty
			s.append (cloud_names.prompt_agree_terms_of_use_and_rules)
			s.append_character ('%N')
			s.append (
					if is_cloud_required then
						cloud_names.prompt_sign_to_edition_cloud_services ({ES_IDE_SETTINGS}.edition_title)
					else
						cloud_names.prompt_sign_to_cloud_services
					end
				)
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
			create hb
			hb.extend (vb_learn)
			create lab_collapse.make_with_text (cloud_names.symbol_close)
			lab_collapse.set_foreground_color (colors.disabled_foreground_color)
			lab_collapse.set_minimum_width (lab_collapse.font.string_width (lab_collapse.text) + 4)
			lab_collapse.align_text_center
			lab_collapse.align_text_top
			hb.extend (lab_collapse)
			hb.disable_item_expand (lab_collapse)
			l_learn_more_box.extend (hb)
			l_learn_more_box.hide
			create lnk.make_with_text (cloud_names.label_learn_more)
			lnk.align_text_left
			lnk.select_actions.extend (agent (i_learn_more_box: EV_WIDGET; i_lnk: EV_WIDGET)
				do
					i_learn_more_box.show
					i_lnk.hide
				end(l_learn_more_box, lnk))
			lab_collapse.pointer_button_press_actions.extend (agent (i_learn_more_box: EV_WIDGET; i_lnk: EV_WIDGET; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
				do
					i_learn_more_box.hide
					i_lnk.show
				end(l_learn_more_box, lnk,?,?,?,?,?,?,?,?)
			)
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
			create l_frame
			sign_in_frame := l_frame

				-- Layout
--			create hb
--			hb.extend (l_frame); hb.disable_item_expand (l_frame)
--			hb.extend (create {EV_CELL})

--			vb.extend (hb)
--			vb.disable_item_expand (hb)
			vb.extend (l_frame)
			vb.disable_item_expand (l_frame)


--			create lnk.make_with_text (cloud_names.label_open_eiffelstudio_account_web_site)
--			lnk.align_text_left
--			lnk.select_actions.extend (agent open_account_url (cloud_service, Void))
--			vb.extend (lnk)
--			vb.disable_item_expand (lnk)

			if {ES_IDE_SETTINGS}.cloud_required then
				-- Check if needed ... if not is_guest_signed_in and then
				if attached remaining_allowed_guest_days as l_days and then l_days > 0 then
					create but.make_with_text_and_action (cloud_names.button_guest, agent on_guest)
					layout_constants.set_default_width_for_button (but)
					append_label_and_item_horizontally (cloud_names.label_can_continue_as_guest_for_n_days (l_days), but, vb)
					debug
						if attached guest_mode_sign_in_count as nb and then nb > 0 then
							append_label_and_item_horizontally ("(" + nb.out + ")", create {EV_CELL}, vb)
						end
					end
				else
					create but.make_with_text_and_action (cloud_names.button_quit, agent on_next)
					layout_constants.set_default_width_for_button (but)
					append_label_and_item_horizontally (cloud_names.label_cannot_continue_as_guest, but, vb)
				end
			end
			a_box.set_background_color (colors.stock_colors.white)
			a_box.propagate_background_color
		end

feature -- Mode selection

	set_default_mode
		do
			if is_sign_in_challenge_auth_allowed then
				set_cloud_sign_in_mode (cloud_service, sign_in_frame)
			else
				check is_basic_auth_allowed end
				set_credential_sign_in_mode (sign_in_frame)
			end
		end

	set_credential_sign_in_mode (fr: EV_FRAME)
		local
			b: like new_credential_sign_box
			lnk: EV_HIGHLIGHT_LINK_LABEL
			hb: EV_HORIZONTAL_BOX
			lab: EV_LABEL
			sep: EV_WIDGET
		do
			fr.remove_text

			b := new_credential_sign_box
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
			hb.extend (lnk)
			hb.disable_item_expand (lnk)


			create hb
			hb.set_padding_width (scaler.scaled_size (5))

				-- Cloud sign-in
			if
				is_sign_in_challenge_auth_allowed and then
				attached new_cloud_sign_in_link (cloud_service, fr) as l_web_sign_in_box
			then
				hb.extend (l_web_sign_in_box)
				hb.disable_item_expand (l_web_sign_in_box)
			end -- end of web sign-in

				-- Offline access token.
			if
				is_offline_allowed and then
				attached new_use_offline_auth_link (fr) as l_off_box
			then
				if hb.count > 0 then
					create {EV_VERTICAL_SEPARATOR} sep
					hb.extend (sep); hb.disable_item_expand (sep)
				end
				hb.extend (l_off_box)
				hb.disable_item_expand (l_off_box)
			end -- end of offline

			if hb.count > 0 then
--				hb.set_border_width (layout_constants.default_border_size)
--				hb.set_padding_width (layout_constants.default_padding_size)
				create lab.make_with_text (cloud_names.label_or_space)
				hb.put_front (lab); hb.disable_item_expand (lab)
				b.extend (hb)
				b.disable_item_expand (hb)
			end

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
		do
			l_field_width := scaler.scaled_size (300)
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

			if attached new_credential_sign_in_link (fr) as l_box then
				vb_off.extend (l_box)
				vb_off.disable_item_expand (l_box)
			end

			fr.extend (vb_off)
			fr.propagate_background_color
		end

	set_cloud_sign_in_mode (cld: ES_CLOUD_S; fr: EV_FRAME)
		local
			vb, l_inner: EV_VERTICAL_BOX
--			l_weblnk: EV_HIGHLIGHT_LINK_LABEL
			lab: EV_LABEL
			hb: EV_HORIZONTAL_BOX
			but: EV_BUTTON
		do
			fr.wipe_out
--			fr.set_text ("Sign-in")
			fr.remove_text

			create vb
			vb.set_border_width (layout_constants.default_border_size)
			vb.set_padding_width (layout_constants.default_padding_size)

			create l_inner
			l_inner.set_border_width (layout_constants.default_border_size)
			l_inner.set_padding_width (layout_constants.default_padding_size)

			create but.make_with_text ("Sign in")
			but.set_font (fonts.highlighted_label_font)
			but.set_minimum_size (scaler.scaled_size (150), scaler.scaled_size (50))
			but.select_actions.extend (agent request_cloud_sign_in (cld, l_inner))
			create hb
			l_inner.extend (hb); l_inner.disable_item_expand (hb)
				-- Center button
			hb.extend (create {EV_CELL})
			hb.extend (but); hb.disable_item_expand (but)
			hb.extend (create {EV_CELL})

			vb.extend (l_inner)
			vb.extend (create {EV_CELL})

			if attached new_credential_sign_in_link (fr) as l_box then
				create hb
				vb.extend (hb)
				vb.disable_item_expand (hb)
				create lab.make_with_text (cloud_names.label_or_space)
				hb.extend (lab); hb.disable_item_expand (lab)
				hb.extend (l_box)
				hb.disable_item_expand (l_box)
				hb.extend (create {EV_LABEL})
			end

			fr.wipe_out
			fr.extend (vb)

			fr.propagate_background_color
		end

	request_cloud_sign_in (cld: ES_CLOUD_S; b: EV_VERTICAL_BOX)
		local
			lnk: like new_link_label
			lab: EV_LABEL
			hb: EV_HORIZONTAL_BOX
			sep: EV_WIDGET
		do
			if
				attached cloud_service.new_cloud_sign_in_request (eiffel_layout.product_version_name) as rqst
			then
				b.wipe_out
				create lab
--				b.extend (lab); b.disable_item_expand (lab); lab.hide
				open_url (rqst.sign_in_url, lab)

				create lab.make_with_text (locale.translation_in_context ("Sign in from your browser to continue", "eiffel.account"))
				lab.set_font (fonts.highlighted_label_font)
				b.extend (lab); b.disable_item_expand (lab)

				create hb
				b.extend (hb); b.disable_item_expand (hb)

				create lab.make_with_text (locale.translation_in_context ("If your browser hasn't opened for you to sign in, ", "eiffel.account"))
				lab.align_text_center
				b.extend (lab); b.disable_item_expand (lab)

				create hb
				b.extend (hb); b.disable_item_expand (hb)
				hb.extend (create {EV_CELL})
				create lnk.make_with_text (locale.translation_in_context ("open it manually", "eiffel.account"))
				hb.extend (lnk); hb.disable_item_expand (lnk)
				lnk.select_actions.extend (agent open_url (rqst.sign_in_url, Void))

				create lab.make_with_text (locale.translation_in_context (" or ", "eiffel.account"))
				hb.extend (lab); hb.disable_item_expand (lab)

				create lnk.make_with_text (locale.translation_in_context ("copy the URL", "eiffel.account"))
				hb.extend (lnk); hb.disable_item_expand (lnk)
				lnk.select_actions.extend (agent (i_url: READABLE_STRING_GENERAL)
						do
							(create {EV_SHARED_APPLICATION}).ev_application.clipboard.set_text (i_url)
						end(rqst.sign_in_url)
					)
				hb.extend (create {EV_CELL})

				create lab
				b.extend (lab); b.disable_item_expand (lab)

				create hb
				hb.set_padding_width (scaler.scaled_size (3))
				b.extend (hb); b.disable_item_expand (hb)

				hb.extend (create {EV_CELL})
				lnk := new_link_label (locale.translation_in_context ("Check now", "eiffel.account"), agent check_request_cloud_sign_in (cld, rqst, lab, b))
				hb.extend (lnk); hb.disable_item_expand (lnk)

				create {EV_VERTICAL_SEPARATOR} sep
				hb.extend (sep); hb.disable_item_expand (sep)

				lnk := new_link_label (locale.translation_in_context ("Cancel", "eiffel.account"), agent report_cloud_sign_in_error (cld, "Cancelled", b))
				hb.extend (lnk); hb.disable_item_expand (lnk)
				hb.extend (create {EV_CELL})

				start_waiting (lab)
				check_request_cloud_sign_in (cld, rqst, lab, b)

				b.propagate_background_color

			else
				report_cloud_sign_in_error (cloud_service, locale.translation_in_context ("could not request Sign-in", "cloud.error"), b)
			end
		end

	report_cloud_sign_in_error (cld: ES_CLOUD_S; err: detachable READABLE_STRING_GENERAL; b: EV_VERTICAL_BOX)
		local
			but: EV_BUTTON
			lab: EV_LABEL
		do
			stop_waiting
			b.wipe_out
			create lab.make_with_text (cloud_names.label_error_message (err))
			b.extend (lab)

			create but.make_with_text (locale.translation_in_context ("TRY AGAIN", "eiffel.account"))
			but.set_font (fonts.highlighted_label_font)
			but.select_actions.extend (agent request_cloud_sign_in (cld, b))
			but.set_background_color (colors.stock_colors.red)
			but.set_foreground_color (colors.stock_colors.white)
			but.set_minimum_width (scaler.scaled_size (100))

			b.extend (but)
			b.disable_item_expand (but)
		end

	check_request_cloud_sign_in (cld: ES_CLOUD_S; rqst: ES_CLOUD_SIGN_IN_REQUEST; lab: EV_LABEL; b: EV_VERTICAL_BOX)
		local
			t: EV_TIMEOUT
			l_mesg: EV_LABEL
			err: detachable READABLE_STRING_GENERAL
		do
			if not cld.is_available then
				cld.async_check_availability (False)
			else
				if cld.is_signed_in and then attached cld.active_account as acc then
						-- Already authenticated !!!
					report_cloud_sign_in_error (cld, "Already authenticated", b)
				else
					cld.check_cloud_sign_in_request (rqst)
					if rqst.is_approved or rqst.has_error then
						stop_waiting
							-- Exit
						b.wipe_out
						create l_mesg
						b.extend (l_mesg)
						b.disable_item_expand (l_mesg)

						if
							rqst.is_approved and
							cld.is_signed_in and
							attached cld.active_account as acc
						then
							l_mesg.set_text ({STRING_32} "Welcome user " + acc.username)
							b.set_focus
							if attached parent_window_of (b) as win then
								if attached {EV_TITLED_WINDOW} win as l_titled_win then
									l_titled_win.raise
								else
									win.hide
								end
								win.show
								win.set_focus
							end
							on_user_signed_in (acc)
						elseif rqst.has_error then
							err := rqst.error_message
							report_cloud_sign_in_error (cld, err, b)
						else
							check False end
							err := "Unexpected case"
							report_cloud_sign_in_error (cld, err, b)
						end
					else
						t := check_request_cloud_sign_in_timer
						if t = Void or else t.is_destroyed then
							create t.make_with_interval (5_000)
							t.actions.extend (agent check_request_cloud_sign_in (cld, rqst, lab, b))
							check_request_cloud_sign_in_timer := t
						else
							-- wait for next timeout event ...
						end
					end
				end
			end
		end

	check_request_cloud_sign_in_timer: detachable EV_TIMEOUT

	waiting_timer: detachable EV_TIMEOUT

	start_waiting (lab: EV_LABEL)
		local
			t: EV_TIMEOUT
		do
			t := waiting_timer
			if t /= Void then
				check no_pending_waiting_timer: False end
				t.actions.wipe_out
			else
				create t.make_with_interval (100) -- 500 ms
				waiting_timer := t
			end
			t.actions.extend (agent update_waiting (lab, t))
		end

	update_waiting (lab: EV_LABEL; t: EV_TIMEOUT)
		local
			s: STRING_32
			i: INTEGER
		do
			if lab.is_destroyed then
				t.destroy
			else
				if attached {INTEGER_32} lab.data as d then
					i := d + 1
				else
					i := 1
				end
				lab.set_data (i)

				inspect i \\ 4
				when  0 then s := {STRING_32} "◰"
				when  1 then s := {STRING_32} "◳"
				when  2 then s := {STRING_32} "◲"
				when  3 then s := {STRING_32} "◱"
				else
					s := " "
				end
				lab.set_text (s)
			end
		end

	stop_waiting
		do
			if attached waiting_timer as t then
				t.destroy
				waiting_timer := Void
			end
			if attached check_request_cloud_sign_in_timer as t then
				t.destroy
				check_request_cloud_sign_in_timer := Void
			end
		end

	set_register_mode (fr: EV_FRAME)
		local
			b: like new_register_link_link
			lnk: EV_HIGHLIGHT_LINK_LABEL
		do
			fr.remove_text
			b := new_register_link_link
			create lnk.make_with_text (cloud_names.label_sign_in_with_existing_account)
			lnk.align_text_left
			lnk.select_actions.extend (agent set_credential_sign_in_mode (fr))
			b.extend (lnk)
			b.disable_item_expand (lnk)
			fr.wipe_out
			fr.extend (b)
			b.show
			fr.propagate_background_color
		end

	new_credential_sign_box: EV_VERTICAL_BOX
		local
			lab: EV_LABEL
			l_field_width: INTEGER
			w: EV_WIDGET
			tf_password: EV_PASSWORD_FIELD
			tf_username: EV_TEXT_FIELD
			but: EV_BUTTON
			cb: EV_CHECK_BUTTON
			l_focus: detachable EV_WIDGET
			l_kept_credential: detachable TUPLE [username, password: READABLE_STRING_32]
			hb: EV_HORIZONTAL_BOX
			lnk: EV_HIGHLIGHT_LINK_LABEL
		do
			l_field_width := scaler.scaled_size (300)

			l_kept_credential := cloud_service.kept_credential

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
			cb.enable_select
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


			create hb
			create lab.make_with_text (cloud_names.prompt_note_account_usage)
--			lab.set_foreground_color (colors.stock_colors.dark_grey)
--			lab.set_font (fonts.italic_label_font)
			lab.align_text_left
			hb.extend (lab)
			hb.disable_item_expand (lab)

			if attached cloud_service as cld then
				create lab.make_with_text (" ");
				hb.extend (lab);
				hb.disable_item_expand (lab);

				create lnk.make_with_text (cloud_names.label_short_open_eiffelstudio_account_web_site)
				lnk.align_text_left
				lnk.select_actions.extend (agent open_account_url (cld, Void));
	--			lnk.select_actions.extend (agent set_register_mode (fr))
				hb.extend (lnk)
				hb.disable_item_expand (lnk)
			end

			Result.extend (hb)
			Result.disable_item_expand (hb)

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
		do
			l_field_width := scaler.scaled_size (300)

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

	new_credential_sign_in_link (frame: EV_FRAME): EV_WIDGET
		local
			l_weblnk: EV_HIGHLIGHT_LINK_LABEL
		do
			create l_weblnk.make_with_text (cloud_names.link_login_with_credentials)
			l_weblnk.align_text_left
			l_weblnk.select_actions.extend (agent set_credential_sign_in_mode (frame))
			Result := l_weblnk
		end

	new_cloud_sign_in_link (cld: ES_CLOUD_S; frame: EV_FRAME): EV_WIDGET
		local
			l_weblnk: EV_HIGHLIGHT_LINK_LABEL
		do
			create l_weblnk.make_with_text (cloud_names.link_web_sign_in_challenge)
			l_weblnk.align_text_left
			l_weblnk.select_actions.extend (agent set_cloud_sign_in_mode (cld, frame))
			Result := l_weblnk
		end

	new_use_offline_auth_link (frame: EV_FRAME): EV_WIDGET
		local
			l_weblnk: EV_HIGHLIGHT_LINK_LABEL
		do
			create l_weblnk.make_with_text (cloud_names.link_login_with_offline_token)
			l_weblnk.align_text_left
			l_weblnk.select_actions.extend (agent set_offline_mode (frame))
			Result := l_weblnk
		end

	new_register_link_link: EV_VERTICAL_BOX
		local
			l_weblnk: EV_HIGHLIGHT_LINK_LABEL
			lab: EV_LABEL
		do
			create Result
--			Result.set_border_width (layout_constants.default_border_size)
--			Result.set_padding_width (layout_constants.default_padding_size)
			create l_weblnk.make_with_text (cloud_names.link_create_new_account)
			l_weblnk.align_text_left
--			l_weblnk.set_minimum_width (scaler.scaled_size (300))
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
			Result := cloud_service.is_offline_allowed
		end

	is_basic_auth_allowed: BOOLEAN
		do
			Result := cloud_service.is_basic_auth_allowed
		end

	is_sign_in_challenge_auth_allowed: BOOLEAN
		do
			Result := cloud_service.is_sign_in_challenge_auth_allowed
		end

	is_guest_signed_in: BOOLEAN
		do
			Result := cloud_service.is_guest
		end

	remaining_allowed_guest_days: INTEGER
		do
			Result := cloud_service.remaining_days_for_guest
		end

	guest_mode_sign_in_count: INTEGER
		do
			Result := cloud_service.guest_mode_signed_in_count
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
			acc: acc.same_as (cloud_service.active_account) and then
				not acc.is_expired
		do
			on_next
		end

	on_guest
		do
			cloud_service.continue_as_guest
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
				if attached cloud_service as cld then
					if cld.is_available	then
						cld.sign_in_with_credential (u, p)
						if cld.has_error then
							create s32.make_from_string_general (locale.translation_in_context ("Service error (try again later).", "cloud.error"))
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
					on_system_error (locale.translation_in_context ("Cloud service not activated.", "cloud.error"), a_report_label)
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

				if attached cloud_service as cld then
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
			on_system_error (locale.translation_in_context ("Your license is expired, please renew or purchase a new one.", "cloud.error"), a_report_label)
		end

	on_user_sign_in_refused (a_form: like new_gui_form; a_report_label: detachable EV_LABEL)
		do
			on_system_error (locale.translation_in_context ("Error: invalid username or password.", "cloud.error"), a_report_label)
		end

	on_user_registered (acc: ES_ACCOUNT; a_report_label: detachable EV_LABEL)
		do
			on_system_error (locale.translation_in_context ("Thank you for the registration.", "cloud.message"), a_report_label)
		end

	on_user_registration_error (a_form: like new_gui_form; a_report_label: detachable EV_LABEL)
		do
			on_system_error (locale.translation_in_context ("Error while registering.", "cloud.error"), a_report_label)
		end

	on_cloud_service_not_available (a_msg: detachable READABLE_STRING_GENERAL; a_report_label: detachable EV_LABEL)
		local
			s: STRING_32
		do
			create s.make_from_string (locale.translation_in_context ("Account service is not available for now (try again later).", "cloud.error"))
			if a_msg /= Void then
				s.append_character ('%N')
				s.append (a_msg)
			end
			on_system_error (s, a_report_label)
		end

	on_cloud_service_not_activated_error (a_report_label: detachable EV_LABEL)
		do
			on_system_error (locale.translation_in_context ("Cloud service not activated.", "cloud.error"), a_report_label)
		end

feature {NONE} -- Widget factory

	new_link_label (a_title: READABLE_STRING_GENERAL; a_action: PROCEDURE): EV_HIGHLIGHT_LINK_LABEL
		do
			create Result.make_with_text (a_title)
			Result.select_actions.extend (a_action)
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
		do
			create popup.make_with_shadow
			create lab.make_with_text (msg)
			lab.set_minimum_height (3 * lab.font.height)
			lab.align_text_vertical_center
			if a_is_error then
				lab.set_foreground_color (colors.stock_colors.red)
			end
			popup.extend (lab)

			popup.set_size (scaler.scaled_size (200), 3 * lab.font.height)
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
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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
