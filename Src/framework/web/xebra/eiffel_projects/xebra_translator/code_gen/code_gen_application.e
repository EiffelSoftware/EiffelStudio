note
	description: "Summary description for {CODE_GEN_APPLICATION}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_GEN_APPLICATION

create
	make

feature -- Access

	make
		-- for testing
		local
			servlet: ROOT_SERVLET_ELEMENT
			list: LIST [OUTPUT_ELEMENT]
			list2: LIST [VARIABLE_ELEMENT]
			var: VARIABLE_ELEMENT
			oe: PLAIN_XHTML_ELEMENT
			buf: INDENDATION_STREAM
			name: STRING
		do
			name := "hello_world"
			create {ROOT_SERVLET_ELEMENT} servlet.make (name)
			create {LINKED_LIST[OUTPUT_ELEMENT]}list.make
			create {LINKED_LIST[VARIABLE_ELEMENT]}list2.make
			create var.make ("my_var", "STRING")
			create oe.make ("<html><body /> </html>")
			list.extend (oe)
			list2.extend (var)
			servlet.set_local_variables (list2)
			servlet.set_session_variables (list2)
			servlet.set_xhtml_elements (list)
			create buf.make_open_write ("/home/sandrod/workspace/xebra/eiffel_projects/xebra_translator/code_gen/" + name + ".e")
			buf.set_ind_character ('%T')
			servlet.serialize (buf)
			buf.close
		end

end
