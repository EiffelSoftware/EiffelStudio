indexing

	description: 
		"AST representation of bit symbols.";
	date: "$Date$";
	revision: "$Revision $"

class BITS_SYMBOL_AS

inherit

	BASIC_TYPE
		redefine
			set, is_deep_equal
		end

feature -- Properties

	bits_symbol: ID_AS;
			-- Bits value

feature -- Comparison

	is_deep_equal (other: TYPE): BOOLEAN is
			-- ATTENTION: May be this feature should be deferred now...
		local
			o: BITS_SYMBOL_AS
		do
			o ?= other;
			Result := o /= Void and then
				bits_symbol.is_equal (o.bits_symbol)
		end;

feature -- Output

	dump: STRING is
			-- Debug purpose
		do
			!!Result.make (5 + bits_symbol.count);
			Result.append ("BIT ");
			Result.append (bits_symbol);
   		end;

feature {NONE} -- Initialization

	set is
			-- Yacc initilization
		do
			bits_symbol ?= yacc_arg (0);
		ensure then
			bits_symbol_exists: bits_symbol /= Void
		end;

end -- class BITS_SYMBOL_AS
