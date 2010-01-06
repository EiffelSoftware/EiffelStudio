class
	TEST_G [G -> ANY create default_create end]

feature -- Access

	f: !G
		do
			Result := new_f
		end

feature {NONE} -- Factory

	new_f: !G
		do
			create Result
		end

end
