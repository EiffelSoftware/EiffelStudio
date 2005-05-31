indexing

	description: "Error with bracket expression";
	date: "$Date$";
	revision: "$Revision$"

deferred class VWBR

inherit

	FEATURE_ERROR
		undefine
			subcode
		redefine
			build_explain, is_defined
		end
	
feature -- Properties

	target_class: CLASS_C
			-- Class for which bracket expression is applied

	code: STRING is "VWBR"
			-- Error code

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then
				target_class /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		do
			st.add_string ("Target class: ")
			target_class.append_name (st)
			st.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_target_class (t: CLASS_C) is
			-- Assign `t' to `target_class'.
		require
			t_not_void: t /= Void
		do
			target_class := t
		end

end
