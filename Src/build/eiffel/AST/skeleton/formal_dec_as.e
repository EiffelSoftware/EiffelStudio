
-- Abstract description of a formal generic parameter.
-- Instances produced by Yacc.

class FORMAL_DEC_AS

inherit

	FORMAL_AS
		redefine
			set, simple_format, is_deep_equal
		end

feature -- Attributes

	formal_name: ID_AS;
			-- Formal generic parameter name

	constraint: TYPE;
			-- Constraint of the formal generic

feature -- Initialization

	set is
			-- Yacc initialization
		do
			formal_name ?= yacc_arg (0);
			constraint ?= yacc_arg (1);
			position := yacc_int_arg (0);
		ensure then
			formal_name_exists: formal_name /= Void
		end; 

	is_deep_equal (other: TYPE): BOOLEAN is
		local
			o: FORMAL_DEC_AS;
			o_c: TYPE;
		do
			o ?= other;
			Result := o /= Void and then
				formal_name.is_equal (o.formal_name) and then
				position = o.position;
			if Result then
				o_c := o.constraint;
				if constraint = Void then
					Result := o_c = Void
				else
					Result := o_c /= Void and then
						constraint.is_deep_equal (o_c)
				end;
			end;
		end;

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			s: STRING;
		do
			s := clone (formal_name)
			s.to_upper;
			ctxt.put_string (s);
			if constraint /= void then
				ctxt.put_space;
				ctxt.put_text_item (ti_Constraint);
				ctxt.put_space;
				constraint.simple_format (ctxt);
			end;
			ctxt.always_succeed;
		end;
		
end
