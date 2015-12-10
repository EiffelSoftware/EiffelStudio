note
	description: "Summary description for {CMS_MOTION_CATEGORY_FORM_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_CATEGORY_FORM_RESPONSE

inherit

	CMS_RESPONSE
		rename
			make as make_response
		end

create
	make


feature {NONE} -- Initialization

	make (req: WSF_REQUEST; res: WSF_RESPONSE; a_api: like api; a_motion_api: CMS_MOTION_API)
		do
			motion_api := a_motion_api
			make_response (req, res, a_api)
		end

	motion_api: CMS_MOTION_API

feature -- Query

	category_id_path_parameter (req: WSF_REQUEST): INTEGER_64
			-- Category id passed as path parameter for request `req'.
		local
			s: STRING
		do
			if attached {WSF_STRING} req.path_parameter ("id") as p_nid then
				s := p_nid.value
				if s.is_integer_64 then
					Result := s.to_integer_64
				end
			end
		end

feature -- Process

	process
			-- Computed response message.
		local
			b: STRING_8
			cid: INTEGER_64
		do
			create b.make_empty
			cid := category_id_path_parameter (request)
			if
				cid > 0 and then
				attached motion_api.category_by_id (cid) as l_category
			then
				if
					location.ends_with_general ("/edit")
				then
					edit_form (l_category)
				elseif location.ends_with_general ("/delete")  then
					delete_form (l_category)
				end
			else
				new_form
			end
		end

feature -- Process Edit

	edit_form (a_category: CMS_MOTION_LIST_CATEGORY)
		local
			f: like new_edit_form
			b: STRING
			fd: detachable WSF_FORM_DATA
		do
			create b.make_empty
			f := new_edit_form (a_category, url (location, Void), "edit-category")
			api.hooks.invoke_form_alter (f, fd, Current)
			if request.is_post_request_method then
				f.validation_actions.extend (agent new_form_validate (?, b))
				f.submit_actions.extend (agent edit_form_submit (?, a_category, b))
				f.process (Current)
				fd := f.last_data
			end
			if a_category.has_id then
				add_to_menu (create {CMS_LOCAL_LINK}.make (translation ("View", Void),  motion_api.resource_path + "/" + motion_api.item + "/category/" + a_category.id.out), primary_tabs)
				add_to_menu (create {CMS_LOCAL_LINK}.make (translation ("Edit", Void),  motion_api.resource_path + "/" + motion_api.item + "/category/" + a_category.id.out + "/edit"), primary_tabs)
--				add_to_menu (create {CMS_LOCAL_LINK}.make (translation ("Delete", Void),"resources/wish/category/" + a_category.id.out + "/delete"), primary_tabs)
			end
			if attached redirection as l_location then
				-- FIXME: Hack for now
				set_title (a_category.synopsis)
				b.append (html_encoded (a_category.synopsis) + " saved")
			else
				set_title (formatted_string (translation ("Edit $1 #$2", Void), [a_category.synopsis, a_category.id]))
				f.append_to_html (wsf_theme, b)
			end
			set_main_content (b)
		end

feature -- Process Delete

	delete_form (a_category: CMS_MOTION_LIST_CATEGORY)
		local
			f: like new_delete_form
			b: STRING
			fd: detachable WSF_FORM_DATA
		do
			create b.make_empty
			f := new_delete_form (a_category, url (location, Void), "edit-category")
			api.hooks.invoke_form_alter (f, fd, Current)
			if request.is_post_request_method then
				f.process (Current)
				fd := f.last_data
			end
			if a_category.has_id then
				add_to_menu (create {CMS_LOCAL_LINK}.make (translation ("View", Void), motion_api.resource_path + "/" + motion_api.item + "/category/" + a_category.id.out ), primary_tabs)
				add_to_menu (create {CMS_LOCAL_LINK}.make (translation ("Edit", Void), motion_api.resource_path + "/" + motion_api.item + "/category/" + a_category.id.out + "/edit"), primary_tabs)
--				add_to_menu (create {CMS_LOCAL_LINK}.make (translation ("Delete", Void),"resources/wish/category/" + a_category.id.out + "/delete"), primary_tabs)
			end
			if attached redirection as l_location then
				-- FIXME: Hack for now
				set_title (a_category.synopsis)
				b.append (html_encoded (a_category.synopsis) + " deleted")
			else
				set_title (formatted_string (translation ("Delete $1 #$2", Void), [a_category.synopsis, a_category.id]))
				f.append_to_html (wsf_theme, b)
			end
			set_main_content (b)
		end


feature -- Process New

	new_form
		local
			f: like new_edit_form
			b: STRING
			fd: detachable WSF_FORM_DATA
			l_category: detachable CMS_MOTION_LIST_CATEGORY
		do
			create b.make_empty
			f := new_edit_form (l_category, url (location, Void), "create-category")
			api.hooks.invoke_form_alter (f, fd, Current)
			if request.is_post_request_method then
				f.validation_actions.extend (agent new_form_validate (?, b))
				f.submit_actions.extend (agent edit_form_submit (?, l_category, b))
				f.process (Current)
				fd := f.last_data
			end
			if attached redirection as l_location then
				-- FIXME: Hack for now
				if attached l_category then
					set_title (l_category.synopsis)
					b.append (html_encoded (l_category.synopsis) + " Saved")
				end
			else
				if attached l_category then
					set_title (formatted_string (translation ("Saved $1 #$2", Void), [l_category.synopsis, l_category.id]))
				end
				f.append_to_html (wsf_theme, b)
			end
			set_main_content (b)
		end

feature -- Form	

	edit_form_submit (fd: WSF_FORM_DATA; a_category: detachable CMS_MOTION_LIST_CATEGORY; b: STRING)
		local
			l_update_category: BOOLEAN
			l_save_category: BOOLEAN
			l_category: detachable CMS_MOTION_LIST_CATEGORY
			s: STRING
			lnk: CMS_LINK
		do

			l_update_category := attached {WSF_STRING} fd.item ("op") as l_op and then l_op.same_string ("Update "+ motion_api.item + " category")
			if l_update_category then
				debug ("cms")
					across
						fd as c
					loop
						b.append ("<li>" +  html_encoded (c.key) + "=")
						if attached c.item as v then
							b.append (html_encoded (v.string_representation))
						end
						b.append ("</li>")
					end
				end
				if a_category /= Void then
					l_category := a_category
					if l_category.has_id then
						create {CMS_LOCAL_LINK} lnk.make (translation ("View", Void), motion_api.resource_path + "/" + motion_api.item + "/category/" + l_category.id.out )
						change_category (fd, a_category)
						s := "modified"
						set_redirection (lnk.location)
					end
				end
			end
			l_save_category := attached {WSF_STRING} fd.item ("op") as l_op and then l_op.same_string ("Create " + motion_api.item + " category")
			if l_save_category then
				debug ("cms")
					across
						fd as c
					loop
						b.append ("<li>" +  html_encoded (c.key) + "=")
						if attached c.item as v then
							b.append (html_encoded (v.string_representation))
						end
						b.append ("</li>")
					end
				end
				create_category (fd)
			end

		end

	new_edit_form (a_category: detachable CMS_MOTION_LIST_CATEGORY; a_url: READABLE_STRING_8; a_name: STRING): CMS_FORM
			-- Create a web form named `a_name' for `a_category' Category (if set), using form action url `a_url'.
		local
			f: CMS_FORM
			th: WSF_FORM_HIDDEN_INPUT
		do
			create f.make (a_url, a_name)

			create th.make ("category-id")
			if a_category /= Void then
				th.set_text_value (a_category.id.out)
			else
				th.set_text_value ("0")
			end
			f.extend (th)

			populate_form (f, a_category)

			Result := f
		end

	new_form_validate (fd: WSF_FORM_DATA; b: STRING)
		do
			if attached fd.string_item ("op") as f_op then
				if
					f_op.is_case_insensitive_equal_general ("Create " + motion_api.item + " category")
				then
					if attached fd.string_item ("synopsis") as l_synopsis then
						if attached motion_api.category_by_name (l_synopsis) then
							fd.report_invalid_field ("synopsis", "Category already taken!")
						end
					else
						fd.report_invalid_field ("synopsis", "missing synopsis")
					end
				elseif	f_op.is_case_insensitive_equal_general ("Update " + motion_api.item + " category")
				then
					if attached fd.string_item ("synopsis") as l_synopsis then
						if attached  {CMS_MOTION_LIST_CATEGORY} motion_api.category_by_name (l_synopsis) as ll_synop and then
						   attached  fd.integer_item ("category-id") as l_id and then l_id /= ll_synop.id
						then
							fd.report_invalid_field ("synopsis", "Category already taken!")
						end
					else
						fd.report_invalid_field ("synopsis", "missing synopsis")
					end

				end
			end
		end

	new_delete_form (a_category: detachable CMS_MOTION_LIST_CATEGORY; a_url: READABLE_STRING_8; a_name: STRING;): CMS_FORM
			-- Create a web form named `a_name' for node `a_user' (if set), using form action url `a_url'.
		local
			f: CMS_FORM
			ts: WSF_FORM_SUBMIT_INPUT
		do
			create f.make (a_url, a_name)
			f.extend_html_text ("<br/>")
			f.extend_html_text ("<legend>Are you sure you want to delete?</legend>")

				-- TODO check if we need to check for has_permissions!!
			if
				a_category /= Void and then
				a_category.has_id
			then
				create ts.make ("op")
				ts.set_default_value ("Delete")
				fixme ("[
					ts.set_default_value (translation ("Delete"))
					]")

				f.extend (ts)
				create ts.make ("op")
				ts.set_default_value ("Cancel")
				ts.set_formmethod ("GET")
				ts.set_formaction ("/" + motion_api.resource_path + "/" + motion_api.item + "/category/" + a_category.id.out)
				f.extend (ts)
			end

			Result := f
		end



	populate_form (a_form: WSF_FORM; a_category: detachable CMS_MOTION_LIST_CATEGORY)
			-- Fill the web form `a_form' with data from `a_category' if set,
		local
			ti: WSF_FORM_TEXT_INPUT
			ta: WSF_FORM_TEXTAREA
			fs: WSF_FORM_FIELD_SET
			cb: WSF_FORM_CHECKBOX_INPUT
			ts: WSF_FORM_SUBMIT_INPUT
		do
			if a_category /= Void then
				create fs.make
				fs.set_legend (motion_api.item + " Category Information")
				a_form.extend (fs)
				a_form.extend_html_text ("<br/>")

				create ti.make_with_text ("synopsis", a_category.synopsis)
				ti.set_label ("Synopsis")
				ti.enable_required
				fs.extend (ti)

				create ta.make ("description")
				if attached a_category.description as l_description then
					ta.set_text_value (l_description)
				end
				ta.set_label ("Category")
				fs.extend (ta)

				create cb.make ("Is Active?")
				cb.set_checked (a_category.is_active)
				cb.set_title ("Is Active")
				fs.extend (cb)

				create ts.make ("op")
				ts.set_default_value ("Update " + motion_api.item + " category")
				a_form.extend (ts)
			else
				create fs.make
				fs.set_legend ("New " + motion_api.item + " Category Information")
				a_form.extend (fs)
				a_form.extend_html_text ("<br/>")

				create ti.make_with_text ("synopsis", "")
				ti.set_label ("Synopsis")
				ti.enable_required
				fs.extend (ti)

				create ta.make ("Category")
				ta.set_label ("Category")
				fs.extend (ta)

				create cb.make ("Is Active?")
				cb.set_checked (True)
				cb.set_title ("Is Active")
				fs.extend (cb)

				create ts.make ("op")
				ts.set_default_value ("Create " + motion_api.item + " category")
				a_form.extend (ts)
			end
		end

	change_category (a_form_data: WSF_FORM_DATA; a_category: CMS_MOTION_LIST_CATEGORY)
			-- Update node `a_node' with form_data `a_form_data' for the given content type `a_content_type'.
		do
			if attached a_form_data.string_item ("op") as f_op then
				if f_op.is_case_insensitive_equal_general ("Update " + motion_api.item + " category") then
					if
						attached a_form_data.string_item ("category-id") as l_category_id and then
						attached {CMS_MOTION_LIST_CATEGORY} motion_api.category_by_id (l_category_id.to_integer_64)
					then
						if
							attached a_form_data.string_item ("synopsis") as l_synopsis
						then
							a_category.set_synopsis (l_synopsis)
							if attached a_form_data.string_item ("description") as l_description then
								a_category.set_description (l_description)
							end
							if attached a_form_data.string_item ("Is Active?") then
								a_category.set_is_active (True)
							else
								a_category.set_is_active (False)
							end
							motion_api.save_category (a_category)
						end
					end
				end
			end
		end

	create_category (a_form_data: WSF_FORM_DATA)
		local
			c: CMS_MOTION_LIST_CATEGORY
		do
			if attached a_form_data.string_item ("op") as f_op then
				if f_op.is_case_insensitive_equal_general ("Create " + motion_api.item + " category") then
					if
						attached  a_form_data.string_item ("synopsis") as l_synopsis
					then
						create c.make_empty
						c.set_synopsis (l_synopsis)
						if attached a_form_data.string_item ("description") as l_description then
							c.set_description (l_description)
						end
						if attached a_form_data.string_item ("Is Active?") then
							c.set_is_active (True)
						end

						motion_api.save_category (c)

						if motion_api.has_error then
							-- handle error
						else
							add_success_message ("Created " + motion_api.item + " category")
						end

					else
						a_form_data.report_invalid_field ("synopsis", "Missing synopsis!")
					end
				end
			end
		end


end
