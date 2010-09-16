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
				if area.item (s) = Void then
				end
			end
		end

	size: INTEGER

	area: SPECIAL [T]

end
