note
	description: "[
		A link shoud contain the following properties hrer(REQUIRED), rel (REQUIRED), name(OPTIONAL)
		render(OPTIONAL), prompt (OPTIONAL).
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_LINK

create
	make_empty,
	make

feature {NONE} -- Initialization

	make_empty
		do
			href := ""
			rel := ""
		end

	make (a_href: like href; a_rel: like rel)
		do
			href := a_href
			rel := a_rel
		end


feature -- Access

	href: STRING

	rel: STRING_32

	prompt: detachable STRING_32

	name: detachable STRING_32

	render: detachable STRING_32

feature -- Element Change

	set_href (a_href: like href)
		do
			href := a_href
		ensure
			href_set: href ~ a_href
		end

	set_rel (a_rel: like rel)
		do
			rel := a_rel
		ensure
			rel_set: rel ~ a_rel
		end

	set_prompt (a_prompt: like prompt)
		do
			prompt := a_prompt
		ensure
			prompt_set: prompt ~ a_prompt
		end

	set_name (a_name: like name)
		do
			name := a_name
		ensure
			name_set: name ~ a_name
		end

	set_render (a_render: like render)
		do
			render := a_render
		ensure
			render_set: render ~ a_render
		end

note
	copyright: "2011-2012, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
