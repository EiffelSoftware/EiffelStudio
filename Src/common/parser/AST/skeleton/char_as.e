indexing
	description: "AST representation of character constant."
	date: "$Date$"
	revision: "$Revision$"

class
	CHAR_AS

inherit

	ATOMIC_AS
		redefine
			is_character, good_character, is_equivalent
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

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_char_as (Current)
		end

feature -- Attributes

	value: CHARACTER;
			-- Character value

feature -- Properties

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

feature -- Output

	string_value: STRING is
		do
			Result := char_text (value)
		end

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_text_item_without_tabs (ti_Quote);
--			ctxt.put_string (char_text (value));
--			ctxt.put_text_item_without_tabs (ti_Quote)
--		end

end -- class CHAR_AS
