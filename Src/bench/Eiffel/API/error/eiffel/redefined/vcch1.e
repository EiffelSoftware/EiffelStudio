-- Error when a non-deferred class has a deferred feature

class VCCH1 

inherit

	EIFFEL_ERROR
		rename
			build_explain as old_build_explain
		end;

	EIFFEL_ERROR
		redefine
			build_explain
		select
			build_explain
		end
	
feature

	a_feature: FEATURE_I;
			-- Deferred feature in non deferred class

	set_a_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		do
			a_feature := f;
		end;

	code: STRING is "VCCH1";
			-- Error code
	
	build_explain (a_clickable: CLICK_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `a_clickable'.
		do
			old_build_explain (a_clickable);
			a_clickable.put_string ("%Tfeature ");
			a_feature.append_clickable_signature (a_clickable);
			a_clickable.put_string (" written in ");
			a_feature.written_class.append_clickable_name (a_clickable);
			a_clickable.new_line;
		end;

end
