-- Error when a generic type has not the exact number of generic parameters

class VTUG 

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end;

feature 

	code: STRING is "VTUG";

	feature_i: FEATURE_I;

	set_feature (f: FEATURE_I) is
		do
			feature_i := f;
		end;

	type: TYPE_A;
			-- Type violating the rule

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	base_class: CLASS_C;

	set_base_class (c: CLASS_C) is
		do
			base_class := c;
		end;

	entity_name: STRING;
			-- I-th argument of the involved feature ?

	set_entity_name (i: STRING) is
			-- Assign `i' to `entity_name' ?
		do
			entity_name := i;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			if feature_i /= Void then
				ow.put_string ("In feature: ");
				feature_i.append_name (ow, feature_i.written_class);
				ow.new_line;
			else
				ow.put_string ("In inheritance clause%N");
			end;
			if entity_name /= Void then
				ow.put_string ("Entity name: ");
				ow.put_string (entity_name);
				ow.new_line;
			end;
			ow.put_string ("Invalid type: ");
			type.append_to (ow);
			ow.put_string ("%NBase class: ");
			base_class.e_class.append_signature (ow);
			ow.new_line;
		end;

end
