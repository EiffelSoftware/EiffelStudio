note
	description: "Summary description for {OPENID_CMS_EXECUTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	OPENID_CMS_EXECUTION

inherit
	CMS_EXECUTION

create
	make

feature -- Execution

	process
		local
			b: STRING
			f: CMS_FORM
			tf: WSF_FORM_TEXT_INPUT
			ts: WSF_FORM_SUBMIT_INPUT
			o: OPENID_CONSUMER
			v: OPENID_CONSUMER_VALIDATION
			tb: HASH_TABLE [READABLE_STRING_8, STRING_8]
			l_uid: INTEGER
		do
			create b.make_empty
			set_title ("OpenID identities")
			if attached request.string_item ("openid.mode") as l_openid_mode then
					-- Callback
				create o.make (request.absolute_script_url ("/openid/login"))
				o.ask_email (True)
				o.ask_nickname (False)
--				o.ask_all_info (False)

				create v.make_from_items (o, request.items_as_string_items)
				v.validate
				if v.is_valid then
					if attached v.identity as l_identity then
						if attached user as u then
							if attached service.storage.custom_value (l_identity, "openid") as obj then
								l_uid := user_id_from_custom_value (obj)
								if l_uid > 0 and then l_uid = u.id then
									-- Authenticated
									b.append ("OpenID already associated to user %""+ user_link (u) +"%"")
								else
									-- Wrong USER !!!
									b.append ("OpenID already associated to another user !!!")
								end
							else
									-- New OpenID association
								create tb.make (1)
								tb.force (l_identity, "openid_identity")
								tb.force (u.id.out, "uid")
								service.storage.set_custom_value (l_identity, tb, "openid")

								b.append ("OpenID %""+ l_identity +"%" is now associated with user %""+ user_link (u) +"%"")
							end
						else
							if
								attached service.storage.custom_value (l_identity, "openid") as obj and then
								attached user_id_from_custom_value (obj) as obj_uid and then
								obj_uid > 0 and then
								attached service.storage.user_by_id (obj_uid.to_integer) as u
							then
									-- Authenticated
								set_user (u)
								b.append ("Authenticated as %""+ user_link (u) +"%"")
								set_redirection (user_url (u))
							else
									-- Register new account
								b.append ("Register new account associated with Openid %"" + l_identity + "%"?")
								across
									v.attributes as c
								loop
									b.append ("<li>" + c.key + "=" + c.item + "</li>")
								end
								set_session_item ("openid.identity", l_identity)
								if attached v.email_attribute as att_email then
									set_session_item ("openid.email", att_email)
								end
								if attached v.nickname_attribute as att_nickname then
									set_session_item ("openid.nickname", att_nickname)
								end
								b.append ("Create new account from your OpenID ")
								b.append (link ("Register new account", "/user/register", Void))
								set_redirection (url ("/user/register", Void))
							end
						end
					end
				else
					b.append ("User authentication failed!!")
				end
			elseif attached request.string_item ("openid") as p_openid then
				b.append ("Check openID: " + p_openid)
				create o.make (request.absolute_script_url ("/openid/login"))
				o.ask_email (True)
				o.ask_all_info (False)
				if attached o.auth_url (p_openid) as l_url then
					set_redirection (l_url)
				else
					b.append ("Failure")
				end
			else
				if attached user as u then
					if attached service.storage.custom_value_names_where ("uid", u.id.out, "openid") as lst then
						across
							lst as c
						loop
							b.append ("<li>OpenID: " + c.item + "</li>")
						end
					else
						b.append ("No OpenID associated with current account")
					end
				end
				create f.make (url ("/openid/login", Void), "openid-login")
				create tf.make ("openid")
				tf.set_size (50)
				tf.set_text_value ("")
				tf.set_label ("OpenID identifier")
				f.extend (tf)
				create ts.make_with_text ("op", "Validate")
				f.extend (ts)
				f.prepare (Current)
				f.append_to_html (theme, b)
			end
			set_main_content (b)
		end

	user_id_from_custom_value (lst: TABLE_ITERABLE [READABLE_STRING_8, STRING_8]): INTEGER
		local
			l_uid: detachable READABLE_STRING_8
		do
			across
				lst as c
			until
				l_uid /= Void
			loop
				if c.key.same_string ("uid") then
					l_uid := c.item
				end
			end
			if l_uid /= Void and then l_uid.is_integer then
				Result := l_uid.to_integer
			end
		end

end
