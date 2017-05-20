note
	description: "Summary description for {}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_EXECUTION_I

inherit
	WSF_EXECUTION

feature -- Execution

	execute
		local
			req: WSF_REQUEST
			res: WSF_RESPONSE
			q: detachable STRING_32
			n: NATURAL_64
			page: WSF_PAGE_RESPONSE
			log_res: WSF_LOGGER_RESPONSE_WRAPPER
		do
			req := request
			res := response
			debug
				server_log (req.request_uri)
				if attached req.content_type as l_content_type then
					server_log ("content_type:" + l_content_type.string)
				end
			end
			if attached req.http_expect as l_expect and then l_expect.same_string ("100-continue") then
				(create {EXECUTION_ENVIRONMENT}).sleep (900_000_000) -- 900 milliseconds
			end

			create page.make
			if attached req.request_uri as l_uri then
				if l_uri.starts_with (test_url ("get/01")) then
					page.set_status_code (200)
					page.header.put_content_type_text_plain
					page.put_string ("get-01")
					create q.make_empty

					across
						req.query_parameters as qcur
					loop
						if not q.is_empty then
							q.append_character ('&')
						end
						q.append (qcur.item.name.as_string_32 + "=" + qcur.item.string_representation)
					end
					if not q.is_empty then
						page.put_string ("(" + q + ")")
					end
				elseif l_uri.starts_with (test_url ("post/01")) then
					page.put_header (200, <<["Content-Type", "text/plain"]>>)
					page.put_string ("post-01")
					create q.make_empty

					across
						req.query_parameters as qcur
					loop
						if not q.is_empty then
							q.append_character ('&')
						end
						q.append (qcur.item.name.as_string_32 + "=" + qcur.item.string_representation)
					end

					if not q.is_empty then
						page.put_string ("(" + q + ")")
					end

					create q.make_empty
--					req.set_raw_input_data_recorded (True)

					across
						req.form_parameters as fcur
					loop
						debug
							server_log ("%Tform: " + fcur.item.name)
						end
						if not q.is_empty then
							q.append_character ('&')
						end
						q.append (fcur.item.name.as_string_32 + "=" + fcur.item.string_representation)
					end

--					if attached req.raw_input_data as d then
--						server_log ("Raw data=" + d)
--					end

					if not q.is_empty then
						page.put_string (" : " + q )
					end
				elseif l_uri.starts_with (test_url ("post/file/01")) then
					page.put_header (200, <<["Content-Type", "text/plain"]>>)
					page.put_string ("post-file-01")
					n := req.content_length_value
					if n > 0 then
						req.input.read_string (n.to_integer_32)
						q := req.input.last_string
						page.put_string ("%N" + q)
					end
				else
					page.put_header (200, <<["Content-Type", "text/plain"]>>)
					page.put_string ("Hello")
				end
			else
				page.put_header (200, <<["Content-Type", "text/plain"]>>)
				page.put_string ("Bye")
			end

			if
				attached new_file (req, "output.log") as l_out and
				attached new_file (req, "error.log") as l_err
			then
				create log_res.make_from_response (res, l_out, l_err)
				log_res.send (page)

				l_out.close
				l_err.close
			else
				check False end
				res.send (page)
			end
		end

	new_file (req: WSF_REQUEST; a_suffix: STRING): detachable FILE
		local
			dp, p, fp: PATH
			d: DIRECTORY
			i: INTEGER
			f: detachable FILE
			retried: INTEGER
		do
			if retried = 0 then
				create dp.make_from_string ("logs")
				create d.make_with_path (dp)
				if not d.exists then
					d.recursive_create_dir
				end
				if attached req.request_time_stamp as t then
					create p.make_from_string (t.out)
				else
					create p.make_from_string ("")
				end

				from
					i := 0
					if p.is_empty then
						fp := dp.extended (a_suffix)
					else
						fp := dp.extended_path (p).appended ("-" + a_suffix)
					end
					create {PLAIN_TEXT_FILE} f.make_with_path (fp)
				until
					not f.exists
				loop
					i := i + 1
					if p.is_empty then
						fp := dp.extended (i.out + "-" + a_suffix)
					else
						fp := dp.extended_path (p).appended ("_" + i.out + "-" + a_suffix)
					end
					f.make_with_path (fp)
				end
				f.open_write
			elseif retried < 5 then
				-- Eventually another request created the file at the same time ..
				f := new_file (req, a_suffix)
			else
				f := Void
			end
			Result := f
		rescue
			retried := retried + 1
			retry
		end

feature -- Helper

	server_log (s: STRING)
		deferred
		end

	test_url (a_query_url: READABLE_STRING_8): READABLE_STRING_8
		deferred
		end

end

