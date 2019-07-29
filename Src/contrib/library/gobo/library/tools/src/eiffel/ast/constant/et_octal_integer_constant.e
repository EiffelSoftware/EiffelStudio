note

	description:

		"Eiffel integer constants in octal format"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2009-2019, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_OCTAL_INTEGER_CONSTANT

inherit

	ET_INTEGER_CONSTANT

create

	make

feature {NONE} -- Initialization

	make (a_literal: like literal; a_value: NATURAL_64; a_has_overflow: BOOLEAN)
			-- Create a new Integer constant.
		require
			a_literal_not_void: a_literal /= Void
			valid_literal: {RX_PCRE_ROUTINES}.regexp ("0[cC][0-7]+(_+[0-7]+)*").recognizes (a_literal)
		do
			literal := a_literal
			value := a_value
			has_overflow := a_has_overflow
			make_leaf
		ensure
			literal_set: literal = a_literal
			value_set: value = a_value
			has_overflow_set: has_overflow = a_has_overflow
			line_set: line = no_line
			column_set: column = no_column
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR)
			-- Process current node.
		do
			a_processor.process_octal_integer_constant (Current)
		end

invariant

	valid_literal: {RX_PCRE_ROUTINES}.regexp ("0[cC][0-7]+(_+[0-7]+)*").recognizes (literal)

end
