indexing
	description: "Description of a cluster in the system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_DESCRIPTOR

inherit
	IEIFFEL_CLUSTER_DESCRIPTOR_IMPL_STUB
		redefine
			name,
			description,
			tool_tip,
			classes,
			class_count,
			clusters,
			cluster_count,
			cluster_path,
			relative_path,
			is_override_cluster,
			is_library,
			parent
		end
		
create
	make_with_cluster_i
	
feature {NONE} -- Initialization

	make_with_cluster_i (a_cluster: CLUSTER_I) is
			-- Initialize with `a_cluster'.
		require
			a_cluster_exists: a_cluster /= Void
		do
			compiler_cluster := a_cluster
		end
		
feature -- Access

	name: STRING is
			-- Cluster name.
		local
			ass_i: ASSEMBLY_I
		do
			ass_i ?= compiler_cluster
			if ass_i /= Void then
				Result := ass_i.assembly_name
			else
				Result := compiler_cluster.cluster_name
			end
		ensure then
			result_exists: Result /= Void
		end

	description: STRING is
			-- Cluster description.
		local
			indexes: EIFFEL_LIST [INDEX_AS]
			i: INDEX_AS
			found: BOOLEAN
			tag: STRING
			list: EIFFEL_LIST [ATOMIC_AS]
			s: STRING_AS
		do
			create Result.make (50)
			indexes := compiler_cluster.indexes
			if indexes /= Void then
				from
					indexes.start
				until
					indexes.after or 
					found
				loop
					tag := indexes.item.tag
					if tag.is_equal ("description") then
						found := True
						i := indexes.item
					end
					indexes.forth
				end
				if i /= Void then
					list := i.index_list
					from
						list.start
					until
						list.after
					loop
						s ?= list.item
						if s /= Void then
							Result.append (s.value)
						end
						list.forth
						if not list.after and s /= Void then
							Result.append (", ")
						end
					end				
				end			
			end
		ensure then
			result_exists: Result /= Void
		end

	tool_tip: STRING is
			-- Cluster Tool Tip.
		do
			create Result.make (0)
		end

	classes: CLASS_ENUMERATOR is
			-- List of classes in cluster.
		local
			res: ARRAYED_LIST [IEIFFEL_CLASS_DESCRIPTOR_INTERFACE]
			l: HASH_TABLE [CLASS_I, STRING]
			class_desc: CLASS_DESCRIPTOR
		do
			l := compiler_cluster.classes
			create res.make (l.count)
			from
				l.start
			until
				l.after
			loop
				create class_desc.make_with_class_i (l.item_for_iteration)
				res.extend (class_desc)
				l.forth
			end
			create Result.make (res)
		ensure then
			result_exists: Result /= Void
		end

	class_count: INTEGER is
			-- Number of classes in cluster.
		do
			Result := compiler_cluster.classes.count
		end

	clusters: CLUSTER_ENUMERATOR is
			-- List of subclusters in cluster.
		local
			res: ARRAYED_LIST [IEIFFEL_CLUSTER_DESCRIPTOR_INTERFACE]
			cluster_desc: CLUSTER_DESCRIPTOR
			l: ARRAYED_LIST [CLUSTER_I]
		do
			l := compiler_cluster.sub_clusters
			create res.make (l.count)
			from
				l.start
			until
				l.after
			loop
				create cluster_desc.make_with_cluster_i (l.item)
				res.extend (cluster_desc)
				l.forth
			end
			create Result.make (res)
		ensure then
			result_exists: Result /= Void
		end

	cluster_count: INTEGER is
			-- Number of subclusters in cluster.
		do
			Result := compiler_cluster.sub_clusters.count
		end

	cluster_path: STRING is
			-- Full path to cluster.
		do
			Result := compiler_cluster.path
		ensure then
			result_exists: Result /= Void
		end

	relative_path: STRING is
			-- Relative path to cluster.
		do
			Result := compiler_cluster.dollar_path
		ensure then
			result_exists: Result /= Void
		end

	is_override_cluster: BOOLEAN is
			-- Should this cluster classes take priority over other classes with same name?
		do
			Result := compiler_cluster.is_override_cluster
		end

	is_library: BOOLEAN is
			-- Should this cluster be treated as library?
		do
			Result := compiler_cluster.is_library
		end
		
	parent: like current is
			-- Parent cluster
		do
			if compiler_cluster.parent_cluster /= Void then
				create Result.make_with_cluster_i (compiler_cluster.parent_cluster)
			end
		end
		
		
	is_external_cluster: BOOLEAN is
			-- Is this cluster used for external classes?
		local
			ass_i: ASSEMBLY_I
		do
			ass_i ?= compiler_cluster
			Result := ass_i /= Void
		end
	
feature {NONE} -- Implementation

	compiler_cluster: CLUSTER_I;
			-- Associated compiler structure.
	
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
end -- class CLUSTER_DESCRIPTOR
