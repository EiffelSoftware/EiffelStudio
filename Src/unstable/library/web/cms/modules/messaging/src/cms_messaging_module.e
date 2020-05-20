note
	description: "Module that provides messenger functionality."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MESSAGING_MODULE

inherit
	CMS_MODULE
		rename
			module_api as messaging_api
		redefine
			setup_hooks,
--			install,
			initialize,
			permissions,
			messaging_api
		end

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	REFACTORING_HELPER

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			version := "1.0"
			description := "Messaging module"
			package := "messaging"
		end

feature -- Access

	name: STRING = "messaging"
			-- <Precursor>

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		local
			l_messaging_api: like messaging_api
		do
			Precursor (api)
			create l_messaging_api.make (api)
			messaging_api := l_messaging_api
		end

feature {CMS_API} -- Access: API

	messaging_api: detachable CMS_MESSAGING_API

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		local
			m: WSF_URI_MAPPING
		do
			create m.make_trailing_slash_ignored ("/messaging", create {WSF_URI_AGENT_HANDLER}.make (agent handle_get_messaging (a_api, ?, ?)))
			a_router.map (m, a_router.methods_head_get)
			a_router.handle ("/messaging", create {WSF_URI_AGENT_HANDLER}.make (agent handle_post_messaging (a_api, ?, ?)), a_router.methods_put_post)
		end

feature -- Security

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("admin messaging")
			Result.force ("message any user")
			Result.force ("use messaging")
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
		end

feature -- Hooks

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		do
			debug ("refactor_fixme")
				fixme ("add messaging to menu")
			end
		end

	new_html_messaging_form (a_response: CMS_RESPONSE; api: CMS_API): STRING
		local
			f: CMS_FORM
		do
			a_response.add_style (a_response.module_resource_url (Current, "/files/css/messaging.css", Void), Void)
-- TODO: use template to overwrite/customize			
--			if attached smarty_template_block (Current, "messaging", api) as l_tpl_block then
--				across
--					a_response.values as tb
--				loop
--					l_tpl_block.set_value (tb.item, tb.key)
--				end
--				Result := l_tpl_block.to_html (a_response.theme)
--			else
				f := new_messaging_form (a_response, api)
				api.hooks.invoke_form_alter (f, f.last_data, a_response)

				Result := "<div class=%"messaging-box%"><h1>Send message to ...</h1>" + f.to_html (a_response.wsf_theme) + "<br/></div>"
--			end
		end

	new_messaging_form (a_response: CMS_RESPONSE; api: CMS_API): CMS_FORM
		local
			f: CMS_FORM
			f_name: WSF_FORM_TEXT_INPUT
			f_msg: WSF_FORM_TEXTAREA
			f_submit: WSF_FORM_SUBMIT_INPUT
			f_user: WSF_FORM_CHECKBOX_INPUT
			f_set: WSF_FORM_FIELD_SET
			l_params: CMS_DATA_QUERY_PARAMETERS
			l_step: NATURAL_32
			l_name: READABLE_STRING_32
			nb: INTEGER
			i: INTEGER
		do
			create f.make (a_response.url ("messaging", Void), "messaging-form")

			if attached api.user as l_current_user then
				nb := api.user_api.users_count
				from
					create f_set.make
					f_set.set_legend ("Select users")
					f.extend (f_set)
					i := 0
					l_step := 10
				until
					i > nb
				loop
					create l_params.make (i.to_natural_64, l_step)
					if attached api.user_api.recent_users (l_params) as l_users then
						across
							l_users as ic
						loop
							if l_current_user.id = ic.item.id then
							else
								create f_user.make_with_value ("users[]", ic.item.id.out)
								l_name := api.user_api.real_user_display_name (ic.item)
								if l_name.same_string (ic.item.name) then
									f_user.set_title (l_name)
								else
									f_user.set_title (l_name + " (" + ic.item.name + ")")
								end
								f_set.extend (f_user)
							end
						end
					end
					i := i + l_step.to_integer_32
				end

				create f_name.make ("title")
				f_name.set_size (80)
				f_name.set_label ("Title")
				f_name.set_is_required (True)
				f.extend (f_name)

				create f_msg.make ("message")
				f_msg.set_cols (80)
				f_msg.set_rows (75)
				f_msg.set_label ("Message")
				f_msg.set_rows (5)
				f_msg.set_is_required (True)
				f.extend (f_msg)

				create f_submit.make_with_text ("submit-op", "Send")
				f.extend (f_submit)
			end
			f.extend_html_text ("[
<script>
var lastChecked = null;

$(document).ready(function() {
    var $chkboxes = $('input[name="users\[\]"]');
    $chkboxes.click(function(e) {
        if(!lastChecked) {
            lastChecked = this;
            return;
        }

        if(e.shiftKey) {
            var start = $chkboxes.index(this);
            var end = $chkboxes.index(lastChecked);

            $chkboxes.slice(Math.min(start,end), Math.max(start,end)+ 1).prop('checked', lastChecked.checked);

        }

        lastChecked = this;
    });
});
</script>
			]")
			Result := f
		end

	handle_get_messaging (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			if api.has_permissions (<<"use messaging", "message any user">>) then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				r.values.force ("messaging", "messaging")
				r.set_main_content (new_html_messaging_form (r, api))
				r.execute
			else
				api.response_api.send_permissions_access_denied (Void, <<"use messaging", "message any user">>, req, res)
			end
		end

	handle_post_messaging (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			e: CMS_EMAIL
			l_emails: ARRAYED_LIST [CMS_EMAIL]
			s: STRING
			l_uid: READABLE_STRING_32
			f: like new_messaging_form
			l_user: detachable CMS_USER
			l_email_title: READABLE_STRING_8
			l_email_messg: READABLE_STRING_8
		do
			if api.has_permission ("message any user") then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				r.add_style (r.module_resource_url (Current, "/files/css/messaging.css", Void), Void)

				create s.make_empty

				f := new_messaging_form (r, api)
				f.process (r)
				if attached f.last_data as fd then
					if
						not fd.has_error and then
						attached fd.string_item ("title") as l_title and then
						attached fd.string_item ("message") as l_message and then
						attached fd.table_item ("users") as l_users
					then
						create l_emails.make (l_users.count)

						s.append ("Send message %"")
						s.append (r.html_encoded (l_title))
						s.append ("%"")
						s.append (" to users: <ul>")
						across
							l_users as ic
						loop
							if attached {WSF_STRING} ic.item as p_uid then
								l_uid := p_uid.value
								if l_uid.is_integer_64 then
									l_user := api.user_api.user_by_id (l_uid.to_integer_64)
								else
									l_user := api.user_api.user_by_name (l_uid)
								end
								s.append ("<li>")
								if l_user /= Void and then attached l_user.email as l_user_email then
									s.append (r.html_encoded (api.user_api.real_user_display_name (l_user)))
									s.append (" &lt;")
									s.append (r.html_encoded (l_user_email))
									s.append ("&gt;")

									l_email_title := resolved_template_text (api, l_title, l_user)
									l_email_messg := resolved_template_text (api, l_message, l_user)

									e := api.new_html_email (l_user_email, l_email_title, l_email_messg)

									s.append (" <pre>")
									s.append (e.message)
									s.append ("</pre>")
									l_emails.force (e)
									api.process_email (e)
									if e.is_sent then
										s.append (" successfully sent.")
									else
										s.append (" failure, not sent!")
									end
								else
									s.append (r.html_encoded (p_uid.value))
									s.append (" skipped!")
								end
								s.append ("</li>%N")
							end
						end
					else
						f.append_to_html (r.wsf_theme, s)
					end
				end
				r.set_main_content (s)
				r.execute
			else
				api.response_api.send_permissions_access_denied (Void, <<"message any user">>, req, res)
			end
		end

feature {NONE} -- Contact Message

	resolved_template_text (api: CMS_API; a_text: READABLE_STRING_GENERAL; a_target_user: detachable CMS_USER): READABLE_STRING_8
		local
			smt: CMS_SMARTY_TEMPLATE_TEXT
		do
			create smt.make (api.utf_8_encoded (a_text))
			across
				api.builtin_variables as vars_ic
			loop
				smt.set_value (vars_ic.item, vars_ic.key)
			end
			if a_target_user /= Void then
				smt.set_value (a_target_user.name, "target_user_name")
				smt.set_value (api.user_api.real_user_display_name (a_target_user), "target_user_profile_name")
				smt.set_value (a_target_user.id.out, "target_user_id")
				if attached a_target_user.email as l_email then
					smt.set_value (l_email, "target_user_email")
				end
			end
			Result := smt.string
		end

end
