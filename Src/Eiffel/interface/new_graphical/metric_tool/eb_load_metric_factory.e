indexing
	description: "Factory used to create new nodes for metric when load metric definitions from xml file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_LOAD_METRIC_FACTORY

inherit
	EB_METRIC_SHARED

feature -- metric creation

	new_basic_metric (a_name: STRING; a_unit: QL_METRIC_UNIT; a_uuid: UUID): EB_METRIC_BASIC is
			-- New basic metric
		require
			a_name_attached: a_name /= Void
			a_unit_attached: a_unit /= Void
			a_uuid_attached: a_uuid /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_linear_metric (a_name: STRING; a_unit: QL_METRIC_UNIT; a_uuid: UUID): EB_METRIC_LINEAR is
			-- New linear metric
		require
			a_name_attached: a_name /= Void
			a_unit_attached: a_unit /= Void
			a_uuid_attached: a_uuid /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_ratio_metric (a_name: STRING; a_unit: QL_METRIC_UNIT; a_uuid: UUID; a_num_name: STRING; a_num_uuid: UUID; a_den_name: STRING; a_den_uuid: UUID): EB_METRIC_RATIO is
			-- New ratio metric
		require
			a_name_attached: a_name /= Void
			a_unit_attached: a_unit /= Void
			a_uuid_attached: a_uuid /= Void
			a_num_name_attached: a_num_name /= Void
			a_den_name_attached: a_den_name /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Criterion creation

	new_normal_criterion (a_name: STRING; a_scope: QL_SCOPE): EB_METRIC_NORMAL_CRITERION is
			-- New normal criterion
		require
			a_name_attached: a_name /= Void
			a_scope_attached: a_scope /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_text_criterion (a_name: STRING; a_scope: QL_SCOPE): EB_METRIC_TEXT_CRITERION is
			-- NEw text criterion
		require
			a_name_attached: a_name /= Void
			a_scope_attached: a_scope /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_path_criterion (a_name: STRING; a_scope: QL_SCOPE): EB_METRIC_PATH_CRITERION is
			-- New normal criterion
		require
			a_name_attached: a_name /= Void
			a_scope_attached: a_scope /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_domain_criterion (a_name: STRING; a_scope: QL_SCOPE): EB_METRIC_DOMAIN_CRITERION is
			-- New domain criterion
		require
			a_name_attached: a_name /= Void
			a_scope_attached: a_scope /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_caller_criterion (a_name: STRING; a_scope: QL_SCOPE): EB_METRIC_CALLER_CALLEE_CRITERION is
			-- New caller/callee criterion
		require
			a_name_attached: a_name /= Void
			a_scope_attached: a_scope /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_and_criterion (a_name: STRING; a_scope: QL_SCOPE): EB_METRIC_AND_CRITERION is
			-- New and criterion
		require
			a_name_attached: a_name /= Void
			a_scope_attached: a_scope /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_or_criterion (a_name: STRING; a_scope: QL_SCOPE): EB_METRIC_OR_CRITERION is
			-- New or criterion
		require
			a_name_attached: a_name /= Void
			a_scope_attached: a_scope /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Domain item creation

	new_application_target_item (a_id: STRING): EB_METRIC_TARGET_DOMAIN_ITEM is
			-- New application domain item
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_group_item (a_id: STRING): EB_METRIC_GROUP_DOMAIN_ITEM is
			-- New group domain item with id `a_id'
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		deferred
		end

	new_folder_item (a_id: STRING): EB_METRIC_FOLDER_DOMAIN_ITEM is
			-- New folder domain item with id `a_id'
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		deferred
		end

	new_class_item (a_id: STRING): EB_METRIC_CLASS_DOMAIN_ITEM is
			-- New class domain item with id `a_id'
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		deferred
		end

	new_feature_item (a_id: STRING): EB_METRIC_FEATURE_DOMAIN_ITEM is
			-- New group domain item with id `a_id'
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		deferred
		end

	new_delayed_item (a_id: STRING): EB_METRIC_DELAYED_DOMAIN_ITEM is
			-- New group domain item with id `a_id'
		deferred
		end

feature -- Archive node creation

	new_metric_arichive_node (a_metric_name: STRING; a_metric_type: INTEGER; a_time: DATE_TIME; a_value: DOUBLE; a_input: EB_METRIC_DOMAIN; a_uuid: STRING): EB_METRIC_ARCHIVE_NODE is
			-- New metric archive node and initialize `metric_name' with `a_metric_name', `metric_type' with `a_metric_type', `calculated_time' with `a_time',
			-- `value' with `a_value', `input_domain' with `a_input and `uuid' with `a_uuid'.
		require
			a_metric_name_attached: a_metric_name /= Void
			a_metric_type_valid: is_metric_type_valid (a_metric_type)
			a_time_attached: a_time /= Void
			a_input_attached: a_input /= Void
			a_uuid_attached: a_uuid /= Void
			a_uuid_valid: shared_uuid.is_valid_uuid (a_uuid)
		deferred
		ensure
			result_attached: Result /= Void
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
