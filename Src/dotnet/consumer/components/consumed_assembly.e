indexing
	description: "Assembly description to be persisted in XML"

class
	CONSUMED_ASSEMBLY

inherit
	KEY_ENCODER
		redefine
			out,
			is_equal
		end
create
	make,
	make_from_name

feature {NONE} -- Initialization

	make (ass: ASSEMBLY) is
			-- Initialize from `ass'.
		require
			non_void_assembly: ass /= Void
		local
			aname: ASSEMBLY_NAME
		do
			aname := ass.get_name
			if aname.get_public_key_token /= Void then
				make_from_name (aname)
			else
				create name.make_from_cil (ass.get_location)
				create version.make_from_cil (aname.get_version.to_string)
				create culture.make_from_cil (aname.get_culture_info.to_string)
				if culture.is_empty then
					culture := "neutral"
				end
			end
		ensure
			name_set: name /= Void
			culture_set: culture /= Void
			version_set: version /= Void
		end

	make_from_name (aname: ASSEMBLY_NAME) is
			-- Initialize from `aname'.
			--| Need to be signed assembly otherwise we can't get the location
		require
			non_void_name: aname /= Void
			signed_assembly: aname.get_public_key_token /= Void
		do
			create name.make_from_cil (aname.get_name)
			key := encoded_key (aname.get_public_key_token)					
			create version.make_from_cil (aname.get_version.to_string)
			create culture.make_from_cil (aname.get_culture_info.to_string)
			if culture.is_empty then
				culture := "neutral"
			end
		ensure
			name_set: name /= Void
			culture_set: culture /= Void
			version_set: version /= Void
			key_set: key /= Void
		end
		
feature -- Access

	name: STRING
			-- Assembly path (local) or fullname (in GAC)
	
	version: STRING
			-- Assembly version number
	
	culture: STRING
			-- Assembly culture
	
	key: STRING
			-- Assembly public key token
	
	out: STRING is
			-- New string containing terse printable representation
			-- of current object
			-- Eg: "System.Management, Version=1.0.3300.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
		local
			count: INTEGER
		do
			count := name.count
			count := count + version.count + 2
			count := count + culture.count + 2
			if key /= Void then
				count := count + key.count + 2
			end
			create Result.make (count)
			Result.append (name)
			Result.append (", Version=")
			Result.append (version)
			Result.append (", Culture=")
			Result.append (culture)
			if key /= Void then
				Result.append (", PublicKeyToken=")
				Result.append (key)
			end			
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := other.name.is_equal (name) and
						(version = Void implies other.version = Void) and
						(version /= Void implies (other.version /= Void and then other.version.is_equal (version))) and
						(culture = Void implies other.culture = Void) and
						(culture /= Void implies (other.culture /= Void and then other.culture.is_equal (culture))) and
						(key = Void implies other.key = Void) and
						(key /= Void implies (other.key /= Void and then other.key.is_equal (key)))
		end
		
invariant
	non_void_assembly_name: name /= Void

end -- class CONSUMED_ASSEMBLY
