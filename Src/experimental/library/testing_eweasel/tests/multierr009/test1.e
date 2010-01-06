class
	TEST1

feature

	att: STRING

	make is
		require
			bad_guy2: (agent (s: STRING) do s.wrong end) /= Void
		do
		end

end
