
deferred class NAMABLE 
	
feature 

	title_label: STRING is
			-- Text representing current data for namer window title.
			-- (By default returns label)
		do
			Result := label
		end;

	label: STRING is
			-- Text representing
			-- current data
		require
			is_able_to_be_named: is_able_to_be_named
		deferred
		ensure
			valid_label_result: Result /= Void;
			visual_name_if_not_void: visual_name /= Void implies Result = visual_name
		end;

	visual_name: STRING is
			-- Name shown in interface
		require
			is_able_to_be_named: is_able_to_be_named
		deferred
		end;

	set_visual_name (new_name: STRING) is
			-- Set visual_name to `new_name'.
		require
			is_able_to_be_named: is_able_to_be_named
		deferred
		end;

	is_able_to_be_named: BOOLEAN is
			-- Is Current able to be named at the moment?
		do
			Result := true
		end;

	check_new_name (new_name: STRING) is
			-- Check `new_name' before setting visual name
		require
			valid_new_name: new_name /= Void
		do
		end;

	is_valid_new_name: BOOLEAN is
			-- Is new_name valid (after check_new_name)?
		do
			Result := True
		end;

end
