note
	description: "[
		POST version of REQUEST
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_POST_REQUEST

inherit
	XH_REQUEST
	redefine
		method
	end

create
	make_from_message,
	make_empty,
	make_goto_request

feature {NONE} -- Initialization

feature -- Constants


feature -- Access

	method: CHARACTER = 'P'

feature {NONE} -- Implementation


		--						-- Read POST/GET params				
--			if l_s.starts_with (Key_arg + Key_textxml) then
--					-- Handle special case for POST 'text/xml' encoding
--				l_s.remove_head (Key_arg.count + Key_textxml.count)
--				l_s.remove_tail (key_t_end.count)
--				create arguments.make (1)
--				arguments.force (l_s.twin, "text/xml")
--			else
--					-- Handle regular case (form encoded)
--				

	read_arguments (a_string: STRING)
			-- <Precursor>
		do
			if attached {STRING} current.headers_in ["Content-Type"] as l_content_type then
					if l_content_type.is_equal (Content_type_form_urlencoded) then
					arguments := parse_table (a_string, Key_arg, Key_p_key, Key_p_value, Key_t_end)
				else
					a_string.remove_head (key_arg.count)
					a_String.remove_tail (key_t_end.count)
					arguments.force (a_string, "content")
				end
			end
		end

	read_uri (a_the_request: STRING): STRING
		local
			l_i: INTEGER
		do
			l_i := a_the_request.substring_index ("HTTP",1)
			Result := a_the_request.substring (6, l_i-2)
		end

	call_pre_handler (a_form_handler: XH_FORM_HANDLER; a_response: XH_RESPONSE)
			-- <Precursor>
			-- Calls prehandle_post_request
		do
			a_form_handler.handle_form (Current, a_response)
		end
end
