indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CREATION_EXPR_AS

inherit
	CALL_AS
		redefine
			is_equivalent
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			type ?= yacc_arg (0);
			call ?= yacc_arg (1);
		end

feature -- Properties

	type: TYPE;
			-- Creation type

	call: ACCESS_INV_AS;
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (call, other.call) and then
				equivalent (type, other.type)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
		end

invariant
		-- A creation expression contains its type
	type_exists: type /= Void

end -- class CREATION_EXPR_AS
