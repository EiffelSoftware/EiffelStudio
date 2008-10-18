class TEST1 [G]

inherit
	TEST2 [G]

feature

	extend (a_item: like g_template)
		local
			l_cell: CELL [like g_template]
		do
			create l_cell.put (a_item)
		end

end
