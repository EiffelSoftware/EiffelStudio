indexing
	description: "Common ancestor to all Eiffel types"
	date: "$$"
	revision: "$$"	

deferred class
	CODE_TYPE
	
inherit
	CODE_NAMED_ENTITY
		redefine
			is_equal
		end

feature {NONE} -- Initialization

	make (a_type: CODE_TYPE_REFERENCE) is
			-- Initialize instance with arguments.
		require
			non_void_type: a_type /= Void
		do
			name := a_type.name
			namespace := a_type.namespace
			eiffel_name := a_type.eiffel_name
			full_name := a_type.full_name
		ensure
			name_set: name /= Void
			namespace_set: namespace /= Void
			eiffel_name_set: eiffel_name /= Void
			full_name_set: full_name /= Void
		end
		
feature -- Access

	namespace: STRING
			-- Namespace to which type belongs to

	full_name: STRING
			-- Type full name
	
	eiffel_name: STRING
			-- Eiffel name
		
	code: STRING is
			-- Type source code
		deferred	
		end

feature -- Comparison

	is_equal (other: CODE_TYPE): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
			-- We consider that CodeDom has the same limitation as C# where
			-- two namespaces with the same name cannot have types with the same name
		do
			Result := other.full_name.is_equal (full_name)
		end

invariant
	non_void_namespace: namespace /= Void
	non_void_eiffel_name: eiffel_name /= Void
	non_void_full_name: full_name /= Void

end -- class CODE_TYPE

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