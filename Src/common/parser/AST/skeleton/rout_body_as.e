deferred class ROUT_BODY_AS

inherit

	AST_EIFFEL
		redefine
			byte_node
		end

feature -- Conveniences

	is_once: BOOLEAN is
			-- Is the routine body a once one ?
		do
			-- Do nothing
		end;

	is_deferred: BOOLEAN is
			-- Is the routine body a deferred one ?
		do
			-- Do nothing
		end;

	is_external: BOOLEAN is
			-- Is the routine body an external one ?
		do
			-- Do nothing
		end;

feature -- Byte code

	byte_node: BYTE_CODE is
			-- Byte associated to the routine body (compound)
		do
			-- Do nothing
		end;

end
