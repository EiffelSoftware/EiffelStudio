indexing
	description: "Retrieve or create {CODE_TYPE_REFERENCE} from various inputs.%
					%Will resolve array types, arrays with different element types must have a different name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_TYPE_REFERENCE_FACTORY

inherit
	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	CODE_DIRECTIONS
		export
			{NONE} all
		end

	CODE_SHARED_GENERATION_HELPERS
		export
			{NONE} all
		end

create
	default_create

feature -- Access

	is_registered (a_type: CODE_TYPE_REFERENCE): BOOLEAN is
			-- Is `a_type' in cache?
		do
			Result := type_references_cache.has (a_type.name)
		end
		
feature -- Basic Operations

	register (a_type: CODE_TYPE_REFERENCE) is
			-- Add `a_type' to cache.
		require
			non_void_type: a_type /= Void
			not_registered: not is_registered (a_type)
		do
			type_references_cache.put (a_type, a_type.name)
		ensure
			registered: is_registered (a_type)
		end
	
	reset_cache is
			-- Reset content of `type_references_cache'.
		do
			type_references_cache.clear_all
		end

feature -- Factory

	type_reference_from_reference (a_type_reference: SYSTEM_DLL_CODE_TYPE_REFERENCE): CODE_TYPE_REFERENCE is
			-- Initialize instance.
		require
			non_type_reference: a_type_reference /= Void
			valid_type_reference: a_type_reference.base_type /= Void
		local
			l_element_type: SYSTEM_DLL_CODE_TYPE_REFERENCE
			l_reference_type: CODE_TYPE_REFERENCE
		do
			-- We must set the element type because an instance of CODE_TYPE_REFERENCE created from an instance
			-- of SYSTEM_DLL_CODE_TYPE_REFERENCE would not have enough information to find the element type
			-- by itself
			l_element_type := a_type_reference.array_element_type
			if l_element_type /= Void then
				l_reference_type := type_reference_from_reference (l_element_type)
			end
			Result := type_reference (type_reference_name (a_type_reference), Void, Void, l_reference_type, True, False, True)
		ensure
			non_void_type_reference: Result /= Void
		end

	type_reference_from_declaration (a_declaration: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_namespace: STRING): CODE_TYPE_REFERENCE is
			-- Initialize instance.
		require
			non_void_declaration: a_declaration /= Void
		local
			l_type_name, l_name: STRING
		do
			if a_declaration.name /= Void then
				l_type_name := a_declaration.name
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_type_name, [a_namespace])
				l_type_name := "DEFAULT_TYPE_NAME"
			end
			if a_namespace /= Void and then a_namespace.count > 0 then
				create l_name.make (l_type_name.count + 1 + a_namespace.count)
				l_name.append (a_namespace)
				l_name.append_character ('.')
				l_name.append (l_type_name)
			else
				l_name := l_type_name
			end
			Result := type_reference (l_name, Void, Void, Void, False, False, False)
			add_members (a_declaration, Result)
		ensure
			non_void_type_reference: Result /= Void
		end

	type_reference_from_code (a_code_type: CODE_GENERATED_TYPE): CODE_TYPE_REFERENCE is
			-- Initialize instance from `a_code_type'.
		require
			non_void_code_type: a_code_type /= Void
		do
			Result := type_reference (a_code_type.name, a_code_type.eiffel_name, Void, Void, False, False, True)
		ensure
			non_void_type_reference: Result /= Void
		end
	
	type_reference_from_name (a_name: STRING): CODE_TYPE_REFERENCE is
			-- Initialize instance from .NET full name.
		require
			non_void_name: a_name /= Void
		do
			Result := type_reference (a_name, Void, Void, Void, True, True, False)
		ensure
			non_void_type_reference: Result /= Void
		end
	
	type_reference_from_type (a_type: SYSTEM_TYPE): CODE_TYPE_REFERENCE is
			-- Initialize instance from `a_type'.
		require
			non_void_type: a_type /= Void
		local
			l_element_type: SYSTEM_TYPE
			l_reference_element_type: CODE_TYPE_REFERENCE
		do
			l_element_type := a_type.get_element_type
			if l_element_type /= Void then
				l_reference_element_type := type_reference_from_type (l_element_type)
			end
			Result := type_reference (a_type.full_name, Void, a_type, l_reference_element_type, False, False, True)
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

feature {NONE} -- Implementation

	type_reference (a_name: STRING; a_eiffel_name: STRING; a_type: SYSTEM_TYPE; a_element_type: CODE_TYPE_REFERENCE; a_search_for_type, a_search_for_element_type, a_is_initialized: BOOLEAN): CODE_TYPE_REFERENCE is
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
				Result.set_initialized (a_is_initialized)
				type_references_cache.put (Result, a_name)
			end
		end
		
	add_members (a_declaration: SYSTEM_DLL_CODE_TYPE_DECLARATION; a_type: CODE_TYPE_REFERENCE) is
			-- Add members of `a_declaration' and its parents to `a_type'.
		require
			non_void_declaration: a_declaration /= Void
			non_void_type: a_type /= Void
		local
			l_members: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION
			l_member: SYSTEM_DLL_CODE_TYPE_MEMBER
			l_event: SYSTEM_DLL_CODE_MEMBER_EVENT
			l_field: SYSTEM_DLL_CODE_MEMBER_FIELD
			l_method: SYSTEM_DLL_CODE_MEMBER_METHOD
			l_property: SYSTEM_DLL_CODE_MEMBER_PROPERTY
			l_member_reference: CODE_MEMBER_REFERENCE
			l_argument: CODE_PARAMETER_DECLARATION_EXPRESSION
			i, l_count: INTEGER
		do
			l_members := a_declaration.members
			if l_members /= Void then
				from
					l_count := l_members.count
				until
					i = l_count
				loop
					l_member := l_members.item (i)
					l_method ?= l_member
					if l_method /= Void then
						create l_member_reference.make (l_method.name, a_type, l_method.attributes & {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Override = {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Override)
						a_type.add_member (l_member_reference)
					else
						l_property ?= l_member
						if l_property /= Void then
							if l_property.has_get then
								create l_member_reference.make ("get_" + l_property.name, a_type, l_property.attributes & {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Override = {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Override)
								l_member_reference.set_initialized
								a_type.add_member (l_member_reference)
							end
							if l_property.has_set then
								create l_member_reference.make ("set_" + l_property.name, a_type, l_property.attributes & {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Override = {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Override)
								create l_argument.make (create {CODE_VARIABLE_REFERENCE}.make ("value", type_reference_from_reference (l_property.type), a_type), in_argument)
								l_member_reference.add_argument (l_argument)
								l_member_reference.set_initialized
								a_type.add_member (l_member_reference)
							end
						else
							l_field ?= l_member
							if l_field /= Void then
								create l_member_reference.make (l_field.name, a_type, False)
								l_member_reference.set_initialized
								a_type.add_member (l_member_reference)
							else
								l_event ?= l_member
								if l_event /= Void then
									create l_member_reference.make ("add_" + l_member.name, a_type, l_event.attributes & {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Override = {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Override)
									create l_argument.make (create {CODE_VARIABLE_REFERENCE}.make ("value", type_reference_from_reference (l_event.type), a_type), in_argument)
									l_member_reference.add_argument (l_argument)
									l_member_reference.set_initialized
									a_type.add_member (l_member_reference)
									
									create l_member_reference.make ("remove_" + l_member.name, a_type, l_event.attributes & {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Override = {SYSTEM_DLL_MEMBER_ATTRIBUTES}.Override)
									create l_argument.make (create {CODE_VARIABLE_REFERENCE}.make ("value", type_reference_from_reference (l_event.type), a_type), in_argument)
									l_member_reference.add_argument (l_argument)
									l_member_reference.set_initialized
									a_type.add_member (l_member_reference)
								end
							end
						end
					end
					i := i + 1
				end
			end
		end
		
feature {NONE} -- Private Access

	type_references_cache: HASH_TABLE [CODE_TYPE_REFERENCE, STRING] is
			-- Cache for code type references
		once
			create Result.make (256)
		end

invariant
	non_void_cache: type_references_cache /= Void

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
