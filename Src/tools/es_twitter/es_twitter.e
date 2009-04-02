note
	description : "Eiffel Twitter client"
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_TWITTER

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		local
			t: TWITTER_I
			s: STRING
			pref: like preferences
			src: STRING
			retried: BOOLEAN
		do
			if not retried then
				create pref
				if attached separate_character_option_value ('u') as l_login then
					pref.login := l_login
				end
				if attached separate_character_option_value ('p') as l_passwd then
					pref.password := l_passwd
				end
				if attached separate_word_option_value ("source") as l_source then
					src := l_source
				else
					src := "EiffelTwitter"
				end
				if index_of_character_option ('i') > 0 then
					pref := preferences (True, pref)
				end
				if pref.login = Void or pref.password = Void then
					usage ("Missing login/password ...%N")
				else
					create {TWITTER_JSON} t.make_with_source (pref.login, pref.password, src)
					if attached t.verify_credentials as l_user then
						print ("Authentication succeed...%N")
						start_tweeting (t)
					else
						print ("Authentication failed...%N")
					end
				end
			else
				print ("Bye ...%N")
			end
		rescue
			print ("Authentication failed...%N")
			retried := True
			retry
		end

	usage (m: detachable STRING)
		do
			if m /= Void then
				io.error.put_string (m)
				io.error.put_new_line
			end
			io.error.put_string ("Usage: -i (-c|-f filename) -u login -p password -a action arguments...%N")
			io.error.put_string ("   -i: interactive, ask login/password%N")
			io.error.put_string ("   -c: text from input%N")
			io.error.put_string ("   -f: text from file %"filename%"%N")
			io.error.put_string ("   -a: action followed by eventual arguments%N")
			io.error.put_string ("%N")
			io.error.put_string (" Action can be:%N")
			io.error.put_string ("   update: to post an update%N")
			io.error.put_string ("   message user: new message to %"user%"%N")
			io.error.put_string ("   createfriendship user: create friendship with %"user%"%N")
			io.error.put_string ("   destroyfriendshipt user: destroy friendship with %"user%"%N")
			io.error.put_string ("   friends {user}: list friends of authenticated user or %"user%"%N")
			io.error.put_string ("   followers {user}: list followers of authenticated user or %"user%"%N")
			io.error.put_string ("%N")
		end

	start_tweeting (t: TWITTER_I)
		local
			a: detachable ANY
			f: RAW_FILE
			l_action, l_arg: detachable STRING
			l_data: CELL [STRING]
			txt: STRING
			i: INTEGER
		do
			debug ("twitter")
				if attached t.rate_limit_status (True) as rate then
					print ("Remaining twitter hits: " + rate.remaining_hits.out + " / " + rate.hourly_limit.out + "%N")
				end
			end
			if attached separate_character_option_value ('a') as v then
				l_action := v
			end

--			if attached t.user_timeline (0, "djocenet", Void, 0, 0, 0) as l_stats then
--					print ("%NUpdates:%N")
--					print ("-----------------------------------%N")
--					display_statuses (l_stats)
--					print ("-----------------------------------%N")
--			end

			create l_data.put ("")
			if l_action /= Void then
				if l_action.is_case_insensitive_equal ("update") then
					get_input (l_data)
					txt := l_data.item
					if txt.count <= 140 then
						if attached t.update_status (txt, 0) as l_stat then
							print ("%NUpdate posted:%N")
							print ("-----------------------------------%N")
							display_status (l_stat, True)
							print ("-----------------------------------%N")
						end
					else
						print ("Text should be less than 140 characters.%N")
					end
				elseif l_action.is_case_insensitive_equal ("message") then
					if attached argument (index_of_character_option ('a') + 2) as l_user then
						get_input (l_data)
						txt := l_data.item
						if txt.count <= 140 then
							if attached t.new_message (l_user, txt) as l_mesg then
								print ("%NMessage sent:%N")
								print ("-----------------------------------%N")
								display_message (l_mesg, True)
								print ("-----------------------------------%N")
							end
						else
							print ("Text should be less than 140 characters.%N")
						end
					else
						usage ("Missing recipient...%N")
					end
				elseif l_action.is_case_insensitive_equal ("createfriendship") then
					if attached argument (index_of_character_option ('a') + 2) as l_user then
						if attached t.create_friendship (0, l_user, False) as l_friend then
							print ("%NFriendship created with " + l_user + ":%N")
							print ("-----------------------------------%N")
							display_user (l_friend, True)
							print ("-----------------------------------%N")
						end
					else
						usage ("Missing screen_name...%N")
					end
				elseif l_action.is_case_insensitive_equal ("destroyfriendship") then
					if attached argument (index_of_character_option ('a') + 2) as l_user then
						if attached t.destroy_friendship (0, l_user) as l_friend then
							print ("%NFriendship destroyed with " + l_user + ":%N")
							print ("-----------------------------------%N")
							display_user (l_friend, True)
							print ("-----------------------------------%N")
						end
					else
						usage ("Missing screen_name...%N")
					end
				elseif l_action.is_case_insensitive_equal ("friends") then
					i := index_of_character_option ('a') + 2
					if i <= argument_count and then attached argument (i) as l_user then
						l_arg := l_user
					end
					if attached t.friends (0, l_arg, 0) as l_friends then
						print ("%NFriends:%N")
						print ("-----------------------------------%N")
						display_users (l_friends)
						print ("-----------------------------------%N")
					end
				elseif l_action.is_case_insensitive_equal ("followers") then
					i := index_of_character_option ('a') + 2
					if i <= argument_count and then attached argument (i) as l_user then
						l_arg := l_user
					end
					if attached t.followers (0, l_arg, 0) as l_followers then
						print ("%NFollowers:%N")
						print ("-----------------------------------%N")
						display_users (l_followers)
						print ("-----------------------------------%N")
					end
				end
			end
		end

	get_input (a_data: CELL [STRING])
		local
			f: RAW_FILE
		do
			if index_of_character_option ('c') > 0 then
				get_input_from (a_data, io.input)
			elseif attached separate_character_option_value ('f') as fn then
				create f.make_open_read (fn)
				get_input_from (a_data, f)
				f.close
			else
				get_input_from (a_data, io.input)
			end
		end

	get_input_from (a_data: CELL [STRING]; f: FILE)
		local
			txt, s: detachable STRING
			i: INTEGER
			console: FILE
		do
			from
				f.read_line
				s := f.last_string
				check s /= Void end
				create txt.make_empty
			until
				f.end_of_file or s.is_empty
			loop
				txt.append (s)
				if not f.end_of_file then
					txt.append ("%N")
				end
				f.read_line
				s := f.last_string
				check s /= Void end
			end
			a_data.replace (txt)
		end

	post_file (t: TWITTER_I; f: FILE)
		local
			txt, s: detachable STRING
			i: INTEGER
			console: FILE
		do
			from
				f.read_line
				s := f.last_string
				check s /= Void end
				create txt.make_empty
			until
				f.end_of_file or s.is_empty
			loop
				txt.append (s)
				if not f.end_of_file then
					txt.append ("%N")
				end
				f.read_line
				s := f.last_string
				check s /= Void end
			end
			print ("f=" + txt)
			if txt.count <= 140 then
				if attached t.update_status (txt, i) as l_stat then
					i := l_stat.id
				end
			else
				print ("Text should be less than 140 characters.%N")
			end
		end

feature -- Access

	display_status (a_status: TWITTER_STATUS; is_full: BOOLEAN)
		do
			if is_full then
				print (a_status.full_out)
			else
				print (a_status.short_out)
			end
			io.new_line
		end

	display_user (a_user: TWITTER_USER; is_full: BOOLEAN)
		do
			if is_full then
				print (a_user.full_out)
			else
				print (a_user.short_out)
			end
			io.new_line
		end

	display_message (a_mesg: TWITTER_MESSAGE; is_full: BOOLEAN)
		do
			if is_full then
				print (a_mesg.full_out)
			else
				print (a_mesg.short_out)
			end
			io.new_line
		end

	display_statuses (a_list: LIST [TWITTER_STATUS])
		do
			from
				a_list.start
			until
				a_list.after
			loop
				display_status (a_list.item, False)
				a_list.forth
			end
		end

	display_users (a_list: LIST [TWITTER_USER])
		do
			from
				a_list.start
			until
				a_list.after
			loop
				display_user (a_list.item, False)
				a_list.forth
			end
		end

	display_messages (a_list: LIST [TWITTER_MESSAGE])
		do
			from
				a_list.start
			until
				a_list.after
			loop
				display_message (a_list.item, False)
				a_list.forth
			end
		end

feature -- Change

	preferences (a_new: BOOLEAN; a_pref: detachable like preferences): TUPLE [login: STRING; password: STRING]
		local
			d: detachable like preferences
			f: RAW_FILE
			s: detachable STRING
		do
			create f.make ("eiffel_twitter.data")
			if not a_new and f.exists and then f.is_readable then
				f.open_read
				d ?= f.retrieved
				f.close
			end
			if d = Void then
				create d
				io.put_string ("Please provide your twitter's account details.%N")
				io.put_string ("login: ")
				io.read_line
				s := io.last_string
				check s /= Void end
				d.login := s.string
				io.output.put_string ("password: ")
				io.read_line
				s := io.last_string
				check s /= Void end
				d.password := s.string
				f.open_write
				f.independent_store (d)
				f.close
			end
			if a_pref /= Void then
				a_pref.login := d.login
				a_pref.password := d.password
				Result := a_pref
			else
				Result := d
			end
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
