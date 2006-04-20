indexing
	description: "Object that represents a single scope in EQL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_SINGLE_SCOPE

inherit
	EQL_SCOPE
		undefine
			is_equal
		end

	EQL_ITERABLE_ITEM

feature -- Iterator

	itr: EQL_SINGLE_SCOPE_ITERATOR [like Current] is
			-- Iterator for Current
		do
			create Result.make (Current)
		end

	distinct_itr: like itr is
			-- Distinct iterator
		do
			Result := itr
		end

feature -- Status reporting

	is_feature_scope: BOOLEAN is
			-- Does current single scope represent a feature scope?
		do
		end

	is_class_scope: BOOLEAN is
			-- Does current single scope represent a class scope?
		do
		end

	is_cluster_scope: BOOLEAN is
			-- Does current single scope represent a cluster scope?
		do
		end

	is_system_scope: BOOLEAN is
			-- Does current single scope represent a system scope?
		do
		end

	is_invariant_scope: BOOLEAN is
			-- Does current single scope represent an invariant?
		do
		end

	is_metric_scope: BOOLEAN is
			-- Does current single scope represent a metric scope?
		do
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
end
