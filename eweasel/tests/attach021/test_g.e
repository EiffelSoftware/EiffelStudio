class
	TEST_G [G -> ANY create default_create end]

feature -- Access

	f: attached G
		do
			Result := new_f
		end

feature {NONE} -- Factory

	new_f: attached G
		do
			create Result
		end

end
