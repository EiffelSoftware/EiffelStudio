indexing 
	description: "Source code generator for indexer expressions"
	date: "$$"
	revision: "$$"
	
class
	ECD_INDEXER_EXPRESSION

inherit
	ECD_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `target_object' and `indices'.
		do
			create indices.make
		ensure
			non_void_indices: indices /= Void
		end
		
feature -- Access

	target_object: ECD_EXPRESSION
			-- Target object
	
	indices: LINKED_LIST [ECD_EXPRESSION]
			-- Linked_list indexer indices
		
	code: STRING is
			-- | Result := "`target_object'.item (`indices', ...)".
			-- Eiffel code of indexer expression
		do
			Check
				non_void_target_object: target_object /= Void
			end
		
			create Result.make (120)
			Result.append (target_object.code + ".item (")
			from
				indices.start
				if not indices.after then
					Result.append (indices.item.code)
					indices.forth
				end
			until
				indices.after
			loop
				Result.append (Dictionary.comma)
				Result.append (Dictionary.space)
				Result.append (indices.item.code)
				indices.forth
			end
			Result.append (Dictionary.Closing_round_bracket)
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is array indexer expression ready to be generated?
		do
			Result := target_object.ready and indices /= Void and then indices.for_all (agent is_index_ready)
		end

	is_index_ready (a_index: ECD_EXPRESSION): BOOLEAN is
			-- Is expression `a_index' ready?
		require
			non_void_index: a_index /= Void
		do
			Result := a_index.ready
		end
		
	type: TYPE is
			-- Type
		do
			Result := target_object.type
		end

feature -- Status Setting

	set_target_object (an_expression: like target_object) is
			-- Set `target_object' with `an_expression'.
		require
			non_void_expression: an_expression /= Void
		do
			target_object := an_expression
		ensure
			target_object_set: target_object = an_expression
		end		
		
	add_indice (an_indice: ECD_EXPRESSION) is
			-- Set `indices' with `a_list'.
		require
			non_void_list: an_indice /= Void
		do
			indices.extend (an_indice)
		ensure
			indices_set: indices.has (an_indice)
		end	
		
invariant
	non_void_indices: indices /= Void
	
end -- class ECD_INDEXER_EXPRESSION

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