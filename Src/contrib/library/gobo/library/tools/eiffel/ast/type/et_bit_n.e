note

	description:

		"Eiffel 'BIT N' types"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2003-2009, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_BIT_N

inherit

	ET_BIT_TYPE

create

	make

feature {NONE} -- Initialization

	make (a_constant: like constant; a_named_base_class: like named_base_class)
			-- Create a new 'BIT N' type.
		require
			a_constant_not_void: a_constant /= Void
			a_named_base_class_not_void: a_named_base_class /= Void
		do
			bit_keyword := tokens.bit_keyword
			constant := a_constant
			size := No_size
			named_base_class := a_named_base_class
		ensure
			constant_set: constant = a_constant
			named_base_class_set: named_base_class = a_named_base_class
		end

feature -- Access

	position: ET_POSITION
			-- Position of first character of
			-- current node in source code
		do
			Result := bit_keyword.position
			if Result.is_null then
				Result := constant.position
			end
		end

	first_leaf: ET_AST_LEAF
			-- First leaf node in current node
		do
			Result := bit_keyword
		end

	last_leaf: ET_AST_LEAF
			-- Last leaf node in current node
		do
			Result := constant
		end

	break: ET_BREAK
			-- Break which appears just after current node
		do
			Result := constant.break
		end

feature -- Output

	append_to_string (a_string: STRING)
			-- Append textual representation of
			-- current type to `a_string'.
		do
			a_string.append_string (bit_space)
			if constant.is_negative then
				a_string.append_character ('-')
			end
			a_string.append_string (constant.literal)
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR)
			-- Process current node.
		do
			a_processor.process_bit_n (Current)
		end

invariant

	constant_not_void: constant /= Void

end
