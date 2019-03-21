class TEST

create
	make

feature {NONE} -- Creation

	make
			-- An feature without arguments but with a separate instruction calling a feature with separate argument.
		do
			separate s as t do
				f (t)
			end
		end

feature {TEST} -- Test

	s: separate TEST
			-- A feature that returns an object of a separate type.
		do
			Result := Current
		end

	f (t: separate TEST)
			-- A feature that takes a separate argument.
		do
			if t = Current then
				print ("OK%N")
			end
		end

end
