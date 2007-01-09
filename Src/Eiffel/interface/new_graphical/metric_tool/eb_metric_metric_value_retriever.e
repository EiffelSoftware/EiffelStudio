indexing
	description: "Value retriever to get metric value over a given domain"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_METRIC_VALUE_RETRIEVER

inherit
	EB_METRIC_VALUE_RETRIEVER
		redefine
			default_create
		end

	EB_METRIC_SHARED
		undefine
			default_create
		end

create
	default_create,
	make

feature{NONE} -- Initialization

	default_create is
			-- Process instances of classes with no creation clause.
			-- (Default: do nothing.)
		do
			metric_name := ""
			create input_domain.make
		end

	make (a_metric_name: like metric_name; a_input_domain: like input_domain) is
			-- Initialization `metric_name' with `a_metric_name' and `input_domain' with `a_input_domain'.
		require
			a_metric_name_attached: a_metric_name /= Void
			a_input_domain_attached: a_input_domain /= Void
		do
			set_metric_name (a_metric_name)
			set_input_domain (a_input_domain)
		ensure
			metric_name_set: metric_name.is_equal (a_metric_name)
			input_domain_set: input_domain = a_input_domain
		end

feature -- Access

	metric_name: STRING
			-- Name of the metric from which `value' is caluculated over `input_domain'

	input_domain: EB_METRIC_DOMAIN
			-- Input domain

	value: DOUBLE is
			-- Retrieved value
		do
			Result := metric_manager.metric_with_name (metric_name).value (input_domain).first.value
		end

	visitable_name: STRING_GENERAL is
			-- Name of current visitable item
		do
			Result := metric_names.visitable_name (metric_names.l_metric_value, metric_name)
		end

feature -- Status report

	is_retrievable: BOOLEAN is
			-- Is `value' retrievable?
		do
			Result := metric_manager.is_metric_calculatable (metric_name) and then input_domain.is_valid
		end

feature -- Setting

	set_metric_name (a_name: like metric_name) is
			-- Set `metric_name' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			create metric_name.make_from_string (a_name)
		ensure
			metric_name_set: metric_name.is_equal (a_name)
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

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR) is
			-- Process current using `a_visitor'.
		do
			a_visitor.process_metric_value_retriever (Current)
		end

invariant
	metric_name_attached: metric_name /= Void
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
