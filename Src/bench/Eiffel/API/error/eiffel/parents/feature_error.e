

deferred class FEATURE_ERROR 

inherit

	EIFFEL_ERROR
		redefine
			trace
		end;

feature 

	feature_i: FEATURE_I;
			-- Feature involved in the error
			-- [if Void it is in the invariant]

	set_feature (f: FEATURE_I) is
			-- Assign `f' to `feature'.
		do
			feature_i := f;
		end;

	feature_name: STRING;

	set_feature_name (s: STRING) is
		obsolete "Use `set_feature' if a FEATURE_I is defined%N%
				%or change the inheritance clause from FEATURE_ERROR%N%
				%to FEATURE_NAME_ERROR"
		do
			feature_name := s;
		end;

	trace is
		do
			print_error_message;
			put_string ("Class: ");
			class_c.append_clickable_signature (error_window);
			if feature_i /= Void then
				put_string ("%NFeature: ");
				feature_i.append_clickable_name (error_window, class_c);
			elseif feature_name /= Void then
				put_string ("%NFeature: ");
				put_string (feature_name);
			else
				put_string ("%NFeature: invariant");
			end;
			new_line;
			build_explain;
		end;

end
