indexing
	description: "Basic structure to hold info about an assembly."
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

invariant
	assembly_name_not_void: assembly_name /= Void

end -- class ASSEMBLY_INFO
