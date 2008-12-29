note
	description: "View points of a class or a group"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_VIEWPOINTS

create
	default_create,
	make_class,
	make_group

feature {NONE} -- Initialization

	make_class (a_class: like conf_class)
			-- Initialization
		require
			a_class_not_void: a_class /= Void
		do
			conf_class := a_class
			conf_group := a_class.group
			calculate_viewpoints
		ensure
			conf_class_not_void: conf_class = a_class
			conf_group_not_void: conf_group = a_class.group
		end

	make_group (a_group: like conf_group)
			-- Initialize with `a_group'.
		require
			a_group_not_void: a_group /= Void
		do
			conf_group := a_group
			calculate_viewpoints
		ensure
			conf_group_not_void: conf_group = a_group
		end

feature -- Access

	conf_class : CONF_CLASS
			-- Config class

	conf_group: CONF_GROUP
			-- Config group

	view_points: LIST [CONF_GROUP]
			-- All viewpoints that are available for `conf_group'

	current_viewpoint: CONF_GROUP
			-- Current viewpoint
		do
			Result := conf_group
		end

feature -- Status report

	has_renamed_view_point: BOOLEAN
			-- Has renamed view point?

feature -- Element change

	set_conf_class (a_class: like conf_class)
			-- Set `conf_class' with `a_class'.
		require
			a_class_not_void: a_class /= Void
		do
			conf_class := a_class
			conf_group := a_class.group
			calculate_viewpoints
		ensure
			conf_class_not_void: conf_class = a_class
			conf_group_not_void: conf_group = a_class.group
		end

	set_conf_group (a_group: like conf_group)
			-- Set `conf_group' with `a_group'
		require
			a_group_not_void: a_group /= Void
		do
			conf_group := a_group
			conf_class := Void
			calculate_viewpoints
		ensure
			conf_class_is_void: conf_class = Void
			conf_group_not_void: conf_group = a_group
		end

feature {NONE} -- Implementation

	calculate_viewpoints
			-- Calculate all viewpoints for `conf_group'
		require
			conf_group_not_void: conf_group /= Void
		local
			l_list: ARRAYED_LIST [CONF_VIRTUAL_GROUP]
			l_phys_as: CONF_PHYSICAL_ASSEMBLY
			l_as: CONF_ASSEMBLY
			l_view_points: ARRAYED_LIST [CONF_GROUP]
		do
			l_list := conf_group.target.system.used_in_libraries
			if l_list /= Void then
				l_view_points := calculate_sorted_viewpoints (l_list)
				if conf_group.is_cluster then
					l_view_points.put_front (conf_group)
				end
			elseif conf_group.classes_set and then conf_group.is_assembly then
				l_as ?= conf_group
				check
					assembly: l_as /= Void
				end
				l_view_points := calculate_sorted_viewpoints (l_as.physical_assembly.assemblies)
			elseif conf_group.is_physical_assembly then
				l_phys_as ?= conf_group
				check
					assembly: l_phys_as /= Void
				end
				l_view_points := calculate_sorted_viewpoints (l_phys_as.assemblies)
			else
				has_renamed_view_point := False
				create l_view_points.make (1)
				l_view_points.put_front (conf_group)
			end
			view_points := l_view_points
		ensure
			view_points_not_void: view_points /= Void
		end

	calculate_sorted_viewpoints (a_list: ARRAYED_LIST [CONF_VIRTUAL_GROUP]): ARRAYED_LIST [CONF_GROUP]
			-- Compute sorted viewpoints for `a_list'.
		local
			l_renamed: BOOLEAN
			l_sorted_list: SORTABLE_ARRAY [CONF_GROUP]
			l_vg: CONF_VIRTUAL_GROUP
		do
			create l_sorted_list.make (1, a_list.count)
			l_sorted_list.compare_objects
			from
				a_list.start
			until
				a_list.after
			loop
				l_vg := a_list.item
				l_sorted_list.put (l_vg, a_list.index)
				if (l_vg.name_prefix /= Void and then not l_vg.name_prefix.is_empty) or
				(conf_class /= Void and then l_vg.renaming /= Void and then l_vg.renaming.has (conf_class.name))
				then
					l_renamed := True
				end
				a_list.forth
            end
			has_renamed_view_point := l_renamed
			l_sorted_list.sort
			create Result.make_from_array (l_sorted_list)
		end

note
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
