indexing
	description: "Info about expression creation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CREATION_EXPR_CALL_B

feature -- Access

	parameters: BYTE_LIST [EXPR_B] is
		deferred
		end

feature -- Analyze/Unanalyze

	enlarged: CALL_ACCESS_B is
		deferred
		end

	analyze is
		deferred
		end

	unanalyze is
		deferred
		end

feature -- Generation

	generate_il is
		deferred
		end

	generate is
		deferred
		end

	make_creation_byte_code (ba: BYTE_ARRAY) is
		deferred
		end

feature -- Status

	is_single: BOOLEAN is
		deferred
		end

	is_simple_expr: BOOLEAN is
		deferred
		end

	feature_name: STRING is
		deferred
		end

feature -- Setting

	set_register (reg: REGISTRABLE) is
		deferred
		end

	set_need_invariant (b: BOOLEAN) is
		deferred
		end

	set_parent (p: NESTED_B) is
		deferred
		end

feature -- Info setting

	info: CREATE_TYPE
			-- Type of object being created.

	set_info (i: like info) is
			-- Assign `i' to `info'.
		require
			i_not_void: i /= Void
		do
			info := i
		ensure
			info_set: info = i
		end

feature -- Copy

	fill_from (f: CALL_ACCESS_B) is
			-- Fill in node with call `f'
		deferred
		end

end -- class CREATION_EXPR_CALL_B
