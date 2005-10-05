indexing
	description : "[
		Shared cache of checked entities.
		
		Threading Note: Default exported interface is thread-safe.
		]"
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	EC_CHECKED_CACHE

feature -- Access

	checked_entities: IDICTIONARY is
			-- Checked entities cache.
			-- Key: An entity (an ASSEMBLY, SYSTEM_TYPE, etc.)
			-- Value: Corresponding checked entity (ASSEMBLY => EC_CHECKED_ASSEMBLY)
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		do
			Result := checked_entities_table
		end
	
feature -- Extension

	set_checked_entity (a_entity: ICUSTOM_ATTRIBUTE_PROVIDER; a_checked_entity: EC_CHECKED_ENTITY) is
			-- Adds or sets a checked entity `a_entity' to `checked_entities'.
		indexing
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

	wipe_out_cache is
			-- Clears `checked_entities'
		indexing
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		do
			checked_entities_table.clear
			add_predefine_checked_entities (checked_entities_table)
		end
	
feature {NONE} -- Implementation

	checked_entities_table: HASHTABLE is
			-- Checked entities table containing:
			-- Key: An entity (an ASSEMBLY, SYSTEM_TYPE, etc.)
			-- Value: Corresponding checked entity (ASSEMBLY => EC_CHECKED_ASSEMBLY)
			--
			-- Note: Please use `set_checked_entity' to set item data instead of using HASHTABLE
			--       features directly.
		indexing
			once_status: global
			metadata: create {SYNCHRONIZATION_ATTRIBUTE}.make end
		once
			create Result.make (1000)
			add_predefine_checked_entities (Result)
		ensure
			result_not_void: Result /= Void
		end
		
	add_predefine_checked_entities (a_table: HASHTABLE) is
			-- Predefined checked entities.
		require
			a_table_not_void: a_table /= Void
		local
			l_type: SYSTEM_TYPE
		do			
			l_type := {SYSTEM_TYPE}.get_type ("System.Byte")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.Int16")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.Int32")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.Int64")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.IntPtr")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.Single")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.Double")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.Char")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.Boolean")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.String")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.SByte")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, False, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.UInt16")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, False, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.UInt32")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, False, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.UInt64")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, False, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.UIntPtr")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, False, False))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.Void")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, True, True))
			
			l_type := {SYSTEM_TYPE}.get_type ("System.TypedReference")
			a_table.add (l_type, create {EC_STATIC_CHECKED_TYPE}.make (l_type, False, False))
		end
		

end -- class EC_CHECKED_CACHE
