indexing
	description: "Error when a local variable name is a feature name also."
	date: "$Date$"
	revision: "$Revision$"

class VRLE1 

inherit
	FEATURE_ERROR
		redefine
			build_explain, subcode
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

feature -- Properties

	local_name: STRING
			-- Local variable name in conflict

	code: STRING is "VRLE"
			-- Error code

	subcode: INTEGER is
		do
			Result := 1
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Local entity name: ")
			st.add_string (local_name)
			st.add_new_line
		end

feature {COMPILER_EXPORTER}

	set_local_name (s_id: INTEGER) is
			-- Assign `s_id' to `local_name'.
		require
			valid_s_id: s_id >= 0
		do
			local_name := Names_heap.item (s_id)
		end

end -- class VRLE1
