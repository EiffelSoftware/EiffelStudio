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
		do
			Result := consumed_assembly_from_name (ass.get_name)
		ensure
			result_not_void: Result /= Void
			name_set: Result.name /= Void
			version_set: Result.version /= Void
			culture_set: Result.culture /= Void
		end

	consumed_assembly_from_name (aname: ASSEMBLY_NAME): CONSUMED_ASSEMBLY is
			-- Initialize from `aname'.
			--| Need to be signed assembly otherwise we can't get the location
		require
			non_void_name: aname /= Void
		local
			key: STRING
			culture: STRING
		do
			if aname.get_public_key_token = Void or else aname.get_public_key_token.length = 0 then
				key := "null"
			else
				key := encoded_key (aname.get_public_key_token)
			end
			if aname.culture_info.to_string.length = 0 then
				culture := "neutral"
			else
				create culture.make_from_cil (aname.culture_info.to_string)
			end
			create Result.make (create {STRING}.make_from_cil (aname.name),
								create {STRING}.make_from_cil (aname.version.to_string),
								culture, key)
		ensure
			result_not_void: Result /= Void
			name_set: Result.name /= Void
			version_set: Result.version /= Void
			culture_set: Result.culture /= Void
		end
		
end -- class CONSUMED_ASSEMBLY_FACTORY
