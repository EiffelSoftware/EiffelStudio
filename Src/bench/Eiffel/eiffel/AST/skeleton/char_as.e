indexing
	description: "Node for character constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CHAR_AS

inherit
	ATOMIC_AS
		redefine
			is_character, type_check, byte_node, value_i,
			good_character, make_character
		end

	CHARACTER_ROUTINES

feature {AST_FACTORY} -- Initialization

	initialize (c: CHARACTER) is
			-- Create a new CHARACTER AST node.
		do
			value := c
		ensure
			value_set: value = c
		end

feature -- Properties

	value: CHARACTER
			-- Character value

	is_character: BOOLEAN is True
			-- Is the current value a character value ?

	good_character: BOOLEAN is True
			-- Is the current atomic a good character?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := value = other.value
		end

feature -- Conveniences

	value_i: CHAR_VALUE_I is
			-- Interface value
		do
			!! Result
			Result.set_char_val (value)
		end

	type_check is
			-- Type check character
		do
			context.put (Character_type)
		end

	byte_node: CHAR_CONST_B is
			-- Associated byte code
		do
			!! Result
			Result.set_value (value)
		end

	make_character: CHAR_VAL_B is
			-- Character value
		do
		   !! Result.make (value)
		end

feature -- Output

	string_value: STRING is
		do
			Result := char_text (value)
			Result.precede ('%'')
			Result.extend ('%'')
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt : FORMAT_CONTEXT) is
			-- Reconstiture text.
		do
			--| VB 05/23/2000 Removed in favor of literal char symbol.
			--|ctxt.put_text_item_without_tabs (ti_Quote)
			--|ctxt.put_string (char_text (value))
			--|ctxt.put_text_item_without_tabs (ti_Quote)
			ctxt.put_text_item (
				create {CHARACTER_TEXT}.make (string_value)
			)
		end

end -- class CHAR_AS
