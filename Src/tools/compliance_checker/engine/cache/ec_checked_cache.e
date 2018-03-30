note
	description : "[
		Shared cache of checked entities.
		
		Threading Note: Default exported interface is thread-safe.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

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

	checked_entities_table: separate HASHTABLE
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
		do
			add_predefind_type ("System.SByte", False, True, a_table)
			add_predefind_type ("System.Int16", True, True, a_table)
			add_predefind_type ("System.Int32", True, True, a_table)
			add_predefind_type ("System.Int64", True, True, a_table)
			add_predefind_type ("System.Single", True, True, a_table)
			add_predefind_type ("System.Double", True, True, a_table)
			add_predefind_type ("System.Char", True, True, a_table)
			add_predefind_type ("System.Boolean", True, True, a_table)
			add_predefind_type ("System.String", True, True, a_table)
			add_predefind_type ("System.Byte" , True, True, a_table)
			add_predefind_type ("System.UInt16", False, True, a_table)
			add_predefind_type ("System.UInt32", False, True, a_table)
			add_predefind_type ("System.UInt64", False, True, a_table)
			add_predefind_type ("System.IntPtr", True, True, a_table)
			add_predefind_type ("System.UIntPtr", False, False, a_table)
			add_predefind_type ("System.Void", True, True, a_table)
			add_predefind_type ("System.TypedReference", False, False, a_table)
		end

	add_predefind_type (name: SYSTEM_STRING; is_compliant, is_eiffel_compliant: BOOLEAN; table: HASHTABLE)
			-- Add a predefined type of name `name`
			-- that is compliant and Eiffel-compliant according to values of `is_compliant` and `is_eiffel_compliant`
			-- to the table `table`.
		do
			if attached {SYSTEM_TYPE}.get_type (name) as t then
				table.add (t, create {EC_STATIC_CHECKED_TYPE}.make (t, is_compliant, is_eiffel_compliant))
			else
				check
					is_type_predefined: False
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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

end
