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
			name := a_name
			name.to_upper
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
		do

			buf.put_string (header_note)

			buf.put_new_line

			buf.put_string (class_kw)
			buf.indent
			buf.put_string (name)
			buf.unindent
			buf.put_new_line

			buf.put_string (inherit_kw)
			buf.indent
			buf.put_string (servlet_class)
			buf.unindent
			buf.put_new_line

			buf.put_string (create_kw)
			buf.indent
			buf.put_string (constructor_name)
			buf.unindent
			buf.put_new_line

			buf.put_string (feature_kw + " -- Initialization")
			buf.indent
			--make_feature.serialize (buf)
			write_make_feature (buf)
			buf.unindent
			buf.put_new_line

			buf.put_string (feature_kw + " {NONE} -- Access")
			buf.put_new_line
			buf.indent
			controller_variable.serialize (buf)
			buf.put_new_line
			buf.unindent

			buf.put_string (feature_kw + " -- Implementation")
			buf.put_new_line
			buf.indent
			write_request_feature (buf)
			buf.unindent

			buf.new_line

			buf.put_string (end_kw)
		end

	write_make_feature (buffer: INDENDATION_STREAM)
			-- Serializes the make feature of the {SERVLET}
		local
			make_feature: FEATURE_ELEMENT
			make_code: PLAIN_CODE_ELEMENT
			code_list: LIST [PLAIN_CODE_ELEMENT]
		do
			create make_code.make (create_kw + " " + controller_var + ".make")
			create {LINKED_LIST [PLAIN_CODE_ELEMENT]} code_list.make
			code_list.extend (make_code)
			create make_feature.make ("make", code_list)
			make_feature.serialize (buffer)
		end

	write_request_feature (buffer: INDENDATION_STREAM)
			-- Serializes the request feature of the {SERVLET}
		local
			request_feature: FEATURE_ELEMENT
			local_list: LIST [VARIABLE_ELEMENT]
			feature_elements: LIST [SERVLET_ELEMENT]
			content_make, result_equals: PLAIN_CODE_ELEMENT
		do
			create {LINKED_LIST [VARIABLE_ELEMENT]} local_list.make
			local_list.extend (response_variable)

			create content_make.make (create_kw + " " + response_name + ".make")
			create result_equals.make ("Result := " + response_name)

			create {LINKED_LIST [SERVLET_ELEMENT]} feature_elements.make
			feature_elements.extend (content_make)
			feature_elements.append (xhtml_elements)
			feature_elements.extend (result_equals)

			create request_feature.make_with_locals (request_name, feature_elements, local_list)

			request_feature.serialize (buffer)
		end

feature {NONE} -- Access

	class_kw: STRING = "class"
	feature_kw: STRING = "feature"
	inherit_kw: STRING = "inherit"
	create_kw: STRING = "create"
	local_kw: STRING = "local"
	do_kw: STRING = "do"
	end_kw: STRING = "end"
	controller_var: STRING = "controller"
	response_name: STRING = "response"
	constructor_name: STRING = "make"
	request_name: STRING = "handle_request (request: REQUEST): RESPONSE"

	response_type: STRING = "RESPONSE"

	servlet_class: STRING = "SERVLET"

	header_note: STRING = "[
note
	description: "Generated code!"
	author: "XEB Code Generation"
			]"

	newline: STRING = "%N"
	tab: STRING = "%T"
	newline_tab: STRING = "%N%T"

end
