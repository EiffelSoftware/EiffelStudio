note
	description: "[
			]"

class
	NODE_ADD_CMS_EXECUTION

inherit
	NODE_CMS_EXECUTION

create
	make

feature -- Execution

	process
			-- Computed response message.
		local
			b: STRING_8
			f: like edit_form
			fd: detachable WSF_FORM_DATA
		do
			create b.make_empty
			if attached non_empty_string_path_parameter ("type") as s_type then
				if attached service.content_type (s_type) as l_type then
					f := edit_form (Void, url (request.path_info, Void), "add-" + l_type.name, l_type)
					set_title ("Create " + l_type.title)
					if has_permission ("create " + l_type.name) then
						if request.is_post_request_method then
							f.validation_actions.extend (agent edit_form_validate (?, b))
							f.submit_actions.extend (agent edit_form_submit (?, Void, l_type, b))
							f.process (Current)
							fd := f.last_data
						end
						f.append_to_html (theme, b)
					else
						set_title ("Access denied")
					end
				else
					set_title ("Unknown content type [" + s_type + "]")
				end
			else
				set_title ("Create new content ...")
				b.append ("<ul id=%"content-types%">")
				across
					service.content_types as c
				loop
					if has_permission ("create " + c.item.name) then
						b.append ("<li>" + link (c.item.name, "/node/add/" + c.item.name, Void))
						if attached c.item.description as d then
							b.append ("<div class=%"description%">" + d + "</div>")
						end
						b.append ("</li>")
					end
				end
				b.append ("</ul>")
			end
			set_main_content (b)
		end

end
