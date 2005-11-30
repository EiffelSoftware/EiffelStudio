-- Call as an instruction

class INSTR_CALL_B

inherit

	INSTR_B
		redefine
			enlarge_tree, analyze, generate,
			is_unsafe, optimized_byte_node, calls_special_features,
			size, inlined_byte_code, pre_inlined_code
		end

create
	make

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_instr_call_b (Current)
		end

feature {NONE} -- Initialization

	make (c: like call; l: like line_number) is
			-- New instance of INSTR_CALL_B initialized with `c' and `l'.
		require
			c_not_void: c /= Void
			l_positive: l > 0
		do
			call := c
			line_number := l
		ensure
			call_set: call = c
			line_number_set: line_number = l
		end

feature

	enlarge_tree is
			-- Enlarge byte code tree
		do
			call := call.enlarged;
		end;

	call: CALL_B;
			-- Instruction call

	analyze is
			-- Analyze the call
		do
			call.analyze;
		end;

	generate is
			-- Generate the call
		do
			generate_line_info;
			generate_frozen_debugger_hook
			call.generate;
		end;

feature -- Array optimization

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := call.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := call.is_unsafe
		end;

	optimized_byte_node: like Current is
		do
			Result := Current
			call := call.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := call.size
		end

	pre_inlined_code: like Current is
		do
			Result := Current;
			call := call.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			call := call.inlined_byte_code
		end

invariant
	call_not_void: call /= Void

end
