-- The when..then construct.

class CASE_B 

inherit

	BYTE_NODE
		redefine
			analyze, generate, enlarge_tree, make_byte_code,
			has_loop, assigns_to, is_unsafe, optimized_byte_node,
			calls_special_features, size, pre_inlined_code,
			inlined_byte_code, line_number, set_line_number
		end;

feature -- Access

	line_number : INTEGER;

feature -- Line number setting

	set_line_number (lnr : INTEGER) is

		do
			line_number := lnr
		ensure then
			line_number_set : line_number = lnr
		end

feature 

	interval: BYTE_LIST [BYTE_NODE];
			-- Case interval {list of INTERVAL_B}: can be Void
			-- in situations such as 5..3

	compound: BYTE_LIST [BYTE_NODE];
			-- Associated compound {list of INSTR_B}: can be Void
	
	set_interval (i: like interval) is
			-- Assign `i' to `interval'.
		do
			interval := i;
		end;

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c;
		end;

	enlarge_tree is
			-- Enlarge the when construct
		do
			interval.enlarge_tree;
			if compound /= Void then
				compound.enlarge_tree;
			end;
		end;

	analyze is
			-- Builds a proper context (for C code).
		do
				-- Values are constants (need not be analyzed)
			if compound /= Void then
				compound.analyze;
			end;
		end;

	generate is
			-- Generate C code in `buffer'.
		local
			buf: GENERATION_BUFFER
		do
			generate_line_info;
			interval.generate;
			buf := buffer
			if compound /= Void then
				buf.indent;
				compound.generate;
				buf.putstring ("break;");
				buf.new_line;
				buf.exdent;
			else
				buf.indent;
				buf.putstring ("break;");
				buf.new_line;
				buf.exdent;
			end;
		end;

feature -- Byte code generation

	make_range (ba: BYTE_ARRAY) is
			-- Generate range byte code
		local
			i, nb: INTEGER;
			inter: INTERVAL_B;
		do
			from
				i := interval.count;
			until
				i < 1
			loop
				inter ?= interval.i_th (i);
				inter.make_range (ba);
				ba.mark_forward2;
				i := i - 1;
			end;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate compound byte code
		local
			i: INTEGER;
		do
			from
				i := interval.count;
			until
				i < 1
			loop
				ba.write_forward2;
				i := i - 1;
			end;
			if compound /= Void then
				compound.make_byte_code (ba);
			end;
			make_breakable (ba);
				-- To end of inspect
			ba.append (Bc_jmp);
			ba.mark_forward;
		end;

feature -- Array optimization

	has_loop: BOOLEAN is
		do
			Result := compound /= void and then compound.has_loop
		end;

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := compound /= void and then compound.assigns_to (i)
		end;

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := compound /= void and then
						compound.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := compound /= void and then compound.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current;
			if compound /= void then
				compound := compound.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := 1;
			if compound /= Void then
				Result := Result + compound.size
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			if compound /= void then
				compound := compound.pre_inlined_code
			end
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			if compound /= void then
				compound := compound.inlined_byte_code
			end
		end

end
