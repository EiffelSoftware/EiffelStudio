indexing
	description: "Object that retrieves data from a metric criterion and use the data in another metric criterion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_CRITERION_DATA_RETRIEVER

inherit
	EB_METRIC_ITERATOR
		redefine
			process_domain_criterion,
			process_caller_callee_criterion,
			process_supplier_client_criterion,
			process_text_criterion,
			process_path_criterion,
			process_value_criterion,
			process_nary_criterion
		end

feature -- Access

	original_criterion: EB_METRIC_CRITERION
			-- Original criterion from which data is retrieved

feature -- Setting

	set_original_criterion (a_criterion: like original_criterion) is
			-- Set `origianl_criterion' with `a_criterion'.
		do
			original_criterion := a_criterion
		ensure
			original_criterion_set: original_criterion = a_criterion
		end

feature -- Data retrieval

	retrieve_data (a_criterion: EB_METRIC_CRITERION) is
			-- Retrieve data from `original_criterion' and store it in `a_criterion'.
		require
			a_acriterion_attached: a_criterion /= Void
		do
			if original_criterion /= Void then
				a_criterion.process (Current)
			end
		end

feature{NONE} -- Process

	process_domain_criterion (a_criterion: EB_METRIC_DOMAIN_CRITERION) is
			-- Process `a_criterion'.
		local
			l_domain_criterion: EB_METRIC_DOMAIN_CRITERION
		do
			l_domain_criterion ?= original_criterion
			if l_domain_criterion /= Void then
				a_criterion.set_domain (l_domain_criterion.domain)
			end
		end

	process_caller_callee_criterion (a_criterion: EB_METRIC_CALLER_CALLEE_CRITERION) is
			-- Process `a_criterion'.
		local
			l_caller_callee_criterion: EB_METRIC_CALLER_CALLEE_CRITERION
			l_domain_criterion: EB_METRIC_DOMAIN_CRITERION
		do
			l_caller_callee_criterion ?= original_criterion
			if l_caller_callee_criterion /= Void then
				a_criterion.set_domain (l_caller_callee_criterion.domain)
				if l_caller_callee_criterion.only_current_version then
					a_criterion.enable_only_current_version
				else
					a_criterion.disable_only_current_version
				end
			else
				l_domain_criterion ?= original_criterion
				if l_domain_criterion /= Void then
					a_criterion.set_domain (l_domain_criterion.domain)
				end
			end
		end

	process_supplier_client_criterion (a_criterion: EB_METRIC_SUPPLIER_CLIENT_CRITERION) is
			-- Process `a_criterion'.
		local
			l_supplier_client_cri: EB_METRIC_SUPPLIER_CLIENT_CRITERION
			l_domain_cri: EB_METRIC_DOMAIN_CRITERION
		do
			l_supplier_client_cri ?= original_criterion
			if l_supplier_client_cri /= Void then
				a_criterion.set_domain (l_supplier_client_cri.domain)
				a_criterion.set_indirect_referenced_class_retrieved (l_supplier_client_cri.indirect_referenced_class_retrieved)
				a_criterion.set_normal_referenced_class_retrieved (l_supplier_client_cri.normal_referenced_class_retrieved)
				a_criterion.set_only_syntactically_referencedd_class_retrieved (l_supplier_client_cri.only_syntactically_referencedd_class_retrieved)
			else
				l_domain_cri ?= original_criterion
				if l_domain_cri /= Void then
					a_criterion.set_domain (l_domain_cri.domain)
				end
			end
		end

	process_text_criterion (a_criterion: EB_METRIC_TEXT_CRITERION) is
			-- Process `a_criterion'.
		local
			l_text_cri: EB_METRIC_TEXT_CRITERION
		do
			l_text_cri ?= original_criterion
			if l_text_cri /= Void then
				a_criterion.set_text (a_criterion.text)
				if l_text_cri.is_identical_comparison_used then
					a_criterion.enable_identical_comparison
				else
					a_criterion.disable_identical_comparison
				end
				if l_text_cri.is_case_sensitive then
					a_criterion.enable_case_sensitive
				else
					a_criterion.disable_case_sensitive
				end
			end
		end

	process_path_criterion (a_criterion: EB_METRIC_PATH_CRITERION) is
			-- Process `a_criterion'.
		local
			l_path_cri: EB_METRIC_PATH_CRITERION
		do
			l_path_cri ?= original_criterion
			if l_path_cri /= Void then
				a_criterion.set_path (l_path_cri.path)
			end
		end

	process_value_criterion (a_criterion: EB_METRIC_VALUE_CRITERION) is
			-- Process `a_criterion'.
		local
			l_value_cri: EB_METRIC_VALUE_CRITERION
			l_domain_cri: EB_METRIC_DOMAIN_CRITERION
		do
			l_value_cri ?= original_criterion
			if l_value_cri /= Void then
				a_criterion.set_domain (l_value_cri.domain)
				a_criterion.set_value_tester (l_value_cri.value_tester)
			else
				l_domain_cri ?= original_criterion
				if l_domain_cri /= Void then
					a_criterion.set_domain (l_domain_cri.domain)
				end
			end
		end

	process_nary_criterion (a_criterion: EB_METRIC_NARY_CRITERION) is
			-- Process `a_criterion'.
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
