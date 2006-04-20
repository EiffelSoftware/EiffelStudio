indexing
	description: "Representation of scope which metrics are calculated over."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_SCOPE

inherit
	EB_METRIC_SCOPE_INFO

create
	default_create,
	make

feature -- Initialization

	make (an_index: INTEGER) is
		require
			correct_index: valid_scope_index (an_index)
		do
			index := an_index
		end

feature -- Access

	name: STRING is
		-- Scope name.
		do
			Result := scope_name (index)
		ensure
			good_result: Result /= Void and then not Result.is_empty
		end

	index: INTEGER
		-- Scope index

	e_feature: E_FEATURE
		-- Feature object metric will be evaluated over when index is `Feature_scope'.

	set_e_feature (ft: E_FEATURE) is
			-- Assign `ft' to `e_feature'.
		do
			e_feature := ft
		end

	class_c: CLASS_C
		-- Class object metric will be evaluated over when index is `Class_scope'.

	set_class_c (cl: CLASS_C) is
			-- Assign `cl' to `class_c'.
		do
			class_c := cl
		end

	cluster_i: CLUSTER_I
		-- Cluster object metric will be evaluated over when index is `Cluster_scope'.

	set_cluster_i (cl: CLUSTER_I) is
			-- Assign `cl' to `cluster_i'.
		do
			cluster_i := cl
		end

	system_i: SYSTEM_I
		-- System object metric will be evaluated over when index is `System_scope'.

	set_system_i (st: SYSTEM_I) is
			-- Assign `st' to `system_i'.
		do
			system_i := st
		end

feature -- Scopes creation

	list_of_scopes: ARRAYED_LIST [EB_METRIC_SCOPE] is
			-- List of scopes available in the metric tool.
		local
			a_feature, a_class, a_cluster, a_system, an_archive: EB_METRIC_SCOPE
		do
			create Result.make (5)
			create a_feature.make (Feature_scope)
			Result.extend (a_feature)
			create a_class.make (Class_scope)
			Result.extend (a_class)
			create a_cluster.make (Cluster_scope)
			Result.extend (a_cluster)
			create a_system.make (System_scope)
			Result.extend (a_system)
			create an_archive.make (Archive_scope)
			Result.extend (an_archive)
		ensure
			good_result: Result /= Void and then Result.count = 5
		end

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

end -- class EB_METRIC_SCOPE
