class BITS_AS

inherit

	BASIC_TYPE
		redefine
			set, simple_format
		end

feature -- Attributes

	bits_value: INTEGER_AS;
			-- Bits value

feature -- Initialization

	set is
			-- Yacc initilization
		do
			bits_value ?= yacc_arg (0);
		ensure then
			bits_value_exists: bits_value /= Void
		end;

	dump: STRING is
			-- Debug purpose
		do
			!!Result.make (10);
			Result.append ("BIT ");
			Result.append_integer (bits_value.value);
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_string ("BIT ");
			ctxt.put_string (bits_value.value.out);
		end;

end -- class BITS_AS
