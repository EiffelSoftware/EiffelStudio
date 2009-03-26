note
	description: "[
			Element which renders a class that handles
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_SERVLET_ELEMENT

inherit
	SERVLET_ELEMENT

create
	make, make_with_elements

feature --Initialization

	make_with_elements  (a_name: STRING; a_controller_name: STRING; is_stateful: BOOLEAN; a_root_tag: like root_tag; some_elements: LIST[OUTPUT_ELEMENT])
			-- `a_name': The name of the servlet
			-- `a_controller_name': The name of the controller class
			-- `some_elements': The elements which should be executed and written to the page
		require
			a_name_is_not_emtpy: not a_name.is_empty
			a_controller_is_not_empty: not a_controller_name.is_empty
		do
			make (a_name, a_controller_name, stateful, a_root_tag)
			from
				some_elements.start
			until
				some_elements.after
			loop
				put_xhtml_elements (some_elements.item)
				some_elements.forth
			end
		end

	make (a_name: STRING; a_controller_name: STRING; is_stateful: BOOLEAN; a_root_tag: like root_tag)
			-- `a_name': The name of the servlet
			-- `a_controller_name': The name of the controller class
		require
			name_is_valid: not a_name.is_empty
			controller_name_is_valid: not a_controller_name.is_empty
		do
			name := a_name
			stateful := is_stateful
			controller_name := a_controller_name
			create {LINKED_LIST [OUTPUT_ELEMENT]} xhtml_elements.make
			create controller_variable.make (controller_var, a_controller_name)
			create {LINKED_LIST [STRING]}controller_calls.make
			root_tag := a_root_tag
		end

feature -- Access

	name: STRING
			-- Name of the page

	controller_name: STRING
			-- Name of the used controller class

	xhtml_elements: LIST [OUTPUT_ELEMENT]
			-- All elements which have to be displayed on the page
			-- Including controller calls and plain code

	controller_variable: VARIABLE_ELEMENT
			-- Controller variable	

	stateful: BOOLEAN
			-- Is the controller of the servlet stateful?

	root_tag: TAG_ELEMENT assign set_tag
			-- All tags which represent the page

	controller_calls: LIST [STRING] assign set_controller_calls
			-- All calls which should be available to the servlets

	controller_calls_with_result: LIST [STRING] assign set_controller_calls_with_result
			-- All calls which return something which should be available to the servlets

feature -- Element change

	put_xhtml_elements (element: OUTPUT_ELEMENT)
			-- Adds an {OUTPUT_ELEMENT} to the list.
		do
			element.set_response_var ("Result")
			element.set_controller_var (controller_var)
			element.set_response_name ("Result")
			xhtml_elements.extend (element)
		end

feature -- Implementation

	set_tag (root: TAG_ELEMENT)
			-- Sets the tag, which renders the page
		do
			root_tag := root
		end

	set_controller_calls (a_calls: LIST [STRING])
			-- Sets the caller functions
		do
			controller_calls := a_calls
		end

	set_controller_calls_with_result (a_calls: LIST [STRING])
			-- Sets the caller functions with result
		do
			controller_calls_with_result := a_calls
		end

	serialize (buf: INDENDATION_STREAM)
			-- <Precursor>		
		local
			servlet: CLASS_ELEMENT
		do
			create servlet.make (name.as_upper + "_SERVLET")
			if stateful then
				servlet.set_inherit (stateful_servlet_class)
			else
				servlet.set_inherit (stateless_servlet_class)
			end
			servlet.set_constructor_name (constructor_name)
			servlet.add_feature (build_constructor_feature)
			servlet.add_feature (build_request_feature)
			servlet.add_variable (controller_variable)
			servlet.add_variable (create {VARIABLE_ELEMENT}.make ("root_tag", "TAG_SERIALIZER"))
			servlet.serialize (buf)
		end

	build_request_feature: FEATURE_ELEMENT
			-- Serializes the request feature of the {SERVLET}
		do
			create Result.make (request_name)
			Result.append_expression ("create Result." + constructor_name)
			Result.append_expression ("root_tag.output (Current, Result.text)")
		end

	build_constructor_feature: FEATURE_ELEMENT
				-- Serializes the make feature of the {SERVLET}
			do
				create Result.make ("make")
				Result.append_expression ("create " + controller_var + "." + constructor_name)
				Result.append_expression ("create stack.make (10)")
				Result.append_local ("temp", "TAG_SERIALIZER")
				Result.append_local ("stack", "ARRAYED_STACK [TAG_SERIALIZER]")
				root_tag.build_tag_tree (Result, True)

				Result.append_expression ("create {HASH_TABLE [PROCEDURE [ANY, TUPLE], STRING]} controller_features.make (10)")
				from
					controller_calls.start
				until
					controller_calls.after
				loop
					Result.append_expression ("controller_features.put (agent "
						+ "controller." + controller_calls.item + ", %"" + controller_calls.item + "%")")
					controller_calls.forth
				end

				Result.append_expression ("create {HASH_TABLE [FUNCTION [ANY, TUPLE, STRING], STRING]} controller_features_with_result.make (10)")
				from
					controller_calls_with_result.start
				until
					controller_calls_with_result.after
				loop
					Result.append_expression ("controller_features_with_result.put (agent "
						+ "controller." + controller_calls_with_result.item + ", %"" + controller_calls_with_result.item + "%")")
					controller_calls_with_result.forth
				end
			end

feature {NONE} -- Access

	controller_var: STRING = "controller"
	constructor_name: STRING = "make"
	request_name: STRING = "handle_request (request: REQUEST): RESPONSE"

	response_type: STRING = "RESPONSE"

	stateful_servlet_class: STRING = "STATEFUL_SERVLET"
	stateless_servlet_class: STRING = "STATELESS_SERVLET"

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

