indexing

	description:
		"General information about the Eiffel system."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class SYSTEM_STATISTICS

inherit
	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	QL_SHARED

create
	make,
	make_compilation_stat

feature {NONE} -- Initialization

	make is
			-- Initialize statistical information.
		require
			project_inititalized: Eiffel_project.initialized
		do
			create processed_targets.make (50)
			number_of_compiled_classes := Eiffel_system.number_of_classes
			number_of_melted_classes := System.degree_minus_1.count
			number_of_compilations := Workbench.compilation_counter - 1
		end

	make_compilation_stat is
			-- Initailize `number_of_compilations'
		do
			number_of_compilations := Workbench.compilation_counter
		end

feature -- Access

	number_of_compiled_classes: INTEGER
			-- Number of compiled classes

	number_of_classes: INTEGER is
			-- Number of classes
		local
			l_domain_generator: QL_GROUP_DOMAIN_GENERATOR
			l_group_domain: QL_GROUP_DOMAIN
		do
			create l_domain_generator
			l_domain_generator.set_criterion (create{QL_GROUP_IS_CLUSTER_CRI})
			l_domain_generator.enable_fill_domain
			l_group_domain ?= system_target_domain.new_domain (l_domain_generator)
			check l_group_domain /= Void end
			number_count := 0
			l_group_domain.do_all (agent count_class (?, False))
			Result := number_count
		end

	count_class (a_group: QL_GROUP; is_recursive: BOOLEAN) is
			-- Count class in `a_group'.
			-- If `is_recursive' is True, recursively count class if `a_group' is a library.
		local
			l_library: CONF_LIBRARY
			l_processed: like processed_targets
			l_group_domain: QL_GROUP_DOMAIN
		do
			if a_group.group.is_library then
				if is_recursive then
					l_library ?= a_group.group
					check l_library /= Void end
					l_processed := processed_targets
					if not l_processed.has (l_library.target) then
						l_group_domain ?= a_group.groups_in_target
						from
							l_group_domain.start
						until
							l_group_domain.after
						loop
							count_class (l_group_domain.item, True)
							l_group_domain.forth
						end
					end
				else
					number_count := number_count + a_group.group.classes.count
				end
			else
				if a_group.group.classes /= Void then
					number_count := number_count + a_group.group.classes.count
				end
			end
		end

	processed_targets: ARRAYED_LIST [CONF_TARGET]
			-- List of processed targets

	number_of_used_classes: INTEGER is
			-- Number of used classes
		local
			l_domain_generator: QL_GROUP_DOMAIN_GENERATOR
			l_group_domain: QL_GROUP_DOMAIN
		do
			create l_domain_generator
			l_domain_generator.enable_fill_domain
			l_group_domain ?= system_target_domain.new_domain (l_domain_generator)
			check l_group_domain /= Void end
			number_count := 0
			processed_targets.wipe_out
			l_group_domain.do_all (agent count_class (?, True))
			Result := number_count
		end

	number_of_clusters: INTEGER is
			-- Number of clusters in the system
		do
			Result := number_of_groups (create{QL_GROUP_IS_CLUSTER_CRI})
		end

	number_of_assemblies: INTEGER is
			-- Number of assemblies
		do
			Result := number_of_groups (create{QL_GROUP_IS_ASSEMBLY_CRI})
		end

	number_of_libraries: INTEGER is
			-- Number of libraries
		do
			Result := number_of_groups (create{QL_GROUP_IS_LIBRARY_CRI})
		end

	number_of_melted_classes: INTEGER
			-- Number of melted classes in the system

	number_of_compilations: INTEGER;
			-- Number of melted classes in the system

feature{NONE} -- Implementation

	count_number (a_group: QL_GROUP) is
			-- Increase `number_count' by 1.
		do
			number_count := number_count + 1
		ensure
			good_result: number_count = old number_count + 1
		end

	number_count: INTEGER
			-- Number of some data being calculated

	number_of_groups (a_criterion: QL_GROUP_CRITERION): INTEGER is
			-- Number of groups which satisfy `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		local
			l_domain_generator: QL_GROUP_DOMAIN_GENERATOR
			l_group_domain: QL_GROUP_DOMAIN
		do
			create l_domain_generator
			l_domain_generator.set_criterion (a_criterion)
			number_count := 0
			l_domain_generator.actions.extend (agent count_number)
			l_group_domain ?= system_target_domain.new_domain (l_domain_generator)
			Result := number_count
		end

invariant
	processed_targets_attached: processed_targets /= Void

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

end -- class SYSTEM_STATISTICS
