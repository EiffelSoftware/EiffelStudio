deferred class
	TEST1

inherit
	TEST2
		undefine
			f
		end

feature

	f is
		deferred
		ensure then
			true_set: (agent (a_test: BOOLEAN): BOOLEAN
				do
					Result := a_test
				end).item ([True])
		end

end
