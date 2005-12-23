-- Access to Current

class CURRENT_B

inherit

	ACCESS_B
		redefine
			enlarged, is_current,
			register_name, pre_inlined_code, print_register,
			is_fast_as_local
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_current_b (Current)
		end

feature

	type: LIKE_CURRENT_I is
			-- Current type
		once
			create Result
		end

	is_current: BOOLEAN is
			-- This is an access to Current
		do
			Result := True
		end

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		local
			current_b: CURRENT_B;
		do
			current_b ?= other;
			Result := current_b /= Void
		end;

	enlarged: CURRENT_B is
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		do
				-- This is the root of the call tree
			create {CURRENT_BL} Result;
		end;

	register_name: STRING is
			-- The "Current" string
		once
			Result := "Current";
		end;

	print_register is
			-- Print "Current" register
		do
			context.buffer.put_string (register_name)
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN is true
			-- Is expression calculation as fast as loading a local?

feature -- Inlining

	pre_inlined_code: CURRENT_B is
		do
			create {INLINED_CURRENT_B} Result
		end

end
