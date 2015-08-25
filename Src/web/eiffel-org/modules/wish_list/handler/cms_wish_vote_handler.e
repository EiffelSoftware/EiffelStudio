note
	description: "Summary description for {CMS_WISH_VOTE_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_WISH_VOTE_HANDLER

inherit

	CMS_WISH_LIST_ABSTRACT_HANDLER

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get,
			do_post
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

feature -- Query

	wish_id_path_parameter (req: WSF_REQUEST): INTEGER_64
			-- Wish id passed as path parameter for request `req'.
		local
			s: STRING
		do
			if attached {WSF_STRING} req.path_parameter ("id") as p_nid then
				s := p_nid.value
				if s.is_integer_64 then
					Result := s.to_integer_64
				end
			end
		end

feature -- HTTP methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_message: STRING
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if attached r.user as l_user then
				if req.percent_encoded_path_info.ends_with_general ("/like") then
						-- like
					wish_api.add_wish_like (l_user, wish_id_path_parameter (req))
				elseif req.percent_encoded_path_info.ends_with_general ("/not_like") then
						-- not_like
					wish_api.add_wish_not_like (l_user, wish_id_path_parameter (req))
				end
			end
			r.set_status_code ({HTTP_STATUS_CODE}.found)
			r.set_redirection (req.absolute_script_url ("/resources/wish_list"))
			r.execute
		end


	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			l_message: STRING
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			if attached r.user as l_user then
				if req.percent_encoded_path_info.ends_with_general ("/like") then
						-- like
					wish_api.add_wish_like (l_user, wish_id_path_parameter (req))
				elseif req.percent_encoded_path_info.ends_with_general ("/not_like") then
						-- not_like
					wish_api.add_wish_not_like (l_user, wish_id_path_parameter (req))
				end
			end
			r.set_status_code ({HTTP_STATUS_CODE}.found)
			r.set_redirection (req.absolute_script_url ("/resources/wish_list"))
			r.execute
		end


end
