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
		redefine
			is_equal
		end
	
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
			
feature -- Equality

	is_equal (other: like Current): BOOLEAN is
			-- Are `other' and `Current' identical?
		do
			Result := same_as (other)
		end

	same_as (other: like Current): BOOLEAN is
			-- Are `other' and `Current' identical?
		do
			Result := other /= Void and then cluster_name.same_as (other.cluster_name)
				and then assembly_name.same_as (other.assembly_name)
				and then same_ast (prefix_name, other.prefix_name)
				and then same_ast (version, other.version)
				and then same_ast (culture, other.culture)
				and then same_ast (public_key_token, other.public_key_token)
		end
		
feature -- Duplication

	duplicate: like Current is
			-- Duplicate current object.
		do
			create Result.initialize (cluster_name.duplicate,
				assembly_name.duplicate, duplicate_ast (prefix_name),
				duplicate_ast (version), duplicate_ast (culture),
				duplicate_ast (public_key_token))
		end
		
feature -- Saving

	save (st: GENERATION_BUFFER) is
			-- Saving in `st'.
		do
			cluster_name.save (st)
			st.put_character (':')
			st.put_character ('%T')
			assembly_name.save (st)
			if version /= Void then
				st.put_character (',')
				version.save (st)		
			end
			if culture /= Void then
				st.put_character (',')
				culture.save (st)
			end
			if public_key_token /= Void then
				st.put_character (',')
				public_key_token.save (st)
			end
			st.put_new_line
			if prefix_name /= Void then
				st.indent
				st.put_string ("prefix")
				st.put_new_line
				st.indent
				prefix_name.save (st)
				st.exdent
				st.put_new_line
				st.put_string ("end")
				st.exdent
				st.put_new_line
			end
		end
		
feature -- Setting

	set_prefix_name (name: like prefix_name) is
			-- Assign `name' to `prefix_name'.
		do
			prefix_name := name
		end
		
invariant
	cluster_name_not_void: cluster_name /= Void
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

end -- class ASSEMBLY_SD
