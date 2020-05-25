note
	description: "Tool that displays account information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ACCOUNT_TOOL_PANEL

inherit
	ES_DOCKABLE_TOOL_PANEL [EV_VERTICAL_BOX]
		redefine
			on_show
		end

	ES_CLOUD_OBSERVER
		redefine
			on_account_signed_in,
			on_account_signed_out,
			on_account_updated,
			on_cloud_available,
			on_session_state_changed
		end

	SHARED_ES_CLOUD_SERVICE

	SHARED_ES_CLOUD_NAMES

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	EB_VETO_FACTORY

create
	make

feature {NONE} -- Initialization

	build_tool_interface (a_widget: EV_VERTICAL_BOX)
			-- Builds the tools user interface elements.
			-- Note: This function is called prior to showing the tool for the first time.
			--
			-- `a_widget': A widget to build the tool interface using.
		do
			main_box := a_widget
			update
			if attached es_cloud_s.service as cld then
				cld.register_observer (Current)
			end
		end

feature -- Widgets

	main_box: EV_VERTICAL_BOX

feature -- Status

	is_cloud_available: BOOLEAN

feature -- Operations

	update
		do
			refresh
		end

feature -- Events

	on_cloud_available (a_is_available: BOOLEAN)
		do
			is_cloud_available := a_is_available
			refresh
		end

	on_session_state_changed (sess: ES_ACCOUNT_SESSION)
		do
			refresh
		end

	on_account_signed_in (acc: ES_ACCOUNT)
		do
			refresh
		end

	on_account_signed_out
		do
			refresh
		end

	on_account_updated (acc: detachable ES_ACCOUNT)
		do
			refresh
		end

feature {NONE} -- Factory		

	create_widget: EV_VERTICAL_BOX
			-- Create a new container widget upon request.
			-- Note: You may build the tool elements here or in build_tool_interface
			-- (export status {NONE})
		do
			create Result
			Result.set_border_width (layout_constants.default_border_size)
			Result.set_padding_width (layout_constants.default_padding_size)
		end

    create_tool_bar_items: detachable ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display at the top of the tool.
        do
        end

feature {NONE} -- Action handlers

	on_show
			-- Performs actions when the user widget is displayed.
		do
			Precursor
			if is_initialized then
				refresh
			end
		end

	refresh
		local
			lab: EV_LABEL
			b: like main_box
			but: EV_BUTTON
			lnk: EVS_HIGHLIGHT_LINK_LABEL
			hb: EV_HORIZONTAL_BOX
			txt: EV_RICH_TEXT
			q,r: INTEGER_64
			nb_days: INTEGER_64
			s: STRING
			l_dbg: BOOLEAN
			acc: detachable ES_ACCOUNT
		do
			b := main_box
			b.wipe_out
			if attached es_cloud_s.service as cld then
				if not is_cloud_available then
					cld.async_check_availability
--					is_cloud_available := cld.is_available
--					if is_cloud_available then
--						cld.on_cloud_available (True)
--					end
				end
				l_dbg := cld.is_debug_enabled
				acc := cld.active_account
				if acc /= Void then
					create lab.make_with_text (acc.username)
					b.extend (lab)
					b.disable_item_expand (lab)

					create txt
					b.extend (txt)
					append_text_to ("%N%N", txt)
					if cld.is_enterprise_edition then
						append_bold_text_to (locale.translation_in_context ("Edition: enterprise", "cloud.info"), txt)
						append_text_to ("%N", txt)
					elseif attached cld.installation.associated_plan as l_plan then
						append_bold_text_to (locale.translation_in_context ("License: ", "cloud.info"), txt)
						append_text_to (l_plan.name, txt)
						append_text_to ("%N", txt)
						if attached l_plan.expiration_date as dt then
							nb_days := l_plan.days_remaining
							append_bold_text_to (locale.translation_in_context ("Expires: ", "cloud.info"), txt)
							append_text_to (dt.out, txt)
							append_text_to ("%N", txt)

							if nb_days >= 0 then
								append_bold_text_to (locale.translation_in_context ("Days remaining: ", "cloud.info"), txt)
								append_text_to (nb_days.out, txt)
								append_text_to ("%N", txt)
							else
								append_bold_text_to (locale.translation_in_context ("License: EXPIRED!", "cloud.info"), txt)
								append_text_to ("%N", txt)
							end
						end
						append_bold_text_to (locale.translation_in_context ("Installation id: ", "cloud.info"), txt)
						append_text_to (cld.installation.id, txt)
						append_text_to ("%N", txt)
					end
					if attached cld.active_session as sess then
						append_text_to ("%N", txt)
						append_bold_text_to ("Session: ", txt)
						append_text_to (sess.id.out, txt)
						append_text_to ("%N", txt)
						if attached {ES_ACCOUNT_ACCESS_TOKEN} acc.access_token as tok then
							append_text_to ("%N", txt)
							append_bold_text_to (locale.translation_in_context ("Authentication token expiration: ", "cloud.info"), txt)
							append_text_to (tok.expiration_date.out, txt)
							if attached tok.expiration_delay_in_seconds as nb and then nb >= 0 then
								append_text_to (" ", txt)
								create s.make_empty
								q := nb
								r := q \\ 60
								if r > 0 then
									s.append (r.out + " secs")
								end
								q := q // 60
								if q > 0 then
									r := q \\ 60
									if q > 0 then
										s.prepend (r.out + " minutes ")
									end
									q := q // 60
									if q > 0 then
										r := q \\ 24
										if q > 0 then
											s.prepend (r.out + " hours ")
										end
										q := q // 24
										if q > 0 then
											s.prepend (q.out + " days ")
										end
									end
								end
								append_text_to (s, txt)
								append_text_to ("%N", txt)
							end
						end
					end
					if l_dbg then
							-- no translation for debug interface.
						append_bold_text_to ("Cloud: ", txt)
						append_text_to (cld.server_url, txt)
						append_text_to ("%N", txt)
						if attached cld.installation as l_installation then
							append_bold_text_to ("Installation: ", txt)
							append_text_to (l_installation.id, txt)
							if attached l_installation.creation_date as dt then
								append_italic_text_to (" (since " + dt.out + ")" , txt)
							end
							append_text_to ("%N", txt)
						end
						if attached {ES_ACCOUNT_ACCESS_TOKEN} acc.access_token as tok then
							append_bold_text_to ("Session (%N", txt)
							append_text_to ("%T", txt)
							append_text_to ("id=", txt)
							if attached cld.active_session as sess then
								append_text_to (sess.id, txt)
							end
							append_text_to ("%N%T", txt)
							append_text_to ("token=", txt)
							append_text_to (tok.token, txt)
							append_text_to ("%N%T", txt)
							append_text_to ("expiration=", txt)
							append_text_to (tok.expiration_date.out, txt)
							if attached tok.expiration_delay_in_seconds as nb and then nb >= 0 then
								append_text_to (" ", txt)
								create s.make_empty
								q := nb
								r := q \\ 60
								if r > 0 then
									s.append (r.out + " secs")
								end
								q := q // 60
								if q > 0 then
									r := q \\ 60
									if q > 0 then
										s.prepend (r.out + " minutes ")
									end
									q := q // 60
									if q > 0 then
										r := q \\ 24
										if q > 0 then
											s.prepend (r.out + " hours ")
										end
										q := q // 24
										if q > 0 then
											s.prepend (q.out + " days ")
										end
									end
								end


								append_text_to (s, txt)
								append_text_to ("%N", txt)

							end
							if attached tok.refresh_key as k then
								append_text_to ("%T", txt)
								append_text_to ("refresh_key=", txt)
								append_text_to (k, txt)
								append_text_to ("%N", txt)
							end

							append_text_to (")%N", txt)

						end
					end
					create hb
					b.extend (hb)
					b.disable_item_expand (hb)
					hb.extend (create {EV_CELL})

					if is_cloud_available then
	--					create hb
						create but.make_with_text_and_action (locale.translation_in_context ("Reload", "cloud.info"), agent on_account_reload (cld, acc))
						hb.extend (but)
						layout_constants.set_default_size_for_button (but)
						hb.disable_item_expand (but)

						create but.make_with_text_and_action (locale.translation_in_context ("Sign out", "cloud.info"), agent on_sign_out (cld))
						hb.extend (but)
						layout_constants.set_default_size_for_button (but)
						hb.disable_item_expand (but)

						if l_dbg and then attached cld.active_session as sess then
							-- no translation for debug interface.
							create but.make_with_text_and_action ("Ping", agent on_account_ping (cld, acc, sess))
							hb.extend (but)
							layout_constants.set_default_size_for_button (but)
							hb.disable_item_expand (but)

							create but.make_with_text_and_action ("End", agent on_session_end (cld, acc, sess))
							hb.extend (but)
							layout_constants.set_default_size_for_button (but)
							hb.disable_item_expand (but)

							create but.make_with_text_and_action ("Pause", agent on_session_pause (cld, acc, sess))
							hb.extend (but)
							layout_constants.set_default_size_for_button (but)
							hb.disable_item_expand (but)

							create but.make_with_text_and_action ("Resume", agent on_session_resume (cld, acc, sess))
							hb.extend (but)
							layout_constants.set_default_size_for_button (but)
							hb.disable_item_expand (but)

							if acc /= Void and then attached acc.access_token as tok and then tok.has_refresh_key then
								create but.make_with_text_and_action ("Refresh", agent on_account_refresh_token (cld, tok, acc))
								hb.extend (but)
								layout_constants.set_default_size_for_button (but)
								hb.disable_item_expand (but)
							end
						end
					end
				else
					if cld.is_guest then
						create lab.make_with_text (cloud_names.prompt_welcome_guest)
					else
						create lab.make_with_text (cloud_names.prompt_not_connected_with_account)
					end
					lab.align_text_left

					b.extend (lab)
					b.disable_item_expand (lab)
					if is_cloud_available then
						create lnk.make_with_text (cloud_names.prompt_connected_your_account)
						lnk.align_text_left
						lnk.align_text_top
						lnk.select_actions.extend (agent (i_cld: ES_CLOUD_S)
							local
								l_startup_page: ES_STARTUP_PAGE
							do
								create l_startup_page.make (not i_cld.is_enterprise_edition)
								l_startup_page.switch_to_account_page (i_cld, Void, False)
								l_startup_page.show_modal_to_window (develop_window.window)
							end(cld)
						)
						b.extend (lnk)
					end
				end

				if not is_cloud_available then
					create hb
					b.extend (hb)
					b.disable_item_expand (hb)
					hb.extend (create {EV_CELL})

					create lab.make_with_text (cloud_names.label_service_not_available + {STRING_32} " ") -- extra space for layout
					hb.extend (lab)
					hb.disable_item_expand (lab)
					create but.make_with_text_and_action (cloud_names.button_try_to_reconnect, agent update)
					layout_constants.set_default_size_for_button (but)
					hb.extend (but)
					hb.disable_item_expand (but)
					hb.extend (create {EV_CELL})
				end
				if l_dbg then
					create lab.make_with_text (cloud_names.label_field_installation + cld.installation.id)
					b.extend (lab)
					b.disable_item_expand (lab)
				end
			else
				create lab.make_with_text (locale.translation_in_context ("Service not activated!", "cloud.error"))
				b.extend (lab)
			end
			b.set_background_color (colors.stock_colors.default_background_color)
			b.propagate_background_color
		end

	on_sign_out (cld: ES_CLOUD_S)
		do
			cld.sign_out
		end

	on_account_refresh_token (cld: ES_CLOUD_S; tok: ES_ACCOUNT_ACCESS_TOKEN; acc: ES_ACCOUNT)
		local
			l_style: EV_POINTER_STYLE
		do
			l_style := widget.pointer_style
			widget.set_pointer_style (pixmaps.stock_pixmaps.busy_cursor)
			cld.refresh_token (tok, acc)
			widget.set_pointer_style (l_style)
			if not is_cloud_available then
				refresh
			end
		end

	on_account_reload (cld: ES_CLOUD_S; acc: ES_ACCOUNT)
		local
			l_style: EV_POINTER_STYLE
		do
			l_style := widget.pointer_style
			widget.set_pointer_style (pixmaps.stock_pixmaps.busy_cursor)
			cld.update_account (acc)
			widget.set_pointer_style (l_style)
			if not is_cloud_available then
				refresh
			end
		end

	on_account_ping (cld: ES_CLOUD_S; acc: ES_ACCOUNT; sess: ES_ACCOUNT_SESSION)
		do
			cld.ping_installation (acc, sess)
		end

	on_session_end (cld: ES_CLOUD_S; acc: ES_ACCOUNT; sess: ES_ACCOUNT_SESSION)
		do
			cld.end_session (acc, sess)
		end

	on_session_pause (cld: ES_CLOUD_S; acc: ES_ACCOUNT; sess: ES_ACCOUNT_SESSION)
		do
			cld.pause_session (acc, sess)
		end

	on_session_resume (cld: ES_CLOUD_S; acc: ES_ACCOUNT; sess: ES_ACCOUNT_SESSION)
		do
			cld.resume_session (acc, sess)
		end

feature -- Access: Help

	help_context_id: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "TO-FILL"
		end

feature -- Rich text helper

	append_text_to (a_txt: detachable READABLE_STRING_GENERAL; a_rich_text: EV_RICH_TEXT)
		do
			if a_txt /= Void and then not a_txt.is_empty then
				append_formatted_text_to (a_txt, Void, a_rich_text)
			end
		end

	append_bold_text_to (a_txt: READABLE_STRING_GENERAL; a_rich_text: EV_RICH_TEXT)
		do
			if not a_txt.is_empty then
				append_formatted_text_to (a_txt, bold_format, a_rich_text)
			end
		end

	append_italic_text_to (a_txt: READABLE_STRING_GENERAL; a_rich_text: EV_RICH_TEXT)
		do
			if not a_txt.is_empty then
				append_formatted_text_to (a_txt, italic_format, a_rich_text)
			end
		end

	append_formatted_text_to (a_txt: READABLE_STRING_GENERAL; a_format: detachable EV_CHARACTER_FORMAT; a_rich_text: EV_RICH_TEXT)
		local
			i,j: INTEGER
		do
			if not a_txt.is_empty then
				i := a_rich_text.text_length + 1
				a_rich_text.append_text (a_txt)
				j := i + a_txt.count
				if a_format /= Void then
					a_rich_text.format_region (i, j, a_format)
				else
					a_rich_text.format_region (i, j, normal_format)
				end
			end
		end

	normal_format: EV_CHARACTER_FORMAT
		do
			Result := text_format ("normal")
			if Result = Void then
				create Result.default_create
				set_text_format (Result, "normal")
			end
		end

	bold_format: EV_CHARACTER_FORMAT
		local
			ft: EV_FONT
		do
			Result := text_format ("bold")
			if Result = Void then
				create Result.default_create
				ft := Result.font.twin
				ft.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
				Result.set_font (ft)
				set_text_format (Result, "bold")
			end
		end

	italic_format: EV_CHARACTER_FORMAT
		local
			ft: EV_FONT
		do
			Result := text_format ("italic")
			if Result = Void then
				create Result.default_create
				ft := Result.font.twin
				ft.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
				Result.set_font (ft)
				set_text_format (Result, "italic")
			end
		end

	text_formats: detachable STRING_TABLE [EV_CHARACTER_FORMAT]

	set_text_format (a_format: EV_CHARACTER_FORMAT; a_name: READABLE_STRING_GENERAL)
		local
			tb: like text_formats
		do
			tb := text_formats
			if tb = Void then
				create tb.make (1)
				text_formats := tb
			end
			tb.force (a_format, a_name)
		end

	text_format (a_name: READABLE_STRING_GENERAL): detachable EV_CHARACTER_FORMAT
		do
			if attached text_formats as tb then
				Result := tb.item (a_name)
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
