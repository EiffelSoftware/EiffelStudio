class
	CACHE [T]

feature

	wipe_out is
		local
			s: INTEGER
		do
			from
				s := Size
			until
				s = 0
			loop
				s := s - 1
				area.item(s).do_nothing
			end
		end

	size: INTEGER

	area: SPECIAL [T]

end
