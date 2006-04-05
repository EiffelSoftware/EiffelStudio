indexing
	description: "[
					Matches Eiffel and .NET type names.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_TYPE_CACHE

inherit
	CODE_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	CODE_SHARED_GENERATION_CONTEXT
		export
			{NONE} all
		end

	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end

create
	default_create

feature -- Access

	found_type: CODE_GENERATED_TYPE
			-- Last type found with `search'

	Generated_types: HASH_TABLE [CODE_GENERATED_TYPE, STRING] is
			-- Types declared in Codedom tree
			-- Value: `CODE_GENERATED_TYPE'
			-- Key: .NET full type name
		once
			create Result.make (128)
			Result.compare_objects
		ensure
			non_void_generated_types: Result /= Void
		end

feature -- Status Repport

	is_generated (a_type: CODE_TYPE_REFERENCE): BOOLEAN is
			-- Is type `a_type_name' declared in Codedom tree?
		require
			non_void_type: a_type /= Void
		do
			Result := Generated_types.has (a_type.name)
		end

	found: BOOLEAN
			-- Was last call to `search' successful?

feature -- Basics Operations

	search (a_type: CODE_TYPE_REFERENCE) is
			-- Search for type `a_type' in cache.
			-- Set `found', and `found_type' accordingly.
		require
			non_void_type: a_type /= Void
		do
			Generated_types.search (a_type.name)
			found := Generated_types.found
			if found then
				found_type := Generated_types.found_item
			end
		end

feature -- Element Settings

	add_generated_type (a_type: CODE_GENERATED_TYPE) is
			-- Add `a_type' to generated types cache.
		require
			non_void_generated_type: a_type /= Void
		do
			generated_types.force (a_type, a_type.name)
			Type_reference_factory.type_reference_from_code (a_type).set_initialized (True)
			if generated_types.found then
				event_manager.raise_event ({CODE_EVENTS_IDS}.type_in_cache, [a_type.name])
			end
		ensure
			generated_types_set: generated_types.has (a_type.name)
		end

	reset is
			-- Reset content of `Generated_types'.
		do
			Generated_types.clear_all
		end

invariant
	non_void_types: Generated_types /= Void
	found_type_if_found: found implies found_type /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CODE_TYPE_CACHE

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