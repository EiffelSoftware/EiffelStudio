note
	description: "Summary description for {TWITTER_JSON}."
	author: "Jocelyn Fiat"
	date: "$Date$"
	revision: "$Revision$"

class
	TWITTER_JSON


feature -- Twitter: Account Methods

	show_tweet (a_string: STRING): detachable TWITTER_TWEETS
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached parsed_json (a_string) as j then
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
					Result := twitter_tweets (Void, j)
				end
			else
				print (a_string)
			end
		end

	verify_credentials (a_string: STRING): detachable TWITTER_USER
			-- Returns anrepresentation of the requesting user if authentication was successful
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached parsed_json (a_string) as j then
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
					Result := twitter_user (Void, j)
				end
			else
				print (a_string)
			end
		end


	twitter_tweets (a_tweet: detachable like twitter_tweets; a_json: JSON_VALUE): TWITTER_TWEETS
			-- Fill `a_tweet' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_tweet /= Void then
				Result := a_tweet
			else
				create Result
			end
			Result.set_created_at (string_value_from_json (a_json, "created_at"))
			Result.set_text (string_value_from_json (a_json, "text"))
			if attached {JSON_OBJECT} json_value (a_json, "user") as l_user then
				Result.set_user (twitter_user (Void, l_user))
			end
		end


	twitter_user (a_user: detachable like twitter_user; a_json: JSON_VALUE): TWITTER_USER
			-- Fill `a_user' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_user /= Void then
				Result := a_user
			else
				create Result
			end
			Result.set_id (integer_value_from_json (a_json, "id"))
			Result.set_created_at (string_value_from_json (a_json, "created_at"))
			Result.set_name (string_value_from_json (a_json, "name"))
			Result.set_screen_name (string_value_from_json (a_json, "screen_name"))
			if attached string_value_from_json (a_json, "location") as s then
				Result.set_location (stripslashes (s))
			else
				Result.set_location (Void)
			end
			Result.set_description (string_value_from_json (a_json, "description"))
			Result.set_profile_image_url (string_value_from_json (a_json, "profile_image_url"))
			Result.set_url (string_value_from_json (a_json, "url"))
			Result.set_protected (boolean_value_from_json (a_json, "protected"))
			Result.set_followers_count (integer_value_from_json (a_json, "followers_count"))

			if attached {JSON_OBJECT} json_value (a_json, "status") as l_status then
				Result.set_status (twitter_status (Void, l_status))
			end
		end


	twitter_status (a_status: detachable like twitter_status; a_json: JSON_VALUE): TWITTER_STATUS
			-- Fill `a_status' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_status /= Void then
				Result := a_status
			else
				create Result
			end
			Result.set_id (integer_value_from_json (a_json, "id"))
			Result.set_text (string_value_from_json (a_json, "text"))
			Result.set_in_reply_to_user_id (integer_value_from_json (a_json, "in_reply_to_user_id"))
			Result.set_in_reply_to_status_id (integer_value_from_json (a_json, "in_reply_to_status_id"))
			Result.set_in_reply_to_screen_name (string_value_from_json (a_json, "in_reply_to_screen_name"))
			Result.set_created_at (string_value_from_json (a_json, "created_at"))
			Result.set_truncated (boolean_value_from_json (a_json, "truncated"))
			Result.set_favorited (boolean_value_from_json (a_json, "favorited"))
			Result.set_source (string_value_from_json (a_json, "source"))

			if attached {JSON_OBJECT} json_value (a_json, "user") as l_user then
				Result.set_user (twitter_user (Void, l_user))
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

note
	copyright: "Copyright (c) 2003-2010, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
