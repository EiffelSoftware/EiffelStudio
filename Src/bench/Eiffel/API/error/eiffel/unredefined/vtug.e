indexing

	description: 
		"Error when a generic type has not the exact number %
		%of generic parameters.";
	date: "$Date$";
	revision: "$Revision $"

class VTUG 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, is_defined
		end;

feature -- Properties

	code: STRING is "VTUG";

	e_feature: E_FEATURE;

	type: TYPE_A;
			-- Type violating the rule

	entity_name: STRING;
			-- I-th argument of the involved feature ?

	base_class: CLASS_C;

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				type /= Void and then
				base_class /= Void
		ensure then
			valid_type: Result implies type /= Void;
			valid_base_class: Result implies base_class /= Void;
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			if e_feature /= Void then
				st.add_string ("In feature: ");
				e_feature.append_name (st);
			else
				st.add_string ("In inheritance clause");
			end;
			st.add_new_line;
			if entity_name /= Void then
				st.add_string ("Entity name: ");
				st.add_string (entity_name);
				st.add_new_line;
			end;
			st.add_string ("Invalid type: ");
			type.append_to (st);
			st.add_new_line;
			st.add_string ("Base class: ");
			base_class.append_signature (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_base_class (c: CLASS_C) is
		require
			valid_c: c /= Void
		do
			base_class := c
		end;

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		require
			valid_t: t /= Void
		do
			type := t;
		end;

	set_feature (f: FEATURE_I) is
		do
			if f /= Void then
				e_feature := f.api_feature (f.written_in);
			end
		end;

	set_entity_name (i: STRING) is
			-- Assign `i' to `entity_name' ?
		do
			entity_name := i;
		end;

end -- class VTUG
