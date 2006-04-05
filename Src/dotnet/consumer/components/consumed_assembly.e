indexing
	description: "Assembly description to be persisted in XML"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			location := format_path (loc)
			gac_path := format_path (gp)
			unique_id := id
			is_in_gac := a_in_gac
			
			folder_name := fn
		ensure
			name_set: name = n
			folder_name_set: folder_name = fn
			version_set: version = v
			culture_set: culture = c
			key_set: key = k
			location_set: format_path (loc).is_equal (location)
			gac_path_set: format_path (gp).is_equal (gac_path)
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
		
	set_version (a_ver: like version) is
			-- Sets `version' with `a_ver'
		require
			a_ver_not_void: a_ver /= Void
			not_a_Ver_is_empty: not a_ver.is_empty
		do
			version := a_ver
		ensure
			version_set: version = a_ver
		end
		
	set_culture (a_culture: like culture) is
			-- Sets `culture' with `a_culture'
		require
			a_culture_not_void: a_culture /= Void
			not_a_culture_is_empty: not a_culture.is_empty
		do
			culture := a_culture
		ensure
			culture_set: culture = a_culture
		end
		
	set_key (a_key: like key) is
			-- Sets `key' with `a_key'
		require
			a_key_not_void: a_key /= Void
		do
			key := a_key
		ensure
			key_set: key = a_key
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
			l_path := format_path (a_path)
			Result := l_path.is_equal (location) or l_path.is_equal (gac_path)
		end
		
	has_same_ready_formatted_path (a_path: STRING): BOOLEAN is
			-- does current instance have a path that equals `a_path'.
			-- This is an optimized version of `has_same_path' that assumes `a_path' has already
			-- been converted to lower case
		require
			not_a_path_is_empty: a_path /= Void
			a_path_not_void: not a_path.is_empty
			a_path_is_formatted: a_path.is_equal (format_path (a_path))
		do
			Result := a_path.is_equal (location) or a_path.is_equal (gac_path)
		end
		
feature -- Formatting

	format_path (a_path: STRING): STRING is
			-- Formats `a_path' to produce a comparable path.
		require
			a_path_not_void: a_path /= Void
			not_path_is_empty: not a_path.is_empty
		local
			l_unc_path: BOOLEAN
		do
			l_unc_path := a_path.count > 2 and then a_path.substring (1, 2).is_equal ("\\")
			Result := a_path.as_lower
			Result.replace_substring_all ("\\", "\")
			if l_unc_path then
				Result.prepend_character ('\')	
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_still_unc_path: a_path.count > 2 implies (a_path.substring (1, 2).is_equal ("\\") implies Result.substring (1, 2).is_equal ("\\"))
		end		

invariant
	non_void_assembly_name: name /= Void
	not_name_is_empty: not name.is_empty
	non_void_assembly_version: version /= Void
	not_version_is_empty: not version.is_empty
	non_void_culture: culture /= Void
	non_void_key: key /= Void
	non_void_location: location /= Void
	not_location_is_empty: not location.is_empty
	non_void_gac_path: gac_path /= Void
	not_gac_path_is_empty: not gac_path.is_empty
	non_void_folder_name: folder_name /= Void
	valid_folder_name: not folder_name.is_empty

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CONSUMED_ASSEMBLY