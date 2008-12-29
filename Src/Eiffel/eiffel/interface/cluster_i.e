note
	description: "Internal representation of a cluster"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_I

inherit
	CONF_CLUSTER
		rename
			name as cluster_name,
			parent as parent_cluster,
			children as sub_clusters
		redefine
			parent_cluster,
			sub_clusters
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		undefine
			is_equal
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		undefine
			is_equal
		end

create {CONF_COMP_FACTORY}
	make

feature -- Attributes

	parent_cluster: CLUSTER_I
			-- Parent cluster of Current cluster
			-- (Void implies it is a top level cluster)

	sub_clusters: ARRAYED_LIST [CLUSTER_I]
			-- List of sub clusters for Current cluster

feature -- Access

	name_in_upper: STRING
			-- Cluster name in upper case
		do
			Result := cluster_name.as_upper
		end

	actual_namespace: STRING
			-- Associated full namespace of current cluster.
		local
			l_local_namespace: STRING
		do

			if is_precompile then
				Result := internal_actual_namespace
			else

				if parent_cluster /= Void then
						-- Start with parent cluster namespace
					Result := parent_cluster.actual_namespace
				else
						-- Use target namespace
					Result := target.options.local_namespace
				end

				if Result = Void then
					create Result.make_empty
				else
					Result := Result.twin
				end

					-- Add cluster name/namespace part
				l_local_namespace := options.local_namespace
				if l_local_namespace = Void or else l_local_namespace.is_empty then
					if target.setting_use_cluster_name_as_namespace then
						if not Result.is_empty then
							Result.append_character ('.')
						end
						Result.append (cluster_name)
					end
				else
					if not Result.is_empty then
						Result.append_character ('.')
					end
					Result.append (l_local_namespace)
				end

				internal_actual_namespace := Result
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Type anchors

	class_anchor: CLASS_I;
			-- Type of classes one can insert in Current

feature {NONE} -- Internal implementation cache

	internal_actual_namespace: like actual_namespace
			-- Cached version of `actual_namespace'

;note
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

end
