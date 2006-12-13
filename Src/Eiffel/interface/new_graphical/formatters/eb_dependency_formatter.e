indexing
	description: "Dependency formatter"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_DEPENDENCY_FORMATTER

inherit
	EB_FORMATTER
		redefine
			internal_recycle
		end

	SHARED_FORMAT_INFO

	EB_DOMAIN_ITEM_UTILITY

	QL_SHARED

	EXCEPTIONS

	QL_UTILITY

feature -- Access

	browser: EB_CLASS_BROWSER_DEPENDENCY_VIEW
			-- Browser in which dependencies are displayed

	widget: EV_WIDGET is
			-- Graphical representation of the information provided.
		do
			if associated_stone = Void or browser = Void then
				Result := empty_widget
			else
				Result := browser.widget
			end
		end

	associated_stone: STONE
			-- Stone associated with current formatter

	final_stone_from_stone (a_stone: STONE): STONE is
			-- Final stone from `a_stone'.
			-- This feature can turn a feature stone into a class stone which cantains associated class of that feature.
		require
			a_stone_attached: a_stone /= Void
			a_stone_valid: is_stone_valid (a_stone)
		local
			l_feature_stone: FEATURE_STONE
		do
			l_feature_stone ?= a_stone
			if l_feature_stone /= Void then
				create {CLASSC_STONE} Result.make (l_feature_stone.e_class)
			else
				Result := a_stone
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Properties

	is_dotnet_formatter: BOOLEAN is True
			-- Is Current able to format .NET class texts?

	is_dotnet_mode: BOOLEAN
			-- Is Current class a .NET class? 		

	line_numbers_allowed: BOOLEAN is False
			-- Does it make sense to show line numbers in Current?	

	has_breakpoints: BOOLEAN is False
		-- Should `Current' display breakpoints?

	is_stone_valid (a_stone: STONE): BOOLEAN is
			-- Is `a_stone' valid for current formatter?
		local
			l_target_stone: TARGET_STONE
			l_group_stone: CLUSTER_STONE
			l_class_stone: CLASSC_STONE
			l_feature_stone: FEATURE_STONE
		do
			if a_stone /= Void then
				l_feature_stone ?= a_stone
				l_class_stone ?= a_stone
				l_group_stone ?= a_stone
				l_target_stone ?= a_stone
				Result := l_feature_stone /= Void or else
						  l_class_stone /= Void or else
						  l_group_stone /= Void or else
						  l_target_stone /= Void
			end
		end

	name_of_stone (a_stone: STONE): STRING_32 is
			-- Name of `a_stone'
		require
			a_stone_attached: a_stone /= Void
			a_stone_valid: is_stone_valid (a_stone)
		local
			l_target_stone: TARGET_STONE
			l_cluster_stone: CLUSTER_STONE
			l_class_stone: CLASSC_STONE
			l_feature_stone: FEATURE_STONE
			l_group: CONF_GROUP
		do
			l_feature_stone ?= a_stone
			l_class_stone ?= a_stone
			l_cluster_stone ?= a_stone
			l_target_stone ?= a_stone
			create Result.make (64)
			if l_feature_stone /= Void then
				Result.append (interface_names.string_general_to_lower (interface_names.s_feature_stone))
				Result.append (l_feature_stone.e_feature.name)
			elseif l_class_stone /= Void then
				Result.append (interface_names.string_general_to_lower (interface_names.s_class_stone))
				Result.append (l_class_stone.class_name)
			elseif l_cluster_stone /= Void then
				if not l_cluster_stone.path.is_empty then
						-- For a folder
					Result.append (interface_names.string_general_to_lower (interface_names.s_folder_stone))
					Result.append (l_cluster_stone.folder_name)
				else
						-- For a group
					l_group := l_cluster_stone.group
					if l_group.is_library then
						Result.append (interface_names.string_general_to_lower (interface_names.s_library_stone))
					elseif l_group.is_cluster then
						Result.append (interface_names.string_general_to_lower (interface_names.s_cluster_stone))
					elseif l_group.is_assembly then
						Result.append (interface_names.string_general_to_lower (interface_names.s_assembly_stone))
					end
					Result.append (l_group.name)
				end
			elseif l_target_stone /= Void then
				Result.append (interface_names.string_general_to_lower (interface_names.s_target_stone))
				Result.append (l_target_stone.target.name)
			end
		ensure
			result_attached: Result /= Void
		end

	element_name: STRING is
			-- name of associated element in current formatter.
			-- For exmaple, if a class stone is associated to current, `element_name' would be the class name.
		local
			l_target_stone: TARGET_STONE
			l_cluster_stone: CLUSTER_STONE
			l_class_stone: CLASSC_STONE
			l_feature_stone: FEATURE_STONE
			l_group: CONF_GROUP
		do
			if associated_stone /= Void and then is_stone_valid (associated_stone) then
				l_feature_stone ?= associated_stone
				l_class_stone ?= associated_stone
				l_cluster_stone ?= associated_stone
				l_target_stone ?= associated_stone
				create Result.make (64)
				if l_feature_stone /= Void then
					Result.append (l_feature_stone.e_feature.name)
				elseif l_class_stone /= Void then
					Result.append (l_class_stone.class_name)
				elseif l_cluster_stone /= Void then
					if not l_cluster_stone.path.is_empty then
							-- For a folder
						Result.append (l_cluster_stone.folder_name)
					else
							-- For a group
						Result.append (l_group.name)
					end
				elseif l_target_stone /= Void then
					Result.append (l_target_stone.target.name)
				end
			end
		end

feature -- Status setting

	set_dotnet_mode (a_flag: BOOLEAN) is
			-- Set whether formatting in .NET mode to 'a_flag'
		do
			is_dotnet_mode := a_flag
		ensure
			mode_is_flag: is_dotnet_mode = a_flag
		end

	set_stone (new_stone: STONE) is
			-- Associate current formatter with stone contained in `new_stone'.
		do
			force_stone (new_stone)
			if is_stone_valid (new_stone) then
				associated_stone := new_stone
				must_format := True
				format
			else
				associated_stone := Void
				reset_display
			end
			if
				selected and then
				not widget.is_displayed
			then
				if widget_owner /= Void then
					widget_owner.set_widget (widget)
				end
				display_header
			end
		end

	set_focus is
			-- Set focus to current formatter.
		do
			if browser /= Void then
				browser.set_focus
			end
		end

	set_browser (a_browser: like browser) is
			-- Set `browser' with `a_browser'.
		require
			a_browser_attached: a_browser /= Void
		do
			browser := a_browser
		ensure
			browser_set: browser = a_browser
		end

	setup_viewpoint is
			-- Setup viewpoint for formatting.
		do
		end

feature {NONE} -- Implementation

	reset_display is
			-- Clear all graphical output.
		do
			if browser /= Void then
				browser.reset_display
			end
		end

	temp_header: STRING_GENERAL is
			-- Temporary header displayed during the format processing.
		local
			l_str: STRING_GENERAL
		do
			if associated_stone /= Void then
				l_str := name_of_stone (associated_stone)
			else
				l_str := ""
			end
			Result := interface_names.l_Header_dependency (command_name, l_str)
		end

	header: STRING_GENERAL is
			-- Header displayed when current formatter is selected.
		do
			if associated_stone /= Void then
				Result := interface_names.l_Header_dependency (capital_command_name, name_of_stone (associated_stone))
			else
				Result := Interface_names.l_select_element_to_show_info
			end
		end

	class_domain_from_associated_stone: QL_CLASS_DOMAIN is
			-- Query language class domain from `associated_stone'.
		require
			associated_stone_attached: associated_stone /= Void
			associated_stone_valid: is_stone_valid (associated_stone)
		local
			l_domain_generator: QL_CLASS_DOMAIN_GENERATOR
		do
			create l_domain_generator.make (class_criterion_factory.criterion_with_name (query_language_names.ql_cri_is_compiled, []), True)
			l_domain_generator.enable_optimization
			l_domain_generator.disable_distinct_item
			Result ?= domain_item_from_stone (final_stone_from_stone (associated_stone)).domain_without_scope.new_domain (l_domain_generator)
		ensure
			result_attached: Result /= Void
		end

	dependency_criterion (a_domain: QL_DOMAIN): QL_CLASS_CRITERION is
			-- Criterion to filter dependency classes
		require
			associated_stone_attached: associated_stone /= Void
			associated_stone_valid: is_stone_valid (associated_stone)
			a_domain_attached: a_domain /= Void
			browser_attached: browser /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	generate_result is
			-- Generate result.
		require
			associated_stone_attached: associated_stone /= Void
			associated_stone_valid: is_stone_valid (associated_stone)
		local
			l_dep: HASH_TABLE [HASH_TABLE [DS_HASH_SET [QL_CLASS], QL_CLASS], QL_GROUP]
			l_target_domain: QL_TARGET_DOMAIN
			l_dep_domain: QL_CLASS_DOMAIN
			l_generator: QL_CLASS_DOMAIN_GENERATOR
			l_group: QL_GROUP
			l_class_tbl: HASH_TABLE [DS_HASH_SET [QL_CLASS], QL_CLASS]
			l_class_set: DS_HASH_SET [QL_CLASS]
			l_source_domain: QL_CLASS_DOMAIN
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_dep.make (36)
				create l_generator
				l_generator.enable_fill_domain
				l_generator.enable_optimization
				l_generator.disable_distinct_item
					-- Generate dependency table `l_dep'.
					-- `l_dep' is a hash table whose key is ql group items and value is another hash table whose key is class in that ql group, and value is
					-- a set of classes who depend on this class.
				l_source_domain := class_domain_from_associated_stone
				from
					l_target_domain := system_target_domain
					l_source_domain.start
				until
					l_source_domain.after
				loop
					l_generator.set_criterion (dependency_criterion (l_source_domain.item.wrapped_domain))
					l_dep_domain ?= l_target_domain.new_domain (l_generator)
					check l_dep_domain /= Void end
					from
						l_dep_domain.start
					until
						l_dep_domain.after
					loop
						l_group ?= l_dep_domain.item.parent
						check l_group /= Void end
						l_class_tbl := l_dep.item (l_group)

						if l_class_tbl = Void then
							create l_class_tbl.make (64)
							l_dep.force (l_class_tbl, l_group)
						end

						l_class_set := l_class_tbl.item (l_dep_domain.item)
						if l_class_set = Void then
							create l_class_set.make (64)
							l_class_set.set_equality_tester (create {AGENT_BASED_EQUALITY_TESTER [QL_CLASS]}.make (agent is_class_equal))
							l_class_tbl.force (l_class_set, l_dep_domain.item)
						end
						l_class_set.force (l_source_domain.item)
						l_dep_domain.forth
					end
					l_source_domain.forth
				end
				browser.set_starting_element (stone)
				browser.update (Void, [l_dep, l_source_domain] )
			else
				browser.set_trace (exception_trace)
				browser.update (Void, Void)
			end
		end

	internal_recycle is
			-- Recycle
		do
			Precursor
			browser.recycle
			browser := Void
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
