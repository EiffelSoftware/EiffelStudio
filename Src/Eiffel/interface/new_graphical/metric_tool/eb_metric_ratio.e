indexing
	description: "Ratio metric"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_RATIO

inherit
	EB_METRIC
		redefine
			make,
			is_ratio
		end

	EXCEPTIONS

create
	make,
	make_with_numerator_and_denominator

feature{NONE} -- Initialization

	make (a_name: STRING; a_unit: like unit; a_uuid: like uuid) is
			-- Initialize `name' with `a_name', `unit' with `a_unit', and `uuid' with `a_uuid'.
		do
			Precursor (a_name, a_unit, a_uuid)
			numerator_metric_name := ""
			denominator_metric_name := ""
		end

	make_with_numerator_and_denominator (a_name: STRING; a_unit: like unit; a_uuid: like uuid; a_num_name: STRING; a_num_uuid: UUID; a_den_name: STRING; a_den_uuid: UUID) is
			-- Initialize `name' with `a_name', `unit' with `a_unit', `uuid' with `a_uuid',
			-- `numerator_metric_name' with `a_num_name' and `denominator_metric_name' with `a_den_name'.
		require
			a_name_attached: a_name /= Void
			a_unit_attached: a_unit /= Void
			a_uuit_attached: a_uuid /= Void
			a_num_name_attached: a_num_name /= Void
			a_den_name_attached: a_den_name /= Void
			a_num_uuid_attached: a_num_uuid /= Void
			a_den_uuid_attached: a_den_uuid /= Void
		do
			make (a_name, a_unit, a_uuid)
			numerator_metric_name := a_num_name.twin
			denominator_metric_name := a_den_name.twin
			set_numerator_metric_uuid (a_num_uuid)
			set_denominator_metric_uuid (a_den_uuid)
		ensure
			numerator_metric_name_set: numerator_metric_name /= Void and then numerator_metric_name.is_equal (a_num_name)
			denominator_metric_name_set: denominator_metric_name /= Void and then denominator_metric_name.is_equal (a_den_name)
			numerator_metric_uuid_set : numerator_metric_uuid = a_num_uuid
			denominator_metric_uuid_set: denominator_metric_uuid = a_den_uuid
		end

feature -- Access

	numerator_metric_name: STRING
			-- Name of numerator metric

	denominator_metric_name: STRING
			-- Name of denominator metric

	numerator_metric_uuid: UUID
			-- UUID of numerator metric

	denominator_metric_uuid: UUID
			-- UUID of denominator metric

	direct_referenced_metrics: LIST [STRING] is
			-- Name of metrics which are directly referenced by Current
		do
			create {LINKED_LIST [STRING]} Result.make
			Result.extend (numerator_metric_name)
			Result.extend (denominator_metric_name)
		end

feature -- Setting

	set_numerator_metric_name (a_name: STRING) is
			-- Set `numerator_metric_name' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			numerator_metric_name := a_name.twin
		ensure
			numerator_metric_name_set: numerator_metric_name /= Void and then numerator_metric_name.is_equal (a_name)
		end

	set_numerator_metric_uuid (a_uuid: UUID) is
			-- Set `numerator_metric_uuid' with `a_uuid'.
		require
			a_uuid_attached: a_uuid /= Void
		do
			numerator_metric_uuid := a_uuid
		ensure
			numerator_metric_uuid_set: numerator_metric_uuid = a_uuid
		end

	set_denominator_metric_name (a_name: STRING) is
			-- Set `denominator_metric_name' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			denominator_metric_name := a_name.twin
		ensure
			denominator_metric_name_set: denominator_metric_name /= Void and then denominator_metric_name.is_equal (a_name)
		end

	set_denominator_metric_uuid (a_uuid: UUID) is
			-- Set `denominator_metric_uuid' with `a_uuid'.
		require
			a_uuid_attached: a_uuid /= Void
		do
			denominator_metric_uuid := a_uuid
		ensure
			denominator_metric_uuid_set: denominator_metric_uuid = a_uuid
		end

feature -- Status report

	is_result_domain_available: BOOLEAN is
			-- After metric calculation, can we get the last generated domain
			-- for detail display?
		do
			Result := False
		end

	is_ratio: BOOLEAN is True
			-- Is current a ratio metric?

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR) is
			-- Process current using `a_visitor'.
		do
			a_visitor.process_ratio_metric (Current)
		end

feature -- Metric calculation

	value (a_scope: EB_METRIC_DOMAIN): QL_QUANTITY_DOMAIN is
			-- Calcualte current domain using `a_scope'.
		local
			l_num_metric: EB_METRIC
			l_den_metric: EB_METRIC
			l_den_value: QL_QUANTITY_DOMAIN
		do
			l_num_metric := manager.metric_with_name (numerator_metric_name)
			l_den_metric := manager.metric_with_name (denominator_metric_name)
			if should_result_be_filtered then
				l_num_metric.enable_filter_result
				l_den_metric.enable_filter_result
			else
				l_num_metric.disable_filter_result
				l_den_metric.disable_filter_result
			end
			l_den_value := l_den_metric.value (a_scope)
			if l_den_value.first.value = 0.0 then
				raise ("Devided by 0")
			else
				Result := l_num_metric.value (a_scope) / l_den_value
			end
		end

invariant
	numerator_metric_name_valid: numerator_metric_name /= Void
	denominator_metric_name_valid: denominator_metric_name /= Void

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
