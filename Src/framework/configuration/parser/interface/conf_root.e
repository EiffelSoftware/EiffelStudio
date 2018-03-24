note
	description: "The root feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ROOT

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_cluster, a_class_type, a_feature: detachable STRING_32; a_all_root: BOOLEAN)
			-- Create with `a_cluster', `a_class' and `a_feature'.
			-- `a_all_root' indicates that all classes are considered to be root.
		require
			a_cluster_ok: a_cluster /= Void implies not a_cluster.is_empty
			a_class_ok: not a_all_root implies a_class_type /= Void and then not a_class_type.is_empty
			a_feature_ok: a_feature /= Void implies not a_feature.is_empty
		do
			is_all_root := a_all_root
			if a_all_root then
				class_type_name := {STRING_32} "ANY"
			else
				if a_cluster /= Void then
					cluster_name := a_cluster.as_lower
				end
				if a_feature /= Void then
					feature_name := a_feature.as_lower
				end
				if a_class_type /= Void then
						-- Implied by precondition `a_class_ok' and condition `not a_all_root'
					class_type_name := a_class_type.as_upper
				else
					check precondition__a_class_ok: False end
					class_type_name := {STRING_32} "ANY"
				end
			end
		ensure
			cluster_set: not a_all_root implies (a_cluster = Void and cluster_name = Void) or
				(a_cluster /= Void and then attached cluster_name as l_cluster_name and then
					l_cluster_name.same_string (a_cluster.as_lower))
			class_type_name_not_void: class_type_name /= Void
			class_set: not a_all_root implies (a_class_type /= Void and then class_type_name.same_string (a_class_type.as_upper))
			class_set: a_all_root implies class_type_name.same_string ({STRING_32} "ANY")
			feature_set: not a_all_root implies (a_feature = Void and feature_name = Void) or
				(a_feature /= Void and then attached feature_name as l_feature_name and then
					l_feature_name.same_string (a_feature.as_lower))
			feature_set: a_all_root implies feature_name = Void
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is it the same file_rule as `other'?
		do
			Result := equal (cluster_name, other.cluster_name) and
				equal (class_type_name, other.class_type_name) and
				equal (feature_name, other.feature_name) and
				is_all_root = other.is_all_root
		end

feature -- Output

	text: STRING_32
			-- New string with printable representation.
		do
			if is_all_root then
				Result := {STRING_32} "All classes"
			else
				create Result.make_empty
				if attached cluster_name as l_cluster_name then
					Result.append (l_cluster_name)
					Result.append_character ('.')
				end
				Result.append (class_type_name)
				if attached feature_name as l_feature_name then
					Result.append_character ('.')
					Result.append (l_feature_name)
				end
			end
		end

feature -- Access, stored in configuration file

	cluster_name: detachable STRING_32
			-- The name of the root cluster.

	class_type_name: STRING_32
			-- The name of the root type.

	feature_name: detachable STRING_32
			-- The name of the root feature.

	is_all_root: BOOLEAN
			-- Are all classes considered to be root classes?

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_cluster_name (a_name: like cluster_name)
			-- Set `cluster_name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_lower: a_name.is_equal (a_name.as_lower)
		do
			cluster_name := a_name
		ensure
			name_set: cluster_name = a_name
		end

	set_class_type_name (a_name: like class_type_name)
			-- Set `class_type_name' to `a_name'.
		require
			a_name_ok: a_name /= Void and then not a_name.is_empty
			a_name_upper: a_name.is_equal (a_name.as_upper)
		do
			class_type_name := a_name
		ensure
			name_set: class_type_name = a_name
		end

	set_feature_name (a_name: like feature_name)
			-- Set `feature_name' to `a_name'.
		require
			a_name_ok: a_name /= Void implies not a_name.is_empty
			a_name_lower: a_name /= Void implies a_name.is_equal (a_name.as_lower)
		do
			feature_name := a_name
		ensure
			name_set: feature_name = a_name
		end

invariant
	cluster_name_ok: attached cluster_name as inv_cluster_name implies not inv_cluster_name.is_empty
	cluster_name_lower: attached cluster_name as inv_cluster_name implies inv_cluster_name.same_string (inv_cluster_name.as_lower)
	class_type_name_ok: attached class_type_name as inv_class_type_name and then not inv_class_type_name.is_empty
	class_type_name_upper: inv_class_type_name.same_string (inv_class_type_name.as_upper)
	feature_name_ok: attached feature_name as inv_feature_name implies not inv_feature_name.is_empty
	feature_name_lower: attached feature_name as inv_feature_name implies inv_feature_name.same_string (inv_feature_name.as_lower)

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
