class INH_ASSERT_INFO

inherit

	SHARED_WORKBENCH

creation

	make

feature

	written_in: CLASS_ID;
			-- Written_in id of the routine that has assertion

	body_index: BODY_INDEX;
			-- Body index value of the routine that has the assertion

	has_postcondition: BOOLEAN;
			-- Is has_postcondition set to True? 

	has_precondition: BOOLEAN;
			-- Is has_precondition set to True? 

	make, update (feat: feature_i) is
			-- Update `has_precondition' and 
			-- `has_postcondition' fields.
		do
			written_in := feat.written_in;
			body_index := feat.body_index;
			is_origin := feat.is_origin;
			has_postcondition := feat.has_postcondition;
			has_precondition := feat.has_precondition;
		end;

	has_assertion: BOOLEAN is
		do
			Result := (has_precondition or else has_postcondition)
		end;

	same_as (other: like Current): BOOLEAN is
			-- Check to see if assertions has changed
		do
			Result := (has_precondition = other.has_precondition) and then
					(has_postcondition = other.has_postcondition) and then
					(equal (body_index, other.body_index) and
					is_origin = other.is_origin)
		end;

	is_origin: BOOLEAN;
			-- Is Current come from an origin feature?

	trace is
		do
			io.putstring ("written_in class: ");
			io.putstring (System.class_of_id (written_in).name);
			io.new_line;
			io.putstring ("body_index: ");
			io.putstring (body_index.dump);
			io.new_line;
			io.putstring ("has_postcondition: ");
			io.putbool (has_postcondition);
			io.new_line;
			io.putstring ("has_precondition: ");
			io.putbool (has_precondition);
			io.new_line;
		end;

end
