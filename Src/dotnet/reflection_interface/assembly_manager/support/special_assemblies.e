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
			error_code: INTEGER
			returned_value: INTEGER
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
		once
			create reflection_interface.make_reflectioninterface
			reflection_interface.makereflectioninterface
			imported_assemblies := reflection_interface.assemblies
			if not reflection_interface.lastreadsuccessful then 
				error_code := reflection_interface.lasterror.code
				if error_code = reflection_interface.Haswritelockcode or error_code = reflection_interface.Hasreadlockcode then
					returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Access_violation_error, dictionary.Error_caption, dictionary.Abort_retry_ignore_message_box_buttons, dictionary.Error_icon)
					if returned_value = dictionary.Retry_result then
						imported_assemblies := reflection_interface.assemblies
						Result := intern_non_editable_assemblies (imported_assemblies)
					elseif returned_value = dictionary.Ignore_result then
						create reflection_support.make_reflectionsupport
						reflection_support.make
						reflection_support.cleanassemblies
						imported_assemblies := reflection_interface.assemblies
						Result := intern_non_editable_assemblies (imported_assemblies)
					end
				end
			else
				Result := intern_non_editable_assemblies (imported_assemblies)
			end
		rescue
			if not reflection_interface.lastreadsuccessful then 
				error_code := reflection_interface.lasterror.code
				if error_code = reflection_interface.Haswritelockcode or error_code = reflection_interface.Hasreadlockcode then
					returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Access_violation_error, dictionary.Error_caption, dictionary.Abort_retry_ignore_message_box_buttons, dictionary.Error_icon)
					if returned_value = dictionary.Retry_result then
						imported_assemblies := reflection_interface.assemblies
						Result := intern_non_editable_assemblies (imported_assemblies)
					elseif returned_value = dictionary.Ignore_result then
						create reflection_support.make_reflectionsupport
						reflection_support.make
						reflection_support.cleanassemblies
						imported_assemblies := reflection_interface.assemblies
						Result := intern_non_editable_assemblies (imported_assemblies)
					end
				end
			else					
				if reflection_interface.lasterror /= Void and then reflection_interface.lasterror.description /= Void and then reflection_interface.lasterror.description.length > 0 then
					returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (reflection_interface.lasterror.description, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
				end
			end
		end
		
	non_removable_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_ASSEMBLYDESCRIPTOR]
		indexing
			description: "List of assemblies that cannot be removed from the Eiffel assembly cache"
			external_name: "NonRemovableAssemblies"
		local
			reflection_interface: ISE_REFLECTION_REFLECTIONINTERFACE
			imported_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST
			error_code: INTEGER
			returned_value: INTEGER
			message_box: SYSTEM_WINDOWS_FORMS_MESSAGEBOX
			reflection_support: ISE_REFLECTION_REFLECTIONSUPPORT
		once
			create reflection_interface.make_reflectioninterface
			reflection_interface.makereflectioninterface
			imported_assemblies := reflection_interface.assemblies
			if not reflection_interface.lastreadsuccessful then
				error_code := reflection_interface.lasterror.code
				if error_code = reflection_interface.Haswritelockcode or error_code = reflection_interface.Hasreadlockcode then
					returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Access_violation_error, dictionary.Error_caption, dictionary.Abort_retry_ignore_message_box_buttons, dictionary.Error_icon)
					if returned_value = dictionary.Retry_result then
						imported_assemblies := reflection_interface.assemblies
						Result := intern_non_removable_assemblies (imported_assemblies)
					elseif returned_value = dictionary.Ignore_result then
						create reflection_support.make_reflectionsupport
						reflection_support.make
						reflection_support.cleanassemblies
						imported_assemblies := reflection_interface.assemblies
						Result := intern_non_removable_assemblies (imported_assemblies)
					end
				end			
			else	
				Result := intern_non_removable_assemblies (imported_assemblies)
			end
		rescue
			if not reflection_interface.lastreadsuccessful then 
				error_code := reflection_interface.lasterror.code
				if error_code = reflection_interface.Haswritelockcode or error_code = reflection_interface.Hasreadlockcode then
					returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (dictionary.Access_violation_error, dictionary.Error_caption, dictionary.Abort_retry_ignore_message_box_buttons, dictionary.Error_icon)
					if returned_value = dictionary.Retry_result then
						imported_assemblies := reflection_interface.assemblies
						Result := intern_non_editable_assemblies (imported_assemblies)
					elseif returned_value = dictionary.Ignore_result then
						create reflection_support.make_reflectionsupport
						reflection_support.make
						reflection_support.cleanassemblies
						imported_assemblies := reflection_interface.assemblies
						Result := intern_non_editable_assemblies (imported_assemblies)
					end
				end
			else					
				if reflection_interface.lasterror /= Void and then reflection_interface.lasterror.description /= Void and then reflection_interface.lasterror.description.length > 0 then
					returned_value := message_box.show_string_string_messageboxbuttons_messageboxicon (reflection_interface.lasterror.description, dictionary.Error_caption, dictionary.Ok_message_box_button, dictionary.Error_icon)
				end
			end
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

feature {NONE} -- Implementation

	dictionary: DICTIONARY is
		indexing
			description: "Dictionary"
			external_name: "Dictionary"
		once
			create Result
		end

	intern_non_editable_assemblies (imported_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST): SYSTEM_COLLECTIONS_ARRAYLIST is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_ASSEMBLYDESCRIPTOR]
		indexing
			description: "List of assemblies that cannot be edited"
			external_name: "InternNonEditableAssemblies"		
		require
			non_void_imported_assemblies: imported_assemblies /= Void
		local
			i: INTEGER
			mscorlib_found: BOOLEAN
			an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			added: INTEGER			
		do
			from
				create Result.make
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

	intern_non_removable_assemblies (imported_assemblies: SYSTEM_COLLECTIONS_ARRAYLIST): SYSTEM_COLLECTIONS_ARRAYLIST is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_ASSEMBLYDESCRIPTOR]
		indexing
			description: "List of assemblies that cannot be removed"
			external_name: "InternNonRemovableAssemblies"		
		require
			non_void_imported_assemblies: imported_assemblies /= Void
		local
			i: INTEGER
			an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			added: INTEGER
			mscorlib_found: BOOLEAN
			system_found: BOOLEAN		
		do
			from
				create Result.make
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
		
end -- class SPECIAL_ASSEMBLIES
