indexing
	description: "AST representation of a the content of an Eiffel constant."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANT_AS

inherit
	CONTENT_AS
		redefine
			is_unique, is_constant, is_equivalent
		end

feature {AST_FACTORY} -- Initialization

	initialize (v: like value) is
			-- Create a new CONSTANT AST node.
		require
			v_not_void: v /= Void
		do
			value := v
		ensure
			value_set: value = v
		end

feature {NONE} -- Initialization

	set is 
			-- Yacc initialisation
		do
			value ?= yacc_arg (0);
		ensure then
			value_exists: value /= Void
		end;

feature -- Properties

	value: EXPR_AS;
			-- Constant value

	is_constant: BOOLEAN is True
			-- Is the current content a constant one ?

	is_unique: BOOLEAN is
			-- Is the content a unique ?
		local
			a_value: VALUE_AS;
		do
			a_value ?= value;
			if a_value /= Void then
				Result := a_value.terminal.is_unique;
			end;
		end;

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (value, other.value)
		end

feature -- Access

	is_body_equiv (other: like Current): BOOLEAN is
			-- Are the values of Current and other the
			-- same?
		do
			Result := equivalent (value, other.value)
		end;

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
		do
			Result := False
		end;

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this constant.
			-- Result is `0'.
		do
			Result := 0
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_space;
			ctxt.put_text_item_without_tabs (ti_Is_keyword);
			ctxt.put_space;
			ctxt.format_ast (value)
		end;

feature {CONSTANT_AS} -- Replication

	set_value (v: like value) is
		do
			value := v
		end;

end -- class CONSTANT_AS
