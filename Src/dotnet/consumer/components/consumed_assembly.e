indexing
	description: "Assembly description to be persisted in XML"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ASSEMBLY

inherit
	ANY
		redefine
			is_equal, out
		end

create
	make

feature {NONE} -- Initialization

	make (n, v, c, k: STRING) is
			-- Set `name' with `n'.
			-- Set `version' with `v'.
			-- Set `culture' with `c'.
			-- Set `key' with `k'.
		require
			non_void_name: n /= Void
			valid_name: not n.is_empty
			non_void_version: v /= Void
			valid_version: not v.is_empty
			non_void_culture: c /= Void
			valid_culture: not c.is_empty
			valid_key: k /= Void implies not k.is_empty
		do
			name := n
			version := v
			culture := c
			key := k
		ensure
			name_set: name = n
			version_set: version = v
			culture_set: culture = c
			key_set: key = k
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
	non_void_assembly_version: version /= Void
	non_void_assembly_culture: culture /= Void

end -- class CONSUMED_ASSEMBLY
