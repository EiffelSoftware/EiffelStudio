note
	description: "{ORDER_HANDLER} handle the resources that we want to expose"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class	ORDER_HANDLER

inherit

	WSF_SKELETON_HANDLER

	SHARED_DATABASE_API

	SHARED_EJSON

	REFACTORING_HELPER

	SHARED_ORDER_VALIDATION

	WSF_RESOURCE_HANDLER_HELPER
		rename
			execute_options as helper_execute_options,
			handle_internal_server_error as helper_handle_internal_server_error
		end

create

	make_with_router


feature -- Execution variables

	Order_execution_variable: STRING = "ORDER"
			-- Execution variable used by application

	Generated_content_execution_variable: STRING = "GENERATED_CONTENT"
			-- Execution variable used by application

	Extracted_order_execution_variable: STRING = "EXTRACTED_ORDER"
			-- Execution variable used by application

feature -- Documentation

	description: READABLE_STRING_GENERAL
			-- General description for self-generated documentation;
			-- The specific URI templates supported will be described automatically
		do
			Result :=  "Create, Read, Update or Delete an ORDER."
		end

feature -- Access

	is_chunking (req: WSF_REQUEST): BOOLEAN
		-- Will the response to `req' using chunked transfer encoding?
		do
			-- No.
		end

	includes_response_entity (req: WSF_REQUEST): BOOLEAN
			-- Does the response to `req' include an entity?
			-- Method will be DELETE, POST, PUT or an extension method.
		do
			Result := False
			-- At present, there is no support for this except for DELETE.
		end

	conneg (req: WSF_REQUEST): CONNEG_SERVER_SIDE
			-- Content negotiatior for all requests
		once
			create Result.make ({HTTP_MIME_TYPES}.application_json, "en", "UTF-8", "identity")
		end

	mime_types_supported (req: WSF_REQUEST): LIST [STRING]
			-- All values for Accept header that `Current' can serve
		do
			create {ARRAYED_LIST [STRING]} Result.make_from_array (<<{HTTP_MIME_TYPES}.application_json>>)
			Result.compare_objects
		end

	languages_supported (req: WSF_REQUEST): LIST [STRING]
			-- All values for Accept-Language header that `Current' can serve
		do
			create {ARRAYED_LIST [STRING]} Result.make_from_array (<<"en">>)
			Result.compare_objects
		end

	charsets_supported (req: WSF_REQUEST): LIST [STRING]
			-- All values for Accept-Charset header that `Current' can serve
		do
			create {ARRAYED_LIST [STRING]} Result.make_from_array (<<"UTF-8">>)
			Result.compare_objects
		end

	encodings_supported (req: WSF_REQUEST): LIST [STRING]
			-- All values for Accept-Encoding header that `Current' can serve
		do
			create {ARRAYED_LIST [STRING]} Result.make_from_array (<<"identity">>)
			Result.compare_objects
		end

	max_age (req: WSF_REQUEST): NATURAL
			-- Maximum age in seconds before response to `req` is considered stale;
			-- This is used to generate a Cache-Control: max-age header.
			-- Return 0 to indicate already expired.
			-- Return Never_expires to indicate never expires.
		do
			-- All our responses are considered stale.
		end

	is_freely_cacheable (req: WSF_REQUEST): BOOLEAN
			-- Should the response to `req' be freely cachable in shared caches?
			-- If `True', then a Cache-Control: public header will be generated.
		do
			-- definitely not!
		end

	private_headers (req: WSF_REQUEST): detachable LIST [READABLE_STRING_8]
			-- Header names intended for a single user.
			-- If non-Void, then a Cache-Control: private header will be generated.
			-- Returning an empty list prevents the entire response from being served from a shared cache.
		do
			create {ARRAYED_LIST [READABLE_STRING_8]} Result.make (0)
		end

	non_cacheable_headers (req: WSF_REQUEST): detachable LIST [READABLE_STRING_8]
			-- Header names that will not be sent from a cache without revalidation;
			-- If non-Void, then a Cache-Control: no-cache header will be generated.
			-- Returning an empty list prevents the response being served from a cache
			--  without revalidation.
		do
			create {ARRAYED_LIST [READABLE_STRING_8]} Result.make (0)
		end

	is_sensitive (req: WSF_REQUEST): BOOLEAN
			-- Is the response to `req' of a sensitive nature?
			-- If `True' then a Cache-Control: no-store header will be generated.
		do
			Result := True
			-- since it's commercial data.
		end

	matching_etag (req: WSF_REQUEST; a_etag: READABLE_STRING_32; a_strong: BOOLEAN): BOOLEAN
			-- Is `a_etag' a match for resource requested in `req'?
			-- If `a_strong' then the strong comparison function must be used.
		local
			l_id: STRING
			l_etag_util: ETAG_UTILS
		do
			l_id := order_id_from_request (req)
			if db_access.orders.has_key (l_id) then
				check attached db_access.orders.item (l_id) as l_order then
						-- postcondition of `has_key'
					create l_etag_util
					Result := a_etag.same_string (l_etag_util.md5_digest (l_order.out).as_string_32)
				end
			end
		end

	etag (req: WSF_REQUEST): detachable READABLE_STRING_8
			-- Optional Etag for `req' in the requested variant
		local
			l_etag_utils: ETAG_UTILS
		do
			create l_etag_utils
			if attached {ORDER} req.execution_variable (Order_execution_variable) as l_order then
				Result := l_etag_utils.md5_digest (l_order.out)
			end
		end

	modified_since (req: WSF_REQUEST; a_date_time: DATE_TIME): BOOLEAN
			-- Has resource requested in `req' been modified since `a_date_time' (UTC)?
		do
			-- We don't track this information. It is safe to always say yes.
			Result := True
		end

feature -- Measurement

	content_length (req: WSF_REQUEST): NATURAL
			-- Length of entity-body of the response to `req'
		do
			check attached {READABLE_STRING_8} req.execution_variable (Generated_content_execution_variable) as l_response then
					-- postcondition generated_content_set_for_get_head of `ensure_content_available'
					-- We only call this for GET/HEAD in this example.
				Result := l_response.count.as_natural_32
			end
		end

	allow_post_to_missing_resource (req: WSF_REQUEST): BOOLEAN
			-- The resource named in `req' does not exist, and this is a POST. Do we allow it?
		do
			-- No.
		end

feature -- Status report

	finished (req: WSF_REQUEST): BOOLEAN
			-- Has the last chunk been generated for `req'?
		do
			-- precondition is never met
		end

feature -- Execution

	check_resource_exists (req: WSF_REQUEST; a_helper: WSF_METHOD_HELPER)
			-- Call `a_helper.set_resource_exists' to indicate that `req.path_translated'
			--  is the name of an existing resource.
			-- We also put the order into `req.execution_variable (Order_execution_variable)' for GET or HEAD responses.
		local
			l_id: STRING
		do
			if req.is_post_request_method then
				a_helper.set_resource_exists
				-- because only /order is defined to this handler for POST
			else
				-- the request is of the form /order/{orderid}
				l_id := order_id_from_request (req)
				if db_access.orders.has_key (l_id) then
					a_helper.set_resource_exists
					if req.is_get_head_request_method then
						check attached db_access.orders.item (l_id) as l_order then
								-- postcondition `item_if_found' of `has_key'
							req.set_execution_variable (Order_execution_variable, l_order)
						end
					end
				end
			end
		ensure then
			order_saved_only_for_get_head: req.is_get_head_request_method =
				attached {ORDER} req.execution_variable (Order_execution_variable)
		end

feature -- GET/HEAD content

	ensure_content_available (req: WSF_REQUEST)
			-- Commence generation of response text (entity-body).
			-- If not chunked, then this will create the entire entity-body so as to be available
			--  for a subsequent call to `content'.
			-- If chunked, only the first chunk will be made available to `next_chunk'. If chunk extensions
			--  are used, then this will also generate the chunk extension for the first chunk.
			-- We save the text in `req.execution_variable (Generated_content_execution_variable)'
			-- We ignore the results of content negotiation, as there is only one possible combination.
		do
			check attached {ORDER} req.execution_variable (Order_execution_variable) as l_order then
					-- precondition get_or_head and postcondition order_saved_only_for_get_head of `check_resource_exists' and
				if attached {JSON_VALUE} json.value (l_order) as jv then
					req.set_execution_variable (Generated_content_execution_variable, jv.representation)
				else
					req.set_execution_variable (Generated_content_execution_variable, "")
				end
			end
		ensure then
			generated_content_set_for_get_head: req.is_get_head_request_method implies
				 attached {READABLE_STRING_8} req.execution_variable (Generated_content_execution_variable)
		end

	content (req: WSF_REQUEST): READABLE_STRING_8
			-- Non-chunked entity body in response to `req';
			-- We only call this for GET/HEAD in this example.
		do
			check attached {READABLE_STRING_8} req.execution_variable (Generated_content_execution_variable) as l_response then
					-- postcondition generated_content_set_for_get_head of `ensure_content_available'
				Result := l_response
			end
		end

		next_chunk (req: WSF_REQUEST): TUPLE [a_chunk: READABLE_STRING_8; a_extension: detachable READABLE_STRING_8]
			-- Next chunk of entity body in response to `req';
			-- The second field of the result is an optional chunk extension.
		do
			-- precondition `is_chunking' is never met, but we need a dummy `Result'
			-- to satisfy the compiler in void-safe mode
			Result := ["", Void]
		end

	generate_next_chunk (req: WSF_REQUEST)
			-- Prepare next chunk (including optional chunk extension) of entity body in response to `req'.
			-- This is not called for the first chunk.
		do
			-- precondition `is_chunking' is never met
		end

feature -- DELETE

	delete (req: WSF_REQUEST)
			-- Delete resource named in `req' or set an error on `req.error_handler'.
		local
			l_id: STRING
		do
			l_id := order_id_from_request (req)
			if db_access.orders.has_key (l_id) then
				if is_valid_to_delete (l_id) then
					delete_order (l_id)
				else
					req.error_handler.add_custom_error ({HTTP_STATUS_CODE}.method_not_allowed, "DELETE not valid",
						"There is conflict while trying to delete the order, the order could not be deleted in the current state")
				end
			else
				req.error_handler.add_custom_error ({HTTP_STATUS_CODE}.not_found, "DELETE not valid",
					"There is no such order to delete")
			end
		end

	delete_queued (req: WSF_REQUEST): BOOLEAN
			-- Has resource named by `req' been queued for deletion?
		do
			-- No
		end


feature -- PUT/POST

	is_entity_too_large (req: WSF_REQUEST): BOOLEAN
			-- Is the entity stored in `req.execution_variable (Request_entity_execution_variable)' too large for the application?
		do
			-- No. We don't care for this example.
		end

	check_content_headers (req: WSF_REQUEST)
			-- Check we can support all content headers on request entity.
			-- Set `req.execution_variable (Content_check_code_execution_variable)' to {NATURAL} zero if OK, or 415 or 501 if not.
		do
			-- We don't bother for this example. Note that this is equivalent to setting zero.
		end

	create_resource (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Create new resource in response to a PUT request when `check_resource_exists' returns `False'.
			-- Implementor must set error code of 200 OK or 500 Server Error.
		do
			-- We don't support creating a new resource with PUT. But this can't happen
			-- with our router mappings, so we don't bother to set a 500 response.
		end

	append_resource (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Create new resource in response to a POST request.
			-- Implementor must set error code of 200 OK or 204 No Content or 303 See Other or 500 Server Error.
		do
			if attached {ORDER} req.execution_variable (Extracted_order_execution_variable) as l_order then
				save_order (l_order)
				compute_response_post (req, res, l_order)
			else
				handle_bad_request_response ("Not a valid order", req, res)
			end
		end

	check_conflict (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Check we can support all content headers on request entity.
			-- Set `req.execution_variable (Conflict_check_code_execution_variable)' to {NATURAL} zero if OK, or 409 if not.
			-- In the latter case, write the full error response to `res'.
		do
			if attached {ORDER} req.execution_variable (Extracted_order_execution_variable) as l_order then
				if not is_valid_to_update (l_order)	then
					req.set_execution_variable (Conflict_check_code_execution_variable, {NATURAL} 409)
					handle_resource_conflict_response (l_order.out +"%N There is conflict while trying to update the order, the order could not be update in the current state", req, res)
				end
			else
				req.set_execution_variable (Conflict_check_code_execution_variable, {NATURAL} 409)
				--| This ought to be a 500, as if attached should probably be check attached. But as yet I lack a proof.
				handle_resource_conflict_response ("There is conflict while trying to update the order, the order could not be update in the current state", req, res)
			end
		end

	check_request (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Check that the request entity is a valid request.
			-- The entity is available as `req.execution_variable (Conflict_check_code_execution_variable)'.
			-- Set `req.execution_variable (Request_check_code_execution_variable)' to {NATURAL} zero if OK, or 400 if not.
			-- In the latter case, write the full error response to `res'.
		local
			l_order: detachable ORDER
			l_id: STRING
		do
			if attached {READABLE_STRING_8} req.execution_variable (Request_entity_execution_variable) as l_request then
				l_order := extract_order_request (l_request)
				if req.is_put_request_method then
					l_id := order_id_from_request (req)
					if l_order /= Void  and then db_access.orders.has_key (l_id) then
						l_order.set_id (l_id)
						req.set_execution_variable (Request_check_code_execution_variable, {NATURAL} 0)
						req.set_execution_variable (Extracted_order_execution_variable, l_order)
					else
						req.set_execution_variable (Request_check_code_execution_variable, {NATURAL} 400)
						handle_bad_request_response (l_request +"%N is not a valid ORDER, maybe the order does not exist in the system", req, res)
					end
				else
					req.set_execution_variable (Request_check_code_execution_variable, {NATURAL} 0)
					req.set_execution_variable (Extracted_order_execution_variable, l_order)
				end
			else
				req.set_execution_variable (Request_check_code_execution_variable, {NATURAL} 400)
				handle_bad_request_response ("Request is not a valid ORDER", req, res)
			end
		end

	update_resource (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Perform the update requested in `req'.
			-- Write a response to `res' with a code of 204 or 500.
		do
			if attached {ORDER} req.execution_variable (Extracted_order_execution_variable) as l_order then
				update_order (l_order)
				compute_response_put (req, res, l_order)
			else
				handle_internal_server_error (res)
			end
		end

feature -- HTTP Methods

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

	order_id_from_request (req: WSF_REQUEST): STRING
			-- Value of "orderid" template URI variable in `req'
		require
			req_attached: req /= Void
		do
			if attached {WSF_VALUE} req.path_parameter ("orderid") as l_value then
				Result := l_value.as_string.value.as_string_8
			else
				Result := ""
			end
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
			create parser.make_parser (l_post)
			if attached parser.parse as jv and parser.is_parsed then
				if attached {like extract_order_request} json.object (jv, "ORDER") as res then
					Result := res
				end
			end
		end

note
	copyright: "2011-2013, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
