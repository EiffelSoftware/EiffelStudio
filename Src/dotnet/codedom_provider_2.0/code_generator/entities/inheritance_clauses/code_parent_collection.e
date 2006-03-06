indexing
	description: "Generated class parents collection"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_PARENT_COLLECTION

inherit
	HASH_TABLE [CODE_PARENT, STRING]

	CODE_SHARED_GENERATION_HELPERS
		undefine
			is_equal,
			copy
		end

	CODE_SHARED_EIFFEL_METADATA_PROVIDER
		export
			{NONE} all
		undefine
			is_equal,
			copy
		end

create
	make

feature -- Access

	parent_type_with_homonym: CODE_TYPE_REFERENCE
			-- Direct parent containing feature with Eiffel name given as argument to `has_feature' if any
			-- (can be inherited from a higher level parent but we really need the direct parent for the rename clause)

feature -- Status Report

	has_feature (a_name: STRING): BOOLEAN is
			-- Does collection has a feature with Eiffel name `a_name'?
		require
			non_void_name: a_name /= Void
		local
			l_type: CODE_GENERATED_TYPE
			l_features: HASH_TABLE [CODE_FEATURE, STRING]
			l_dotnet_type: SYSTEM_TYPE
			l_parent_type: CODE_TYPE_REFERENCE
		do
			parent_type_with_homonym := Void
			from
				start
			until
				after or Result
			loop
				l_parent_type := item_for_iteration.type
				Resolver.search (l_parent_type)
				if Resolver.found then
					l_type := Resolver.found_type
					l_features := l_type.all_features
					l_features.search (a_name)
					Result := l_features.found
					if Result then
						parent_type_with_homonym := l_parent_type
					else
						Result := l_type.parents.has_feature (a_name)
						if Result then
							parent_type_with_homonym := l_parent_type
						end
					end
				else
					l_dotnet_type := l_parent_type.dotnet_type
					if l_dotnet_type /= Void then
						Result := dotnet_hierarchy_has_feature (a_name, l_dotnet_type)
						if Result then
							parent_type_with_homonym := l_parent_type
						end
					end
				end
				forth
			end
		ensure
			parent_type_with_homonym_set: (parent_type_with_homonym /= Void) = Result
		end

feature {NONE} -- Implementation

	dotnet_hierarchy_has_feature (a_name: STRING; a_type: SYSTEM_TYPE): BOOLEAN is
			-- Do `a_type' or any base type of `a_type' have a feature with Eiffel name `a_name'?
			--| We don't actually need to search parents as representation of .NET type in metadata is flat
		local
			l_features: LIST [CODE_MEMBER_REFERENCE]
		do
			l_features := Metadata_provider.all_features (a_type)
			if l_features /= Void then
				from
					l_features.start
				until
					l_features.after or Result
				loop
					Result := l_features.item.eiffel_name.is_equal (a_name)
					l_features.forth
				end
			end
		end

end -- class CODE_PARENT_COLLECTION

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