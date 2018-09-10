note
	description: "Summary description for {FACEBOOK_JSON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FACEBOOK_JSON

inherit

	FACEBOOK_I
		redefine
			default_create
		select
			default_create
		end

	REFACTORING_HELPER
		rename
			default_create as  default_rh
		end

create
	default_create,
	make

feature {NONE} -- Initialization

	default_create
		do
			create facebook_api.make ("")
		end

	make (a_access_token: READABLE_STRING_32)
		do
			create facebook_api.make (a_access_token)
		end

feature -- Access

	last_status_code: INTEGER
			-- <Precuror>
		do
			if attached facebook_api.last_response as l_response then
				Result := l_response.status
			end
		end

feature --Facebook Access Token

	extended_access_token (a_app_id: STRING; a_app_secret: STRING; a_short_token: STRING): detachable FB_ACCESS_TOKEN
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.extended_access_token (a_app_id, a_app_secret, a_short_token) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						-- TO BE COMPLETED
					end
				end
			end
		end

feature -- Facebook API: User

	user (a_user_id: STRING; a_params: detachable FB_USER_PARAMETER): detachable FB_USER
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.show_user (a_user_id, a_params) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := fb_user (Void, j)
					end
				end
			end
		end

	user_feed (a_user_id: STRING; a_params: detachable FB_POST_PARAMETER): detachable FB_EDGES [FB_POST]
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.user_timeline_posts (a_user_id +"/feed", a_params) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := fb_connection_post (j)
					end
				end
			end
		end

	user_friends (a_user_id: STRING; a_params: detachable FB_USER_PARAMETER): detachable FB_EDGES [FB_USER]
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.user_friends (a_user_id +"/friends", a_params) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := fb_friends (j)
					end
				end
			end
		end

	user_likes (a_user_id: STRING; a_params: detachable FB_PAGE_PARAMETER): detachable FB_EDGES [FB_PAGE]
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.user_likes (a_user_id +"/likes", a_params) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := fb_pages (j)
					end
				end
			end
		end

	user_groups (a_user_id: STRING; a_params: detachable FB_GROUP_PARAMETER): detachable FB_EDGES [FB_GROUP]
			-- The Facebook Groups that the person belongs to.
			-- GET /{user_id}/groups	
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.user_groups (a_user_id +"/groups", a_params) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := fb_groups (j)
					end
				end
			end
		end

feature -- Facebook API: user feed

	publish_status_on_user_feed (a_user_id: STRING; a_params: detachable FB_USER_FEED_PUBLISHING): detachable STRING
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.publish_on_user_feed (a_user_id + "/feed", a_params) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := string_value_from_json (j, "id")
					end
				end
			end
		end

	delete_feed (a_post_id: STRING): BOOLEAN
		local
				err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.delete_feed (a_post_id) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := boolean_value_from_json (j, "success")
					end
				end
			end
		end


	publish_photo_on_user_feed (a_user_id: STRING; a_photo: PATH; a_params: detachable FB_USER_FEED_PUBLISHING): detachable STRING
				-- <Precursor>
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.publish_photo_on_user_feed (a_user_id + "/photos", a_photo, a_params) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := string_value_from_json (j, "id")
					end
				end
			end
		end

	publish_video_on_user_feed (a_user_id: STRING; a_video: PATH; a_params: detachable FB_VIDEO_PUBLISHING): detachable STRING
		local
				err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.publish_video_on_user_feed (a_user_id + "/videos", a_video, a_params) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := string_value_from_json (j, "id")
					end
				end
			end
		end



feature	-- Post

	post (a_post_id: READABLE_STRING_32; a_params: detachable FB_POST_PARAMETER): detachable FB_POST
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.show_post (a_post_id, a_params) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := fb_post (Void, j)
					end
				end
			end
		end

feature  {FB_EDGES} -- Connection Pages

	connection_post_page (a_uri: READABLE_STRING_8): detachable FB_EDGES [FB_POST]
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.user_timeline_posts (a_uri, Void) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := fb_connection_post (j)
					end
				end
			end
		end

	connection_user_page (a_uri: READABLE_STRING_8): detachable FB_EDGES [FB_USER]
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.user_friends (a_uri, Void) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := fb_friends (j)
					end
				end
			end
		end

	connection_likes_page (a_uri: READABLE_STRING_8): detachable FB_EDGES [FB_PAGE]
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.user_friends (a_uri, Void) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := fb_pages (j)
					end
				end
			end
		end

	connection_groups_page (a_uri: READABLE_STRING_8): detachable FB_EDGES [FB_GROUP]
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.user_groups (a_uri, Void) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := fb_groups (j)
					end
				end
			end
		end


feature -- Implementation Factory

	fb_user (a_user: detachable like fb_user; a_json: JSON_VALUE): FB_USER
			-- Fill `a_user' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_user /= Void then
				Result := a_user
			else
				create Result
			end
			Result.set_id (string_value_from_json (a_json, "id"))
			Result.set_name (string32_value_from_json (a_json, "name"))
			Result.set_birthday (string_value_from_json (a_json, "birthday"))
			Result.set_email (string_value_from_json (a_json, "email"))
			Result.set_first_name (string32_value_from_json (a_json, "first_name"))
			Result.set_gender (string_value_from_json (a_json, "gender"))
			Result.set_last_name (string32_value_from_json (a_json, "last_name"))
			Result.set_link (string_value_from_json (a_json, "link"))
			Result.set_locale (string_value_from_json (a_json, "locale"))
			if attached {JSON_OBJECT} json_value (a_json, "location") as l_location then
					--Result.set_location (fb_page (Void, location))
			end
			Result.set_middle_name (string32_value_from_json (a_json, "middle_name"))
			Result.set_time_zone (real_value_from_json (a_json, "time_zone"))
		end

	fb_friends (a_json: JSON_VALUE): FB_EDGES [FB_USER]
			-- Fill `a_friends' from `a_json'
		require
			a_json_attached: a_json /= Void
		local
			l_data: LIST [FB_USER]
			i: INTEGER
			l_pag: FB_PAGING
		do
			create Result.make (Current)
			if attached {JSON_ARRAY} json_value (a_json, "data") as l_array then
				from
					create {ARRAYED_LIST [FB_USER]} l_data.make (l_array.count)
					i := 1
				until
					i > l_array.count
				loop
					l_data.force (fb_user (Void, l_array.i_th (i)))
					i := i + 1
				end
				Result.set_data (l_data)
			end
			if attached {JSON_OBJECT} json_value (a_json, "paging") as l_paging then
				l_pag := fb_paging (Void, l_paging)
				if attached l_pag.previous as l_prev then
					Result.set_action_back (agent connection_user_page (l_prev) )
				end
				if attached l_pag.next as l_next then
					Result.set_action_forth (agent connection_user_page (l_next) )
				end
				Result.set_paging (fb_paging (Void, l_paging))
			end
			if attached {JSON_OBJECT} json_value (a_json, "summary") as l_summary then
				Result.set_summary (fb_summary (Void,l_summary))
			end
		end

	fb_pages (a_json: JSON_VALUE): FB_EDGES [FB_PAGE]
			-- Fill `a_friends' from `a_json'
		require
			a_json_attached: a_json /= Void
		local
			l_data: LIST [FB_PAGE]
			i: INTEGER
			l_pag: FB_PAGING
		do
			create Result.make (Current)
			if attached {JSON_ARRAY} json_value (a_json, "data") as l_array then
				from
					create {ARRAYED_LIST [FB_PAGE]} l_data.make (l_array.count)
					i := 1
				until
					i > l_array.count
				loop
					l_data.force (fb_page (Void, l_array.i_th (i)))
					i := i + 1
				end
				Result.set_data (l_data)
			end
			if attached {JSON_OBJECT} json_value (a_json, "paging") as l_paging then
				l_pag := fb_paging (Void, l_paging)
				if attached l_pag.previous as l_prev then
					Result.set_action_back (agent connection_likes_page (l_prev) )
				end
				if attached l_pag.next as l_next then
					Result.set_action_forth (agent connection_likes_page (l_next) )
				end
				Result.set_paging (fb_paging (Void, l_paging))
			end
			if attached {JSON_OBJECT} json_value (a_json, "summary") as l_summary then
				Result.set_summary (fb_summary (Void,l_summary))
			end
		end


	fb_groups (a_json: JSON_VALUE): FB_EDGES [FB_GROUP]
			--Return Group edges from `a_json'
		require
			a_json_attached: a_json /= Void
		local
			l_data: LIST [FB_GROUP]
			i: INTEGER
			l_pag: FB_PAGING
		do
			create Result.make (Current)
			if attached {JSON_ARRAY} json_value (a_json, "data") as l_array then
				from
					create {ARRAYED_LIST [FB_GROUP]} l_data.make (l_array.count)
					i := 1
				until
					i > l_array.count
				loop
					l_data.force (fb_group (Void, l_array.i_th (i)))
					i := i + 1
				end
				Result.set_data (l_data)
			end
			if attached {JSON_OBJECT} json_value (a_json, "paging") as l_paging then
				l_pag := fb_paging (Void, l_paging)
				if attached l_pag.previous as l_prev then
					Result.set_action_back (agent connection_groups_page (l_prev) )
				end
				if attached l_pag.next as l_next then
					Result.set_action_forth (agent connection_groups_page (l_next) )
				end
				Result.set_paging (fb_paging (Void, l_paging))
			end
			if attached {JSON_OBJECT} json_value (a_json, "summary") as l_summary then
				Result.set_summary (fb_summary (Void,l_summary))
			end
		end

	fb_paging (a_paging: detachable like fb_paging; a_json: JSON_VALUE): FB_PAGING
			-- Fill `a_paging' from `a_json'
		require
			a_json_attached: a_json /= Void
		local
		do
			if a_paging /= Void then
				Result := a_paging
			else
				create Result
			end
			if attached {JSON_OBJECT} json_value (a_json, "cursors") as l_cursors then
					Result.set_cursor_after (string_value_from_json (l_cursors, "after"))
					Result.set_cursor_before (string_value_from_json (l_cursors, "before"))
			end
			Result.set_next (unescaped_string_8_value_from_json (a_json, "next"))
			Result.set_previous (unescaped_string_8_value_from_json (a_json,"previous"))
		end

	fb_summary (a_summary: detachable like fb_summary; a_json: JSON_VALUE): FB_SUMMARY
			-- Fill `a_summary' from `a_json'
		require
			a_json_attached: a_json /= Void
		local
		do
			if a_summary /= Void then
				Result := a_summary
			else
				create Result
			end
			Result.set_total_count (integer_value_from_json (a_json, "total_count"))
		end

	fb_post (a_post: detachable like fb_post; a_json: JSON_VALUE): FB_POST
			-- Fill `a_user' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_post /= Void then
				Result := a_post
			else
				create Result
			end
			Result.set_id (string_value_from_json (a_json, "id"))
			Result.set_caption (string_value_from_json (a_json, "caption"))
			Result.set_created_time (string_value_from_json (a_json, "created_time"))
			Result.set_message (string_value_from_json (a_json, "message"))
			Result.set_story (string_value_from_json (a_json, "story"))
		end

	fb_page (a_page: detachable like fb_page; a_json: JSON_VALUE): FB_PAGE
			-- Fill `a_page' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_page /= Void then
				Result := a_page
			else
				create Result
			end
			Result.set_id (string_value_from_json (a_json, "id"))
			Result.set_about (string32_value_from_json (a_json, "about"))
			Result.set_description (string32_value_from_json (a_json, "description"))
		end

	fb_group (a_group: detachable like fb_group; a_json: JSON_VALUE): FB_GROUP
			-- Fill `a_group' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_group /= Void then
				Result := a_group
			else
				create Result
			end
			Result.set_id (string_value_from_json (a_json, "id"))
			Result.set_description (string32_value_from_json (a_json, "description"))
			Result.set_email (string_value_from_json (a_json, "email"))
		end

	fb_connection_post (a_json: JSON_VALUE): detachable FB_EDGES [FB_POST]
			-- Fill `a_friends' from `a_json'
		require
			a_json_attached: a_json /= Void
		local
			l_data: LIST [FB_POST]
			i: INTEGER
			l_pag: FB_PAGING
		do
			create Result.make (Current)
			if attached {JSON_ARRAY} json_value (a_json, "data") as l_array then
				from
					create {ARRAYED_LIST [FB_POST]} l_data.make (l_array.count)
					i := 1
				until
					i > l_array.count
				loop
					l_data.force (fb_post (Void, l_array.i_th (i)))
					i := i + 1
				end
				Result.set_data (l_data)
			end
			if attached {JSON_OBJECT} json_value (a_json, "paging") as l_paging then
				l_pag := fb_paging (Void, l_paging)
				if attached l_pag.previous as l_prev then
					Result.set_action_back (agent connection_post_page (l_prev) )
				end
				if attached l_pag.next as l_next then
					Result.set_action_forth (agent connection_post_page (l_next) )
				end
				Result.set_paging (fb_paging (Void, l_paging))
			end
			if attached {JSON_OBJECT} json_value (a_json, "summary") as l_summary then
				Result.set_summary (fb_summary (Void,l_summary))
			end
		end

feature --{NONE}

	stripslashes (s: STRING): STRING
		do
			Result := s.string
			Result.replace_substring_all ("\%"", "%"")
			Result.replace_substring_all ("\'", "'")
			Result.replace_substring_all ("\/", "/")
			Result.replace_substring_all ("\\", "\")
		end

feature -- Implementation

	print_last_json_data
			-- Print `last_json' data
		do
			internal_print_json_data (last_json, "  ")
		end

feature {NONE} -- Implementation

	facebook_api: FACEBOOK_API
			-- Facebook API object.

	last_json: detachable JSON_VALUE

	parsed_json (a_json_text: STRING): detachable JSON_VALUE
		local
			j: JSON_PARSER
		do
			create j.make_with_string (a_json_text)
			j.parse_content
			Result := j.parsed_json_value
			last_json := Result
		end

	json_value (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable JSON_VALUE
		local
			l_id: JSON_STRING
			l_ids: LIST [STRING]
		do
			Result := a_json_data
			if Result /= Void then
				if a_id /= Void and then not a_id.is_empty then
					from
						l_ids := a_id.split ('.')
						l_ids.start
					until
						l_ids.after or Result = Void
					loop
						create l_id.make_from_string (l_ids.item)
						if attached {JSON_OBJECT} Result as v_data then
							if v_data.has_key (l_id) then
								Result := v_data.item (l_id)
							else
								Result := Void
							end
						else
							Result := Void
						end
						l_ids.forth
					end
				end
			end
		end

	internal_print_json_data (a_json_data: detachable JSON_VALUE; a_offset: STRING)
		local
			obj: HASH_TABLE [JSON_VALUE, JSON_STRING]
		do
			if attached {JSON_OBJECT} a_json_data as v_data then
				obj	:= v_data.map_representation
				from
					obj.start
				until
					obj.after
				loop
					print (a_offset)
					print (obj.key_for_iteration.item)
					if attached {JSON_STRING} obj.item_for_iteration as j_s then
						print (": " + j_s.item)
					elseif attached {JSON_NUMBER} obj.item_for_iteration as j_n then
						print (": " + j_n.item)
					elseif attached {JSON_BOOLEAN} obj.item_for_iteration as j_b then
						print (": " + j_b.item.out)
					elseif attached {JSON_NULL} obj.item_for_iteration as j_null then
						print (": NULL")
					elseif attached {JSON_ARRAY} obj.item_for_iteration as j_a then
						print (": {%N")
						internal_print_json_data (j_a, a_offset + "  ")
						print (a_offset + "}")
					elseif attached {JSON_OBJECT} obj.item_for_iteration as j_o then
						print (": {%N")
						internal_print_json_data (j_o, a_offset + "  ")
						print (a_offset + "}")
					end
					print ("%N")
					obj.forth
				end
			end
		end

	integer_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): INTEGER
		do
			if
				attached {JSON_NUMBER} json_value (a_json_data, a_id) as v and then
				v.numeric_type = v.integer_type
			then
				Result := v.item.to_integer
			end
		end

	integer_64_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): INTEGER_64
		do
			if
				attached {JSON_NUMBER} json_value (a_json_data, a_id) as v and then
				v.is_number
			then
				Result := v.integer_64_item
			end
		end

	real_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): REAL
		do
			if
				attached {JSON_NUMBER} json_value (a_json_data, a_id) as v and then
				v.numeric_type = v.real_type
			then
				Result := v.item.to_real
			end
		end

	boolean_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): BOOLEAN
		do
			if attached {JSON_BOOLEAN} json_value (a_json_data, a_id) as v then
				Result := v.item
			end
		end

	string_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable STRING
		do
			if attached {JSON_STRING} json_value (a_json_data, a_id) as v then
				Result := v.item
			end
		end

	string32_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable STRING_32
		do
			if attached {JSON_STRING} json_value (a_json_data, a_id) as v then
				Result := v.unescaped_string_32
			end
		end

	unescaped_string_8_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable STRING_8
		do
			if attached {JSON_STRING} json_value (a_json_data, a_id) as v then
				Result := v.unescaped_string_8
			end
		end

	integer_tuple_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable TUPLE [INTEGER, INTEGER]
		do
			if
				attached {JSON_ARRAY} json_value (a_json_data, a_id) as v and then
				v.count = 2 and then attached {JSON_NUMBER} v.i_th (1) as l_index_1 and then
				attached {JSON_NUMBER} v.i_th (2) as l_index_2 and then
				l_index_1.numeric_type = l_index_1.integer_type and then
				l_index_2.numeric_type = l_index_2.integer_type
			then
				Result := [l_index_1.item.to_integer, l_index_2.item.to_integer]
			end
		end

end
