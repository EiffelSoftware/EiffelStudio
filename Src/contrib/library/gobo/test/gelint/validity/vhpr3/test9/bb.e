class BB

inherit

	CC [DD [like Current]]

feature

	f is
		local
			d: DD [like Current]
		do
			create d
			item := d
		end

end -- class BB
