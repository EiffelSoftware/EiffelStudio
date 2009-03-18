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

	root_tag: TAG_ELEMENT assign set_tag
			-- All tags which represent the page

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
		do
			root_tag := root
		end

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
			servlet.add_variable (create {VARIABLE_ELEMENT}.make ("root_tag", "TAG_SERIALIZER"))
			servlet.serialize (buf)
		end

	build_request_feature: FEATURE_ELEMENT
			-- Serializes the request feature of the {SERVLET}
		local
			feature_elements: LIST [SERVLET_ELEMENT]
		do
			create {LINKED_LIST [SERVLET_ELEMENT]} feature_elements.make

			feature_elements.extend (create {PLAIN_CODE_ELEMENT}.make ("create Result." + constructor_name))
			feature_elements.extend (create {PLAIN_CODE_ELEMENT}.make ("Result.text := root_tag.output (Current)"))

			create Result.make (request_name, feature_elements)
		end

	build_constructor_feature: FEATURE_ELEMENT
				-- Serializes the make feature of the {SERVLET}
			local
				make_code: PLAIN_CODE_ELEMENT
				code_list: LIST [PLAIN_CODE_ELEMENT]
				locals: LIST [VARIABLE_ELEMENT]
			do
				create make_code.make ("create " + controller_var + "." + constructor_name)
				create {LINKED_LIST [PLAIN_CODE_ELEMENT]} code_list.make
				create {LINKED_LIST [VARIABLE_ELEMENT]} locals.make
				code_list.extend (make_code)
				code_list.extend (create {PLAIN_CODE_ELEMENT}.make ("create stack.make (10)"))
				locals.extend (create {VARIABLE_ELEMENT}.make ("temp", "TAG_SERIALIZER"))
				locals.extend (create {VARIABLE_ELEMENT}.make ("stack", "ARRAYED_STACK [TAG_SERIALIZER]"))
				locals.extend (create {VARIABLE_ELEMENT}.make ("table", "HASH_TABLE [STRING, STRING]"))
				build_tag_tree_builder (code_list, root_tag, 0)

				create Result.make_with_locals ("make", code_list, locals)
			end

	build_tag_tree_builder (exprs: LIST [SERVLET_ELEMENT]; tag: TAG_ELEMENT; depth: NATURAL)
		local
			children: LIST [TAG_ELEMENT]
		do
			build_param_table (exprs, tag.parameters)
			exprs.extend (create {PLAIN_CODE_ELEMENT}.make ("create {" + tag.class_name + "} temp.make (table)"))
			if depth = 0 then
				exprs.extend (create {PLAIN_CODE_ELEMENT}.make ("root_tag := temp"))
			end
			exprs.extend (create {PLAIN_CODE_ELEMENT}.make ("stack.item.add_to_body (temp)"))

			if tag.has_children then
				exprs.extend (create {PLAIN_CODE_ELEMENT}.make ("stack.put (temp)"))
				children := tag.children
				from
					children.start
				until
					children.after
				loop
					build_tag_tree_builder (exprs, children.item, depth+1)
					children.forth
				end
				exprs.extend (create {PLAIN_CODE_ELEMENT}.make ("stack.remove"))
			end
		end

	build_param_table (exprs: LIST [SERVLET_ELEMENT]; params: HASH_TABLE [STRING, STRING])
		do
			exprs.extend (create {PLAIN_CODE_ELEMENT}.make ("create table.make(10)"))
			from
				params.start
			until
				params.after
			loop
				exprs.extend (create {PLAIN_CODE_ELEMENT}.make ("table.put(%"[%N"
					 + params.item_for_iteration + "%N]%"%N, %"" + params.key_for_iteration + "%")"))
				params.forth
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

