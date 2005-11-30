-- Byte code for assignment

class ASSIGN_B

inherit

	INSTR_B
		redefine
			need_enlarging, enlarged,
			assigns_to, is_unsafe, optimized_byte_node,
			calls_special_features, size, inlined_byte_code,
			pre_inlined_code
		end;

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_assign_b (Current)
		end

feature

	target: ACCESS_B;
			-- Target of the assignment

	source: EXPR_B;
			-- Source of the assignment

	set_target (t: ACCESS_B) is
			-- Assign `t' to `target'.
		do
			target := t;
		end;

	set_source (s: EXPR_B) is
			-- Assign `s' to `source'.
		do
			source := s;
		end;

	need_enlarging: BOOLEAN is True;
			-- This node needs enlarging

	enlarged: ASSIGN_BL is
			-- Enlarge current node.
		do
			create Result.make (Current)
		end;

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := target.assigns_to (i)
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := source.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := source.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current;
			source := source.optimized_byte_node
		end;

feature -- Inlining

	size: INTEGER is
		do
			Result := 1 + source.size
		end

	pre_inlined_code: like Current is
		do
			Result := Current;
			source := source.pre_inlined_code;
				-- Cannot fail: target is local,
				-- Result or attribute
			target ?= target.pre_inlined_code;
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			source := source.inlined_byte_code
		end

end
