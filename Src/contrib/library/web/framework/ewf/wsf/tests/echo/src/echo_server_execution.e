note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ECHO_SERVER_EXECUTION

inherit
	WSF_EXECUTION

create
	make

feature -- Execution

	execute
		local
			req: WSF_REQUEST; res: WSF_RESPONSE
			page: WSF_PAGE_RESPONSE
			l_body: STRING_8
		do
			req := request
			res := response
			create l_body.make (1024)
			create page.make_with_body (l_body)
			page.header.put_content_type_text_plain

			l_body.append ("REQUEST_METHOD=" + req.request_method + "%N")
			l_body.append ("REQUEST_URI=" + req.request_uri + "%N")
			l_body.append ("PATH_INFO=" + req.path_info + "%N")
			l_body.append ("QUERY_STRING=" + req.query_string + "%N")

			l_body.append ("Query parameters:%N")
			across
				req.query_parameters as q
			loop
				l_body.append ("%T"+ q.item.name + "=" + q.item.string_representation +"%N")
			end

			l_body.append ("Form parameters:%N")
			across
				req.form_parameters as q
			loop
				l_body.append ("%T"+ q.item.name + "=" + q.item.string_representation +"%N")
			end

			l_body.append ("Meta variables:%N")
			across
				req.meta_variables as q
			loop
				l_body.append ("%T"+ q.item.name + "=" + q.item.string_representation +"%N")
			end

			res.send (page)
		end

end
