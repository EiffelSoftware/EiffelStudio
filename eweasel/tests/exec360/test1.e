expanded class
	TEST1

inherit
	HASHABLE
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			object_id := 1
			attribute_id := 0
		end

feature -- Access

	object_id: INTEGER
	attribute_id: INTEGER

	as_string: STRING
		do
			Result := object_id.out + "/" + attribute_id.out
		end

	hash_code: INTEGER
			-- For testing
		do
			Result := as_string.hash_code
		end

end
