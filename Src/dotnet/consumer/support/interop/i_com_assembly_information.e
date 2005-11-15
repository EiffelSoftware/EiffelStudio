indexing
	description: "COM visible class representing an assemblies information"
	date: "$Date$"
	revision: "$Revision$"
	interface_metadata:
		create {COM_VISIBLE_ATTRIBUTE}.make (True) end,
		create {GUID_ATTRIBUTE}.make ("E1FFE100-6EB3-46C8-94CE-208A7B1C79C3") end

deferred class
	I_COM_ASSEMBLY_INFORMATION
		
feature -- Access

	name: SYSTEM_STRING is
			-- assembly name
		deferred
		ensure
			non_void_result: Result /= Void
			not_result_is_empty: Result.length > 0
		end
		
	version: SYSTEM_STRING is
			-- assembly version
		deferred
		ensure
			non_void_result: Result /= Void
			not_result_is_empty: Result.length > 0
		end
		
	culture: SYSTEM_STRING is
			-- assembly culture
		deferred
		ensure
			non_void_result: Result /= Void
			not_result_is_empty: Result.length > 0
		end
		
	public_key_token: SYSTEM_STRING is
			-- assembly public key token
		deferred
		ensure
			non_void_result: Result /= Void
		end
		
	is_in_gac: BOOLEAN is
			-- Is assembly currently is GAC
		deferred
		end
		
	is_consumed: BOOLEAN is
			-- has assembly been consumed?
		deferred
		end
		
	consumed_folder_name: SYSTEM_STRING is
			-- name of folder where assembly was consumed to
		deferred
		end

end -- class I_COM_ASSEMBLY_INFORMATION
