indexing
	description: "Retrieve or create {CODE_TYPE_REFERENCE} from various inputs.%
					%Will resolve array types, arrays with different element types must have a different name."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_TYPE_REFERENCE_FACTORY

create
	default_create

feature -- Factory

	type_reference_from_reference (a_type_reference: SYSTEM_DLL_CODE_TYPE_REFERENCE): CODE_TYPE_REFERENCE is
			-- Initialize instance.
		require
			non_type_reference: a_type_reference /= Void
			valid_type_reference: a_type_reference.base_type /= Void
		do
			-- We must set the element type because an instance of CODE_TYPE_REFERENCE created from an instance
			-- of SYSTEM_DLL_CODE_TYPE_REFERENCE would not have enough information to find the element type
			-- by itself
			Result := type_reference (type_reference_name (a_type_reference), Void, Void, type_reference_from_reference (a_type_reference.array_element_type), True, False)
		ensure
			non_void_type_reference: Result /= Void
		end

	type_reference_from_declaration (a_declaration: SYSTEM_DLL_CODE_TYPE_DECLARATION): CODE_TYPE_REFERENCE is
			-- Initialize instance.
		require
			non_void_declaration: a_declaration /= Void
		do
			Result := type_reference (a_declaration.name, Void, Void, Void, False, False)
		ensure
			non_void_type_reference: Result /= Void
		end
		
	type_reference_from_code (a_code_type: CODE_TYPE): CODE_TYPE_REFERENCE is
			-- Initialize instance from `a_code_type'.
		require
			non_void_code_type: a_code_type /= Void
		local
			l_external_type: CODE_EXTERNAL_TYPE
			l_type, l_element_type: TYPE
			l_reference_element_type: CODE_TYPE_REFERENCE
		do
			l_external_type ?= a_code_type
			if l_external_type /= Void then
				l_type := l_external_type.dotnet_type
				l_element_type := l_type.get_element_type
				if l_element_type /= Void then
					l_reference_element_type := type_reference_from_type (l_element_type)
				end
				Result := type_reference (a_code_type.name, a_code_type.eiffel_name, l_type, l_reference_element_type, False, False)
			else
				Result := type_reference (a_code_type.name, a_code_type.eiffel_name, Void, Void, False, False)
			end
		ensure
			non_void_type_reference: Result /= Void
		end
	
	type_reference_from_name (a_name: STRING): CODE_TYPE_REFERENCE is
			-- Initialize instance from .NET full name.
		require
			non_void_name: a_name /= Void
		do
			Result := type_reference (a_name, Void, Void, Void, True, True)
		ensure
			non_void_type_reference: Result /= Void
		end
	
	type_reference_from_type (a_type: TYPE): CODE_TYPE_REFERENCE is
			-- Initialize instance from `a_type'.
		require
			non_void_type: a_type /= Void
		local
			l_element_type: TYPE
			l_reference_element_type: CODE_TYPE_REFERENCE
		do
			l_element_type := a_type.get_element_type
			if l_element_type /= Void then
				l_reference_element_type := type_reference_from_type (l_element_type)
			end
			Result := type_reference (a_type.full_name, Void, a_type, l_reference_element_type, False, False)
		ensure
			non_void_type_reference: Result /= Void
		end

feature -- Access

	type_reference_name (a_type_reference: SYSTEM_DLL_CODE_TYPE_REFERENCE): STRING is
			-- Unique name for `a_type_reference'
		require
			non_void_type_reference: a_type_reference /= Void
		do
			if a_type_reference.array_element_type /= Void then
				Result := type_reference_name (a_type_reference.array_element_type)
				Result.append ("[]")
			else
				Result := a_type_reference.base_type
			end
		end

feature {NONE} -- Private Access

	type_references_cache: HASH_TABLE [CODE_TYPE_REFERENCE, STRING] is
			-- Cache for code type references
		once
			create Result.make (256)
		end

feature {NONE} -- Implementation

	type_reference (a_name: STRING; a_eiffel_name: STRING; a_type: TYPE; a_element_type: CODE_TYPE_REFERENCE; a_search_for_type, a_search_for_element_type: BOOLEAN): CODE_TYPE_REFERENCE is
			-- Type reference with .NET name `a_name'
		require
			non_void_name: a_name /= Void
		do
			type_references_cache.search (a_name)
			if type_references_cache.found then
				Result := type_references_cache.found_item
			else
				create Result.make (a_name)
				if a_eiffel_name /= Void then
					Result.set_eiffel_name (a_eiffel_name)	
				end
				if a_type /= Void then
					Result.set_dotnet_type (a_type)
				end
				if a_element_type /= Void then
					Result.set_element_type (a_element_type)
				end
				Result.set_search_for_type (a_search_for_type)
				Result.set_search_for_element_type (a_search_for_element_type)
				type_references_cache.put (Result, a_name)
			end
		end
		
invariant
	non_void_cache: type_references_cache /= Void

end -- class CODE_TYPE_REFERENCE_FACTORY

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
