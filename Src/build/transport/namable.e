
deferred class NAMABLE 
	
feature 

	label: STRING is
			-- Text representing
			-- current data
		deferred
		ensure
			valid_label_result: Result /= Void;
			visual_name_if_not_void: visual_name /= Void implies Result = visual_name
		end;

	visual_name: STRING is
			-- Name shown in interface
		deferred
		end;

	set_visual_name (new_name: STRING) is
			-- Set visual_name to `new_name'.
		deferred
		end;

end
