note
	description: "Summary description for {ROOT_SERVLET_ELEMENT}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	ROOT_SERVLET_ELEMENT

inherit
	SERVLET_ELEMENT

create
	make, make_with_elements

feature --Initialization

	make_with_elements  (a_name: STRING; a_controller_name: STRING; some_elements: LIST[OUTPUT_ELEMENT])
			-- `a_name': The name of the servlet
			-- `a_controller_name': The name of the controller class
			-- `some_elements': The elements which should be executed and written to the page
		do
			make (a_name, a_controller_name)
			xhtml_elements := some_elements
		end

	make (a_name: STRING; a_controller_name: STRING)
			-- `a_name': The name of the servlet
			-- `a_controller_name': The name of the controller class
		require
			name_is_valid: not a_name.is_empty
			controller_name_is_valid: not a_controller_name.is_empty
		do
			name := a_name + "_SERVLET"
			controller_name := a_controller_name
			create {LINKED_LIST [OUTPUT_ELEMENT]} xhtml_elements.make
			create controller_variable.make (controller_var, a_controller_name)
			create response_variable.make (response_name, "RESPONSE")
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

	response_variable: VARIABLE_ELEMENT
			-- Response variable

feature -- Access

	put_xhtml_elements (element: OUTPUT_ELEMENT)
			-- Adds an {OUTPUT_ELEMENT} to the list.
		do
			element.set_response_var (response_name)
			element.set_controller_var (controller_var)
			element.set_response_name (response_name)
			xhtml_elements.extend (element)
		end

feature -- Implementation

	serialize (buf: INDENDATION_STREAM)
			-- <Precursor>		
		local
			servlet: CLASS_ELEMENT
		do
			create servlet.make (name.as_upper)
			servlet.set_inherit (servlet_class)
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
			local_list: LIST [VARIABLE_ELEMENT]
			feature_elements: LIST [SERVLET_ELEMENT]
			content_make, result_equals: PLAIN_CODE_ELEMENT
		do
			create {LINKED_LIST [VARIABLE_ELEMENT]} local_list.make
			local_list.extend (response_variable)

			create content_make.make ("create " + response_name + "." + constructor_name)
			create result_equals.make ("Result := " + response_name)

			create {LINKED_LIST [SERVLET_ELEMENT]} feature_elements.make
			feature_elements.extend (content_make)
			feature_elements.append (xhtml_elements)
			feature_elements.extend (result_equals)

			create Result.make_with_locals (request_name, feature_elements, local_list)
		end

feature {NONE} -- Access

	controller_var: STRING = "controller"
	response_name: STRING = "response"
	constructor_name: STRING = "make"
	request_name: STRING = "handle_request (request: REQUEST): RESPONSE"

	response_type: STRING = "RESPONSE"

	servlet_class: STRING = "SERVLET"

end
