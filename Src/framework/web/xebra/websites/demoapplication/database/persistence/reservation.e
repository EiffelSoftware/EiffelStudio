note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	RESERVATION

create
	make, make_with_arguments

feature {NONE} -- Initialization

	make_with_arguments (a_id: INTEGER; a_name: STRING; a_date: STRING; a_persons: INTEGER; a_description: STRING)
			-- Initialization for `Current'.
		require
			not_a_name_is_detached_or_not_empty: a_name /= Void implies not a_name.is_empty
			not_a_date_is_detached_or_empty: a_date /= Void and then not a_date.is_empty
			not_a_description_is_detached_or_empty: a_description /= Void and then not a_description.is_empty
		do
			id := a_id
			name := a_name
			date:=  a_date
			persons:= a_persons
			description:= a_description
		ensure
			id_set: equal (id, a_id)
			name_set: equal (name, a_name)
			date_set: equal (date, a_date)
			persons_set: equal (persons, a_persons)
			description_set: equal (description, a_description)
		end

	make
		do
			id := 0
			name := ""
			persons := 0
			description := ""
		end

feature -- Access

	id: INTEGER
	name: STRING assign set_name
	set_name (a_name: STRING)
		do
			name := a_name
		end
	date:  STRING
	persons: INTEGER
	description: STRING assign set_description
	set_description (a_desc: STRING)
		do
			description := a_desc
		end


invariant
	not_name_is_detached_or_empty: name /= Void and then not name.is_empty
	not_date_is_detached_or_empty: date /= Void and then not date.is_empty
	not_description_is_detached_or_empty: description /= Void and then not description.is_empty
end
