note
	description: "{ORDER_HANDLER} handle the resources that we want to expose"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class	ORDER_HANDLER
inherit

	WSF_URI_TEMPLATE_HANDLER

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get,
			do_post,
			do_put,
			do_delete
		end

	SHARED_DATABASE_API

	SHARED_EJSON

	REFACTORING_HELPER

	SHARED_ORDER_VALIDATION

	WSF_SELF_DOCUMENTED_HANDLER

create
	make_with_router

feature {NONE} -- Initialization

	make_with_router (a_router: WSF_ROUTER)
			-- Initialize `router'.
		require
			a_router_attached: a_router /= Void
		do
			router := a_router
		ensure
			router_aliased: router = a_router
		end

feature -- Router

	router: WSF_ROUTER
			-- Associated router that could be used for advanced strategy

feature -- Execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler	
		do
			execute_methods (req, res)
		end

feature -- API DOC

	api_doc : STRING = "URI:/order METHOD: POST%N URI:/order/{orderid} METHOD: GET, PUT, DELETE%N"


feature -- Documentation

	mapping_documentation (m: WSF_ROUTER_MAPPING; a_request_methods: detachable WSF_REQUEST_METHODS): WSF_ROUTER_MAPPING_DOCUMENTATION
		do
			create Result.make (m)
			if a_request_methods /= Void then
				if a_request_methods.has_method_post then
					Result.add_description ("URI:/order METHOD: POST")
				elseif
					a_request_methods.has_method_get
					or a_request_methods.has_method_put
					or a_request_methods.has_method_delete
				then
					Result.add_description ("URI:/order/{orderid} METHOD: GET, PUT, DELETE")
				end
			end
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			id:  STRING
		do
			if attached req.path_info as l_path_info then
				id := get_order_id_from_path (l_path_info)
				if attached retrieve_order (id) as l_order then
					if is_conditional_get (req, l_order) then
						handle_resource_not_modified_response ("The resource" + l_path_info + "does not change", req, res)
					else
						compute_response_get (req, res, l_order)
					end
				else
					handle_resource_not_found_response ("The following resource" + l_path_info + " is not found ", req, res)
				end
			end
		end

	is_conditional_get (req : WSF_REQUEST; l_order : ORDER) : BOOLEAN
			-- Check if If-None-Match is present and then if there is a representation that has that etag
			-- if the representation hasn't changed, we return TRUE
			-- then the response is a 304 with no entity body returned.
		local
			etag_util : ETAG_UTILS
		do
			if attached req.meta_string_variable ("HTTP_IF_NONE_MATCH") as if_none_match then
				create etag_util
				if if_none_match.same_string (etag_util.md5_digest (l_order.out).as_string_32) then
					Result := True
				end
			end
		end

	compute_response_get (req: WSF_REQUEST; res: WSF_RESPONSE; l_order: ORDER)
		local
			h: HTTP_HEADER
			l_msg : STRING
			etag_utils : ETAG_UTILS
		do
			create h.make
			create etag_utils
			h.put_content_type_application_json
			if attached {JSON_VALUE} json.value (l_order) as jv then
				l_msg := jv.representation
				h.put_content_length (l_msg.count)
				if attached req.request_time as time then
					h.add_header ("Date:" + time.formatted_out ("ddd,[0]dd mmm yyyy [0]hh:[0]mi:[0]ss.ff2") + " GMT")
				end
				h.add_header ("etag:" + etag_utils.md5_digest (l_order.out))
				res.set_status_code ({HTTP_STATUS_CODE}.ok)
				res.put_header_text (h.string)
				res.put_string (l_msg)
			end
		end

	do_put (req: WSF_REQUEST; res: WSF_RESPONSE)
		-- Updating a resource with PUT
		-- A successful PUT request will not create a new resource, instead it will
		-- change the state of the resource identified by the current uri.
		-- If success we response with 200 and the updated order.
		-- 404 if the order is not found
		-- 400 in case of a bad request
		-- 500 internal server error
		-- If the request is a Conditional PUT, and it does not mat we response
		-- 415, precondition failed.
		local
			l_put: STRING
			l_order : detachable ORDER
			id :  STRING
		do
			if attached req.path_info as l_path_info then
				id := get_order_id_from_path (l_path_info)
				l_put := retrieve_data (req)
				l_order := extract_order_request(l_put)
				if  l_order /= Void and then db_access.orders.has_key (id) then
					l_order.set_id (id)
					if is_valid_to_update(l_order) then
						if is_conditional_put (req, l_order) then
							update_order( l_order)
							compute_response_put (req, res, l_order)
						else
							handle_precondition_fail_response ("", req, res)
						end
					else
						--| FIXME: Here we need to define the Allow methods
						handle_resource_conflict_response (l_put +"%N There is conflict while trying to update the order, the order could not be update in the current state", req, res)
					end
				else
					handle_bad_request_response (l_put +"%N is not a valid ORDER, maybe the order does not exist in the system", req, res)
				end
			end
		end

	is_conditional_put (req : WSF_REQUEST; order : ORDER) : BOOLEAN
		-- Check if If-Match is present and then if there is a representation that has that etag
		-- if the representation hasn't changed, we return TRUE
		local
			etag_util : ETAG_UTILS
		do
			if attached retrieve_order (order.id) as l_order then
				if attached req.meta_string_variable ("HTTP_IF_MATCH") as if_match then
						create etag_util
						if if_match.same_string (etag_util.md5_digest (l_order.out).as_string_32) then
							Result := True
						end
				else
					Result := True
				end
			end
		end


	compute_response_put (req: WSF_REQUEST; res: WSF_RESPONSE; l_order : ORDER)
		local
			h: HTTP_HEADER
			joc : JSON_ORDER_CONVERTER
			etag_utils : ETAG_UTILS
		do
			create h.make
			create joc.make
			create etag_utils
			json.add_converter(joc)

			create h.make
			h.put_content_type_application_json
			if attached req.request_time as time then
				h.add_header ("Date:" +time.formatted_out ("ddd,[0]dd mmm yyyy [0]hh:[0]mi:[0]ss.ff2") + " GMT")
			end
			h.add_header ("etag:" + etag_utils.md5_digest (l_order.out))
			if attached {JSON_VALUE} json.value (l_order) as jv then
				h.put_content_length (jv.representation.count)
				res.set_status_code ({HTTP_STATUS_CODE}.ok)
				res.put_header_text (h.string)
				res.put_string (jv.representation)
			end
		end


	do_delete (req: WSF_REQUEST; res: WSF_RESPONSE)
		-- Here we use DELETE to cancel an order, if that order is in state where
		-- it can still be canceled.
		-- 200 if is ok
		-- 404 Resource not found
		-- 405 if consumer and service's view of the resouce state is inconsisent
		-- 500 if we have an internal server error
		local
			id: STRING
		do
			if  attached req.path_info as l_path_info then
				id := get_order_id_from_path (l_path_info)
				if db_access.orders.has_key (id) then
					if is_valid_to_delete (id) then
						delete_order( id)
						compute_response_delete (req, res)
					else
						--| FIXME: Here we need to define the Allow methods
						handle_method_not_allowed_response (l_path_info + "%N There is conflict while trying to delete the order, the order could not be deleted in the current state", req, res)
					end
				else
					handle_resource_not_found_response (l_path_info + " not found in this server", req, res)
				end
			end
		end

	compute_response_delete (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			h : HTTP_HEADER
		do
			create h.make
			h.put_content_type_application_json
			if attached req.request_time as time then
				h.put_utc_date (time)
			end
			res.set_status_code ({HTTP_STATUS_CODE}.no_content)
			res.put_header_text (h.string)
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Here the convention is the following.
			-- POST is used for creation and the server determines the URI
			-- of the created resource.
			-- If the request post is SUCCESS, the server will create the order and will response with
			-- HTTP_RESPONSE 201 CREATED, the Location header will contains the newly created order's URI
			-- if the request post is not SUCCESS, the server will response with
			-- HTTP_RESPONSE 400 BAD REQUEST, the client send a bad request
			-- HTTP_RESPONSE 500 INTERNAL_SERVER_ERROR, when the server can deliver the request
		local
			l_post: STRING
		do
			l_post := retrieve_data (req)
			if attached extract_order_request (l_post) as l_order then
				save_order (l_order)
				compute_response_post (req, res, l_order)
			else
				handle_bad_request_response (l_post +"%N is not a valid ORDER", req, res)
			end
		end

	compute_response_post (req: WSF_REQUEST; res: WSF_RESPONSE; l_order : ORDER)
		local
			h: HTTP_HEADER
			l_msg : STRING
			l_location :  STRING
			joc : JSON_ORDER_CONVERTER
		do
			create h.make

			create joc.make
			json.add_converter(joc)

			h.put_content_type_application_json
			if attached {JSON_VALUE} json.value (l_order) as jv then
				l_msg := jv.representation
				h.put_content_length (l_msg.count)
				if attached req.http_host as host then
					l_location := "http://" + host + req.request_uri + "/" + l_order.id
					h.put_location (l_location)
				end
				if attached req.request_time as time then
					h.put_utc_date (time)
				end
				res.set_status_code ({HTTP_STATUS_CODE}.created)
				res.put_header_text (h.string)
				res.put_string (l_msg)
			end
		end

feature {NONE} -- URI helper methods

	get_order_id_from_path (a_path: READABLE_STRING_32) : STRING
		do
			Result := a_path.split ('/').at (3)
		end

feature {NONE} -- Implementation Repository Layer

	retrieve_order ( id : STRING) : detachable ORDER
			-- get the order by id if it exist, in other case, Void
		do
			Result := db_access.orders.item (id)
		end

	save_order (an_order: ORDER)
			-- save the order to the repository
		local
			i : INTEGER
		do
			from
				i := 1
			until
				not db_access.orders.has_key ((db_access.orders.count + i).out)
			loop
				i := i + 1
			end
			an_order.set_id ((db_access.orders.count + i).out)
			an_order.set_status ("submitted")
			an_order.add_revision
			db_access.orders.force (an_order, an_order.id)
		end


	is_valid_to_delete ( an_id : STRING)  : BOOLEAN
		-- Is the order identified by `an_id' in a state whre it can still be deleted?
		do
			if attached retrieve_order (an_id) as l_order then
				if order_validation.is_state_valid_to_update (l_order.status) then
					Result := True
				end
			end
		end

	is_valid_to_update (an_order: ORDER) : BOOLEAN
			-- Check if there is a conflict while trying to update the order
		do
			   	if attached retrieve_order (an_order.id) as l_order then
					if order_validation.is_state_valid_to_update (l_order.status) and then order_validation.is_valid_status_state (an_order.status) and then
					   order_validation.is_valid_transition (l_order, an_order.status) then
					 	Result := True
					end
				end
		end

	update_order (an_order: ORDER)
			-- update the order to the repository
		do
			an_order.add_revision
			db_access.orders.force (an_order, an_order.id)
		end

	delete_order (an_order: STRING)
			-- update the order to the repository
		do
			db_access.orders.remove (an_order)
		end

	extract_order_request (l_post : STRING) : detachable ORDER
			-- extract an object Order from the request, or Void
			-- if the request is invalid
		local
			parser : JSON_PARSER
			joc : JSON_ORDER_CONVERTER
		do
			create joc.make
			json.add_converter(joc)
			create parser.make_with_string (l_post)
			parser.parse_content
			if
				parser.is_valid and then
				attached parser.parsed_json_value as jv
			then
				if attached {like extract_order_request} json.object (jv, "ORDER") as res then
					Result := res
				end
			end
		end

note
	copyright: "2011-2015, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
