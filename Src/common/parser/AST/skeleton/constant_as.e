indexing

	description: "Abstract description of a the content of an Eiffel constant.";
	date: "$Date$";
	revision: "$Revision$"

class CONSTANT_AS

inherit

	CONTENT_AS
		redefine
			is_unique, is_constant, simple_format
		end

feature -- Attributes

	value: EXPR_AS;
			-- Constant value

feature -- Initialization

	set is 
			-- Yacc initialisation
		do
			value ?= yacc_arg (0);
		ensure then
			value_exists: value /= Void
		end;

feature -- Conveniences

	is_constant: BOOLEAN is
			-- Is the current content a constant one ?
		do
			Result := True;
		end;

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

	is_body_equiv (other: like Current): BOOLEAN is
			-- Are the values of Current and other the
			-- same?
		do
			Result := deep_equal (value, other.value)
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

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_space;
			ctxt.put_text_item (ti_Is_keyword);
			ctxt.put_space;
			value.simple_format(ctxt);
			ctxt.commit;
		end;

feature -- Replication

	set_value (v: like value) is
		do
			value := v
		end;

end -- class CONSTANT_AS
