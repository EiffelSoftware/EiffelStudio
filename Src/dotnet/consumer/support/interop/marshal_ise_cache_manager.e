indexing
	description: "Marshalled interface for the Emitter"
	date: "$Date$"
	revision: "$Revision$"

class
	MARSHAL_ISE_CACHE_MANAGER

inherit
	ANY

	MARSHAL_BY_REF_OBJECT
		undefine
			to_string, equals, finalize, get_hash_code
		end

feature -- Access

	is_successful: BOOLEAN is
			-- Was the consuming successful?
		do
			Result := implementation.is_successful
		end
		
	is_initialized: BOOLEAN
			-- Has current object been initialized?
			
	last_error_message: SYSTEM_STRING is
			-- Last error message
		do
			Result := implementation.last_error_message
		end

feature -- Basic Exportations

	initialize (a_clr_version: SYSTEM_STRING) is
			-- initialize the object using default path to EAC
		require
			not_already_initialized: not is_initialized
			not_void_clr_version: a_clr_version /= Void
			valid_clr_version: a_clr_version.length > 0
		do
			create implementation.make (a_clr_version)
			is_initialized := True
		ensure
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
			create implementation.make_with_path (a_path, a_clr_version)
			create cr.make (a_clr_version)
			if not cr.is_initialized then
				(create {EIFFEL_XML_SERIALIZER}).serialize (create {CACHE_INFO}.make (a_clr_version), cr.absolute_info_path)
			end
			is_initialized := True
		ensure
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
		do	
			implementation.consume_gac_assembly (aname, aversion, aculture, akey)
		end
		
	consume_local_assembly (apath, adest: SYSTEM_STRING) is
			-- consume a local assembly from 'apath' into 'adest'
		require
			current_initialized: is_initialized
			non_void_path: apath /= Void
			non_void_dest: adest /= Void
			path_exists: (create {RAW_FILE}.make (create {STRING}.make_from_cil(apath))).exists
			dest_exists: (create {DIRECTORY}.make (create {STRING}.make_from_cil(adest))).exists
		do	
			implementation.consume_local_assembly (apath, adest)
		end
		
	relative_folder_name (aname, aversion, aculture, akey: SYSTEM_STRING): SYSTEM_STRING is
			-- retruns the relative path to an assembly
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
		do	
			if akey /= Void and akey.length > 0 then
				create key.make_from_cil (akey)				
			end
			
			Result := implementation.relative_folder_name (aname, aversion, aculture, key)
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
		do
			create Result.make (implementation.assembly_info_from_assembly (apath))
		ensure
			non_void_result: Result /= Void
		end

feature {NONE} -- Implementation
			
	implementation: ISE_CACHE_MANAGER
			-- Access to `ISE_CACHE_MANAGER'.

end -- class MARSHAL_ISE_CACHE_MANAGER
