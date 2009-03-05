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
			oe: PLAIN_XHTML_ELEMENT
			name: STRING
			controller_name: STRING
			call: CALL_ELEMENT
			op_call: OUTPUT_CALL_ELEMENT
			gen: WEBAPP_GENERATOR
		do
			name := "hello_world"
			controller_name := "MY_CONTROLLER"
			create {ROOT_SERVLET_ELEMENT} servlet.make (name, controller_name)
			create oe.make ("<html><body /> </html>")
			create op_call.make ("return_something")
			create call.make ("do_something")
			servlet.put_xhtml_elements (oe)
			servlet.put_xhtml_elements (call)
			servlet.put_xhtml_elements (op_call)

			create gen.make ("my_web_app")
			gen.put_servlet (servlet)
			gen.generate
		end
end
