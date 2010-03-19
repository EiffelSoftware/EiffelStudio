note
	description : "[
		Shared cache of checked entities.
		
		Threading Note: Default exported interface is thread-safe.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	EC_CHECKED_CACHE

feature -- Access

	checked_entities: IDICTIONARY
			-- Checked entities cache.
			-- Key: An entity (an ASSEMBLY, SYSTEM_TYPE, etc.)
			-- Value: Corresponding checked entity (ASSEMBLY => EC_CHECKED_ASSEMBLY)
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		do
			Result := checked_entities_table
		end

feature -- Extension

	set_checked_entity (a_entity: ICUSTOM_ATTRIBUTE_PROVIDER; a_checked_entity: EC_CHECKED_ENTITY)
			-- Adds or sets a checked entity `a_entity' to `checked_entities'.
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		require
			a_entity_not_void: a_entity /= Void
			a_checked_entity_not_void: a_checked_entity /= Void
		do
			checked_entities_table.add (a_entity, a_checked_entity)
		ensure
			a_entity_added: checked_entities.item (a_entity) /= Void
		end

feature -- Removal

	wipe_out_cache
			-- Clears `checked_entities'
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		do
			checked_entities_table.clear
			add_predefine_checked_entities (checked_entities_table)
		end

feature {NONE} -- Implementation

	checked_entities_table: HASHTABLE
			-- Checked entities table containing:
			-- Key: An entity (an ASSEMBLY, SYSTEM_TYPE, etc.)
			-- Value: Corresponding checked entity (ASSEMBLY => EC_CHECKED_ASSEMBLY)
			--
			-- Note: Please use `set_checked_entity' to set item data instead of using HASHTABLE
			--       features directly.
		note
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		once ("PROCESS")
			create Result.make (1000)
			add_predefine_checked_entities (Result)
		ensure
			result_not_void: Result /= Void
		end

	add_predefine_checked_entities (a_table: HASHTABLE)
			-- Predefined checked entities.
		require
			a_table_not_void: a_table /= Void
		local
			l_type: detachable SYSTEM_TYPE
		do
			l_type := {SYSTEM_TYPE}.get_type ("System.Byte")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.Int16")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.Int32")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.Int64")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.IntPtr")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.Single")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.Double")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.Char")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.Boolean")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.String")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.SByte")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, False, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.UInt16")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, False, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.UInt32")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, False, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.UInt64")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, False, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.UIntPtr")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, False, False))

			l_type := {SYSTEM_TYPE}.get_type ("System.Void")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))

			l_type := {SYSTEM_TYPE}.get_type ("System.TypedReference")
			check l_type_attached: l_type /= Void end
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, False, False))
		end


note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class EC_CHECKED_CACHE
