indexing
	description: "Build instances of CONSUMED_ASSEMBLY from .NET assemblies"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ASSEMBLY_FACTORY

inherit
	KEY_ENCODER

feature -- Basic Operations

	consumed_assembly (ass: ASSEMBLY): CONSUMED_ASSEMBLY is
			-- Initialize from `ass'.
		require
			non_void_assembly: ass /= Void
		local
			aname: ASSEMBLY_NAME
			culture: STRING
			native_culture: SYSTEM_STRING
		do
			aname := ass.get_name
			if aname.get_public_key_token /= Void then
				Result := consumed_assembly_from_name (aname)
			else
				native_culture := aname.get_culture_info.to_string
				if native_culture.get_length = 0 then
					culture := "neutral"
				else
					create culture.make_from_cil (native_culture)
				end
				create Result.make (create {STRING}.make_from_cil (ass.get_location),
									create {STRING}.make_from_cil (aname.get_version.to_string),
									culture,
									Void)
			end
		ensure
			name_set: Result.name /= Void
			culture_set: Result.culture /= Void
			version_set: Result.version /= Void
		end

	consumed_assembly_from_name (aname: ASSEMBLY_NAME): CONSUMED_ASSEMBLY is
			-- Initialize from `aname'.
			--| Need to be signed assembly otherwise we can't get the location
		require
			non_void_name: aname /= Void
			signed_assembly: aname.get_public_key_token /= Void
		local
			culture: STRING
			native_culture: SYSTEM_STRING
		do
			native_culture := aname.get_culture_info.to_string
			if native_culture.get_length = 0 then
				culture := "neutral"
			else
				create culture.make_from_cil (native_culture)
			end
			create Result.make (create {STRING}.make_from_cil (aname.get_name),
								create {STRING}.make_from_cil (aname.get_version.to_string),
								culture,
								encoded_key (aname.get_public_key_token))
		ensure
			name_set: Result.name /= Void
			culture_set: Result.culture /= Void
			version_set: Result.version /= Void
			key_set: Result.key /= Void
		end
		
end -- class CONSUMED_ASSEMBLY_FACTORY
