indexing 
	description: "Source code generator for type of expressions"
	date: "$$"
	revision: "$$"
	
class
	ECDP_TYPE_OF_EXPRESSION

inherit
	ECDP_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		do
			create target.make_empty
		ensure
			non_void_target: target /= Void
		end
		
feature -- Access

	target: STRING
			-- Type of expression target
			
	code: STRING is
			-- | Result := "feature {TYPE}.get_type_string (type)"
			-- | Result C# := "typeof(`type_name')"
			-- Eiffel code of `type of' expression
			-- NOT SUPPORTED YET !!!
		local
			retried: BOOLEAN
		do
			Check
				not_empty_target: not target.is_empty
			end
			if not retried then
				create Result.make (120)
				Result.append ("feature {TYPE}.get_type_string (")
				Result.append (Resolver.dotnet_type_name (target))
				Result.append (Dictionary.Closing_round_bracket)
			else
				create Result.make_from_string (target)
			end
		rescue
			(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			retried := True
			retry
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is expression ready to be generated?
		do
			Result := True
		end

	type: TYPE is
			-- Type
		do
			Result := feature {TYPE}.get_type_string ("System.Type")
		end

feature -- Status Setting

	set_target (a_target: like target) is
			-- Set `target' with `a_target'.
		require
			non_void_target: a_target /= Void
			not_empty_target: not a_target.is_empty
		do
			target := a_target
		ensure
			target_set: target = a_target
		end		

invariant
	non_void_type: type /= Void
	
end -- class ECDP_TYPE_OF_EXPRESSION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------