indexing

	description: 
		"Error when bad conformance on first argument of an infix function.";
	date: "$Date$";
	revision: "$Revision $"

class VWOE1 

inherit

	VWOE
		redefine
			build_explain, is_defined
		end
	
feature -- Properties

	formal_type: TYPE_A;
			-- Formal argument type

	actual_type: TYPE_A;
			-- Actual type of the argument in the call

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then
				formal_type /= Void and then
				actual_type /= Void
		ensure then
			valid_formal_type: formal_type /= Void;
			valid_actual_type: actual_type /= Void;
		end;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("Formal type: ");
			formal_type.append_to (st);
			st.add_string ("%NActual type: ");
			actual_type.append_to (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_formal_type (t: TYPE_A) is
			-- Assign `t' to `formal_type'.
		require
			valid_t: t /= Void
		do
			formal_type := t;
		end;

	set_actual_type (t: TYPE_A) is
			-- Assign `t' to `actual_type'
		require
			valid_t: t /= Void
		do
			actual_type := t;
		end;

end -- class VWOE1
