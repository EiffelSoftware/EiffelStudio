note
	description: "[
		Factory for creating new checked entities.
		Note: This class will cache applicable checked entities and retrieve cached versions on repeat requests.
		      It is recommended that all creation go through this factory instead of creating entities manually.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_CHECKED_ENTITY_FACTORY

inherit
	ANY

	EC_CHECKED_CACHE
		export
			{NONE} all
		end

feature -- Factory Routines

	checked_assembly (a_assembly: ASSEMBLY): EC_CHECKED_ASSEMBLY
			-- Retrieve a checked assembly for `a_assembly'
		require
			a_assembly_not_void: a_assembly /= Void
		do
			if attached {like checked_assembly} checked_entities.item (a_assembly) as l_result then
				Result := l_result
			else
				create Result.make (a_assembly)
				if Result.cache_checked_entity then
					set_checked_entity (a_assembly, Result)
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	checked_type (a_type: SYSTEM_TYPE): EC_CHECKED_TYPE
			-- Retrieve a checked type for `a_type'
		require
			a_type_not_void: a_type /= Void
		do
			if attached {like checked_type} checked_entities.item (a_type) as l_result then
				Result := l_result
			else
				if a_type.is_interface or a_type.is_abstract then
					create {EC_CHECKED_ABSTRACT_TYPE} Result.make (a_type)
				else
					create Result.make (a_type)
				end
				if Result.cache_checked_entity then
					set_checked_entity (a_type, Result)
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	checked_member (a_member: MEMBER_INFO): detachable EC_CHECKED_MEMBER
			-- Retrieve a checked member for `a_member'
		require
			a_member_not_void: a_member /= Void
		do
			if attached {like checked_member} checked_entities.item (a_member) as cm then
				Result := cm
			else
				if attached {METHOD_INFO} a_member as l_method then
					create {EC_CHECKED_MEMBER_METHOD} Result.make (l_method)
				elseif attached {PROPERTY_INFO} a_member as l_property then
					create {EC_CHECKED_MEMBER_PROPERTY} Result.make (l_property)
				elseif attached {CONSTRUCTOR_INFO} a_member as l_ctor then
					create {EC_CHECKED_MEMBER_CONSTRUCTOR} Result.make (l_ctor)
				elseif attached {EVENT_INFO} a_member as l_event then
					create {EC_CHECKED_MEMBER_EVENT} Result.make (l_event)
				elseif attached {FIELD_INFO} a_member as l_field then
					create {EC_CHECKED_MEMBER_FIELD} Result.make (l_field)
				end
			end
		end

	checked_constructor (a_method: CONSTRUCTOR_INFO): EC_CHECKED_MEMBER_CONSTRUCTOR
			-- Retrieve a checked contructor for `a_method'
		require
			a_method_not_void: a_method /= Void
		do
			if attached {like checked_constructor} checked_entities.item (a_method) as l_result then
				Result := l_result
			else
				create Result.make (a_method)
			end
		ensure
			result_not_void: Result /= Void
		end

	checked_method (a_method: METHOD_INFO): EC_CHECKED_MEMBER_METHOD
			-- Retrieve a checked method for `a_method'
		require
			a_method_not_void: a_method /= Void
		do
			if attached {like checked_method} checked_entities.item (a_method) as l_result then
				Result := l_result
			else
				create Result.make (a_method)
			end
		ensure
			result_not_void: Result /= Void
		end

	checked_field (a_field: FIELD_INFO): EC_CHECKED_MEMBER_FIELD
			-- Retrieve a checked field for `a_field'
		require
			a_field_not_void: a_field /= Void
		do
			if attached {like checked_field} checked_entities.item (a_field) as l_result then
				Result := l_result
			else
				create Result.make (a_field)
			end
		ensure
			result_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EC_CHECKED_ENTITY_FACTORY
