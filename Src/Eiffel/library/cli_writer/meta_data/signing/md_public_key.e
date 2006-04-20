indexing
	description: "Representation of a public key"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_PUBLIC_KEY

create
	make_from_file

feature {NONE} -- Initialization

	make_from_file (a_file_name: STRING; a_signing: MD_STRONG_NAME) is
			-- Create a public key from private key stored in `a_file_name'.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			a_signing_not_void: a_signing /= Void
			a_signing_exists: a_signing.exists
		do
				-- Read key pair data from `a_file_name'
			key_pair := read_key_pair_from_file (a_file_name)

			if is_valid then
					-- Read public key from `l_orig_key' key pair.
				item := a_signing.public_key (key_pair)

					-- Get public key token.
				public_key_token := a_signing.public_key_token (item)
			else
					-- Dummy empty key.
				create item.make (0)
			end
		end

feature -- Access

	item: MANAGED_POINTER
			-- Store public key data.

	key_pair: MANAGED_POINTER
			-- Key pair that generated Current.

	public_key_token: MANAGED_POINTER
			-- Public key token of Current.

	is_valid: BOOLEAN
			-- Did an error occurred in `read_key_pair_from_file'?

	public_key_token_string: STRING is
			-- String representation of `public_key_token'.
		require
			key_is_valid: is_valid
			public_key_token_not_void: public_key_token /= Void
			public_key_token_not_empty: public_key_token.count > 0
		local
			i, nb: INTEGER
		do
			from
				i := 0
				nb := public_key_token.count - 1
				create Result.make (2 * (nb + 1))
			until
				i > nb
			loop
				Result.append (public_key_token.read_integer_8 (i).to_hex_string)
				i := i + 1
			end
			Result.to_lower
		end

feature {NONE} -- Implementation

	read_key_pair_from_file (a_file_name: STRING): MANAGED_POINTER is
			-- Read key pair from file `a_file_name'.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		local
			l_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
					-- Reset error condition
				is_valid := True

					-- Read key pair data from `a_file_name'.
				create l_file.make_open_read (a_file_name)
				create Result.make (l_file.count)
				l_file.read_data (Result.item, Result.count)
				l_file.close
			else
					-- We could not read key pair.
				is_valid := False

					--| FIXME: Manu 05/21/2002: we need to generate an error.
				check
					not_yet_implemented: False
				end
			end
		rescue
			retried := True
			retry
		end

invariant
	item_not_void: item /= Void
	key_pair_not_void: key_pair /= Void

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

end -- class MD_PUBLIC_KEY
