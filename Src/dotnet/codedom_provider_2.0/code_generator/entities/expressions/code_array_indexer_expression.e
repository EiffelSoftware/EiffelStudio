indexing 
	description: "Source code generator for array indexer expression"
	date: "$$"
	revision: "$$"

class
	CODE_ARRAY_INDEXER_EXPRESSION

inherit
	CODE_EXPRESSION

	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: CODE_EXPRESSION; a_indices: LIST [CODE_EXPRESSION]) is
			-- Initialize `target_object' and `indices'.
		require
			non_void_target: a_target /= Void
			non_void_indices: a_indices /= Void
		do
			target := a_target
			indices := a_indices
		ensure
			target_set: target = a_target
			indices_set: indices = a_indices
		end
		
feature -- Access

	target: CODE_EXPRESSION
			-- Array indexer target object
	
	indices: LIST [CODE_EXPRESSION]
			-- Array indexer indices

	code: STRING is
			-- | Result := "`target_object'.item (`indices')"
			-- Eiffel code of array indexer expression
		do
			create Result.make (120)
			Result.append (target.code)
			if is_set_reference then
				Result.append (".put (")
			else
				Result.append (".item (")
			end
			from
				indices.start
				if not indices.after then
					Result.append (indices.item.code)
					indices.forth
				end
			until
				indices.after
			loop
				Result.append (", ")
				Result.append (indices.item.code)
				indices.forth
			end
			if not is_set_reference then
				Result.append_character (')')
			end
		end
		
feature -- Status Report
		
	type: CODE_TYPE_REFERENCE is
			-- Type
		local
			l_type: SYSTEM_TYPE
		do
			l_type := target.type.dotnet_type
			if l_type /= Void then
				Result := Type_reference_factory.type_reference_from_type (l_type.get_element_type)
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_type, [target.type.name])
			end
		end

	is_set_reference: BOOLEAN
			-- Are we assigning to the array element?

feature -- Element Setting

	set_is_set_reference (a_bool: BOOLEAN) is
			-- Set `is_set_reference' with `a_bool'.
		do
			is_set_reference := a_bool
		ensure
			is_set_reference_set: is_set_reference = a_bool
		end

invariant
	non_void_indices: indices /= Void
	non_void_target: target /= Void
	
end -- class CODE_ARRAY_INDEXER_EXPRESSION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------