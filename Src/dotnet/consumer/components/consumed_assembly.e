indexing
	description: "Assembly description to be persisted in XML"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ASSEMBLY

inherit
	ANY
		redefine
			is_equal,
			out
		end

create
	make

feature {NONE} -- Initialization

	make (id, fn, n, v, c, k, loc, gp: STRING; a_in_gac: BOOLEAN) is
			-- Set `unique_id' with `id'
			-- Set `folder_name' with 'fn'
			-- Set `name' with `n'.
			-- Set `version' with `v'.
			-- Set `culture' with `c'.
			-- Set `key' with `k'.
			-- Set `location' with `loc'
			-- Set `gac_path' with `gp'
			-- Set `is_in_gac' with `a_in_gac'
		require
			non_void_id: id /= Void
			valid_id: not id.is_empty
			non_void_name: n /= Void
			valid_name: not n.is_empty
			non_void_version: v /= Void
			valid_version: not v.is_empty
			non_void_culture: c /= Void
			valid_culture: not c.is_empty
			non_void_key: k /= Void
			non_void_location: loc /= Void
			valid_location: not loc.is_empty
			non_void_gp: gp /= Void
			valid_gp: not gp.is_empty
		do			
			name := n
			version := v
			culture := c
			key := k
			location := loc.as_lower
			gac_path := gp.as_lower
			unique_id := id
			is_in_gac := a_in_gac
			
			folder_name := fn
		ensure
			name_set: name = n
			folder_name_set: folder_name = fn
			version_set: version = v
			culture_set: culture = c
			key_set: key = k
			location_set: location = loc.as_lower
			gac_path_set: gac_path = gp.as_lower
			unique_id_set: unique_id = id
			is_in_gac_set: is_in_gac = a_in_gac
		end

feature -- Access

	unique_id: STRING
			-- Unique id for consumed assembly

	folder_name: STRING
			-- name of folder where consumed assembly metadata is stored

	name: STRING
			-- Assembly path (local) or fullname (in GAC)
	
	version: STRING
			-- Assembly version number
	
	culture: STRING
			-- Assembly culture
	
	key: STRING
			-- Assembly public key token
			
	location: STRING
			-- Assembly location (path loaded from)
			
	gac_path: STRING
			-- Assembly code base (path of loaded assembly)
			
	is_consumed: BOOLEAN
			-- Indicates if assembly has actually been consumed.
			
	is_in_gac: BOOLEAN
			-- Indicates if assembly was consumed from GAC.
	
	out: STRING is
			-- New string containing terse printable representation
			-- of current object
			-- Eg: "A, Version=1.0.3300.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
		do
			create Result.make (name.count + location.count + 11)
			Result.append (name)
			Result.append (", Version=")
			Result.append (version)
			Result.append (", Culture=")
			Result.append (culture)
			Result.append (", PublicKeyToken=")
			Result.append (key)
			Result.append (", CodeBase=")
			Result.append (location)
		end
		
feature {CACHE_WRITER} -- Status Setting

	set_is_consumed (a_consumed: BOOLEAN) is
			-- Sets `is_consumed' to `a_consumed'
		do
			is_consumed := a_consumed
		ensure
			is_consumed_set: is_consumed = a_consumed
		end
		
	set_location (a_location: STRING) is
			-- Set `location' with `a_location'
		require
			non_void_location: a_location /= Void
			valid_location: not a_location.is_empty
		do
			location := a_location.as_lower
		ensure
			location_set: location = a_location.as_lower
		end
		
	set_gac_path (a_gac_path: STRING) is
			-- Set `gac_path' with `a_gac_path'
		require
			non_void_gac_path: a_gac_path /= Void
			valid_gac_path: not a_gac_path.is_empty
		do
			gac_path := a_gac_path.as_lower
		ensure
			gac_path_set: gac_path = a_gac_path.as_lower
		end

	set_is_in_gac (a_in_gac: BOOLEAN) is
			-- Sets `is_in_gac' to `a_in_gac'
		do
			is_in_gac := a_in_gac
		ensure
			is_in_gac_set: is_in_gac = a_in_gac
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := has_same_path (other.gac_path) or else has_same_path (other.location)
		end
		
	is_assembly_info_equal (other: like Current): BOOLEAN is
			-- Is `other' basic assembly information (name, version, culture and public key token)
			-- equal to current instance?
		require
			other_not_void: other /= Void
		do
			Result := name.is_equal (other.name) and then version.is_equal (other.version) and then
						culture.is_equal (other.culture) and then key.is_equal (other.key)
		end
		
	has_same_path (a_path: STRING): BOOLEAN is
			-- does current instance have a path that equals `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_path: STRING
		do
			l_path := a_path.as_lower
			Result := l_path.is_equal (location) or l_path.is_equal (gac_path)
		end

invariant
	non_void_assembly_name: name /= Void
	non_void_assembly_version: version /= Void
	non_void_culture: culture /= Void
	non_void_key: key /= Void
	non_void_location: location /= Void
	non_void_gac_path: gac_path /= Void
	non_void_folder_name: folder_name /= Void
	valid_folder_name: not folder_name.is_empty

end -- class CONSUMED_ASSEMBLY
