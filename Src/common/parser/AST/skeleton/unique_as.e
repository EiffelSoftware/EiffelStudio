indexing
	description: 
		"AST representation of a unique value."
	date: "$Date$"
	revision: "$Revision$"

class
	UNIQUE_AS

inherit
	ATOMIC_AS
		redefine
			is_unique, is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize is
			-- Create a new UNIQUE AST node.
		do
			-- Do nothing.
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_unique_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	is_unique: BOOLEAN is True
			-- Is the terminal a unique constant ?

feature -- Output

	string_value: STRING is ""

--feature {AST_EIFFEL} -- Output
--
--	simple_format (ctxt: FORMAT_CONTEXT) is
--			-- Reconstitute text.
--		do
--			ctxt.put_text_item_without_tabs (ti_Unique_keyword);
--		end

end -- class UNIQUE_AS
