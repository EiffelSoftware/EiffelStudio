note
	description: "[
		Describe where the block should appear on a site.
		]"
	date: "$Date$"

class
	CMS_BLOCK_REGION

create
	make

feature {NONE} -- Initialization

	make (a_name: like name)
		do
			name := a_name
			create blocks.make (1)
		end

feature -- Access

	name: READABLE_STRING_8
			-- Block region name.

	blocks: ARRAYED_LIST [CMS_BLOCK]
			-- List of blocks.

feature -- Element change

	extend (b: CMS_BLOCK)
			-- Add a block `b' to the list of `blocks'.
		do
			blocks.force (b)
		end

	remove (b: CMS_BLOCK)
		require
			has_block_b: blocks.has (b)
		do
			blocks.prune_all (b)
		end

feature -- Sort

	sort
		local
			cmp: QUICK_SORTER [CMS_BLOCK]
		do
			create cmp.make (create {COMPARABLE_COMPARATOR [CMS_BLOCK]})
			cmp.sort (blocks)
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
