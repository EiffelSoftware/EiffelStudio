indexing
	description: "Special assemblies for assembly manager"
	external_name: "ISE.AssemblyManager.SpecialAssemblies"

class
	SPECIAL_ASSEMBLIES

feature -- Access

	non_editable_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_ASSEMBLYDESCRIPTOR]
		indexing
			description: "List of assemblies that cannot be edited"
			external_name: "NonEditableAssemblies"
		local
			reflection_interface: ISE_REFLECTION_REFLECTIONINTERFACE
			imported_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST
			i: INTEGER
			an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			added: INTEGER
			mscorlib_found: BOOLEAN
		once
			create Result.make
			create reflection_interface.make_reflectioninterface
			reflection_interface.makereflectioninterface
			imported_assemblies := reflection_interface.assemblies
			from
			until
				i = imported_assemblies.count or mscorlib_found
			loop
				an_eiffel_assembly ?= imported_assemblies.item (i)
				if an_eiffel_assembly /= Void then
					a_descriptor := an_eiffel_assembly.assemblydescriptor
					if a_descriptor /= Void and then a_descriptor.name.tolower.equals_string (Mscorlib_assembly_name) then
						added := Result.add (a_descriptor)
						mscorlib_found := True
					end
				end
				i := i + 1
			end			
		ensure
			non_editable_assemblies_created: Result /= Void
		end
		
	non_removable_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_ASSEMBLYDESCRIPTOR]
		indexing
			description: "List of assemblies that cannot be removed from the Eiffel assembly cache"
			external_name: "NonRemovableAssemblies"
		local
			reflection_interface: ISE_REFLECTION_REFLECTIONINTERFACE
			i: INTEGER
			imported_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST
			an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			added: INTEGER
			mscorlib_found: BOOLEAN
			system_found: BOOLEAN
		once
			create Result.make
			create reflection_interface.make_reflectioninterface
			reflection_interface.makereflectioninterface
			imported_assemblies := reflection_interface.assemblies
			from
			until
				i = imported_assemblies.count or (mscorlib_found and system_found)
			loop
				an_eiffel_assembly ?= imported_assemblies.item (i)
				if an_eiffel_assembly /= Void then
					a_descriptor := an_eiffel_assembly.assemblydescriptor
					if a_descriptor /= Void then
						if a_descriptor.name.tolower.equals_string (Mscorlib_assembly_name) and not mscorlib_found then
							added := Result.add (a_descriptor)
							mscorlib_found := True
						elseif a_descriptor.name.tolower.equals_string (System_assembly_name) and not system_found then
							added := Result.add (a_descriptor)
							system_found := True					
						end
					end
				end
				i := i + 1
			end			
		ensure
			non_removable_assemblies_created: Result /= Void
		end
		
	Mscorlib_assembly_name: STRING is "mscorlib"
		indexing
			description: "Name of `mscorlib.dll'"
			external_name: "MscorlibAssemblyName"
		end

	System_assembly_name: STRING is "system"
		indexing
			description: "Name of `System.dll'"
			external_name: "SystemAssemblyName"
		end
		
end -- class SPECIAL_ASSEMBLIES
