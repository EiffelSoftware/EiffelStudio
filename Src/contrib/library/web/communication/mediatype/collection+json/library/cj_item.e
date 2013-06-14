note
	description: "An item should contain, and href property."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	example: "[
		{
			"href": URI
			"data": [ARRAY]
			"links": [ARRAY]
		}
	]"

class
	CJ_ITEM

create
	make,
	make_empty

feature {NONE} -- Initialization

	make_empty
		do
			make ("")
		end

	make (a_href: like href)
		do
			href := a_href
		end

feature -- Access

	href: STRING
			-- URI

	data: detachable ARRAYED_LIST [CJ_DATA]
			--may have a data array

	links: detachable ARRAYED_LIST [CJ_LINK]
			--may have a links array

feature -- Element Change

	set_href (a_href: like href)
		do
			href := a_href
		ensure
			href_set: href ~ a_href
		end

	add_data (a_data: CJ_DATA)
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

	add_link (a_link: CJ_LINK)
		local
			l_links: like links
		do
			l_links := links
			if l_links = Void then
				create l_links.make (1)
				links := l_links
			end
			l_links.force (a_link)
		end

note
	copyright: "2011-2012, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
