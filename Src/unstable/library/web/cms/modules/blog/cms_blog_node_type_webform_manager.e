note
	description: "Summary description for {CMS_BLOG_NODE_TYPE_WEBFORM_MANAGER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BLOG_NODE_TYPE_WEBFORM_MANAGER

inherit
	CMS_NODE_TYPE_WEBFORM_MANAGER [CMS_BLOG]
		redefine
			content_type,
			populate_form,
			update_node,
			new_node,
			append_html_output_to
		end

create
	make

feature -- Access

	content_type: CMS_BLOG_NODE_TYPE
			-- Associated content type.	

feature -- form			

	populate_form (response: NODE_RESPONSE; f: CMS_FORM; a_node: detachable CMS_NODE)
		local
			ti: WSF_FORM_TEXT_INPUT
			s: STRING_32
		do
			Precursor (response, f, a_node)
			create ti.make ("tags")
			ti.set_label ("Tags")
			ti.set_size (70)
			if
				a_node /= Void and then
				attached {CMS_BLOG} a_node as a_blog and then
			 	attached a_blog.tags as l_tags
			 then
				create s.make_empty
				across
					l_tags as ic
				loop
					if not s.is_empty then
						s.append_character (',')
					end
					s.append (ic.item)
				end
				ti.set_text_value (s)
			end
			ti.set_is_required (False)
			f.extend (ti)
		end

	update_node	(response: NODE_RESPONSE; fd: WSF_FORM_DATA; a_node: CMS_NODE)
		do
			Precursor (response, fd, a_node)
			if attached fd.string_item ("tags") as l_tags then
				if attached {CMS_BLOG} a_node as l_blog then
					l_blog.set_tags_from_string (l_tags)
				end
			end
		end

	new_node (response: NODE_RESPONSE; fd: WSF_FORM_DATA; a_node: detachable like new_node): like content_type.new_node
			-- <Precursor>
		do
			Result := Precursor (response, fd, a_node)
			if attached fd.string_item ("tags") as l_tags then
				Result.set_tags_from_string (l_tags)
			end
		end

feature -- Output

	append_html_output_to (a_node: CMS_NODE; a_response: NODE_RESPONSE)
			-- <Precursor>
		local
			s: STRING
		do
			Precursor (a_node, a_response)
			if attached a_response.main_content as l_main_content then
				s := l_main_content
			else
				create s.make_empty
			end

			if attached {CMS_BLOG} a_node as l_blog_post then
				if attached l_blog_post.tags as l_tags then
					s.append ("<div><strong>Tags:</strong> ")
					across
						l_tags as ic
					loop
						s.append ("<span class=%"tag%">")
						s.append (a_response.html_encoded (ic.item))
						s.append ("</span> ")
					end
					s.append ("</div>")
				end
			end
			a_response.set_main_content (s)
		end



end
