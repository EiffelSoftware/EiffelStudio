indexing
	description: "COM interface for the Emitter"
	date: "$Date$"
	revision: "$Revision$"
	attribute:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end
	class_attribute:
		create {CLASS_INTERFACE_ATTRIBUTE}.make_from_class_interface_type_2 (feature {CLASS_INTERFACE_TYPE}.none) end,
		create {GUID_ATTRIBUTE}.make (("01BDF738-3044-3ED6-BA7B-34632D67E145").to_cil) end
	interface_attribute:
		create {GUID_ATTRIBUTE}.make (("E3526F85-A118-3FBC-B445-417452D1AAA5").to_cil) end

class
	COM_ISE_CACHE_MANAGER

create make

feature {NONE} -- Initialization 

	make is
			-- create an instance of ISE_CACHE_MANAGER
		do
			is_initialized := False
		end
		
feature -- Access

	is_successful: BOOLEAN is
			-- was the consuming successful
		do
			Result := impl.is_successful
		end
		
	is_initialized: BOOLEAN 
			-- has COM object been initialized?
	
	last_error_message: SYSTEM_STRING is
			-- last error message
		do
			Result := impl.last_error_message.to_cil
		end
		
feature -- Basic Oprtations

	initialize is
			-- initialize the object using default path to EAC
		require
			not_already_initialized: not is_initialized
		do
			create impl.make
			is_initialized := True
		ensure
			current_initialized: is_initialized
		end
		
	initialize_with_path (a_path: SYSTEM_STRING) is
			-- initialize object with path to specific EAC
		require
			not_already_initialized: not is_initialized
			non_void_path: a_path /= Void
			valid_path: a_path.length > 0
			path_exists: (create {DIRECTORY}.make (create {STRING}.make_from_cil (a_path))).exists
		do
			create impl.make_with_path (create {STRING}.make_from_cil (a_path))
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
		local
			name, version, culture, key: STRING
		do	
			create name.make_from_cil (aname)
			create version.make_from_cil (aversion)
			create culture.make_from_cil (aculture)
			create key.make_from_cil (akey)
			
			impl.consume_gac_assembly (name, version, culture, key)
		end
		
	consume_local_assembly (apath, adest: SYSTEM_STRING) is
			-- consume a local assembly from 'apath' into 'adest'
		require
			current_initialized: is_initialized
			non_void_path: apath /= Void
			non_void_dest: adest /= Void
			path_exists: (create {RAW_FILE}.make (create {STRING}.make_from_cil(apath))).exists
			dest_exists: (create {DIRECTORY}.make (create {STRING}.make_from_cil(adest))).exists
		local
			path, dest: STRING
		do	
			create path.make_from_cil (apath)
			create dest.make_from_cil (adest)
			impl.consume_local_assembly (path, dest)
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
			name, version, culture, key: STRING
		do	
			create name.make_from_cil (aname)
			create version.make_from_cil (aversion)
			create culture.make_from_cil (aculture)
			if akey /= Void and akey.length > 0 then
				create key.make_from_cil (akey)				
			end
			
			Result := impl.relative_folder_name (name, version, culture, key).to_cil
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
			path: STRING
		do
			create path.make_from_cil (apath)
			create Result.make (impl.assembly_info_from_assembly (path))
		ensure
			non_void_result: Result /= Void
		end

feature {NONE} -- Implementation

	impl: ISE_CACHE_MANAGER
		-- impl to the cache manager

end -- class COM_ISE_CACHE_MANAGER
