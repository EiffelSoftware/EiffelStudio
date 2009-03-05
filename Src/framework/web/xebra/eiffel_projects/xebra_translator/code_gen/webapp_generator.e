note
	description: "Summary description for {WEBAPP_GENERATOR}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

class
	WEBAPP_GENERATOR

create
	make

feature -- Access

	webapp_name: STRING

	servlets: LIST [ROOT_SERVLET_ELEMENT]
			-- All the parsed servlets

	put_servlet (servlet: ROOT_SERVLET_ELEMENT)
			-- Adds a servlet to the list
		do
			servlets.extend (servlet)
		end

feature -- Initialization

	make (a_name: STRING)
			-- `a_name': The name of the web application
		do
			webapp_name := a_name
			create {LINKED_LIST [ROOT_SERVLET_ELEMENT]} servlets.make
		end

feature -- Processing

	generate
			-- Generates all the classes for the webapp and links them together.
			--  1. {SERVLET} for every xeb-page
			--  2. {REQUEST_HANDLER}
			--  3. {APPLICATION} which starts the application
		local
			buf: INDENDATION_STREAM
			servlet: ROOT_SERVLET_ELEMENT
			request_class: CLASS_ELEMENT
			application_class: CLASS_ELEMENT
		do
				-- Generate all the {SERVLET} classes
			from
				servlets.start
			until
				servlets.after
			loop
				servlet := servlets.item
				create buf.make_open_write ("code_gen/generated/" + servlet.name.as_lower + ".e")
				buf.set_ind_character ('%T')
				servlet.serialize (buf)
				servlets.forth
				buf.close
			end

				-- Generate the {REQUEST_HANDLER} class
			webapp_name.to_lower
			create buf.make_open_write ("code_gen/generated/" + webapp_name + "_request_handler.e")
			buf.set_ind_character ('%T')
			webapp_name.to_upper
			create request_class.make (webapp_name + "_REQUEST_HANDLER")
			request_class.set_inherit ("REQUEST_HANDLER")
			request_class.set_constructor_name ("make")
			request_class.add_feature (generate_constructor_for_request_handler (servlets))
			request_class.serialize (buf)
			buf.close

				-- Generate the {APPLICATION} class
			create buf.make_open_write ("code_gen/generated/" + webapp_name.as_lower + "_application.e")
			buf.set_ind_character ('%T')
			create application_class.make (webapp_name.as_upper + "_APPLICATION")
			application_class.serialize (buf)
			buf.close

		end

	generate_constructor_for_request_handler (some_servlets: LIST [ROOT_SERVLET_ELEMENT]): FEATURE_ELEMENT
			-- Generates the constructor for the request handler
		local
			constructor: FEATURE_ELEMENT
			feature_body: LIST [SERVLET_ELEMENT]
			servlet: ROOT_SERVLET_ELEMENT
			locals: LIST [VARIABLE_ELEMENT]
			servlet_local: VARIABLE_ELEMENT
		do
			create {LINKED_LIST [SERVLET_ELEMENT]} feature_body.make
			feature_body.extend (wrap ("create {HASH_TABLE [SERVLET, STRING]} servlets.make"))
			from
				some_servlets.start
			until
				some_servlets.after
			loop
				servlet := some_servlets.item
				feature_body.extend (wrap ("create {" + servlet.name.as_upper + "_SERVLET} servlet.make"))
				feature_body.extend (wrap ("servlets.put (servlet, %"" + servlet.name.as_upper + "%")"))
				some_servlets.forth
			end
			create servlet_local.make ("servlet", "SERVLET")
			create {LINKED_LIST [VARIABLE_ELEMENT]} locals.make
			locals.extend (servlet_local)
			create constructor.make_with_locals ("make", feature_body, locals)
			Result := constructor
		end

	wrap (code: STRING): PLAIN_CODE_ELEMENT
		do
			create Result.make (code)
		end

end
