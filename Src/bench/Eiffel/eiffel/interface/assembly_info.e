indexing
	description: "Basic structure to hold info about an assembly."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_INFO

create
	make

feature {NONE} -- Initialization

	make (n: like assembly_name) is
			-- Initialize current with `n'
		require
			n_not_void: n /= Void
			n_not_empty: not n.is_empty
		do
			assembly_name := n
		ensure
			assembly_name_set: assembly_name = n
		end

feature -- Access

	assembly_name: STRING
			-- Assembly name or file location of assembly if local assembly.

	version, culture, public_key_token: STRING
			-- Specification of current assembly.

feature -- Settings

	set_version (a_version: like version) is
			-- Set `version' with `a_version'.
		require
			a_version_not_void: a_version /= Void
			a_version_not_empty: not a_version.is_empty
		do
			version := a_version
		ensure
			version_set: version = a_version
		end

	set_culture (a_culture: like culture) is
			-- Set `culture' with `a_culture'.
		require
			a_culture_not_void: a_culture /= Void
			a_culture_not_empty: not a_culture.is_empty
		do
			culture := a_culture
		ensure
			culture_set: culture = a_culture
		end

	set_public_key_token (a_public_key_token: like public_key_token) is
			-- Set `public_key_token' with `a_public_key_token'.
		require
			a_public_key_token_not_void: a_public_key_token /= Void
			a_public_key_token_not_empty: not a_public_key_token.is_empty
		do
			public_key_token := a_public_key_token
		ensure
			public_key_token_set: public_key_token = a_public_key_token
		end

feature -- Output

	format (a_text_formatter: TEXT_FORMATTER) is
			-- Output name of Current in `a_text_formatter'.
		require
			st_not_void: a_text_formatter /= Void
		do
			a_text_formatter.add_string (assembly_name)
			if version /= Void then
				a_text_formatter.add_string (", ")
				a_text_formatter.add_string (version)
			end
			if culture /= Void then
				a_text_formatter.add_string (", ")
				a_text_formatter.add_string (culture)
			end
			if public_key_token /= Void then
				a_text_formatter.add_string (", ")
				a_text_formatter.add_string (public_key_token)
			end
		end

	full_name: STRING is
			-- Output name of Current
		do
			create Result.make (64)
			Result.append (assembly_name)
			if version /= Void then
				Result.append (", Version=")
				Result.append (version)
			end
			if culture /= Void then
				Result.append (", Culture=")
				Result.append (culture)
			else
				Result.append (", Culture=neutral")
			end
			if public_key_token /= Void then
				Result.append (", PublicKeyToken=")
				Result.append (public_key_token)
			end
		ensure
			full_name_not_void: Result /= Void
		end

invariant
	assembly_name_not_void: assembly_name /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class ASSEMBLY_INFO
