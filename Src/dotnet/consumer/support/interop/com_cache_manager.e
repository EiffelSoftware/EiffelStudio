indexing
	description: "COM interface for metadata consumer"
	date: "$Date$"
	revision: "$Revision$"
	metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end
	class_metadata:
		create {CLASS_INTERFACE_ATTRIBUTE}.make (feature {CLASS_INTERFACE_TYPE}.none) end,
		create {GUID_ATTRIBUTE}.make ("E1FFE121-BD03-4F43-B575-655DAC9941A3") end
	interface_metadata:
		create {GUID_ATTRIBUTE}.make ("E1FFE14C-4113-40E1-9BCC-E8B0CF3C0F5A") end

class
	COM_CACHE_MANAGER

feature -- Access

	is_successful: BOOLEAN
			-- Was the consuming successful?
		
	is_initialized: BOOLEAN 
			-- has COM object been initialized?
			
	last_error_message: SYSTEM_STRING
			-- Last error message

feature -- Basic Exportations

	initialize (a_clr_version: SYSTEM_STRING) is
			-- initialize the object using default path to EAC
		require
			not_already_initialized: not is_initialized
			not_void_clr_version: a_clr_version /= Void
			valid_clr_version: a_clr_version.length > 0
		do
			clr_version := a_clr_version
			is_initialized := True
		ensure
			clr_version_set: clr_version = a_clr_version
			current_initialized: is_initialized
		end
		
	initialize_with_path (a_path, a_clr_version: SYSTEM_STRING) is
			-- initialize object with path to specific EAC and initializes it if not already done.
		require
			not_already_initialized: not is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
			not_void_clr_version: a_clr_version /= Void
			valid_clr_version: a_clr_version.length > 0
		local
			cr: CACHE_READER
		do
			clr_version := a_clr_version
			eac_path := a_path
			create cr.make (a_clr_version)
			cr.set_internal_eiffel_cache_path (eac_path)
			if not cr.is_initialized then
				(create {EIFFEL_XML_SERIALIZER}).serialize (
				create {CACHE_INFO}.make (a_clr_version),
				cr.absolute_info_path)
			end
			is_initialized := True
		ensure
			clr_version_set: clr_version = a_clr_version
			eac_path_set: eac_path = a_path
			current_initialized: is_initialized
		end

	consume_assembly (a_name, a_version, a_culture, a_key: SYSTEM_STRING) is
			-- consume an assembly using it's display name parts.
			-- "`a_name', Version=`a_version', Culture=`a_culture', PublicKeyToken=`a_key'"
		require
			current_initialized: is_initialized
			non_void_name: a_name /= Void
			valid_name: a_name.length > 0
		local
			l_app_domain: APP_DOMAIN
			l_impl: MARSHAL_CACHE_MANAGER
		do	
			l_app_domain := feature {APP_DOMAIN}.create_domain ("EiffelSoftware.MetadataConsumer", Void, Void)
			
			l_impl := new_cache_manager (l_app_domain)
			l_impl.consume_assembly (a_name, a_version, a_culture, a_key)

			update_current (l_impl)
			feature {APP_DOMAIN}.unload (l_app_domain)
		end
		
	consume_assembly_from_path (a_path: SYSTEM_STRING) is
			-- Consume assembly located `a_path'
		require
			current_initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
		local
			i, nb: INTEGER
			l_app_domain: APP_DOMAIN
			l_impl: MARSHAL_CACHE_MANAGER
			l_native_array: NATIVE_ARRAY [SYSTEM_STRING]
			l_path: SYSTEM_STRING
		do	
			l_native_array := a_path.split ((<<';'>>).to_cil)
			from
				l_path := feature {PATH}.get_directory_name (l_native_array.item (0))
				i := 1
				nb := l_native_array.count - 1
			until
				i > nb
			loop
				l_path := feature {SYSTEM_STRING}.concat_string_string (
					l_path, ";")
				l_path := feature {SYSTEM_STRING}.concat_string_string (
					l_path, feature {PATH}.get_directory_name (l_native_array.item (i)))
				i := i + 1
			end
			
			l_app_domain := feature {APP_DOMAIN}.create_domain ("EiffelSoftware.MetadataConsumer", Void, Void)
		
			l_impl := new_cache_manager (l_app_domain)
			
			from
				i := 0
				nb := l_native_array.count - 1
			until
				i > nb
			loop
				l_path := l_native_array.item (i)
				if l_path.length > 0 then
					l_impl.assembly_resolver.add_resolver_path_from_file_name (l_path)
				end
				i := i + 1
			end
			
				-- consume assemblies
			from
				i := 0
				nb := l_native_array.count - 1
			until
				i > nb
			loop
				l_impl.consume_assembly_from_path (l_native_array.item (i))
				i := i + 1
			end
			
			--l_resolver.dispose
			update_current (l_impl)
			feature {APP_DOMAIN}.unload (l_app_domain)
		end
		
	relative_folder_name (a_name, a_version, a_culture, a_key: SYSTEM_STRING): SYSTEM_STRING is
			-- returns the relative path to an assembly using at least `a_name'
		require
			current_initialized: is_initialized
			non_void_name: a_name /= Void
			valid_name: a_name.length > 0
		local
			l_app_domain: APP_DOMAIN
			l_impl: MARSHAL_CACHE_MANAGER
		do	
			l_app_domain := feature {APP_DOMAIN}.create_domain ("EiffelSoftware.MetadataConsumer", Void, Void)
			
			l_impl := new_cache_manager (l_app_domain)
			Result := l_impl.relative_folder_name (a_name, a_version, a_culture, a_key)

			update_current (l_impl)
			feature {APP_DOMAIN}.unload (l_app_domain)
		ensure
			non_void_result: Result /= Void
			non_empty_result: Result.length > 0
		end
		
	relative_folder_name_from_path (a_path: SYSTEM_STRING): SYSTEM_STRING is
			-- Relative path to consumed assembly metadata given `a_path'
		require
			current_initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
			path_exists: (create {FILE_INFO}.make (a_path)).exists
		local
			l_app_domain: APP_DOMAIN
			l_impl: MARSHAL_CACHE_MANAGER
		do	
			l_app_domain := feature {APP_DOMAIN}.create_domain ("EiffelSoftware.MetadataConsumer", Void, Void)
			
			l_impl := new_cache_manager (l_app_domain)
			Result := l_impl.relative_folder_name_from_path (a_path)

			update_current (l_impl)
			feature {APP_DOMAIN}.unload (l_app_domain)
		ensure
			non_void_result: Result /= Void
			non_empty_result: Result.length > 0
		end

	assembly_info_from_assembly (a_path: SYSTEM_STRING): COM_ASSEMBLY_INFORMATION is
			-- retrieve a local assembly's information
		require
			current_initialized: is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
		local
			l_app_domain: APP_DOMAIN
			l_impl: MARSHAL_CACHE_MANAGER
		do
			l_app_domain := feature {APP_DOMAIN}.create_domain ("EiffelSoftware.MetadataConsumer", Void, Void)
				
			l_impl := new_cache_manager (l_app_domain)
			Result := l_impl.assembly_info_from_assembly (a_path)

			update_current (l_impl)
			feature {APP_DOMAIN}.unload (l_app_domain)
		ensure
			non_void_result: Result /= Void
		end


feature {NONE} -- Implementation

	update_current (a_impl: MARSHAL_CACHE_MANAGER) is
			-- Update Current with `a_impl'.
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		require
			a_impl_not_void: a_impl /= Void
		do
			is_successful := a_impl.is_successful
			last_error_message := a_impl.last_error_message
		end
	
	new_cache_manager (a_app_domain: APP_DOMAIN): MARSHAL_CACHE_MANAGER is
			-- New instance of `MARSHAL_CACHE_MANAGER' created in `a_app_domain'.
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		require
			a_app_domain_not_void: a_app_domain /= Void
		do
			Result ?= a_app_domain.create_instance_from_and_unwrap (
				to_dotnet.get_type.assembly.location,
				"EiffelSoftware.MetadataConsumer.MARSHAL_CACHE_MANAGER")
			check
				created_new_cache_manager: Result /= Void
			end

			if eac_path = Void then
				Result.initialize (clr_version)
			else
				Result.initialize_with_path (eac_path, clr_version)
			end
		ensure
			new_cache_manager_not_void: Result /= Void
		end

	clr_version: SYSTEM_STRING
			-- Version of CLR used to emit data
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		end
		
	eac_path: SYSTEM_STRING
			-- Location of EAC `Eiffel Assembly Cache'
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		end

end -- class MARSHAL_CACHE_MANAGER
