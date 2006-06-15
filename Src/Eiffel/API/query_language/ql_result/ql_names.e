indexing
	description: "Name constants used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_NAMES

feature -- Scope item

	ql_target: STRING is "target"
	ql_group: STRING is "group"
	ql_class: STRING is "class"
	ql_feature: STRING is "feature"
	ql_invariant: STRING is "invariant"
	ql_quantity: STRING is "quantity"
	ql_line: STRING is "line"
	ql_local: STRING is "local"
	ql_assertion: STRING is "assertion"
	ql_argument: STRING is "argument"
	ql_generic: STRING is "generic"

feature -- Units

	ql_target_unit: STRING is "target"
	ql_group_unit: STRING is "group"
	ql_class_unit: STRING is "class"
	ql_feature_unit: STRING is "feature"
	ql_compilation_unit: STRING is "compilation"
	ql_local_unit: STRING is "local"
	ql_argument_unit: STRING is "argument"
	ql_ratio_unit: STRING is "ratio"
	ql_line_unit: STRING is "line"
	ql_assertion_unit: STRING is "assertion"
	ql_no_unit: STRING is "no unit"
	ql_generic_unit: STRING is "generic unit"

feature -- Titles

	ql_name: STRING is "name"
	ql_path: STRING is "path"

feature -- Criterion names

	ql_cri_true: STRING is "true"
	ql_cri_false: STRING is "false"
	ql_cri_and: STRING is "and"
	ql_cri_or: STRING is "or"
	ql_cri_not: STRING is "not"
	ql_cri_eq: STRING is "eq"
	ql_cri_ne: STRING is "ne"
	ql_cri_num: STRING is "num"
	ql_cri_is_compiled: STRING is "is_compiled"
	ql_cri_name_is: STRING is "name_is"

	ql_cri_is_assembly: STRING is "is_assembly"
	ql_cri_is_library: STRING is "is_library"
	ql_cri_is_cluster: STRING is "is_cluster"
	ql_cri_is_override: STRING is "is_override"
	ql_cri_is_valid: STRING is "is_valid"
	ql_cri_is_used_in_library: STRING is "is_used_in_library"
	ql_cri_is_class_set: STRING is "is_class_set"

	ql_cri_has_invariant: STRING is "has_invariant"
	ql_cri_ancestor_is: STRING is "ancestor_is"
	ql_cri_proper_ancestor_is: STRING is "proper_ancestor_is"
	ql_cri_parent_is: STRING is "parent_is"
	ql_cri_indirect_parent_is: STRING is "indirect_parent_is"
	ql_cri_descendant_is: STRING is "descendant_is"
	ql_cri_proper_descendant_is: STRING is "proper_descendant_is"
	ql_cri_heir_is: STRING is "heir_is"
	ql_cri_indirect_heir_is: STRING is "indirect_heir_is"
	ql_cri_client_is: STRING is "client_is"
	ql_cri_indirect_client_is: STRING is "indirect_client_is"
	ql_cri_supplier_is: STRING is "supplier_is"
	ql_cri_indirect_supplier_is: STRING is "indirect_supplier_is"
	ql_cri_is_deferred: STRING is "is_deferred"
	ql_cri_is_expanded: STRING is "is_expanded"
	ql_cri_is_external: STRING is "is_external"
	ql_cri_is_frozen: STRING is "is_frozen"
	ql_cri_is_generic: STRING is "is_generic"
	ql_cri_is_obsolete: STRING is "is_obsolete"
	ql_cri_is_precompiled: STRING is "is_precompiled"
	ql_cri_has_top_indexing: STRING is "has_top_indexing"
	ql_cri_has_bottom_indexing: STRING is "has_bottom_indexing"
	ql_cri_has_indexing: STRING is "has_indexing"
	ql_cri_is_enum: STRING is "is_enum"
	ql_cri_is_effective: STRING is "is_effective"
	ql_cri_path_in: STRING is "path_in"
	ql_cri_path_is: STRING is "path_is"
	ql_cri_text_contain: STRING is "text_contain"
	ql_cri_top_indexing_has_tag: STRING is "top_indexing_has_tag"
	ql_cri_bottom_indexing_has_tag: STRING is "bottom_indexing_has_tag"
	ql_cri_indexing_has_tag: STRING is "indexing_has_tag"
	ql_cri_top_indexing_contain: STRING is "top_indexing_contain"
	ql_cri_bottom_indexing_contain: STRING is "bottom_indexing_contain"
	ql_cri_indexing_contain: STRING is "indexing_contain"
	ql_cri_is_always_compiled: STRING is "is_always_compiled"
	ql_cri_is_partial: STRING is "is_partial"
	ql_cri_is_read_only: STRING is "is_read_only"
	ql_cri_is_overriden: STRING is "is_overriden"
	ql_cri_is_overrider: STRING is "is_overrider"
	ql_cri_is_visible: STRING is "is_visible"

	ql_cri_has_argument: STRING is "has_argument"
	ql_cri_has_assertion: STRING is "has_assertion"
	ql_cri_has_assigner: STRING is "has_assigner"
	ql_cri_has_comment: STRING is "has_comment"
	ql_cri_has_local: STRING is "has_local"
	ql_cri_has_postcondition: STRING is "has_postcondition"
	ql_cri_has_precondition: STRING is "has_precondition"
	ql_cri_has_rescue: STRING is "has_rescue"
	ql_cri_is_attribute: STRING is "is_attribute"
	ql_cri_is_caller: STRING is "is_caller_of"
	ql_cri_is_constant: STRING is "is_constant"
	ql_cri_is_function: STRING is "is_function"
	ql_cri_is_immediate: STRING is "is_immediate"
	ql_cri_is_implementor: STRING is "is_implementor_of"
	ql_cri_is_infix: STRING is "is_infix"
	ql_cri_is_once: STRING is "is_once"
	ql_cri_is_origin: STRING is "is_origin"
	ql_cri_is_prefix: STRING is "is_prefix"
	ql_cri_is_procedure: STRING is "is_procedure"
	ql_cri_is_unique: STRING is "is_unique"
	ql_cri_is_feature: STRING is "is_feature"
	ql_cri_is_invariant: STRING is "is_invariant"
	ql_cri_is_creator: STRING is "is_creator"
	ql_cri_is_exported: STRING is "is_exported"
	ql_cri_is_hidden: STRING is "is_hidden"
	ql_cri_implementors_of: STRING is "is_implementors_of"
	ql_cri_is_exported_to: STRING is "is_exported_to"
	ql_cri_callee_is: STRING is "callee_is"
	ql_cri_caller_is: STRING is "caller_is"
	ql_cri_assignee_is: STRING is "assignee_is"
	ql_cri_assigner_is: STRING is "assigner_is"
	ql_cri_createe_is: STRING is "createe_is"
	ql_cri_creator_is: STRING is "creator_is"
	ql_cri_is_invariant_feature: STRING is "is_invariant_feature"

	ql_cri_has_constraint: STRING is "has_constraint"
	ql_cri_has_creation_constraint: STRING is "has_creation_constraint"
	ql_cri_is_reference: STRING is "is_reference"

	ql_cri_is_used: STRING is "is_used"

	ql_cri_has_expression: STRING is "has_expression"
	ql_cri_has_tag: STRING is "has_tag"
	ql_cri_is_require: STRING is "is_require"
	ql_cri_is_require_else: STRING is "is_require_else"
	ql_cri_is_ensure: STRING is "is_ensure"
	ql_cri_is_ensure_then: STRING is "is_ensure_then"
	ql_cri_is_precondition: STRING is "is_precondition"
	ql_cri_is_postcondition: STRING is "is_postcondition"

	ql_cri_is_blank: STRING is "is_blank"
	ql_cri_is_comment: STRING is "is_comment"

feature -- Metric names

	ql_metric_target: STRING is "Number of targets"
	ql_metric_group: STRING is "Number of groups"
	ql_metric_class: STRING is "Number of classes"
	ql_metric_feature: STRING is "Number of features"
	ql_metric_local: STRING is "Number of locals"
	ql_metric_argument: STRING is "Number of arguments"
	ql_metric_line: STRING is "Number of lines"
	ql_metric_compilation: STRING is "Number of compilation"
	ql_metric_assertion: STRING is "Number of assertions"
	ql_metric_sum: STRING is "Sum"
	ql_metric_average: STRING is "Average"
	ql_metric_count: STRING is "Number of items"
	ql_metric_generic: STRING is "Number of generics"

feature -- Assertion type names

	ql_require_assertion: STRING is "require"
	ql_require_else_assertion: STRING is "require else"
	ql_ensure_assertion: STRING is "ensure"
	ql_ensure_then_assertion: STRING is "ensure then"
	ql_invariant_assertion: STRING is "invariant"

feature -- Path marker

	ql_target_path_opener: STRING is ""
	ql_target_path_closer: STRING is ""

	ql_group_path_opener: STRING is ""
	ql_group_path_closer: STRING is ""

	ql_class_path_opener: STRING is "{"
	ql_class_path_closer: STRING is "}"

	ql_feature_path_opener: STRING is "`"
	ql_feature_path_closer: STRING is "'"

	ql_generic_path_opener: STRING is "["
	ql_generic_path_closer: STRING is "]"

	ql_argument_path_opener: STRING is "argument "
	ql_argument_path_closer: STRING is ""

	ql_local_path_opener: STRING is "local "
	ql_local_path_closer: STRING is ""

	ql_assertion_path_opener: STRING is "assertion "
	ql_assertion_path_closer: STRING is ""

	ql_line_path_opener: STRING is "line "
	ql_line_path_closer: STRING is ""

	ql_quantity_path_opener: STRING is "quantity "
	ql_quantity_path_closer: STRING is ""

feature -- Feature caller types

	ql_normal_feature_caller: STRING is "normal caller"
	ql_assigner_feature_caller: STRING is "assign caller"
	ql_creator_feature_caller: STRING is "creator caller"
	ql_normal_feature_callee: STRING is "normal callee"
	ql_assigner_feature_callee: STRING is "assign callee"
	ql_creator_feature_callee: STRING is "creator callee"

feature -- Class relationship

	ql_class_ancestor_relation: STRING is "ancestor"
	ql_class_proper_ancestor_relation: STRING is "proper ancestor"
	ql_class_descendant_relation: STRING is "descendant"
	ql_class_proper_descendant_relation: STRING is "proper descendant"
	ql_class_parent_relation: STRING is "parent"
	ql_class_indirect_parent_relation: STRING is "indirect parent"
	ql_class_heir_relation: STRING is "heir"
	ql_class_indirect_heir_relation: STRING is "indirect heir"
	ql_class_client_relation: STRING is "client"
	ql_class_indirect_client_relation: STRING is "indirect client"
	ql_class_supplier_relation: STRING is "supplier"
	ql_class_indirect_supplier_relation: STRING is "indirect supplier";

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
