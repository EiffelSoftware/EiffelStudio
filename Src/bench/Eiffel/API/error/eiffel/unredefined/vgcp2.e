indexing

	description: 
		"Error when a name of a creation clause is not a final name %
		%of the associated class.";
	date: "$Date$";
	revision: "$Revision $"

class VGCP2 

inherit

	VGCP
		redefine
			subcode, build_explain
		end;

feature -- Properties

	subcode: INTEGER is 2;

	feature_name: STRING;
			-- Feature name repeated in the creation clause of the class
			-- of id `class_id'

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Invalid creation procedure name: ");
			ow.put_string (feature_name);
			ow.new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_feature_name (s: STRING) is
			-- Assign `s' to `feature_name'.
		do
			feature_name := s;
		end;

end -- class VGCP2
