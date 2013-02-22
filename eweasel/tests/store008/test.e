class
	TEST

inherit
	SERIALIZATION_HELPER

create
	make, default_create

feature -- Initialization

	make
			-- Creation procedure.
		local
			l_file: RAW_FILE
			l_objects: like retrieved_objects
		do
			$CREATE
			create l_file.make_with_name ("titi")
			if l_file.exists then
				l_objects := retrieved_recoverable_objects ("stored")
				if l_objects.count /= recoverable_types.count then
					io.put_string ("Error occurred. List of successful retrieval:%N")
					across l_objects as l_item loop
						io.put_string ("Retrieved " + l_item.key + "%N")
					end
				end
			else
					-- Mark that we have stored the object once.
				l_file.open_write
				l_file.close
				store_object (Current, "stored")
			end
		end

	$ATTRIBUTE

end
