class BB

inherit

	CC [DD [STRING]]

feature

	f is
		local
			d: DD [STRING]
		do
			create d
			item := d
		end

end -- class BB
