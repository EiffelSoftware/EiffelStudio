indexing
	description: "COM interface for the Emitter"
	date: "$Date$"
	revision: "$Revision$"
	metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end
	class_metadata:
		create {CLASS_INTERFACE_ATTRIBUTE}.make (feature {CLASS_INTERFACE_TYPE}.none) end,
		create {GUID_ATTRIBUTE}.make ("E1FFE16A-FB59-4f0c-9D85-ADDD9366E359") end
	interface_metadata:
		create {GUID_ATTRIBUTE}.make ("E1FFE157-2182-4c1b-8D26-AC4BB334A7C8") end

class
	COM_ISE_CACHE_MANAGER

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
			path_exists: (create {DIRECTORY}.make (create {STRING}.make_from_cil (a_path))).exists
		local
			cr: CACHE_READER
		do
			clr_version := a_clr_version
			eac_path := a_path
			create cr.make (a_clr_version)
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

	consume_gac_assembly (aname, aversion, aculture, akey: SYSTEM_STRING) is
			-- consume an assembly from the gac defined by
			-- "'aname', Version='aversion', Culture='aculture', PublicKeyToken='akey'"
		require
			current_initialized: is_initialized
			non_void_name: aname /= Void
			non_void_version: aversion /= Void
			non_void_culture: aculture /= Void
			non_void_key: akey /= Void
			non_empty_name: aname.length > 0
			non_empty_version: aversion.length > 0
			non_empty_culture: aculture.length > 0
			non_empty_key: akey.length > 0
		local
			l_app_domain: APP_DOMAIN
			l_impl: MARSHAL_ISE_CACHE_MANAGER
		do	
			l_app_domain := feature {APP_DOMAIN}.create_domain ("Emitter_exe",
				new_evidence, new_setup (Void))
			
			l_impl := new_cache_manager (l_app_domain)
			l_impl.consume_gac_assembly (aname, aversion, aculture, akey)

			update_current (l_impl)
			feature {APP_DOMAIN}.unload (l_app_domain)
		end
		
	consume_local_assembly (apath, adest: SYSTEM_STRING) is
			-- Consume a local assembloes from 'apath' into 'adest'
		require
			current_initialized: is_initialized
			non_void_path: apath /= Void
			non_void_dest: adest /= Void
			path_exists: (create {RAW_FILE}.make (create {STRING}.make_from_cil(apath))).exists
			dest_exists: (create {DIRECTORY}.make (create {STRING}.make_from_cil(adest))).exists
		local
			i, nb: INTEGER
			l_app_domain: APP_DOMAIN
			l_impl: MARSHAL_ISE_CACHE_MANAGER
			l_native_array: NATIVE_ARRAY [SYSTEM_STRING]
			l_path: SYSTEM_STRING
		do	
			l_native_array := apath.split ((<<';'>>).to_cil)
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
			
			l_app_domain := feature {APP_DOMAIN}.create_domain ("Emitter_exe",
				new_evidence, new_setup (l_path))
			
			l_impl := new_cache_manager (l_app_domain)
			
			from
				i := 0
				nb := l_native_array.count - 1
			until
				i > nb
			loop
				l_impl.consume_local_assembly (l_native_array.item (i), adest)
				i := i + 1
			end

			update_current (l_impl)
			feature {APP_DOMAIN}.unload (l_app_domain)
		end
		
	relative_folder_name (aname, aversion, aculture, akey: SYSTEM_STRING): SYSTEM_STRING is
			-- Relative path to an assembly
		require
			current_initialized: is_initialized
			non_void_name: aname /= Void
			non_void_version: aversion /= Void
			non_void_culture: aculture /= Void
			non_empty_name: aname.length > 0
			non_empty_version: aversion.length > 0
			non_empty_culture: aculture.length > 0
		local
			key: STRING
			l_app_domain: APP_DOMAIN
			l_impl: MARSHAL_ISE_CACHE_MANAGER
		do	
			l_app_domain := feature {APP_DOMAIN}.create_domain ("Emitter_exe",
				new_evidence, new_setup (Void))
			
			if akey /= Void and akey.length > 0 then
				create key.make_from_cil (akey)				
			end
			
			l_impl := new_cache_manager (l_app_domain)
			Result := l_impl.relative_folder_name (aname, aversion, aculture, key)

			update_current (l_impl)
			feature {APP_DOMAIN}.unload (l_app_domain)
		ensure
			non_void_result: Result /= Void
			non_empty_result: Result.length > 0
		end
		
	assembly_info_from_assembly (apath: SYSTEM_STRING): COM_ASSEMBLY_INFORMATION is
			-- retrieve a local assembly's information
		require
			current_initialized: is_initialized
			non_void_path: apath /= Void
			non_empty_path: apath.length > 0
		local
			l_app_domain: APP_DOMAIN
			l_impl: MARSHAL_ISE_CACHE_MANAGER
		do
			l_app_domain := feature {APP_DOMAIN}.create_domain ("Emitter_exe",
				new_evidence, new_setup (feature {PATH}.get_directory_name (apath)))
				
			l_impl := new_cache_manager (l_app_domain)
			Result := l_impl.assembly_info_from_assembly (apath)

			update_current (l_impl)
			feature {APP_DOMAIN}.unload (l_app_domain)
		ensure
			non_void_result: Result /= Void
		end

feature {NONE} -- Implementation

	new_setup (apath: SYSTEM_STRING): APP_DOMAIN_SETUP is
			-- New setup for soon to be created AppDomain. If `apath' is not
			-- Void it contains a list of assemblies which needs to be added
			-- in `private_bin_path' of newly created APP_DOMAIN_SETUP instance.
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		local
			l_private_bin_path: SYSTEM_STRING
		do
			if apath /= Void then
				l_private_bin_path := apath
				l_private_bin_path := feature {SYSTEM_STRING}.concat_string_string (
					";" , l_private_bin_path)
				l_private_bin_path := feature {SYSTEM_STRING}.concat_string_string (
					feature {PATH}.get_directory_name (get_type.assembly.location) ,
					l_private_bin_path)
			else
				l_private_bin_path := feature {PATH}.get_directory_name (get_type.assembly.location)
			end
			create Result.make
				-- `application_base' needs to be setup to the magic "file://" so
				-- that when loading assemblies in the app domain initialized with
				-- `Result' it will look for those assemblies in `apath'.
			Result.set_application_base ("file://")
			Result.set_private_bin_path (l_private_bin_path)
			Result.set_application_name ("emitter")
		ensure
			new_setup_not_void: Result /= Void
		end

	new_evidence: EVIDENCE is
			-- New evidence for soon to be created AppDomain
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		do
			-- Void for the moment. If it is not Void we get too many security exceptions.
		end
		
	update_current (a_impl: MARSHAL_ISE_CACHE_MANAGER) is
			-- Update Current with `a_impl'.
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		require
			a_impl_not_void: a_impl /= Void
		do
			is_successful := a_impl.is_successful
			last_error_message := a_impl.last_error_message
		end
	
	new_cache_manager (a_app_domain: APP_DOMAIN): MARSHAL_ISE_CACHE_MANAGER is
			-- New instance of `MARSHAL_ISE_CACHE_MANAGER' created in `a_app_domain'.
		indexing
			metadata: create {COM_VISIBLE_ATTRIBUTE}.make (False) end
		require
			a_app_domain_not_void: a_app_domain /= Void
		do
			Result ?= a_app_domain.create_instance_from_and_unwrap (
				get_type.assembly.location,
				"ISE.Cache.MARSHAL_ISE_CACHE_MANAGER")
			
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

end -- class MARSHAL_ISE_CACHE_MANAGER
