indexing

	description: 
		"Error when undefinition of an attribute, a once, a constant %
		%or a frozen feature";
	date: "$Date$";
	revision: "$Revision $"

class VDUS2 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode, is_defined
		end;
	
feature -- Properties

	undefined_feature: E_FEATURE;
			-- Undefined feature

	parent: E_CLASS;
			-- Parent from which `undefined_feature' is inherited

	code: STRING is "VDUS";
			-- Error code

	subcode: INTEGER is
		do
			Result := 2;
		end;

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				undefined_feature /= Void
		ensure then	
			valid_undefined_feature: Result implies undefined_feature /= Void
		end

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation image for current error
			-- in `ow'.
		do
			ow.put_string ("Feature: ");
			undefined_feature.append_signature (ow, undefined_feature.written_class);
			ow.put_string ("%NIn Undefine clause for parent: ");
			parent.append_name (ow);
			ow.new_line
		end

feature {COMPILER_EXPORTER}

	set_a_feature (f: FEATURE_I) is
			-- Assign `f' to `a_feature'.
		require
			valid_f: f /= Void
		do
			undefined_feature := f.api_feature;
		end;

	set_parent (c: CLASS_C) is
			-- Assign `c' to `parent'.
		require
			valid_c: c /= Void
		do
			parent := c.e_class;
		end;

end -- class VDUS2
