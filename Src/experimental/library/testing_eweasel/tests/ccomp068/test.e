class
	TEST

create
	make

feature -- Initialization

	make is
		do
			ensure_storable_compatibility_with_56
		end

	ensure_storable_compatibility_with_56 is
		indexing
			once_status : global
		once
			do_nothing
		end

end
