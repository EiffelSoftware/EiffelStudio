class CREATION_AS

inherit

	INSTRUCTION_AS
		redefine
			simple_format
		end;

feature -- Attributes

	type: TYPE;
			-- Creation type

	target: ACCESS_AS;
			-- Target to create

	call: ACCESS_INV_AS;
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

feature -- Initialization

	set is
			-- Yacc initialization
		do
			type ?= yacc_arg (0);
			target ?= yacc_arg (1);
			call ?= yacc_arg (2);
		ensure then
			target_exists: target /= Void;
		end;

feature -- Equivalence

	is_equiv (other: INSTRUCTION_AS): BOOLEAN is
			-- Is `other' instruction equivalent to Current?
		local
			creation_as: CREATION_AS
		do
			creation_as ?= other
			if creation_as /= Void then
				-- May be equivalent
				Result := equiv (creation_as)
			else
				-- NOT equivalent
				Result := False
			end
		end;

	equiv (other: like Current): BOOLEAN is
			-- Is `other' creation_as equivalent to Current?
		do
			Result := deep_equal (type, other.type)
			if Result then
				-- May be equivalent
				Result := deep_equal (target, other.target)
				if Result then
					-- May be equivalent
					Result := deep_equal (call, other.call)
				end
			end
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_breakable;
			if type /= Void then
				ctxt.put_text_item (ti_Exclamation);
				type.simple_format (ctxt);
				ctxt.put_text_item (ti_Exclamation);
				ctxt.put_space
			else
				ctxt.put_text_item (ti_Creation_mark);
				ctxt.put_space
			end;
			target.simple_format (ctxt);
			if  call /= void then
				ctxt.need_dot;
				call.simple_format (ctxt);
			end;
		end;

feature {CREATION_AS} -- Replication

	set_call (c: like call) is
		do
			call := c
		end;

	set_target (t: like target) is
		require
			valid_arg: t /= Void
		do
			target := t;
		end;

end -- class CREATION_AS
