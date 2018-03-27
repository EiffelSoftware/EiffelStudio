note
	description: "Assembly description to be persisted in XML"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ASSEMBLY

inherit
	SHARED_CONSUMER_UTILITIES
		redefine
			is_equal,
			out
		end

create
	make

feature {NONE} -- Initialization

	make (id, fn, n, v, c, k: READABLE_STRING_32; loc, gp: PATH; a_in_gac: BOOLEAN)
			-- Set `unique_id' with `id'
			-- Set `folder_name' with 'fn'
			-- Set `name' with `n'.
			-- Set `version' with `v'.
			-- Set `culture' with `c'.
			-- Set `key' with `k'.
			-- Set `location' with `loc'
			-- Set `gac_path' with `gp'
			-- Set `is_in_gac' with `a_in_gac'
			-- set `has_info_only' with `a_info_only'
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
			location := loc.canonical_path
			gac_path := gp.canonical_path
			unique_id := id
			is_in_gac := a_in_gac
			has_info_only := True

			folder_name := fn
		ensure
			name_set: name = n
			folder_name_set: folder_name = fn
			version_set: version = v
			culture_set: culture = c
			key_set: key = k
			location_set: loc.canonical_path.same_as (location)
			gac_path_set: gp.canonical_path.same_as (gac_path)
			unique_id_set: unique_id = id
			is_in_gac_set: is_in_gac = a_in_gac
			has_info_only: has_info_only
			not_is_consumed: not is_consumed
		end

feature -- Access

	unique_id: READABLE_STRING_32
			-- Unique id for consumed assembly

	folder_name: READABLE_STRING_32
			-- name of folder where consumed assembly metadata is stored

	name: READABLE_STRING_32
			-- Assembly path (local) or fullname (in GAC)

	version: READABLE_STRING_32
			-- Assembly version number

	culture: READABLE_STRING_32
			-- Assembly culture

	key: READABLE_STRING_32
			-- Assembly public key token

	location: PATH
			-- Assembly location (path loaded from)

	gac_path: PATH
			-- Assembly code base (path of loaded assembly)

	is_consumed: BOOLEAN
			-- Indicates if assembly has actually been consumed.

	is_in_gac: BOOLEAN
			-- Indicates if assembly was consumed from GAC.

	has_info_only: BOOLEAN
			-- Indicates if only assembly info has been consumed (no types)

	text: STRING_32
			-- New string containing terse printable representation
			-- of current object
			-- Eg: "A, Version=1.0.3300.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
		do
			create Result.make (name.count + location.name.count + 11)
			Result.append_string (name)
			Result.append_string_general (", Version=")
			Result.append_string (version)
			Result.append_string_general (", Culture=")
			Result.append_string (culture)
			Result.append_string_general (", PublicKeyToken=")
			Result.append_string (key)
			Result.append_string_general (", CodeBase=")
			Result.append_string (location.name)
		end

	out: STRING
			-- New string containing terse printable representation
			-- of current object
			-- Eg: "A, Version=1.0.3300.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
		local
			u: UTF_CONVERTER
		do
			Result := u.string_32_to_utf_8_string_8 (text)
		end

feature -- Status Setting

	set_is_consumed (a_consumed: BOOLEAN; a_only_info: BOOLEAN)
			-- Sets `is_consumed' to `a_consumed'
		do
			is_consumed := a_consumed
			if a_consumed then
				has_info_only := a_only_info
			else
				has_info_only := True
			end
		ensure
			is_consumed_set: is_consumed = a_consumed
			not_has_info_only: (not a_consumed implies not has_info_only) or a_consumed implies has_info_only = a_only_info
		end

	set_location (a_location: like location)
			-- Set `location' with `a_location'
		require
			non_void_location: a_location /= Void
			valid_location: not a_location.is_empty
		do
			location := a_location
		ensure
			location_set: location = a_location
		end

	set_gac_path (a_gac_path: like gac_path)
			-- Set `gac_path' with `a_gac_path'
		require
			non_void_gac_path: a_gac_path /= Void
			valid_gac_path: not a_gac_path.is_empty
		do
			gac_path := a_gac_path
		ensure
			gac_path_set: gac_path = a_gac_path
		end

	set_is_in_gac (a_in_gac: BOOLEAN)
			-- Sets `is_in_gac' to `a_in_gac'
		do
			is_in_gac := a_in_gac
		ensure
			is_in_gac_set: is_in_gac = a_in_gac
		end

	set_version (a_ver: like version)
			-- Sets `version' with `a_ver'
		require
			a_ver_not_void: a_ver /= Void
			not_a_Ver_is_empty: not a_ver.is_empty
		do
			version := a_ver
		ensure
			version_set: version = a_ver
		end

	set_culture (a_culture: like culture)
			-- Sets `culture' with `a_culture'
		require
			a_culture_not_void: a_culture /= Void
			not_a_culture_is_empty: not a_culture.is_empty
		do
			culture := a_culture
		ensure
			culture_set: culture = a_culture
		end

	set_key (a_key: like key)
			-- Sets `key' with `a_key'
		require
			a_key_not_void: a_key /= Void
		do
			key := a_key
		ensure
			key_set: key = a_key
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := has_same_path (other.gac_path) or else has_same_path (other.location)
		end

	is_assembly_info_equal (other: like Current): BOOLEAN
			-- Is `other' basic assembly information (name, version, culture and public key token)
			-- equal to current instance?
		require
			other_not_void: other /= Void
		do
			Result := name.is_equal (other.name) and then version.is_equal (other.version) and then
						culture.is_equal (other.culture) and then key.is_equal (other.key)
		end

	has_same_path (a_path: PATH): BOOLEAN
			-- does current instance have a path that equals `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_path: PATH
		do
			l_path := a_path.canonical_path
			Result := l_path.same_as (location) or l_path.same_as (gac_path)
			if not Result then
				Result := l_path.is_same_file_as (location) or else l_path.is_same_file_as (gac_path)
			end
		end

	has_same_gac_information (a_name: like name; a_version: like version; a_culture: like culture; a_key: like key): BOOLEAN
			-- does current instance have same gac information (and it is in the gac)
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_version_ok: a_version /= Void and then not a_version.is_empty
			a_culture_ok: a_culture /= Void
			a_key_ok: a_key /= Void
		do
			if is_in_gac then
				Result := a_name.is_equal (name) and a_version.is_equal (version) and a_key.is_equal (key) and
						(a_culture.is_equal (culture) or
							((a_culture.is_empty or a_culture.is_case_insensitive_equal (neutral_culture)) and
							(culture.is_empty or culture.is_case_insensitive_equal (neutral_culture))))
			end
		end

feature {NONE} -- Constants

	neutral_culture: STRING_32 = "neutral"
			-- Neutral culture name.

invariant
	valid_unique_id: unique_id /= Void and then not unique_id.is_empty
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

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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

end
