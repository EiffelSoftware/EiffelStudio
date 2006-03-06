indexing 
	description: "Source code generator for indexer expressions"
	date: "$$"
	revision: "$$"
	
class
	CODE_INDEXER_EXPRESSION

inherit
	CODE_EXPRESSION

	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like target; a_indices: like indices) is
			-- Initialize `target_object' and `indices'.
		do
			indices := a_indices
			target := a_target
		ensure
			target_set: target = a_target
			indices_set: indices = a_indices
		end
		
feature -- Access

	target: CODE_EXPRESSION
			-- Target object
	
	indices: LIST [CODE_EXPRESSION]
			-- Linked_list indexer indices
		
	code: STRING is
			-- | Result := "`target_object'.item (`indices', ...)".
			-- Eiffel code of indexer expression
		do
			create Result.make (120)
			Result.append (target.code + ".item (")
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
			Result.append_character (')')
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		local
			l_type: SYSTEM_TYPE
			l_members: ARRAY [MEMBER_INFO]
			i, j, l_count, l_par_count: INTEGER
			l_parameters: ARRAY [PARAMETER_INFO]
			l_method: METHOD_INFO
			l_property: PROPERTY_INFO
			l_not_conform: BOOLEAN
		do
			l_type := target.type.dotnet_type
			if l_type /= Void then
				l_members := l_type.get_default_members
				from
					l_type := Void
					l_count := l_members.count
					i := 1
				until
					i > l_count or Result /= Void
				loop
					l_property ?= l_members.item (i)
					if l_property /= Void and then l_property.property_type /= Void then
						l_parameters := l_property.get_index_parameters
						l_type := l_property.property_type
					else
						l_method ?= l_members.item (i)
						if l_method /= Void and then l_method.return_type /= Void then
							l_parameters := l_method.get_parameters
							l_type := l_method.return_type
						end
					end
					if l_type /= Void then
						l_par_count := l_parameters.count
						if l_par_count = indices.count then
							from
								j := 1
							until
								j > l_par_count or l_not_conform
							loop
								l_not_conform := not Type_reference_factory.type_reference_from_type (l_parameters.item (j).parameter_type).conforms_to (indices.i_th (j).type)
								j := j + 1
							end
							if not l_not_conform then
								Result := Type_reference_factory.type_reference_from_type (l_type)
							end
						end						
					end
					i := i + 1
				end
			end
			if Result = Void then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Incorrect_result, ["type from indexer expression for indexer of " + target.type.name])
				Result := target.type 
			end
		end
		
invariant
	non_void_indices: indices /= Void
	
end -- class CODE_INDEXER_EXPRESSION

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