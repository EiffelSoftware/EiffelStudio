indexing
	description: "Abstract representation of an assembly reference in AST for Lace."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_SD

inherit
	AST_LACE

create
	initialize

feature {NONE} -- Initialization

	initialize (a_cluster_name, a_assembly_name, a_prefix, a_version, a_culture, a_public_key_token: ID_SD) is
			-- New Instance of an assembly reference.
		require
			cluster_name_not_void: a_cluster_name /= Void
			assembly_name_not_void: a_assembly_name /= Void
		do
			cluster_name := a_cluster_name
			assembly_name := a_assembly_name
			version := a_version
			culture := a_culture
			public_key_token := a_public_key_token
			prefix_name := a_prefix
		ensure
			cluster_name_set: cluster_name = a_cluster_name
			assembly_name_set: assembly_name = a_assembly_name
			prefix_name_set: prefix_name = a_prefix
			version_set: version = a_version
			culture_set: culture = a_culture
			public_key_token_set: public_key_token = a_public_key_token
		end

feature -- Access

	cluster_name: ID_SD
			-- Cluster name of assembly in Ace file.

	assembly_name: ID_SD
			-- Assembly name or file location of assembly if local assembly.

	prefix_name: ID_SD
			-- Prefix added to all Eiffel class names in current assembly.

	version, culture, public_key_token: ID_SD
			-- Specification of current assembly.

invariant
	cluster_name_not_void: cluster_name /= Void
	assembly_name_not_void: assembly_name /= Void

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

end -- class ASSEMBLY_SD
