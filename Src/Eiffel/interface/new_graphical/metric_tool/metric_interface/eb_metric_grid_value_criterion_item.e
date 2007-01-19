indexing
	description: "[
					Grid item used to manage a value criterion
					Two generics are used to define the associated value criterion:
					the first generic is metric name,
					the second generic is value tester.
					]"

	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_GRID_VALUE_CRITERION_ITEM

inherit
	EB_METRIC_GRID_DOMAIN_ITEM [TUPLE [STRING, BOOLEAN, EB_METRIC_VALUE_TESTER]]
		redefine
			make,
			prepare_components,
			is_pebble_droppable,
			drop_pebble
		end

	EB_SHARED_WRITER
		undefine
			copy,
			default_create
		end

create
	make

feature{NONE} -- Initialization

	make (a_domain: EB_METRIC_DOMAIN) is
			-- Initialize.
		do
			value := ["", False, create {EB_METRIC_VALUE_TESTER}.make]
			Precursor (a_domain)
		end

feature -- Status report

	is_pebble_droppable (a_pebble: ANY): BOOLEAN is
			-- Can `a_pebble' be dropped on Current?
		local
			l_metric: EB_METRIC
		do
			Result := Precursor (a_pebble)
			if not Result then
				l_metric ?= a_pebble
				Result := l_metric /= Void
			end
		end

feature -- Drop

	drop_pebble (a_pebble: ANY) is
			-- Drop `a_pebble' into Current.
		local
			l_metric: EB_METRIC
			l_value: like value
		do
			l_metric ?= a_pebble
			if l_metric /= Void then
				l_value := value
				if l_value = Void then
					l_value := [l_metric.name, False, create {EB_METRIC_VALUE_TESTER}.make]
				else
					l_value.put (l_metric.name, 1)
				end
				set_value (l_value)
			else
				Precursor (a_pebble)
			end
		end

feature{NONE} -- Implementation

	prepare_components is
			-- Prepare components for display.
		local
			l_tester: EB_METRIC_VALUE_TESTER
			l_metric_name: STRING
			l_tokens: LINKED_LIST [EDITOR_TOKEN]
			l_value: like value
			l_writer: like token_writer
		do
			create l_tokens.make
			l_writer := token_writer
			l_writer.set_context_group (Void)
			l_value := value
			l_metric_name ?= l_value.item (1)
			if l_metric_name = Void then
				l_metric_name := ""
			end
			l_tester ?= l_value.item (3)
			if l_tester = Void then
				create l_tester.make
			end

				-- Prepare the value tester part			
			editor_token_output.wipe_out
			expression_generator.generate_output (l_tester)
			l_tokens.append (editor_token_output.generated_output)

				-- Prepare metric part
			l_writer.new_line
			if not l_tokens.is_empty then
				l_writer.add (ti_space)
				l_writer.add (ti_comma)
			end
			if metric_manager.is_metric_calculatable (l_metric_name) then
				l_writer.add (ti_double_quote + l_metric_name + ti_double_quote)
			else
				l_writer.add_error (create {SYNTAX_ERROR}.init, ti_double_quote + l_metric_name + ti_double_quote)
			end
			if not domain.is_empty then
				l_writer.add (ti_comma)
			end
			l_tokens.append (l_writer.last_line.content)
			append_new_item (create {EB_GRID_EDITOR_TOKEN_COMPONENT}.make (l_tokens, 2))

				-- Prepare input domain part.
			if not domain.is_empty then
				components_for_domain.do_all (agent append_new_item)
			end
		end

	expression_generator: EB_METRIC_EXPRESSION_GENERATOR is
			-- Expression generator to generate editor editor output for current item
		once
			create Result.make (editor_token_output)
		ensure
			result_attached: Result /= Void
		end

	editor_token_output: EB_METRIC_EXPRESSION_EDITOR_TOKEN_OUTPUT is
			-- Output from `expression_generator'
		once
			create Result.make (token_writer)
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
