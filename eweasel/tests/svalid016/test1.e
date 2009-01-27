class
	TEST1

feature

	f (a: A)
		do
		end

	g (a: A)
		do
			if not is_empty then
			else
				if pos > 0 then
				elseif pos < 0 then
				else
					from
					until
						pos = 0
					loop
						f (a)
					end
				end
			end
		end

	is_empty: BOOLEAN
		do
		end

	pos: INTEGER
		do
		end

end
