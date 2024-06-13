note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEMO

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			src: STRING
			wt: WIKI_CONTENT_TEXT
			pg: WIKI_PAGE
			html: STRING_8
			htmlgen: WIKI_XHTML_GENERATOR
			demo_resolver: DEMO_RESOLVER
		do
			src := wikitext_example

			create wt.make_from_string (src)
			create pg.make_with_title ("Wikitext Example")
			pg.set_text (wt)

			create html.make_empty -- The string that will contain the generated XHTML
			create demo_resolver -- Resolver for links, templates, images and files
			create htmlgen.make (html) -- The XHTML generator from wikitext content
			htmlgen.register_resolvers (demo_resolver)
			pg.process (htmlgen) -- Generate the XHTML content.

			print (html)
			open_in_browser (html)
		end

feature -- Status

feature -- Access

	wikitext_example: STRING = "[
This is the '''first''' line
{{TOC|limit=2}}
=One=
== one.1 ==
=== one.1.1 ===
=== one.1.2 ===
== one.2 ==
== one.3 ==
=Two=
== two.1 ==
== two.2 ==
=Resources=
== Images ==
* A picture: [[Image:wiki|Official wiki image]]
== Files ==
* The Wikipedia Logo: [[File:wiki.png|frame|center|alt=wiki image|link=Wikipedia|Wikipedia Logo]]
* The Wikipedia Logo from external link: [[File:wiki.png|right|alt=wiki image|link=https://upload.wikimedia.org/wikipedia/en/b/bc/Wiki.png|Wikipedia Logo]]
* The Wikipedia Logo without link: [[File:wiki.png|50px|link=|Wikipedia Logo]]
== Links ==
* A wiki link: [[Other page| another wiki page...]]
* A external link: [https://www.eiffel.org/doc/contribute/Help_to_edit_documentation how to edit documentation content on eiffel.org]
=== three.2.1 ===
=== three.2.2 ===
== three.3 ==
{{rule| name=demo | text=this is a rule example}}
{{SeeAlso| Look at the '''test cases''', this a going place to learn how to use the ''Wikitext'' library}}
This is the '''last''' line.
	]"

feature -- Change

	open_in_browser (txt: STRING_8)
		local
			dir: DIRECTORY
			f: PLAIN_TEXT_FILE
		do
			if attached {EXECUTION_ENVIRONMENT}.current_working_path as tmp_path then
				create f.make_with_path (tmp_path.extended ("tmp-wiki-demo.html"))
				f.open_write
				f.put_string (txt)
				f.close
				if {PLATFORM}.is_windows then
					{EXECUTION_ENVIRONMENT}.launch ({STRING_32} "cmd /C %"start "+ f.path.name + {STRING_32} "%"")
				else
					{EXECUTION_ENVIRONMENT}.launch ({STRING_32} "firefox %"" + f.path.name + {STRING_32} "%"")
				end
				{EXECUTION_ENVIRONMENT}.sleep (1_000_000_000) -- 1 sec
				f.delete
			end
		end

feature {NONE} -- Implementation

invariant
--	invariant_clause: True

end
