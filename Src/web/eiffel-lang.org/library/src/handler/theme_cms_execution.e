note
	description: "[
			]"

class
	THEME_CMS_EXECUTION

inherit
	CMS_EXECUTION

create
	make

feature -- Execution

	process
			-- Computed response message.
		local
--			l_url: READABLE_STRING_8
			b: STRING_8
		do
			set_title ("Home")
			create b.make_empty

			b.append ("<h1>Home</h1>%N")
			if attached service.storage.recent_nodes (1, 10) as l_nodes then
				across
					l_nodes as c
				loop
					b.append ("<div class=%"node-wrapper%">")
					b.append (c.item.to_html (theme))
					b.append ("</div>%N")
				end
			end

--			b.append ("<ul>%N")
--			l_url := url ("/", Void)
--			b.append ("<li><a href=%"" + l_url + "%">Home</a></li>%N")
--			l_url := url ("/info/", Void)
--			b.append ("<li><a href=%"" + l_url + "%">EWF Info</a></li>%N")

--			b.append ("</ul>%N")

			set_main_content (b)
		end

end
