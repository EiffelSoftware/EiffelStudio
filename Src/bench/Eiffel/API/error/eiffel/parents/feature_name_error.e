indexing

	description: 
		"Abstract description of error in third pass.";
	date: "$Date$";
	revision: "$Revision $"

deferred class FEATURE_NAME_ERROR 

inherit

	EIFFEL_ERROR
		redefine
			trace
		end;

feature -- Properties

	feature_name:  STRING;
			-- Feature involved in the error
			-- [if Void it is in the invariant]

feature -- Output

	trace (ow: OUTPUT_WINDOW) is
		do
			print_error_message (ow);
			ow.put_string ("Class: ");
			e_class.append_signature (ow);
			if feature_name /= Void then
				ow.put_string ("%NFeature name: ");
				ow.put_string (feature_name);
				ow.new_line;
			else
				ow.put_string ("%NFeature: invariant%N");
			end;
			build_explain (ow);
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (s: STRING) is
			-- Assign `f' to `feature'.
		do
			feature_name := s;
		end;

end -- class FEATURE_NAME_ERROR
