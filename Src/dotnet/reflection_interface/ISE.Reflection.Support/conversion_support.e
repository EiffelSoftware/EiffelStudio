indexing
	description: "Provides useful transformations."
	external_name: "ISE.Reflection.ConversionSupport"

class
	CONVERSION_SUPPORT

inherit
	ISE_REFLECTION_CONVERT
	
feature -- Access

	assembly_descriptor_from_name (an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is 
			-- Assembly descriptor corresponding to `an_assembly_name'
		indexing
			external_name: "AssemblyDescriptorFromName"
		require
			non_void_assembly_name: an_assembly_name /= Void
		local
			assembly_info: ARRAY [STRING]
			retried: BOOLEAN
		do
			create Result.make1
			if not retried then
				assembly_info := assemblyinfofromname (an_assembly_name)
				if assembly_info /= Void and then assembly_info.count = 4 then	
					Result.make (assembly_info.item (0), assembly_info.item (1), assembly_info.item (2), assembly_info.item (3))
				end
			end
		ensure
			non_void_assembly_descriptor: Result /= Void
		rescue
			retried := True
			retry
		end

	assembly_name_from_descriptor (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): SYSTEM_REFLECTION_ASSEMBLYNAME is
			-- Assembly name corresponding to `a_descriptor'.
		indexing
			external_name: "AssemblyNameFromDescriptor"
		require
			non_void_descriptor: a_descriptor /= Void
		local
			version: SYSTEM_VERSION
			culture: SYSTEM_GLOBALIZATION_CULTUREINFO
			encoding: SYSTEM_TEXT_ASCIIENCODING
			public_key: ARRAY [INTEGER_8]
			retried: BOOLEAN
		do
			create Result.make
			Result.set_Name (a_descriptor.Name)
			create version.make_3 (a_descriptor.Version)
			Result.set_Version (version)
			if not a_descriptor.Culture.equals_string (Neutral_culture) then
				create culture.make (a_descriptor.Culture)
			else
				create culture.make (Empty_string)
			end
			Result.set_CultureInfo (culture)
			create encoding.make_asciiencoding 
			if not retried then
				public_key := encoding.GetBytes (a_descriptor.PublicKey)
				Result.SetPublicKeyToken (public_key)
			end
		ensure
			non_void_assembly_name: Result /= Void
		rescue
			retried := True
			retry
		end

	Empty_string: STRING is ""
			-- Empty string
		indexing
			external_name: "EmptyString"
		end		
	
	Neutral_culture: STRING is "neutral"
			-- Neutral culture
		indexing
			external_name: "NeutralCulture"
		end

end -- class CONVERSION_SUPPORT
