class
	T_TABLE [G, H]

inherit
	T_LINEAR [H]

feature

	first is
		do
			cursor.start
		end

	cursor: T_TABLE_CURSOR [G, H]

end
