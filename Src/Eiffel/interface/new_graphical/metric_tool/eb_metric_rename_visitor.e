indexing
	description: "Visitor to rename metrics"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_RENAME_VISITOR

inherit
	EB_METRIC_VISITOR

create
	make

feature{NONE} -- Initialization

	make (a_old_name, a_new_name: STRING) is
			-- Initialize `old_metric_name' with `a_old_name' and
			-- `new_metric_name' with `a_new_name'.
		require
			a_old_name_attached: a_old_name /= Void
			a_new_name_attached: a_new_name /= Void
		do
			old_metric_name := a_old_name.twin
			new_metric_name := a_new_name.twin
		ensure
			old_metric_name_set: old_metric_name /= Void and then old_metric_name.is_equal (a_old_name)
			new_metric_name_set: new_metric_name /= Void and then new_metric_name.is_equal (a_new_name)
		end

feature -- Process

	process_metric (a_metric: EB_METRIC) is
			-- Process `a_metric'.
		require
			a_metric_attached: a_metric /= Void
		do
			a_metric.process (Current)
		end

feature -- Access

	old_metric_name: STRING
			-- Old metric name

	new_metric_name: STRING
			-- New metric name

feature{NONE} -- Process

	process_basic_metric (a_basic_metric: EB_METRIC_BASIC) is
			-- Process `a_basic_metric'.
		do
		end

	process_linear_metric (a_linear_metric: EB_METRIC_LINEAR) is
			-- Process `a_linear_metric'.
		local
			l_variable_metric: LIST [STRING]
			l_cursor: CURSOR
		do
			l_variable_metric := a_linear_metric.variable_metric
			if not l_variable_metric.is_empty then
				l_cursor := l_variable_metric.cursor
				from
					l_variable_metric.start
				until
					l_variable_metric.after
				loop
					if l_variable_metric.item.is_case_insensitive_equal (old_metric_name) then
						l_variable_metric.replace (new_metric_name.twin)
					end
					l_variable_metric.forth
				end
				l_variable_metric.go_to (l_cursor)
			end
		end

	process_ratio_metric (a_ratio_metric: EB_METRIC_RATIO) is
			-- Process `a_ratio_metric'.
		do
			if a_ratio_metric.denominator_metric_name.is_case_insensitive_equal (old_metric_name) then
				a_ratio_metric.set_numerator_metric_name (new_metric_name)
			end
			if a_ratio_metric.denominator_metric_name.is_case_insensitive_equal (old_metric_name) then
				a_ratio_metric.set_denominator_metric_name (new_metric_name)
			end
		end

	process_criterion (a_criterion: EB_METRIC_CRITERION) is
			-- Process `a_criterion'.
		do
		end

	process_domain_criterion (a_criterion: EB_METRIC_DOMAIN_CRITERION) is
			-- Process `a_criterion'.
		do
		end

	process_caller_criterion (a_criterion: EB_METRIC_CALLER_CALLEE_CRITERION) is
			-- Process `a_criterion'.
		do
		end

	process_text_criterion (a_criterion: EB_METRIC_TEXT_CRITERION) is
			-- Process `a_criterion'.
		do
		end

	process_path_criterion (a_criterion: EB_METRIC_PATH_CRITERION) is
			-- Process `a_criterion'.
		do
		end

	process_normal_criterion (a_criterion: EB_METRIC_NORMAL_CRITERION) is
			-- Process `a_criterion'.
		do
		end

	process_nary_criterion (a_criterion: EB_METRIC_NARY_CRITERION) is
			-- Process `a_criterion'.
		do
			process_list (a_criterion.operands)
		end

	process_and_criterion (a_criterion: EB_METRIC_AND_CRITERION) is
			-- Process `a_criterion'.
		do
			process_nary_criterion (a_criterion)
		end

	process_or_criterion (a_criterion: EB_METRIC_OR_CRITERION) is
			-- Process `a_criterion'.
		do
			process_nary_criterion (a_criterion)
		end

	process_domain_item (a_item: EB_METRIC_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_application_target_domain_item (a_item: EB_METRIC_TARGET_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_group_domain_item (a_item: EB_METRIC_GROUP_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_folder_domain_item (a_item: EB_METRIC_FOLDER_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_class_domain_item (a_item: EB_METRIC_CLASS_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_feature_domain_item (a_item: EB_METRIC_FEATURE_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_delayed_domain_item (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM) is
			-- Process `a_item'.
		do
		end

	process_metric_archive_node (a_item: EB_METRIC_ARCHIVE_NODE) is
			-- Process `a_item'.
		do
		end

invariant
	old_metric_name_attached: old_metric_name /= Void
	new_metric_name_attached: new_metric_name /= Void

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
