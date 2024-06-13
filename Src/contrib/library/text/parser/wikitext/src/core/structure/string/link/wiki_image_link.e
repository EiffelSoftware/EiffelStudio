note
	description: "[
		Summary description for {WIKI_IMAGE_LINK}.
		
		could be ..
			[[Image:Wiki.png|frame|This is Wiki's logo]]
			[[:Image:Wiki.png]]    (direct link to image's page .. do not display)
			
			[[Media:Wiki.png]]    (direct link to the image itself)
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_IMAGE_LINK

inherit
	WIKI_FILE_LINK
		redefine
			wiki_tag_name,
			is_image,
			process
		end

create
	make,
	make_inlined

feature {NONE} -- Identifier

	wiki_tag_name: STRING
		once
			Result := "image:"
		end

feature -- Status report

	is_image: BOOLEAN = True

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_image_link (Current)
		end

note
	copyright: "2011-2024, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
