indexing

	description: 
		"Error when a prefix/infix operator doesn't %
		%exist in a class.";
	date: "$Date$";
	revision: "$Revision $"

class VWOE 

inherit

	FEATURE_ERROR
		redefine
			build_explain, is_defined
		end
	
feature -- Properties

	other_class: CLASS_C;
			-- Class for which there is no infix/prefix feature

	op_name: STRING;
			-- Internal name of the infix/prefix feature

	code: STRING is "VWOE";
			-- Error code

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then
				op_name /= Void and then
				other_class /= Void
		end;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		do
			st.add_indent;
			st.add_string ("There is no feature ");
			st.add_string (op_name);
			st.add_string (" in class ");
			other_class.append_name (st);
			st.add_new_line;
		end

feature {COMPILER_EXPORTER} -- Setting

	set_other_class (o: CLASS_C) is
			-- Assign `o' to `other_class'.
		require
			valid_o: o /= Void
		do
			other_class := o
		end;

	set_op_name (s: STRING) is
			-- Assign `s' to `op_name'.
		do
			op_name := s;
		end;

end -- class VWOE
