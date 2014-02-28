note
	description: "[
		Class to handle negotiation failures for a given resource
		Return status code 406 Not Acceptable
]"
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_NULL_REPRESENTATION_HANDLER

inherit

	ESA_REPRESENTATION_HANDLER

	REFACTORING_HELPER

create
	make

feature -- View

	home_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Home page representation.
		do
			generic_response (req, res)
		end

	problem_report (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			generic_response (req, res)
		end

	problem_reports_guest  (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		do
			generic_response (req, res)
		end


	problem_user_reports  (req: WSF_REQUEST; res: WSF_RESPONSE)
		-- <Precursor>
		do
			generic_response (req, res)
		end

	not_found_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Not found page.
		do
			generic_response (req, res)
		end

	logout_page (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Not found page
		do
		end

feature -- Response

	new_response_get (req: WSF_REQUEST; res: WSF_RESPONSE; output: STRING)
		local
			h: HTTP_HEADER
			l_msg: STRING
			hdate: HTTP_DATE
		do
			create h.make
			create l_msg.make_from_string (output)
			h.put_content_type_text_html
			h.put_content_length (l_msg.count)
			if attached req.request_time as time then
				create hdate.make_from_date_time (time)
				h.add_header ("Date:" + hdate.rfc1123_string)
			end
			res.set_status_code ({HTTP_STATUS_CODE}.not_acceptable)
			res.put_header_text (h.string)
			res.put_string (l_msg)
		end


	generic_response (req: WSF_REQUEST; res: WSF_RESPONSE)
			local
				l_np: HTML_406_PAGE
			do
				if attached req.http_host as l_host then
					create l_np.make ("http://"+l_host,req.path_info,req.http_accept)
					if attached l_np.representation as l_406_page then
						new_response_get (req, res, l_406_page)
					end
				end
			end

end
