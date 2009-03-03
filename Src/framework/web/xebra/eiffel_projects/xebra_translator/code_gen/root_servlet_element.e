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
	make

feature --Initialization

	make (a_name: STRING)
			-- `a_name': The name of the servlet
		do
			name := a_name
			name.to_upper
			create {LINKED_LIST [OUTPUT_ELEMENT]} xhtml_elements.make
			create {LINKED_LIST [VARIABLE_ELEMENT]} session_variables.make
			create {LINKED_LIST [VARIABLE_ELEMENT]} local_variables.make
		end

feature -- Access

	name: STRING

	xhtml_elements: LIST [OUTPUT_ELEMENT]

	session_variables: LIST [VARIABLE_ELEMENT]

	local_variables: LIST [VARIABLE_ELEMENT]

feature -- Access

	set_xhtml_elements (elements: LIST [OUTPUT_ELEMENT])
		do
			xhtml_elements := elements
		end

	set_session_variables (elements: LIST [VARIABLE_ELEMENT])
		do
			session_variables := elements
		end

	set_local_variables (elements: LIST [VARIABLE_ELEMENT])
		do
			local_variables := elements
		end

	put_xhtml_elements (element: OUTPUT_ELEMENT)
		do
			xhtml_elements.put (element)
		end

	put_session_variables (element: VARIABLE_ELEMENT)
		do
			session_variables.put (element)
		end

	put_local_variables (element: VARIABLE_ELEMENT)
		do
			local_variables.put (element)
		end

	response_name: STRING = "response"

feature {NONE} -- Access

	class_kw: STRING = "class"
	feature_kw: STRING = "feature"
	inherit_kw: STRING = "inherit"
	create_kw: STRING = "create"
	local_kw: STRING = "local"
	do_kw: STRING = "do"
	end_kw: STRING = "end"
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

feature -- Implementation

	serialize (buf: INDENDATION_STREAM)
			-- <Precursor>
		local
			make_element: CREATE_FEATURE_ELEMENT
			ind: NATURAL
		do
			create make_element.make (constructor_name)
			ind := 1

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

			buf.put_string (feature_kw + "-- Access")
			buf.put_new_line
			buf.indent
			write_session_variables (buf)
			buf.unindent

			buf.put_string (feature_kw + "-- Implementation")
			buf.put_new_line
			buf.indent
			write_request_feature (buf, ind)
			buf.unindent

			buf.new_line

			buf.put_string (end_kw)
		end

	write_session_variables (buffer: INDENDATION_STREAM)
			-- writes the session variables as features of the servlet
		local
			var: VARIABLE_ELEMENT
		do
			from
				session_variables.start
			until
				session_variables.after
			loop
				var := session_variables.item
				var.serialize (buffer)
				buffer.put_new_line
				session_variables.forth
			end
		end

	write_request_feature (buffer: INDENDATION_STREAM; indendation: NATURAL)
			-- writes the session variables as features of the servlet
		local
			var: VARIABLE_ELEMENT
			xhtml_element: OUTPUT_ELEMENT
		do
			buffer.put_string (request_name)
			buffer.indent
			buffer.put_string (local_kw)
			buffer.indent
			from
				local_variables.start
			until
				local_variables.after
			loop
				var := local_variables.item
				var.serialize (buffer)
				local_variables.forth
			end
			buffer.put_string (response_name + ": " + response_type)
			buffer.unindent
			buffer.put_string (do_kw)
			buffer.indent
			buffer.put_string (create_kw + " " + response_name + ".make")
			from
				xhtml_elements.start
			until
				xhtml_elements.after
			loop
				xhtml_element := xhtml_elements.item
				xhtml_element.serialize (buffer)
				xhtml_elements.forth
			end
			buffer.put_string ("Result := " + response_name)
			buffer.unindent
			buffer.put_string (end_kw)
			buffer.unindent
		end

end
