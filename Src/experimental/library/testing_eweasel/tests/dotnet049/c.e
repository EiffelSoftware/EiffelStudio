class C

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code
		end

feature

	get_hash_code: INTEGER is
		do
			Result := 5
		end

end