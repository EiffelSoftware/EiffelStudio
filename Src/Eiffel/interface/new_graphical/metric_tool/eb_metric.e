note
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

	EB_METRIC_SHARED

	DEBUG_OUTPUT
		rename
			debug_output as name
		end

feature{NONE} -- Initialization

	make (a_name: STRING; a_unit: like unit)
			-- Initialize `name' with `a_name' and `unit' with `a_unit.
		require
			a_name_attached: a_name /= Void
			a_unit_attached: a_unit /= Void
		do
			set_name (a_name)
			set_unit (a_unit)
		end

feature -- Status report

	is_result_domain_available: BOOLEAN
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

	is_registered: BOOLEAN
			-- Is current metric registered?
		do
			Result := manager /= Void
		end

	is_basic: BOOLEAN
			-- Is current a basic metric?
		do
		end

	is_linear: BOOLEAN
			-- Is current a linear metric?
		do
		end

	is_ratio: BOOLEAN
			-- Is current a ratio metric?
		do
		end

	should_result_be_filtered: BOOLEAN
			-- Should result be filtered and only result items that are visible in the input domain are remained?

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

	direct_referenced_metrics: LIST [STRING]
			-- Name of metrics which are directly referenced by Current
		local
			l_reference_visitor: EB_METRIC_REFERENCED_METRIC_VISITOR
		do
			create l_reference_visitor.make
			l_reference_visitor.search_referenced_metric (Current)
			Result := l_reference_visitor.referenced_metric_name.twin
		ensure
			result_attached: Result /= Void
		end

	visitable_name: STRING_GENERAL
			-- Name of current visitable item
		do
			Result := metric_names.visitable_name (metric_names.t_metric, name)
		end

feature -- Setting

	enable_filter_result
			-- Enable that result is filtered.
		do
			should_result_be_filtered := True
		ensure
			result_filter_enabled: should_result_be_filtered
		end

	disable_filter_result
			-- Disable that result is filtered.
		do
			should_result_be_filtered := False
		ensure
			result_filter_disabled: not should_result_be_filtered
		end

feature -- Metric calculation

	value (a_scope: EB_METRIC_DOMAIN): QL_QUANTITY_DOMAIN
			-- Value of current metric calculated over `a_scope'
		require
			a_scope_attached: a_scope /= Void
		deferred
		ensure
			result_attached: Result /= Void
			result_valid: Result.count = 1
		end

	value_item (a_scope: EB_METRIC_DOMAIN): DOUBLE
			-- Value of current metric calculated over `a_scope'.
		require
			a_scope_attached: a_scope /= Void
		do
			Result := value (a_scope).first.value
		end

feature -- Setting

	set_name (a_name: STRING)
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

	set_description (a_description: STRING)
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

	set_unit (a_unit: like unit)
			-- Set `unit' with `a_unit'.
		require
			a_unit_attached: a_unit /= Void
		do
			unit := a_unit
		ensure
			unit_set: unit = a_unit
		end

	enable_fill_domain
			-- Enable that newly generated domain will be filled with satisfied items.
		require
			is_result_domain_available: is_result_domain_available
		do
			is_fill_domain_enabled := True
		ensure
			fill_domain_enabled: is_fill_domain_enabled
		end

	disable_fill_domain
			-- Disable that newly generated domain will be filled with satisfied items.
		do
			is_fill_domain_enabled := False
		ensure
			fill_domain_disabled: not is_fill_domain_enabled
		end

	set_is_predefined (b: BOOLEAN)
			-- Set `is_predefined' with `b'.
		do
			is_predefined := b
		ensure
			is_predefined_set: is_predefined = b
		end

	set_metric_manager (a_manager: like manager)
			-- Set `manager' with `a_manager'.
		do
			manager := a_manager
		ensure
			manager_set: manager = a_manager
		end

invariant
	name_attached: name /= Void
	unit_attached: unit /= Void

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
