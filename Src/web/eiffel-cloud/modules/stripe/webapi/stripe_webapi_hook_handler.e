note
	description: "Summary description for {STRIPE_WEBAPI_HOOK_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_WEBAPI_HOOK_HANDLER

inherit
	STRIPE_WEBAPI_HANDLER

	WSF_REQUEST_EXPORTER

create
	make

feature -- Execution

	default_version: STRING_8 = "v1"

	execute (a_version: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			rep: like new_response
			buf: STRING
			p: PATH
			f: RAW_FILE
			fut: FILE_UTILITIES
			l_useful_id: detachable STRING_32
			l_type: READABLE_STRING_8
			s32: STRING_32
			l_payment_intent_res: PAYMENT_INTENT_SUCCEEDED
			l_is_livemode: BOOLEAN
			l_sign_verified: BOOLEAN
			l_err: BOOLEAN
			d: like safe_webhook_event_data
			l_replied: BOOLEAN
		do
			d := safe_webhook_event_data (req)
			buf := d.buffer
			l_sign_verified := d.signature_verified

			if attached d.event as event then
				l_type := event.type
				l_is_livemode := event.in_livemode
				if
					not l_is_livemode and
					stripe_api.config.is_live_mode
				then
					-- Ignore testing callbacks!!!
				else
					if
						l_type.is_case_insensitive_equal_general ("payment_intent.succeeded") and then
						attached event.object_data as jo
					then
						create l_payment_intent_res.make_with_json (jo)
						if stripe_api.is_payment_processed (l_payment_intent_res.id) then
							stripe_api.cms_api.log_debug ({STRIPE_MODULE}.name, "Stripe payment '" + l_payment_intent_res.id + "' is already processed!!!", Void)
						end
						l_useful_id := l_payment_intent_res.id
					elseif
						l_type.is_case_insensitive_equal_general ("payment_intent.failed") and then
						attached event.object_data as jo
					then
						create l_payment_intent_res.make_with_json (jo)
						if stripe_api.is_payment_processed (l_payment_intent_res.id) then
							api.log_debug ({STRIPE_MODULE}.name, "Stripe payment '" + l_payment_intent_res.id + "' is already processed!!!", Void)
						end
						l_useful_id := l_payment_intent_res.id
					elseif
						l_type.is_case_insensitive_equal_general ("invoice.payment_succeeded")
					then
						process_invoice_payment_succeeded (event, a_version, req, res)
						l_replied := True
					end
				end
			else
				l_err := True
				l_type := "webhook"
			end

			p := api.site_location.extended ("stripe")
			if not l_is_livemode then
				p := p.extended ("test")
			end
			if fut.directory_path_exists (p) then
				create s32.make (20)
				if l_err then
					s32.append_string_general ("ERROR_")
				elseif not l_is_livemode then
					s32.append_string_general ("TEST_")
				end
				s32.append_string_general (req.request_time_stamp.out)
				s32.append_character ('.')
				s32.append_string_general (l_type)
				if l_useful_id /= Void then
					s32.append_character ('.')
					s32.append (l_useful_id)
				end
				create f.make_with_path (p.extended (s32))
				f.create_read_write

				if attached req.raw_header_data as h then
					f.put_string (h.to_string_8)
					f.put_new_line
				elseif attached req.cgi_variables as l_cgi then
					f.put_string (utf_8_encoded (l_cgi.debug_output))
					f.put_new_line
				end

				if attached req.meta_string_variable ("HTTP_STRIPE_SIGNATURE") as s then
					f.put_string ("HTTP_STRIPE_SIGNATURE=" + utf_8_encoded (s))
					f.put_new_line
					if l_sign_verified then
						f.put_string ("Stripe-Signature VERIFIED")
					else
						f.put_string ("Stripe-Signature NOT-VERIFIED")
					end
					f.put_new_line
				end

				f.put_string (create {STRING}.make_filled ('=', 8))
				f.put_new_line
				f.put_string (buf)
				f.close
			end
			if not l_replied then
				rep := new_response (req, res)
				rep.add_string_field ("status" , "ok")
			if l_err then
					rep.add_string_field ("description" , "error occured")
				else
					rep.add_string_field ("description" , "ignored")
				end
				rep.execute
			end
			if f /= Void then
				f.open_append
				f.put_new_line
				f.put_string (create {STRING}.make_filled ('=', 8))
				f.put_new_line
				f.put_string ("Status=" + res.status_code.out)
				f.put_new_line
				f.put_string ("transfered_content_length=" + res.transfered_content_length.out)
				f.put_new_line
				f.put_string (create {STRING}.make_filled ('=', 8))
				f.put_new_line
				if attached {HTTP_HEADER} res.header as h then
					f.put_string (h.string)
					f.put_new_line
				elseif attached {WSF_RESPONSE_HEADER} res.header as wrh then
					across
						wrh as ic
					loop
						f.put_string (ic.item)
						f.put_new_line
					end
				end
				f.put_new_line
				f.close
			end
		end

	process_invoice_payment_succeeded (a_event: STRIPE_EVENT; a_version: READABLE_STRING_GENERAL; req: WSF_REQUEST; res: WSF_RESPONSE)
		require
			a_event.type.is_case_insensitive_equal_general ("invoice.payment_succeeded")
		local
			l_useful_id: detachable STRING_32
			l_sub: STRIPE_SUBSCRIPTION
			l_invoice: STRIPE_INVOICE
			rep: like new_response
		do
			rep := new_response (req, res)
			if attached a_event.object_data as jo then
				create l_invoice.make_with_json (jo)
				if attached l_invoice.payment_intent_id as pi then
					if stripe_api.is_payment_processed (pi) then
						api.log_error ({STRIPE_MODULE}.name, "Stripe payment '" + pi + "' is already processed!", Void)
						rep := new_error_response ("Stripe payment '" + pi + "' is already processed!", req, res)
					else
						-- Process ...
						stripe_api.record_invoice (l_invoice)

						create l_useful_id.make_from_string_general (l_invoice.id)
						if attached l_invoice.subscription_id as sub_id then
							l_sub := stripe_api.subscription (sub_id)
							l_useful_id.append_character ('.')
							l_useful_id.append_string_general (sub_id)
						end
						if attached l_invoice.payment_intent_id as p_id then
							l_useful_id.append_character ('.')
							l_useful_id.append_string_general (p_id)
						end
						api.log_debug ({STRIPE_MODULE}.name, "Stripe invoice payment event: " + html_encoded (l_useful_id), Void)
						if l_sub /= Void then
							stripe_api.process_subscription_cycle (l_sub, l_invoice)
							rep.add_string_field ("status" , "ok")
						else
							rep := new_bad_request_error_response ("Subscription not found", req, res)
						end
					end
				else
					api.log_error ({STRIPE_MODULE}.name, "Stripe invoice without payment_intent_id!", Void)
					rep := new_error_response ("Stripe invoice without payment_intent_id", req, res)
				end
			else
				rep := new_bad_request_error_response ("Missing invoice data", req, res)
			end
			rep.execute
		end

	safe_webhook_event_data (req: WSF_REQUEST): TUPLE [buffer: STRING; event: detachable STRIPE_EVENT; signature_verified: BOOLEAN]
			-- Safe event data, either by verifying the signature, or getting a fresh event data from stripe service.
		local
			buf: STRING
			ev: STRIPE_EVENT
			jp: JSON_PARSER
			l_sign: STRIPE_SIGNATURE
			l_sign_verified: BOOLEAN
		do
			create buf.make (req.content_length_value.to_integer_32)
			req.read_input_data_into (buf)

			create l_sign.make (req.meta_string_variable ("HTTP_STRIPE_SIGNATURE"))
			l_sign_verified := l_sign.is_valid and then l_sign.is_content_verified (buf, stripe_api.config.signing_secret)

			create jp.make_with_string (buf)
			jp.parse_content
			if
				jp.is_parsed and then jp.is_valid and then attached jp.parsed_json_object as jo
			then
				create ev.make_with_json (jo)
				if l_sign_verified then
					Result := [buf, ev, l_sign_verified]
				else
					Result := [buf, stripe_api.event (ev.id), False]
				end
			else
				Result := [buf, Void, l_sign_verified]
			end
		end

end
