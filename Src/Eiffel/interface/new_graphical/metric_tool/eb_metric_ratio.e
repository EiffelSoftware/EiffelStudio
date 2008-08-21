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

	make (a_name: STRING; a_unit: like unit) is
			-- Initialize `name' with `a_name' and `unit' with `a_unit'.
		do
			Precursor (a_name, a_unit)
			numerator_metric_name := ""
			numerator_coefficient := 1
			denominator_coefficient := 1
			denominator_metric_name := ""
		end

	make_with_numerator_and_denominator (a_name: STRING; a_unit: like unit; a_num_name: STRING; a_den_name: STRING; a_num_coefficient: like numerator_coefficient; a_den_coefficient: like denominator_coefficient) is
			-- Initialize `name' with `a_name', `unit' with `a_unit', `uuid' with `a_uuid',
			-- `numerator_metric_name' with `a_num_name' and `denominator_metric_name' with `a_den_name'.
		require
			a_name_attached: a_name /= Void
			a_unit_attached: a_unit /= Void
			a_num_name_attached: a_num_name /= Void
			a_den_name_attached: a_den_name /= Void
		do
			make (a_name, a_unit)
			numerator_metric_name := a_num_name.twin
			denominator_metric_name := a_den_name.twin
			set_numerator_coefficient (a_num_coefficient)
			set_denominator_coefficient (a_den_coefficient)
		ensure
			numerator_metric_name_set: numerator_metric_name /= Void and then numerator_metric_name.is_equal (a_num_name)
			denominator_metric_name_set: denominator_metric_name /= Void and then denominator_metric_name.is_equal (a_den_name)
			numerator_coefficient_set: numerator_coefficient = a_num_coefficient
			denominator_coefficient_set: denominator_coefficient = a_den_coefficient
		end

feature -- Access

	numerator_metric_name: STRING
			-- Name of numerator metric

	denominator_metric_name: STRING
			-- Name of denominator metric

	numerator_coefficient: DOUBLE
			-- Coefficient for numerator metric

	denominator_coefficient: DOUBLE
			-- Coefficient for denominator metric

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

	set_denominator_metric_name (a_name: STRING) is
			-- Set `denominator_metric_name' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			denominator_metric_name := a_name.twin
		ensure
			denominator_metric_name_set: denominator_metric_name /= Void and then denominator_metric_name.is_equal (a_name)
		end

	set_numerator_coefficient (a_coefficient: like numerator_coefficient) is
			-- Set `numerator_coefficient' with `a_coefficient'.
		do
			numerator_coefficient := a_coefficient
		ensure
			numerator_coefficient_set: numerator_coefficient = a_coefficient
		end

	set_denominator_coefficient (a_coefficient: like denominator_coefficient) is
			-- Set `denominator_coefficient' with `a_coefficient'.
		do
			denominator_coefficient := a_coefficient
		ensure
			denominator_coefficient_set: denominator_coefficient = a_coefficient
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
			-- Value of current metric calculated over `a_scope'
		local
			l_num_metric: EB_METRIC
			l_den_metric: EB_METRIC
			l_den_value: DOUBLE
			l_unicode_ex: UNICODE_MESSAGE_EXCEPTION
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
			if denominator_coefficient =0.0 then
				create l_unicode_ex
				l_unicode_ex.set_unicode_message (metric_names.err_divided_by_zero)
				l_unicode_ex.raise
			else
				l_den_value := l_den_metric.value_item (a_scope)
				if l_den_value = 0.0 then
					create l_unicode_ex
					l_unicode_ex.set_unicode_message (metric_names.err_divided_by_zero)
					l_unicode_ex.raise
				else
					create Result.make
					Result.extend (create {QL_QUANTITY}.make_with_value ((numerator_coefficient * (l_num_metric.value_item (a_scope))) /  (denominator_coefficient * l_den_value)))
				end
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
