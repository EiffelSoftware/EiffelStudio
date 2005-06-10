indexing

	description: "Error for assigner call which source type is not compatible with target type.";
	date: "$Date$";
	revision: "$Revision$"

class VBAC1

inherit
	VBAC
		redefine
			build_explain,
			is_defined
		end
	
feature -- Properties

	target_type: TYPE_A
			-- Target type of the assignment (left part)

	source_type: TYPE_A
			-- Source type of the assignment (right part)

	subcode: INTEGER is 1
			-- Error subcode

feature -- Status report

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := Precursor and then
				target_type /= Void and then source_type /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		do
			st.add_string ("Target type: ");
			target_type.append_to (st);
			st.add_new_line;
			st.add_string ("Source type: ");
			source_type.append_to (st);
			st.add_new_line
		end

feature {COMPILER_EXPORTER}

	set_target_type (t: TYPE_A) is
			-- Assign `t' to `target_type'.
		do
			target_type := t
		end

	set_source_type (s: TYPE_A) is
			-- Assign `s' to `source_type'.
		do
			source_type := s
		end

end
