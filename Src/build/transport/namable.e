
deferred class NAMABLE 
	
feature 

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
		end

end
