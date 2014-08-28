note
	description: "Summary description for {CMS_PAGE_TEMPLATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SMARTY_CMS_PAGE_TEMPLATE

inherit
	CMS_PAGE_TEMPLATE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (tpl: READABLE_STRING_GENERAL; t: SMARTY_CMS_THEME)
		do
			theme := t
			create variables.make (0)
			template_name := tpl
		end

	variables: STRING_TABLE [detachable ANY]

feature -- Access

	template_name: READABLE_STRING_GENERAL

	theme: SMARTY_CMS_THEME

	prepare (page: CMS_HTML_PAGE)
		do
			variables.make (10)

			across
				page.variables as ic
			loop
				variables.force (ic.item, ic.key)
			end

			if attached page.title as l_title then
				variables.force (l_title, "title")
				variables.force (l_title, "head_title")
			else
				variables.force ("", "title")
				variables.force ("", "head_title")
			end

			variables.force (page.language, "language")
			variables.force (page.head_lines_to_string, "head_lines")

			across
				theme.regions as r
			loop
				variables.force (page.region (r.item), r.item)
			end
		end

	to_html (page: CMS_HTML_PAGE): STRING
		local
			tpl: detachable TEMPLATE_FILE
			ut: FILE_UTILITIES
			p: detachable PATH
			n: STRING_32
		do
				-- Process html generation
			template_context.set_template_folder (theme.templates_directory)
			template_context.disable_verbose
			debug ("smarty")
				template_context.enable_verbose
			end
			p := template_context.template_folder
			if p = Void then
				create p.make_current
			end
			if attached page.type as l_page_type then
				create n.make_from_string_general (l_page_type)
				n.append_character ('-')
				n.append_string_general (template_name)
				n.append_string_general (".tpl")
				if ut.file_path_exists (p.extended (n)) then
					create tpl.make_from_file (n)
				end
			end
			if tpl = Void then
				create n.make_from_string_general (template_name)
				n.append_string_general (".tpl")
				if ut.file_path_exists (p.extended (n)) then
					create tpl.make_from_file (n)
				end
			end
			if tpl /= Void then
				across
					variables as ic
				loop
					tpl.add_value (ic.item, ic.key)
				end

				debug ("cms")
					template_context.enable_verbose
				end
				tpl.analyze
				tpl.get_output
				if attached tpl.output as l_output then
					Result := l_output
				else
					create Result.make_from_string ("ERROR: template issue.")
				end
			else
				create Result.make_from_string ("ERROR: template issue.")
			end
		end

feature -- Registration

	register (v: STRING_8; k: STRING_8)
		do
			variables.force (v, k)
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
