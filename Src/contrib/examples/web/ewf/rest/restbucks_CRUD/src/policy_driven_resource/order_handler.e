note
	description: "{ORDER_HANDLER} handle the resources that we want to expose"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ORDER_HANDLER

inherit

	WSF_SKELETON_HANDLER

	SHARED_RESTBUCKS_API

	REFACTORING_HELPER

	WSF_RESOURCE_HANDLER_HELPER
		rename
			execute_options as helper_execute_options,
			handle_internal_server_error as helper_handle_internal_server_error
		end

create
	make

feature {NONE} -- Initialization

	make (a_orderid_path_parameter_name: READABLE_STRING_GENERAL; a_router: WSF_ROUTER)
		do
			orderid_path_parameter_name := a_orderid_path_parameter_name
			make_with_router (a_router)
		end

	orderid_path_parameter_name: READABLE_STRING_GENERAL

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

	conneg (req: WSF_REQUEST): SERVER_CONTENT_NEGOTIATION
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

	allowed_cross_origins (req: WSF_REQUEST): detachable STRING
			-- Value for Access-Control-Allow-Origin header;
			-- If supplied, should be a single URI, or the values "*" or "null".
			-- This is currently supported only for GET requests, and POSTs that functions as GET.
		do
			if req.is_get_head_request_method then
				Result := "*"
			end
		end

	matching_etag (req: WSF_REQUEST; a_etag: READABLE_STRING_32; a_strong: BOOLEAN): BOOLEAN
			-- Is `a_etag' a match for resource requested in `req'?
			-- If `a_strong' then the strong comparison function must be used.
		local
			l_id: STRING
		do
			l_id := order_id_from_request (req)
			if l_id /= Void and then has_order (l_id) then
				check attached order (l_id) as l_order then
						-- postcondition of `has_key'
					Result := a_etag.same_string (order_etag (l_order))
				end
			end
		end

	etag (req: WSF_REQUEST): detachable READABLE_STRING_8
			-- Optional Etag for `req' in the requested variant
		do
			if attached {ORDER} req.execution_variable (Order_execution_variable) as l_order then
				Result := order_etag (l_order)
			end
		end

	last_modified (req: WSF_REQUEST): detachable DATE_TIME
			-- When representation of resource selected in `req' was last modified;
			-- SHOULD be set whenever it can reasonably be determined.
		do
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
				if l_id /= Void and then has_order (l_id) then
					a_helper.set_resource_exists
					if req.is_get_head_request_method then
						check attached order (l_id) as l_order then
								-- postcondition `item_if_found' of `has_key'
							req.set_execution_variable (Order_execution_variable, l_order)
						end
					end
				end
			end
		ensure then
			order_saved_only_for_get_head: attached {ORDER} req.execution_variable (Order_execution_variable) implies req.is_get_head_request_method
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
				if attached order_to_json (l_order) as jv then
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
		do
			if
				attached order_id_from_request (req) as l_id and then
				attached order (l_id) as l_order
			then
				if is_valid_to_delete (l_order) then
					delete_order (l_order)
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
				submit_order (l_order)
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
				l_order := order_from_request_input_data (l_request)
				if req.is_put_request_method then
					l_id := order_id_from_request (req)
					if l_order /= Void and then l_id /= Void and then has_order (l_id) then
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
		do
			res.header.put_content_type_application_json
			res.header.put_utc_date (create {DATE_TIME}.make_now_utc)
			res.header.add_header ("etag:" + order_etag (l_order))
			if attached order_to_json (l_order) as jv then
				res.header.put_content_length (jv.representation.count)
				res.set_status_code ({HTTP_STATUS_CODE}.ok)
				res.put_string (jv.representation)
			end
		end

	compute_response_post (req: WSF_REQUEST; res: WSF_RESPONSE; l_order : ORDER)
		local
			l_msg : STRING
		do
			res.header.put_content_type_application_json
			if attached order_to_json (l_order) as jv then
				l_msg := jv.representation
				res.header.put_content_length (l_msg.count)
				res.header.put_location (req.absolute_script_url (req.request_uri + "/" + l_order.id))
				res.header.put_utc_date (create {DATE_TIME}.make_now_utc)
				res.set_status_code ({HTTP_STATUS_CODE}.created)
				res.put_string (l_msg)
			end
		end

feature {NONE} -- URI helper methods

	order_id_from_request (req: WSF_REQUEST): detachable STRING_8
		do
			if attached {WSF_STRING} req.path_parameter (orderid_path_parameter_name) as p_id then
				Result := p_id.url_encoded_value -- the ORDER id has to be valid STRING 8 value.
			end
		end

feature {NONE} -- Implementation Repository Layer

	is_valid_to_delete (a_order: ORDER): BOOLEAN
			-- Is the order identified by `a_id' in a state whre it can still be deleted?
		do
			if attached order (a_order.id) as l_order then
				if api.is_state_valid_to_update (l_order.status) then
					Result := True
				end
			end
		end

	is_valid_to_update (a_order: ORDER): BOOLEAN
			-- Check if there is a conflict while trying to update the order.
		do
		   	if attached order (a_order.id) as l_existing_order then
				if
					api.is_state_valid_to_update (l_existing_order.status) and then
					api.is_valid_status_state (a_order.status) and then
					api.is_valid_transition (l_existing_order, a_order.status)
				then
				 	Result := True
				end
			end
		end

--	update_order (an_order: ORDER)
--			-- update the order to the repository
--		do
--			an_order.add_revision
--			db_access.orders.force (an_order, an_order.id)
--		end

--	delete_order (an_order: STRING)
--			-- update the order to the repository
--		do
--			db_access.orders.remove (an_order)
--		end

feature -- Helpers

	order_etag (a_order: ORDER): STRING_8
		local
			etag_utils: ETAG_UTILS
		do
			create etag_utils
			Result := etag_utils.md5_digest (a_order.hash_code.out + a_order.revision.out)
		end

	order_from_request (req: WSF_REQUEST): detachable ORDER
			-- extract an object Order from the request,
			-- or Void if the request is invalid.
		local
			l_data: STRING
		do
			create l_data.make (req.content_length_value.to_integer_32)
			req.read_input_data_into (l_data)

			Result := order_from_request_input_data (l_data)
		end

	order_from_request_input_data (a_data: READABLE_STRING_8): detachable ORDER
			-- extract an object Order from the request,
			-- or Void if the request is invalid.
		local
			parser : JSON_PARSER
		do
			create parser.make_with_string (a_data)
			parser.parse_content
			if
				parser.is_valid and then
				attached parser.parsed_json_value as jv
			then
				Result := order_from_json (jv)
			end
		end

feature {NONE} -- Conversion

	order_to_json (obj: ORDER): JSON_OBJECT
		local
			j_item: JSON_OBJECT
			ja: JSON_ARRAY
		do
			create Result.make_with_capacity (4)
			Result.put_string (obj.id, id_key)
			if attached obj.location as loc then
				Result.put_string (loc, location_key)
			end
			Result.put_string (obj.status, status_key)
			if attached obj.items as l_items and then not l_items.is_empty then
				create ja.make (l_items.count)
				Result.put (ja, items_key)
				across
					l_items as ic
				loop
					if attached {ORDER_ITEM} ic.item as l_item then
						create j_item.make_with_capacity (4)
						j_item.put_string (l_item.name, name_key)
						j_item.put_string (l_item.size, size_key)
						j_item.put_integer (l_item.quantity, quantity_key)
						j_item.put_string (l_item.option, option_key)
						ja.extend (j_item)
					end
				end
			end
		end

	order_from_json (a_json: JSON_VALUE): detachable ORDER
		local
			l_status: detachable STRING_32
			q: NATURAL_8
			is_valid_from_json: BOOLEAN
			l_name, l_size, l_option: detachable READABLE_STRING_32
		do
			is_valid_from_json := True
			if attached {JSON_OBJECT} a_json as jobj then
					-- Either new order (i.e no id and no status)
					-- or an existing order with `id` and `status` (could be Void, thus use default).
				if attached {JSON_STRING} jobj.item (status_key) as j_status then
					l_status := j_status.unescaped_string_32
				end
				if
					attached {JSON_STRING} jobj.item (id_key) as j_id
				then
						-- Note: the id has to be valid string 8 value!
					create Result.make (j_id.unescaped_string_8, l_status)
				elseif attached {JSON_NUMBER} jobj.item (id_key) as j_id then
						-- Be flexible and accept json number as id.
					create Result.make (j_id.integer_64_item.out, l_status)
				else
					create Result.make_empty
					if l_status /= Void then
						Result.set_status (l_status)
					end
				end
				if attached {JSON_STRING} jobj.item (location_key) as j_location then
					Result.set_location (j_location.unescaped_string_32)
				end
				if attached {JSON_ARRAY} jobj.item (items_key) as j_items then
					across
						j_items as ic
					loop
						if attached {JSON_OBJECT} ic.item as j_item then
							if
								attached {JSON_NUMBER} j_item.item (quantity_key) as j_quantity and then
								j_quantity.integer_64_item < {NATURAL_8}.Max_value
							then
								q := j_quantity.integer_64_item.to_natural_8
							else
								q := 0
							end
							if
								attached {JSON_STRING} j_item.item (name_key) as j_name and then
								attached {JSON_STRING} j_item.item (size_key) as j_size and then
								attached {JSON_STRING} j_item.item (option_key) as j_option
							then
								l_name := j_name.unescaped_string_32
								l_size := j_size.unescaped_string_32
								l_option := j_option.unescaped_string_32
								if is_valid_item_customization (l_name, l_size, l_option, q) then
									Result.add_item (create {ORDER_ITEM}.make (l_name, l_size, l_option, q))
								else
									is_valid_from_json := False
								end
							else
								is_valid_from_json := False
							end
						end
					end
				end
				if not is_valid_from_json or Result.items.is_empty then
					Result := Void
				end
			else
				is_valid_from_json := a_json = Void or else attached {JSON_NULL} a_json
				Result := Void
			end
		end

	is_valid_item_customization (name: READABLE_STRING_GENERAL; size: READABLE_STRING_GENERAL; option: READABLE_STRING_GENERAL; quantity: NATURAL_8): BOOLEAN
		local
			ic: ORDER_ITEM_VALIDATION
		do
			create ic
			Result := 	ic.is_valid_coffee_type (name) and
						ic.is_valid_milk_type (option) and
						ic.is_valid_size_option (size) and
						quantity > 0
		end

	id_key: STRING = "id"

	location_key: STRING = "location"

	status_key: STRING = "status"

	items_key: STRING = "items"

	name_key: STRING = "name"

	size_key: STRING = "size"

	quantity_key: STRING = "quantity"

	option_key: STRING = "option"

note
	copyright: "2011-2017, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
