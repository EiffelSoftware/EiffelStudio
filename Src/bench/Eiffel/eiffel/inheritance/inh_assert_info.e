class INH_ASSERT_INFO

inherit
	SHARED_WORKBENCH

create
	make

feature {NONE} -- Initialization

	make (feat: FEATURE_I) is
			-- Update `has_precondition' and 
			-- `has_postcondition' fields.
		do
			written_in := feat.written_in
			body_index := feat.body_index
			is_origin := feat.is_origin
			has_postcondition := feat.has_postcondition
			has_precondition := feat.has_precondition
			precondition_count := feat.number_of_precondition_slots
			postcondition_count := feat.number_of_postcondition_slots
		end

feature -- Access

	written_in: INTEGER
			-- Written_in id of the routine that has assertion

	body_index: INTEGER
			-- Body index value of the routine that has the assertion

	has_postcondition: BOOLEAN
			-- Is has_postcondition set to True? 

	has_precondition: BOOLEAN
			-- Is has_precondition set to True? 

	has_assertion: BOOLEAN is
		do
			Result := (has_precondition or else has_postcondition)
		end

	precondition_count: INTEGER
			-- Number of preconditions
			-- (inherited assertions are not taken into account)

	postcondition_count: INTEGER
			-- Number of postconditions
			-- (inherited assertions are not taken into account)

	is_origin: BOOLEAN
			-- Is Current come from an origin feature?

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Check to see if assertions has changed
		do
			Result := (has_precondition = other.has_precondition) and then
					(has_postcondition = other.has_postcondition) and then
					(body_index = other.body_index and
					is_origin = other.is_origin)
		end

feature -- Debugging

	trace is
		do
			io.put_string ("written_in class: ")
			io.put_string (System.class_of_id (written_in).name)
			io.put_new_line
			io.put_string ("body_index: ")
			io.put_integer (body_index)
			io.put_new_line
			io.put_string ("has_postcondition: ")
			io.put_boolean (has_postcondition)
			io.put_new_line
			io.put_string ("has_precondition: ")
			io.put_boolean (has_precondition)
			io.put_new_line
		end

end
