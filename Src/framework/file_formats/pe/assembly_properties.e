indexing
	description: "[
		Holds all basic inforamation on an assembly.
	]"
	date:        "$Date$"
	revision:    "$Revision$"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	ASSEMBLY_PROPERTIES

create
	make

feature {NONE} -- Initialization

	make (a_location: like location; a_name: like name; a_hash: like hash_algorithim; a_key: like public_key_token; a_flags: like flags; a_metadata: ASSEMBLY_METADATA) is
			-- Initialize assembly properties.
		require
			a_location_attached: a_location /= Void
			not_a_locatione_is_empty: not a_location.is_empty
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_hash_positive: a_hash > 0
			not_a_key_is_empty: a_key /= Void implies not a_key.is_empty
			a_metadata_attached: a_metadata /= Void
		do
			location := a_location
			name := a_name
			hash_algorithim := a_hash
			public_key_token := a_key
			flags := a_flags
			major_version := a_metadata.major_version
			minor_version := a_metadata.minor_version
			build_number := a_metadata.build_number
			revision_number := a_metadata.revision_number
			locales := a_metadata.locales
		ensure
			location_set: location = a_location
			name_set: name = a_name
			hash_algorithim_set: hash_algorithim = a_hash
			public_key_token_set: public_key_token = a_key
			flags_set: flags = a_flags
		end

feature -- Access

	location: STRING
			-- Location of assembly that properties were retrieved from.

	name: STRING
			-- Assembly name

	hash_algorithim: NATURAL_64
			-- Algorthim used for assembly hash

	public_key_token: ARRAY [NATURAL_8]
			-- Public key token, Void for unsigned assemblies

	flags: NATURAL_64
			-- Assembly flags

	major_version: NATURAL_16
			-- The major version number of the referenced assembly

	minor_version: NATURAL_16
			-- The minor version number of the referenced assembly

	build_number: NATURAL_16
			-- The build number of the referenced assembly.

	revision_number: NATURAL_16
			-- The revision number of the referenced assembly

	locales: LIST [STRING]
			-- A list of locale names conforming to the RFC1766 specification specifying the locales.

feature -- Status report

	is_signed: BOOLEAN is
			-- Indicates if assembly is signed, i.e. has a public key token.
		do
			Result := public_key_token /= Void and then not public_key_token.is_empty
		end

	is_neutral_locale: BOOLEAN is
			-- Indicates if assembly is of a language-neutral locale
		do
			Result := locales = Void or else locales.is_empty
		end

feature -- Query

	public_key_token_string: STRING is
			-- Retrieves string representation of `public_key_token'
		do
			if is_signed then
				Result := encoded_key (public_key_token)
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	version_string: STRING is
			-- Retrieve a string representation of `major_version',  `minor_version',
			-- `build_number' and `revision_number'
		do
			Result := major_version.out + "." + minor_version.out + "." +
				build_number.out + "." + revision_number.out
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Implementation

	encoded_key (a_key: ARRAY [NATURAL_8]): STRING is
			-- Printable representation of `a_key'
		require
			a_key_attached: a_key /= Void
			not_a_key_is_empty: not a_key.is_empty
		local
			l_count: INTEGER
			i: INTEGER
		do
			l_count := a_key.count
			create Result.make (l_count * 2)
			from i := 1 until i > l_count loop
				Result.append ((a_key[i]).to_hex_string)
				i := i + 1
			end
			Result.to_lower
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

invariant
	location_attached: location /= Void
	not_location_is_empty: not location.is_empty
	name_attached: name /= Void
	not_name_is_empty: not name.is_empty
	hash_algorithim_positive: hash_algorithim > 0
	not_public_key_token_is_empty: public_key_token /= Void implies not public_key_token.is_empty
	not_locales_is_empty: locales /= Void implies not locales.is_empty


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

end -- class {ASSEMBLY_PROPERTIES}
