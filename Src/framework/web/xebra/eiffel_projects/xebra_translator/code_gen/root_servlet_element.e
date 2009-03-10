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

	make_with_elements  (a_name: STRING; a_controller_name: STRING; is_stateful: BOOLEAN; some_elements: LIST[OUTPUT_ELEMENT])
			-- `a_name': The name of the servlet
			-- `a_controller_name': The name of the controller class
			-- `some_elements': The elements which should be executed and written to the page
		do
			make (a_name, a_controller_name, stateful)
			from
				some_elements.start
			until
				some_elements.after
			loop
				put_xhtml_elements (some_elements.item)
				some_elements.forth
			end
		end

	make (a_name: STRING; a_controller_name: STRING; is_stateful: BOOLEAN)
			-- `a_name': The name of the servlet
			-- `a_controller_name': The name of the controller class
		require
			name_is_valid: not a_name.is_empty
			controller_name_is_valid: not a_controller_name.is_empty
		do
			name := a_name + "_SERVLET"
			stateful := is_stateful
			controller_name := a_controller_name
			create {LINKED_LIST [OUTPUT_ELEMENT]} xhtml_elements.make
			create controller_variable.make (controller_var, a_controller_name)
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

	serialize (buf: INDENDATION_STREAM)
			-- <Precursor>		
		local
			servlet: CLASS_ELEMENT
		do
			create servlet.make (name.as_upper)
			if stateful then
				servlet.set_inherit (stateful_servlet_class)
			else
				servlet.set_inherit (stateless_servlet_class)
			end
			servlet.set_constructor_name (constructor_name)
			servlet.add_feature (build_constructor_feature)
			servlet.add_feature (build_request_feature)
			servlet.add_variable (controller_variable)
			servlet.serialize (buf)
		end

	build_constructor_feature: FEATURE_ELEMENT
			-- Serializes the make feature of the {SERVLET}
		local
			make_code: PLAIN_CODE_ELEMENT
			code_list: LIST [PLAIN_CODE_ELEMENT]
		do
			create make_code.make ("create " + controller_var + "." + constructor_name)
			create {LINKED_LIST [PLAIN_CODE_ELEMENT]} code_list.make
			code_list.extend (make_code)
			create Result.make ("make", code_list)
		end

	build_request_feature: FEATURE_ELEMENT
			-- Serializes the request feature of the {SERVLET}
		local
			feature_elements: LIST [SERVLET_ELEMENT]
		do
			create {LINKED_LIST [SERVLET_ELEMENT]} feature_elements.make
			feature_elements.extend (create {PLAIN_CODE_ELEMENT}.make ("create Result." + constructor_name))
			feature_elements.append (xhtml_elements)

			create Result.make (request_name, feature_elements)
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
