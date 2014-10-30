note
	description: "Summary description for {CMS_BLOCK_REGION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_BLOCK_REGION

create
	make

feature {NNE} -- Initialization

	make (a_name: like name)
		do
			name := a_name
			create blocks.make (1)
		end

feature -- Access

	name: READABLE_STRING_8

	blocks: ARRAYED_LIST [CMS_BLOCK]

feature -- Element change

	extend (b: CMS_BLOCK)
		do
			blocks.force (b)
		end

;note
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
