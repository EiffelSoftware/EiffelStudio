-- Abstract description of error in third pass

deferred class FEATURE_NAME_ERROR 

inherit

	EIFFEL_ERROR
		redefine
			trace
		end;

feature 

	feature_name:  STRING;
			-- Feature involved in the error
			-- [if Void it is in the invariant]

	set_feature_name (s: STRING) is
			-- Assign `f' to `feature'.
		do
			feature_name := s;
		end;

	trace is
		do
			print_error_message;
			put_string ("Class: ");
			class_c.append_clickable_signature (error_window);
			if feature_name /= Void then
				put_string ("%NFeature name: ");
				put_string (feature_name);
				new_line;
			else
				put_string ("%NFeature: invariant%N");
			end;
			build_explain;
		end;

end
