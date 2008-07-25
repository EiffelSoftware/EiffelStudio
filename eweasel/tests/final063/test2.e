class
	TEST2

feature

	f is
		do
		ensure
			true_set: (agent (a_test: BOOLEAN): BOOLEAN
				do
					Result := a_test
				end).item ([True])
		end

end
