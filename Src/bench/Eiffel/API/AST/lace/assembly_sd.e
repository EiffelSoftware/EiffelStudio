indexing
	description: "Abstract representation of an assembly reference in AST for Lace."
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
			
feature -- Equality

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
			st.putchar (':')
			st.putchar ('%T')
			assembly_name.save (st)
			if version /= Void then
				st.putchar (',')
				version.save (st)		
			end
			if culture /= Void then
				st.putchar (',')
				culture.save (st)
			end
			if public_key_token /= Void then
				st.putchar (',')
				public_key_token.save (st)
			end
			st.new_line
			if prefix_name /= Void then
				st.indent
				st.putstring ("prefix")
				st.new_line
				st.indent
				prefix_name.save (st)
				st.exdent
				st.new_line
				st.putstring ("end")
				st.exdent
				st.new_line
			end
		end

invariant
	cluster_name_not_void: cluster_name /= Void
	assembly_name_not_void: assembly_name /= Void

end -- class ASSEMBLY_SD
