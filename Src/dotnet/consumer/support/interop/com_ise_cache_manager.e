indexing
	description: "COM interface for the Emitter"
	date: "$Date$"
	revision: "$Revision$"
	attribute:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end
	class_attribute:
		create {CLASS_INTERFACE_ATTRIBUTE}.make_from_class_interface_type_2 (feature {CLASS_INTERFACE_TYPE}.none) end,
		create {GUID_ATTRIBUTE}.make (("0477E16A-FB59-4f0c-9D85-ADDD9366E359").to_cil) end
	interface_attribute:
		create {GUID_ATTRIBUTE}.make (("5855B757-2182-4c1b-8D26-AC4BB334A7C8").to_cil) end

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

	start_assembly_enumeration is
			-- Notify that we are about to receive an iteration of assembly path.
		require
			initialized: is_initialized
		do
			impl.Assembly_locations.wipe_out
		end

	add_assembly (an_assembly_path: SYSTEM_STRING) is
			-- Add `an_assembly_path' to the list of assemblies to be consumed `Assembly_locations'.
		require
			initialized: is_initialized
			valid_assembly_path: an_assembly_path /= Void and then an_assembly_path.length > 4 
						and then an_assembly_path.chars (an_assembly_path.length - 3 ) = '.'
						and then an_assembly_path.chars (an_assembly_path.length - 2 ) = 'd'
						and then an_assembly_path.chars (an_assembly_path.length - 1 ) = 'l'
						and then an_assembly_path.chars (an_assembly_path.length - 0 ) = 'l'
			assembly_exists: feature {SYSTEM_FILE}.exists (an_assembly_path) 
		do
			impl.Assembly_locations.extend (create {STRING}.make_from_cil (an_assembly_path))
		ensure
			impl.Assembly_locations.has (create {STRING}.make_from_cil (an_assembly_path))
		end

	consume_assemblies is
			-- Consumed the entire list of assemblies.
		require
			initialized: is_initialized
		local
			l_assembly: ASSEMBLY
		do
			from
				impl.Assembly_locations.start
			until
				impl.Assembly_locations.after
			loop
				l_assembly := feature {ASSEMBLY}.load_from (impl.Assembly_locations.item.to_cil)
				if l_assembly /= Void then
					impl.consume_in_eac (l_assembly)
				else
					check
						error: False
					end
				end
				impl.Assembly_locations.forth
			end
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
