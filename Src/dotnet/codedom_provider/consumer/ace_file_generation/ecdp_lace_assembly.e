indexing
	description: "Lace assembly definition"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_LACE_ASSEMBLY

create
	make

feature {NONE} -- Initialization

	make (sn, n, v, c, k, p: STRING) is
			-- Set `short_name' with `sn'.
			-- Set `name' with `n'.
			-- Set `version' with `v'.
			-- Set `culture' with `c'.
			-- Set `key' with `k'.
			-- Set `prefix' with `p'.			
		require
			non_void_sn: sn /= Void
			valid_sn: not sn.is_empty
			non_void_name: n /= Void
			valid_name: not n.is_empty
			non_void_version: v /= Void
			valid_version: not v.is_empty
			non_void_culture: c /= Void
			valid_culture: not c.is_empty
			valid_key: k /= Void implies not k.is_empty
			non_void_prefix: p /= Void
		do
			short_name := sn
			name := n
			version := v
			culture := c
			key := k
			assembly_prefix := p
		ensure
			short_name_set: short_name = sn
			name_set: name = n
			version_set: version = v
			culture_set: culture = c
			key_set: key = k
			non_void_prefix: assembly_prefix /= Void
		end

feature -- Access

	short_name: STRING
			-- short name that designs assembly.

	name: STRING
			-- Assembly path (local) or fullname (in GAC)
	
	version: STRING
			-- Assembly version number
	
	culture: STRING
			-- Assembly culture
	
	key: STRING
			-- Assembly public key token
	
	assembly_prefix: STRING
			-- Assembly prefix.


invariant
	non_void_short_name: short_name /= Void
	non_void_assembly_name: name /= Void
	non_void_assembly_version: version /= Void
	non_void_assembly_culture: culture /= Void
	non_void_assembly_prefix: assembly_prefix /= Void

end -- class ECDP_LACE_ASSEMBLY

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------