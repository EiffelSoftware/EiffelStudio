indexing
	description	: "Byte code for 'when...then' construct in multi-branch instruction."
	date		: "$Date$"
	revision	: "$Revision$"

class CASE_B 

inherit
	BYTE_NODE
		redefine
			analyze, generate, enlarge_tree, make_byte_code,
			assigns_to, is_unsafe, optimized_byte_node,
			calls_special_features, size, pre_inlined_code,
			inlined_byte_code, line_number, set_line_number
		end

feature -- Access

	line_number : INTEGER

feature -- Line number setting

	set_line_number (lnr : INTEGER) is
		do
			line_number := lnr
		ensure then
			line_number_set : line_number = lnr
		end

feature  -- Status Report

	interval: BYTE_LIST [BYTE_NODE]
			-- Case interval {list of INTERVAL_B}: can be Void
			-- in situations such as 5..3

	compound: BYTE_LIST [BYTE_NODE]
			-- Associated compound {list of INSTR_B}: can be Void
	
	set_interval (i: like interval) is
			-- Assign `i' to `interval'.
		do
			interval := i
		end

	set_compound (c: like compound) is
			-- Assign `c' to `compound'.
		do
			compound := c
		end

	enlarge_tree is
			-- Enlarge the when construct
		do
			interval.enlarge_tree
			if compound /= Void then
				compound.enlarge_tree
			end
		end

	analyze is
			-- Builds a proper context (for C code).
		do
				-- Values are constants (need not be analyzed)
			if compound /= Void then
				compound.analyze
			end
		end

feature -- C generation

	generate is
			-- Generate C code in `buffer'.
		local
			buf: GENERATION_BUFFER
		do
			generate_line_info
			interval.generate
			buf := buffer
			buf.indent
			if compound /= Void then
				compound.generate
			end
			buf.putstring ("break;")
			buf.new_line
			buf.exdent
		end

feature -- IL generation

	generate_il_case (end_label: IL_LABEL) is
			-- Generate IL code.
		local
			case_label, compound_label: IL_LABEL
			need_label: BOOLEAN
			interval_b: INTERVAL_B
		do
			generate_il_line_info
			case_label := il_label_factory.new_label
			need_label := interval.count > 1
			if need_label then
				compound_label := il_label_factory.new_label
			end
			from
				interval.start
			until
				interval.after
			loop
				interval_b ?= interval.item
				interval_b.generate_il_interval (case_label)
				interval.forth

				if need_label and then not interval.after then
					il_generator.branch_to (compound_label)
				end
			end

			if need_label then
				il_generator.mark_label (compound_label)
			end
			if compound /= Void then
				compound.generate_il
			end

				-- Branch to end of `inspect' statement.
			il_generator.branch_to (end_label)

				-- Branch to next `when' statement.
			il_generator.mark_label (case_label)
		end

feature -- Byte code generation

	make_range (ba: BYTE_ARRAY) is
			-- Generate range byte code
		local
			i: INTEGER
			inter: INTERVAL_B
		do
			from
				i := interval.count
			until
				i < 1
			loop
				inter ?= interval.i_th (i)
				inter.make_range (ba)
				ba.mark_forward2
				i := i - 1
			end
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate compound byte code
		local
			i: INTEGER
		do
			from
				i := interval.count
			until
				i < 1
			loop
				ba.write_forward2
				i := i - 1
			end
			if compound /= Void then
				compound.make_byte_code (ba)
			end
				-- To end of inspect
			ba.append (Bc_jmp)
			ba.mark_forward
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
			Result := compound /= Void and then compound.assigns_to (i)
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := compound /= Void and then
						compound.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := compound /= Void and then compound.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			Result := Current
			if compound /= Void then
				compound := compound.optimized_byte_node
			end
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := 1
			if compound /= Void then
				Result := Result + compound.size
			end
		end

	pre_inlined_code: like Current is
		do
			Result := Current
			if compound /= Void then
				compound := compound.pre_inlined_code
			end
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			if compound /= Void then
				compound := compound.inlined_byte_code
			end
		end
end
