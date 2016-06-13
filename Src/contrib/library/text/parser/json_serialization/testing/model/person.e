class
	PERSON

create
	make

feature {NONE} -- Initialization

	make (a_first_name, a_last_name: READABLE_STRING_GENERAL)
		do
			create first_name.make_from_string_general (a_first_name)
			create last_name.make_from_string_general (a_last_name)
		end

feature -- Access

	first_name: IMMUTABLE_STRING_32

	last_name: IMMUTABLE_STRING_32

	details: detachable PERSON_DETAILS

feature -- Element change

	set_details (d: like details)
		do
			details := d
		end

invariant

end
