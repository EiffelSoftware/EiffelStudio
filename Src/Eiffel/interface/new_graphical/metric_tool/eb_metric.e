indexing
	description: "Metric used in EiffelStudio"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC

inherit
	EB_METRIC_VISITABLE

feature{NONE} -- Initialization

	make (a_name: STRING; a_unit: like unit; a_uuid: like uuid) is
			-- Initialize `name' with `a_name', `unit' with `a_unit and `uuid' with `a_uuid'.
		require
			a_name_attached: a_name /= Void
			a_unit_attached: a_unit /= Void
			a_uuid_attached: a_uuid /= Void
		do
			set_name (a_name)
			set_unit (a_unit)
			set_uuid (a_uuid)
		end

feature -- Status report

	is_result_domain_available: BOOLEAN is
			-- After metric calculation, can we get the last generated domain
			-- for detail display?
		deferred
		end

	is_fill_domain_enabled: BOOLEAN
			-- During metric calculation, will internal domain be remaind?
			-- Default: False

	is_predefined: BOOLEAN
			-- Is current metric a predefined one?
			-- If True, user cannot change the definition of it.

	is_registered: BOOLEAN is
			-- Is current metric registered?
		do
			Result := manager /= Void
		end

	is_basic: BOOLEAN is
			-- Is current a basic metric?
		do
		end

	is_linear: BOOLEAN is
			-- Is current a linear metric?
		do
		end

	is_ratio: BOOLEAN is
			-- Is current a ratio metric?
		do
		end

	should_result_be_filtered: BOOLEAN
			-- Should result be filtered and only result items that are visible in the input domain are remained?

	is_just_line_counting: BOOLEAN is
			-- Is current metric a line counting metric?
		do
		end

feature -- Access

	name: STRING
			-- Name of current metric

	last_result_domain: QL_DOMAIN
			-- Last calculated domain
			-- Has effect only when `is_result_domain_available' is True

	unit: QL_METRIC_UNIT
			-- Unit of current metric

	description: STRING
			-- Description of current metric

	manager: EB_METRIC_MANAGER
			-- Metric manager

	uuid: UUID
			-- UUID of current metric

	direct_referenced_metrics: LIST [STRING] is
			-- Name of metrics which are directly referenced by Current
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	enable_filter_result is
			-- Enable that result is filtered.
		do
			should_result_be_filtered := True
		ensure
			result_filter_enabled: should_result_be_filtered
		end

	disable_filter_result is
			-- Disable that result is filtered.
		do
			should_result_be_filtered := False
		ensure
			result_filter_disabled: not should_result_be_filtered
		end

feature -- Metric calculation

	value (a_scope: EB_METRIC_DOMAIN): QL_QUANTITY_DOMAIN is
			-- Calcualte current domain using `a_scope'.
		require
			a_scope_attached: a_scope /= Void
		deferred
		ensure
			result_attached: Result /= Void
			result_valid: Result.count = 1
		end

feature -- Setting

	set_name (a_name: STRING) is
			-- Set `name' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			if name /= Void then
				name.wipe_out
				name.append (a_name)
			else
				create name.make_from_string (a_name)
			end
		ensure
			name_set: name /= Void and then name.is_equal (a_name)
		end

	set_description (a_description: STRING) is
			-- Set `description' with `a_description'.
		require
			a_description_attached: a_description /= Void
		do
			if description /= Void then
				description.wipe_out
				description.append (a_description)
			else
				create description.make_from_string (a_description)
			end
		ensure
			description_set: description /= Void and then description.is_equal (a_description)
		end

	set_unit (a_unit: like unit) is
			-- Set `unit' with `a_unit'.
		require
			a_unit_attached: a_unit /= Void
		do
			unit := a_unit
		ensure
			unit_set: unit = a_unit
		end

	enable_fill_domain is
			-- Enable that newly generated domain will be filled with satisfied items.
		require
			is_result_domain_available: is_result_domain_available
		do
			is_fill_domain_enabled := True
		ensure
			fill_domain_enabled: is_fill_domain_enabled
		end

	disable_fill_domain is
			-- Disable that newly generated domain will be filled with satisfied items.
		do
			is_fill_domain_enabled := False
		ensure
			fill_domain_disabled: not is_fill_domain_enabled
		end

	set_is_predefined (b: BOOLEAN) is
			-- Set `is_predefined' with `b'.
		do
			is_predefined := b
		ensure
			is_predefined_set: is_predefined = b
		end

	set_metric_manager (a_manager: like manager) is
			-- Set `manager' with `a_manager'.
		do
			manager := a_manager
		ensure
			manager_set: manager = a_manager
		end

	set_uuid (a_uuid: like uuid) is
			-- Set `uuid' with `a_uuid'.
		require
			a_uuid_attached: a_uuid /= Void
		do
			uuid := a_uuid
		ensure
			uuid_set: uuid = a_uuid
		end

invariant
	name_attached: name /= Void
	unit_attached: unit /= Void
	uuid_attached: uuid /= Void

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
