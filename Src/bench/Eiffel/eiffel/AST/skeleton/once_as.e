indexing
	description: "AST representation of a once routines."
	date: "$Date$"
	revision: "$Revision$"

class ONCE_AS

inherit
	INTERNAL_AS
		redefine
			byte_node, is_once
		end

feature -- Properties

	is_once: BOOLEAN is True
			-- Is the current routine body a once one ?

feature -- Access

	byte_node: ONCE_BYTE_CODE is
			-- Byte code for once body
		do
			!! Result
			if compound /= Void then
				Result.set_compound (compound.byte_node)
			end
			Result.record_separate_calls_on_arguments
		end

feature {NONE}

	begin_keyword: BASIC_TEXT is
			-- "once" keyword
		once
			Result := ti_Once_keyword
		end

end -- class ONCE_AS
