note
	description: "Representation of a public key"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_PUBLIC_KEY

inherit

	REFACTORING_HELPER
		export {NONE} all end


create
	make_from_file

feature {NONE} -- Initialization

	make_from_file (a_file_name: PATH; a_signing: MD_STRONG_NAME)
			-- Create a public key from private key stored in `a_file_name'.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			a_signing_not_void: a_signing /= Void
--			a_signing_exists: a_signing.exists
		do
				-- Read key pair data from `a_file_name'
			key_pair := read_key_pair_from_file (a_file_name)

			to_implement ("TODO implement CIL_STRONG_NAME is still a mock class.")

--				-- Read public key from `l_orig_key' key pair.
--			if is_valid and then attached a_signing.public_key (key_pair) as k then
--				item := k
--					-- Get public key token.
--				public_key_token := a_signing.public_key_token (k)
--			else
--					-- Indicate that the key is invalid.
--				is_valid := False
--					-- Dummy empty key.
--				create item.make (0)
--			end
			-- Dummy empty key.
			create item.make (0)

		end

feature -- Access

	item: MANAGED_POINTER
			-- Store public key data.

	key_pair: MANAGED_POINTER
			-- Key pair that generated Current.

	public_key_token: detachable MANAGED_POINTER
			-- Public key token of Current.

	is_valid: BOOLEAN
			-- Did an error occurred in `read_key_pair_from_file'?

	public_key_token_string: STRING_32
			-- String representation of `public_key_token'.
		require
			key_is_valid: is_valid
			public_key_token_not_void: attached public_key_token as pub_key_token
			public_key_token_not_empty: pub_key_token.count > 0
		local
			i, nb: INTEGER
		do
			check attached public_key_token as l_public_key_token then
				from
					i := 0
					nb := l_public_key_token.count - 1
					create Result.make (2 * (nb + 1))
				until
					i > nb
				loop
					Result.append_string_general (l_public_key_token.read_integer_8 (i).to_hex_string)
					i := i + 1
				end
				Result.to_lower
			end
		end

feature {NONE} -- Implementation

	read_key_pair_from_file (a_file_name: PATH): MANAGED_POINTER
			-- Read key pair from file `a_file_name'.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		local
			l_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
					-- Read key pair data from `a_file_name'.
				create l_file.make_with_path (a_file_name)
				l_file.open_read
				create Result.make (l_file.count)
				l_file.read_to_managed_pointer (Result, 0, Result.count)
				l_file.close

					-- Reset error condition.
				is_valid := True
			else
					-- We could not read key pair.
				is_valid := False

					-- TODO: Manu 05/21/2002: we need to generate an error.
				check
					is_implemented: False
				end
				create Result.make (0)
			end
		rescue
			retried := True
			retry
		end

invariant
	item_not_void: item /= Void
	key_pair_not_void: key_pair /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

