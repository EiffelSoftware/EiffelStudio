

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

	trace (ow: OUTPUT_WINDOW) is
		do
			print_error_message (ow);
			ow.put_string ("Class: ");
			class_c.e_class.append_signature (ow);
			if feature_i /= Void then
				ow.put_string ("%NFeature: ");
				feature_i.append_name (ow, class_c);
			elseif feature_name /= Void then
				ow.put_string ("%NFeature: ");
				ow.put_string (feature_name);
			else
				ow.put_string ("%NFeature: invariant");
			end;
			ow.new_line;
			build_explain (ow);
		end;

end
