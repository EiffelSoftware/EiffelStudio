note
	description: "Summary description for {CJ_QUERY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	example: "[
		{
			"href": URI,
			"rel": STRING,
			"prompt": STRING,
			"name": STRING
			"data : [ARRAY]
		}
	]"

class
	CJ_QUERY

create
	make,
	make_empty

feature {NONE} -- Initialization

	make (a_href: like href; a_rel: like rel)
		do
			href := a_href
			rel := a_rel
		end

	make_empty
		do
			make ("", "")
		end

feature -- Access

	href: READABLE_STRING_8

	rel: STRING_32

	prompt: detachable STRING_32

	name: detachable STRING_32

	data: detachable ARRAYED_LIST [CJ_DATA]

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

	set_name (a_name: like name)
		do
			name := a_name
		ensure
			name_set: name ~ a_name
		end

	set_prompt (a_prompt: like prompt)
		do
			prompt := a_prompt
		ensure
			prompt_set: prompt ~ a_prompt
		end

	add_data (a_data: like data.item)
		local
			l_data: like data
		do
			l_data := data
			if l_data = Void then
				create l_data.make (1)
				data := l_data
			end
			l_data.force (a_data)
		end

note
	copyright: "2011-2021, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
