indexing
	description: "Metric visitor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_VISITOR

feature -- Process

	process_basic_metric (a_basic_metric: EB_METRIC_BASIC) is
			-- Process `a_basic_metric'.
		require
			a_basic_metric_attached: a_basic_metric /= Void
		deferred
		end

	process_linear_metric (a_linear_metric: EB_METRIC_LINEAR) is
			-- Process `a_linear_metric'.
		require
			a_linear_metric_attached: a_linear_metric /= Void
		deferred
		end

	process_ratio_metric (a_ratio_metric: EB_METRIC_RATIO) is
			-- Process `a_ratio_metric'.
		require
			a_ratio_metric_attached: a_ratio_metric /= Void
		deferred
		end

	process_list (a_list: LIST [EB_METRIC_VISITABLE]) is
			-- Process `a_list'.
		require
			a_list_attached: a_list /= Void
		local
			l_cursor: CURSOR
		do
			if not a_list.is_empty then
				l_cursor := a_list.cursor
				from
					a_list.start
				until
					a_list.after
				loop
					safe_process_item (a_list.item)
					a_list.forth
				end
				if l_cursor /= Void then
					a_list.go_to (l_cursor)
				end
			end
		end

	process_criterion (a_criterion: EB_METRIC_CRITERION) is
			-- Process `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	process_domain_criterion (a_criterion: EB_METRIC_DOMAIN_CRITERION) is
			-- Process `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	process_caller_callee_criterion (a_criterion: EB_METRIC_CALLER_CALLEE_CRITERION) is
			-- Process `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	process_supplier_client_criterion (a_criterion: EB_METRIC_SUPPLIER_CLIENT_CRITERION) is
			-- Process `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	process_text_criterion (a_criterion: EB_METRIC_TEXT_CRITERION) is
			-- Process `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	process_path_criterion (a_criterion: EB_METRIC_PATH_CRITERION) is
			-- Process `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	process_normal_criterion (a_criterion: EB_METRIC_NORMAL_CRITERION) is
			-- Process `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	process_value_criterion (a_criterion: EB_METRIC_VALUE_CRITERION) is
			-- Process `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	process_nary_criterion (a_criterion: EB_METRIC_NARY_CRITERION) is
			-- Process `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	process_and_criterion (a_criterion: EB_METRIC_AND_CRITERION) is
			-- Process `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	process_or_criterion (a_criterion: EB_METRIC_OR_CRITERION) is
			-- Process `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	process_domain (a_domain: EB_METRIC_DOMAIN) is
			-- Process `a_domain'.
		require
			a_domain_attached: a_domain /= Void
		deferred
		end

	process_domain_item (a_item: EB_METRIC_DOMAIN_ITEM) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_application_target_domain_item (a_item: EB_METRIC_TARGET_DOMAIN_ITEM) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_group_domain_item (a_item: EB_METRIC_GROUP_DOMAIN_ITEM) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_folder_domain_item (a_item: EB_METRIC_FOLDER_DOMAIN_ITEM) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_class_domain_item (a_item: EB_METRIC_CLASS_DOMAIN_ITEM) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_feature_domain_item (a_item: EB_METRIC_FEATURE_DOMAIN_ITEM) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_delayed_domain_item (a_item: EB_METRIC_DELAYED_DOMAIN_ITEM) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_metric_archive_node (a_item: EB_METRIC_ARCHIVE_NODE) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_value_tester (a_item: EB_METRIC_VALUE_TESTER) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_constant_value_retriever (a_item: EB_METRIC_CONSTANT_VALUE_RETRIEVER) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

	process_metric_value_retriever (a_item: EB_METRIC_METRIC_VALUE_RETRIEVER) is
			-- Process `a_item'.
		require
			a_item_attached: a_item /= Void
		deferred
		end

feature{NONE} -- Implementation

	safe_process_item (a_item: EB_METRIC_VISITABLE) is
			-- Safe process `a_item'.
		do
			if a_item /= Void then
				a_item.process (Current)
			end
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
