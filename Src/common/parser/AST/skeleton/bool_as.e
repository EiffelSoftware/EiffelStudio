indexing

	description: 
		"AST representation of a boolean constant.";
	date: "$Date$";
	revision: "$Revision$"

class BOOL_AS

inherit

	ATOMIC_AS
		redefine
			is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (b: BOOLEAN) is
			-- Create a new BOOLEAN AST node.
		do
			value := b
		ensure
			value_set: value = b
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			value := yacc_bool_arg (0);
		end;

feature -- Properties

	value: BOOLEAN;
			-- Integer value

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := value = other.value
		end

feature -- Output

	string_value: STRING is
		do
			Result := value.out
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
		do
			if value then
				ctxt.put_text_item (ti_True_keyword)
			else
				ctxt.put_text_item (ti_False_keyword)
			end
		end;

end -- class BOOL_AS
