indexing
	description: "Object to store archive information for one metric"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_ARCHIVE_NODE

inherit
	EB_METRIC_VISITABLE

	EB_METRIC_SHARED

create
	make

feature{NONE} -- Initialization

	make (a_metric_name: STRING; a_metric_type: INTEGER; a_time: DATE_TIME; a_value: DOUBLE; a_input: like input_domain) is
			-- Initialize `metric_name' with `a_metric_name', `metric_type' with `a_metric_type', `calculated_time' with `a_time',
			-- `value' with `a_value' and `input_domain' with `a_input'.
		require
			a_metric_name_attached: a_metric_name /= Void
			a_metric_type_valid: is_metric_type_valid (a_metric_type)
			a_time_attached: a_time /= Void
			a_input_attached: a_input /= Void
		do
			set_metric_name (a_metric_name)
			set_metric_type (a_metric_type)
			set_calculated_time (a_time)
			set_value (a_value)
			set_input_domain (a_input)
		end

feature -- Access

	metric_name: STRING
			-- Name of the archived metric

	metric_type: INTEGER
			-- Metric type

	calculated_time: DATE_TIME
			-- Time when current archive is calculated

	input_domain: EB_METRIC_DOMAIN
			-- Domain over which the metric is calcuated
			-- This is only used for display.

	value: DOUBLE
			-- Metric archive value

feature -- Setting

	set_metric_name (a_name: STRING) is
			-- Set `metric_name' with `a_name'.
		do
			create metric_name.make_from_string (a_name)
		ensure
			metric_name_set: metric_name /= Void and then metric_name.is_equal (a_name)
		end

	set_metric_type (a_type: INTEGER) is
			-- Set `metric_type' with `a_type'.
		require
			type_valid: is_metric_type_valid (a_type)
		do
			metric_type := a_type
		ensure
			metric_type_set: metric_type = a_type
		end

	set_calculated_time (a_time: like calculated_time) is
			-- Set `calculated_time' with `a_time'.
		require
			a_time_attached: a_time /= Void
		do
			calculated_time := a_time
		ensure
			calculated_time_set: calculated_time = a_time
		end

	set_input_domain (a_domain: like input_domain) is
			-- Set `input_domain' with `a_domain'.
		require
			a_domain_attached: a_domain /= Void
		do
			input_domain := a_domain
		ensure
			input_domain_set: input_domain = a_domain
		end

	set_value (a_value: DOUBLE) is
			--  Set `value 'with `a_value'.
		do
			value := a_value
		ensure
			value_set: value = a_value
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR) is
			-- Process current using `a_visitor'.
		do
			a_visitor.process_metric_archive_node (Current)
		end

invariant
	metric_name_attached: metric_name /= Void
	metric_type_valid: is_metric_type_valid (metric_type)
	calculated_time_attached: calculated_time /= Void
	input_domain_attached: input_domain /= Void

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
