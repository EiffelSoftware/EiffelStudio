indexing
	description: "List of instructions that can be used as an instruction.%
		%Only used when optimizing code."
	date: "$Date$"
	revision: "$Revision$"

class
	INSTR_LIST_B

inherit
	INSTR_B
		redefine
			analyze, generate, generate_il, size, pre_inlined_code, inlined_byte_code,
			has_separate_call, assigns_to, calls_special_features, is_unsafe,
			optimized_byte_node, enlarge_tree, make_byte_code
		end

create
	make
	
feature {NONE} -- Initialization

	make (l: like compound) is
			-- Create current with `l' as new compound.
		require
			l_not_void: l /= Void
		do
			compound := l
		ensure
			compound_set: compound = l
		end
		
feature -- Access

	compound: BYTE_LIST [BYTE_NODE]
			-- List of instruction making Current.
			-- Usually content is made of INSTR_B.

feature -- Code analyzis

	analyze is
			-- Loop over `list' and analyze each item
		do
			compound.analyze
		end

feature -- C generation

	generate is
			-- Loop over `list' and generate each item
		do
			compound.generate
		end

feature -- IL code generation

	generate_il is
			-- Loop over `list' and generate IL code for each item
		do
			compound.generate_il
		end

feature -- Byte code generation

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generates byte code for element in the list
		do
			compound.make_byte_code (ba)
		end

feature -- Tree enlargment

	enlarge_tree is
			-- Loop ovet `list' and enlarges each item
		do
			compound.enlarge_tree
		end

feature -- Array optimization

	assigns_to (n: INTEGER): BOOLEAN is
		do
			Result := compound.assigns_to (n)
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := compound.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN is
		do
			Result := compound.is_unsafe
		end

	optimized_byte_node: like Current is
		do
			create Result.make (compound.optimized_byte_node)
		end

feature -- Inlining

	size: INTEGER is
		do
			Result := compound.size
		end

	pre_inlined_code: like Current is
		do
			create Result.make (compound.pre_inlined_code)
		end

	inlined_byte_code: like Current is
		do
			create Result.make (compound.inlined_byte_code)
		end

feature -- Concurrent Eiffel

	has_separate_call: BOOLEAN is
			-- Loop over `list' and determine is there is a separate
			-- call
		do
			Result := compound.has_separate_call
		end

invariant
	compound_not_void: compound /= Void
	in_final_mode: context.final_mode
	
end -- class INSTR_LIST_B
