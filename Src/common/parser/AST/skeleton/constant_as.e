-- Abstract description of a the content of an Eiffel constant

class CONSTANT_AS

inherit

	CONTENT_AS
		redefine
			is_unique, is_constant, byte_node, type_check, format
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

	value_i: VALUE_I is
			-- Interface constant value
		require
			is_constant and then not is_unique;
		local
			val: VALUE_AS;
		do
			val ?= value;
			Result := val.value_i;
		end;

	type_check is
		do
		ensure then
			False
		end; -- type_check

	byte_node: BYTE_CODE is
			-- Associated byte code
		do
		ensure then
			False
		end;

	is_body_equiv (other: like Current): BOOLEAN is
			-- Are the values of Current and other the
			-- same?
		do
			Result := deep_equal (value, other.value)
		end;

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_keyword (" is ");
			value.format(ctxt);
			ctxt.commit;
		end;

end
