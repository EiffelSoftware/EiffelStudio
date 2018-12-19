note
	description: "[
			Administrate path aliases.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_PATH_ALIAS_HANDLER

inherit
	CMS_HANDLER

	WSF_URI_HANDLER
		rename
			new_mapping as new_uri_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get,
			do_post
		end

	REFACTORING_HELPER

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_response: CMS_RESPONSE
			l_sources: ARRAYED_LIST [READABLE_STRING_8]
			l_alias: detachable READABLE_STRING_8
			s: STRING
			b: BOOLEAN
		do
			if api.has_permission ("admin path_alias") then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)
				if attached api.storage.path_aliases as tb then
					create s.make_empty
					s.append ("<h1>Path aliases</h1>%N")
					s.append ("<a href=%"#manage-aliases%">&gt;&gt; Manage aliases ...</a><br/>")
					s.append ("<ul class=%"path_aliases%">")
					create l_sources.make (tb.count)
					l_sources.compare_objects
					across
						tb as ic
					loop
						b := l_sources.has (ic.item)
						if b then
							s.append ("<li class=%"warning%">")
						else
							s.append ("<li>")
							l_sources.force (ic.item)
						end
						if ic.key.is_valid_as_string_8 then
							l_alias := ic.key.to_string_8
							s.append (l_response.link (ic.key, l_alias, Void))
						else
							l_alias := Void
							s.append (l_response.html_encoded (ic.key))
						end
						s.append (" =&gt; ")
						s.append (l_response.link (ic.item, ic.item, Void))
						if b then
							s.append (" <span class=%"warning%">(archived)</span>")
							if l_alias /= Void then
								s.append ("<form action=%"%" method=%"POST%"><input type=%"hidden%" name=%"path_alias%" value=%"" + l_alias + "%"/><input type=%"hidden%" name=%"source%" value=%"" + ic.item + "%"/><input type=%"submit%" name=%"op%" value=%"unset%"/></form>")
							end
						end
						s.append ("</li>")
					end
					s.append ("</ul>")

					s.append ("<a name=%"manage-aliases%"></a><h1>Manage aliases</h1>%N")

						-- New Alias?
					s.append ("<fieldset><legend>New alias</legend>")
					s.append ("<form action=%"%" method=%"POST%">Alias: <input type=%"text%" name=%"path_alias%" value=%"%"/><br/>Target: <input type=%"text%" name=%"source%" value=%"%"/><br/><input type=%"submit%" name=%"op%" value=%"Set Alias%"/></form>")
					s.append ("</fieldset>")

						-- Remove Alias?					
					s.append ("<fieldset><legend>Remove existing alias</legend>")
					s.append ("<form action=%"%" method=%"POST%">Alias: <input type=%"text%" name=%"path_alias%" value=%"%"/><br/>Target: <input type=%"text%" name=%"source%" value=%"%"/><br/><input type=%"submit%" name=%"op%" value=%"unset%"/></form>")
					s.append ("</fieldset>")


				end
				l_response.set_main_content (s)
				l_response.execute
			else
				send_access_denied (req, res)
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			l_response: CMS_RESPONSE
			s: STRING
			l_delay: NATURAL_32
		do
			if api.has_permission ("admin path_alias") then
				create {GENERIC_VIEW_CMS_RESPONSE} l_response.make (req, res, api)
				create s.make_empty

				if
					attached {WSF_STRING} req.form_parameter ("path_alias") as p_alias and then
					attached {WSF_STRING} req.form_parameter ("source") as p_source
				then
					if attached {WSF_STRING} req.form_parameter ("op") as p_op and then p_op.same_string ("unset") then
						api.unset_path_alias (p_source.value.to_string_8, p_alias.value.to_string_8) -- FIXME: avoid `to_string_8`
						if api.has_error then
							s.append ("<div class=%"error%">ERROR: Path alias %"" + l_response.html_encoded (p_alias.value) + "%" raised error!</div>")
						else
							s.append ("<div class=%"success%">Path alias %"" + l_response.html_encoded (p_alias.value) + "%" is now unset!</div>")
						end
					elseif attached {WSF_STRING} req.form_parameter ("op") as p_op and then p_op.same_string ("Set Alias") then
						api.set_path_alias (p_source.value.to_string_8, p_alias.value.to_string_8, False)
						if api.has_error then
							s.append ("<div class=%"error%">ERROR: Path alias %"" + l_response.html_encoded (p_alias.value) + "%" raised error!</div>")
						else
							s.append ("<div class=%"success%">Path alias %"" + l_response.html_encoded (p_alias.value) + "%" is now set!</div>")
						end
					end
				end
				s.append ("<p><a href=%"%">Back to list of path aliases ...</a><p>")
				l_delay := 3
				s.append ("(in " + l_delay.out + " seconds...)")
				l_response.set_main_content (s)

				l_response.set_redirection (l_response.location)
				l_response.set_redirection_delay (l_delay)
				l_response.execute
			else
				send_access_denied (req, res)
					-- CHECK: set redirection?
			end
		end

end
