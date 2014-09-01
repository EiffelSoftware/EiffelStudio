note
	description: "Summary description for {CMS_PAGE_CONTENT_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_PAGE_CONTENT_TYPE

inherit
	CMS_CONTENT_TYPE

create
	make

feature {NONE} -- Initialization

	make
		do
			create {ARRAYED_LIST [like available_formats.item]} available_formats.make (1)
			available_formats.extend (formats.plain_text)
			available_formats.extend (formats.filtered_html)
			available_formats.extend (formats.full_html)
		end

feature -- Access

	name: STRING = "page"

	title: STRING = "basic page"

	description: detachable READABLE_STRING_8
			-- Optional description
		do
			Result := "Use <em>basic pages</em> for your static content, such as an 'About us' page."
		end

	available_formats: LIST [CMS_FORMAT]

feature -- Factory

	fill_edit_form (f: CMS_FORM; a_node: detachable CMS_NODE)
		local
			ti: WSF_FORM_TEXT_INPUT
			fset: WSF_FORM_FIELD_SET
			ta: WSF_FORM_TEXTAREA
			tselect: WSF_FORM_SELECT
			opt: WSF_FORM_SELECT_OPTION
		do
			create ti.make ("title")
			ti.set_label ("Title")
			ti.set_size (70)
			if a_node /= Void then
				ti.set_text_value (a_node.title)
			end
			ti.set_is_required (True)
			f.extend (ti)

			f.extend_html_text ("<br/>")

			create ta.make ("body")
			ta.set_rows (10)
			ta.set_cols (70)
			if a_node /= Void then
				ta.set_text_value (a_node.body)
			end
--			ta.set_label ("Body")
			ta.set_description ("This is the main content")
			ta.set_is_required (False)

			create fset.make
			fset.set_legend ("Body")
			fset.extend (ta)

			fset.extend_html_text ("<br/>")

			create tselect.make ("format")
			tselect.set_label ("Body's format")
			tselect.set_is_required (True)
			across
				 available_formats as c
			loop
				create opt.make (c.item.name, c.item.title)
				if attached c.item.help as f_help then
					opt.set_description ("<ul>" + f_help + "</ul>")
				end
				tselect.add_option (opt)
			end
			if a_node /= Void then
				tselect.set_text_by_value (a_node.format.name)
			end

			fset.extend (tselect)

			f.extend (fset)

		end

	change_node	(a_execution: CMS_EXECUTION; fd: WSF_FORM_DATA; a_node: like new_node)
		local
			b: detachable READABLE_STRING_8
			f: detachable CMS_FORMAT
		do
			if attached fd.integer_item ("id") as l_id and then l_id > 0 then
				check a_node.id = l_id end
			end
			if attached fd.string_item ("title") as l_title then
				a_node.set_title (l_title)
			end

			if attached fd.string_item ("body") as l_body then
				b := l_body
			end
			if attached fd.string_item ("format") as s_format and then attached formats.format (s_format) as f_format then
				f := f_format
			elseif a_node /= Void then
				f := a_node.format
			else
				f := formats.default_format
			end
			if b /= Void then
				a_node.set_body (b, f)
			end
		end

	new_node (a_execution: CMS_EXECUTION; fd: WSF_FORM_DATA; a_node: detachable like new_node): CMS_PAGE
			-- <Precursor>
		local
			b: detachable READABLE_STRING_8
			f: detachable CMS_FORMAT
			l_node: detachable like new_node
		do
			l_node := a_node
			if attached fd.integer_item ("id") as l_id and then l_id > 0 then
				if l_node /= Void then
					check l_node.id = l_id end
				else
					if attached {like new_node} a_execution.service.storage.node (l_id) as n then
						l_node := n
					else
						-- FIXME: Error
					end
				end
			end
			if attached fd.string_item ("title") as l_title then
				if l_node = Void then
					create l_node.make_new (l_title)
				else
					l_node.set_title (l_title)
				end
			else
				if l_node = Void then
					create l_node.make_new ("...")
				end
			end
			l_node.set_author (a_execution.user)

			if attached fd.string_item ("body") as l_body then
				b := l_body
			end
			if attached fd.string_item ("format") as s_format and then attached formats.format (s_format) as f_format then
				f := f_format
			elseif a_node /= Void then
				f := a_node.format
			else
				f := formats.default_format
			end
			if b /= Void then
				l_node.set_body (b, f)
			end
			Result := l_node
		end

invariant

note
	copyright: "2011-2013, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
