note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CLOUD_CHECKER_APP

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			cloud_factory: ES_CLOUD_FACTORY
			cl: ES_CLOUD_S
			u,p: STRING_32
			tok: STRING_8
			i,n: INTEGER
			v: READABLE_STRING_32
			acc: ES_ACCOUNT
		do
			create cloud_factory
			cl := cloud_factory.new_es_cloud
			print ("Checking cloud service at " + cl.server_url + " ...%N")

			if cl.is_available then
				print ("- cloud service: available %N")
				from
					i := 1
					n := argument_count
				until
					i > n
				loop
					if attached argument (i) as arg then
						if arg.same_string ("--token")  and i < n then
							i := i + 1
							v := argument (i)
							if v /= Void then
								tok := {UTF_CONVERTER}.string_32_to_utf_8_string_8 (v)
								tok.left_adjust; tok.right_adjust
								if tok.is_empty then
									tok := Void
								end
							end
						elseif arg.same_string ("--username")  and i < n then
							i := i + 1
							u := argument (i)
							if u /= Void then
								u.left_adjust; u.right_adjust
								if u.is_empty then
									u := Void
								end
							end
						elseif arg.same_string ("--password")  and i < n then
							i := i + 1
							p := argument (i)
							if p /= Void then
								p.left_adjust; p.right_adjust
								if p.is_empty then
									p := Void
								end
							end

						end
					end
					i := i + 1
				end
				if u = Void then
					io.put_string ("> Enter your username: ")
					io.read_line
					u := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (io.last_string)
					u.left_adjust; u.right_adjust
				end
				print ("- checking account [")
				print (u)

				if tok /= Void and then not tok.is_whitespace then
					print (" , signing with given access token [" + tok + "] %N")
					cl.sign_in_with_access_token (u, tok)
				else
					print (" , signing with credential ... %N")
					if p /= Void then
						io.put_string ("  > Enter your password: ")
						io.read_line
						p := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (io.last_string)
						p.left_adjust; p.right_adjust
					end
					cl.sign_in_with_credential (u, p)
				end
				acc := cl.active_account
				if cl.has_error then
					print ({STRING_32} "  > ERROR occurred while trying to sign with username ["+ u +"]%N")
					print_error (cl)
				elseif acc /= Void then
					print ({STRING_32} "  > SUCCESS: signed in with username ["+ u +"]%N")
					tok := acc.access_token.token
					print ("  > - access token: ["+ tok +"]%N")
				else
					print ({STRING_32} "  > ERROR: no account for username ["+ u +"]%N")
				end
				if acc /= Void then
					print ("- checking licenses ... %N")
					if attached cl.account_licenses (acc) as lst then
						print ("  > SUCCESS: " + lst.count.out + " license(s):%N")
						across
							lst as lic
						loop
							print ("  |  " + lic.key + ": ")
							if attached lic.plan_name as pl then
								print (" plan=" + pl)
							end
							if lic.is_active then
								print (" ACTIVE")
								if attached lic.expiration_date as dt then
									print (" days_remaining=" + lic.days_remaining.out)
									print (" expiration_date=[" + (create {HTTP_DATE}.make_from_date_time (dt)).iso8601_string + "]")
								else
									print (" never-expires")
								end
							else
								print (" INACTIVE")
							end
							if lic.is_fallback then
								print (" FALLBACK")
							end

							print ("%N")
						end
--						print ("  > SUCCESS: active license: "+ lic.key +"%N")
					else
						print ("  > ERROR: no license found.%N")
						if cl.has_error then
							print_error (cl)
						end
					end

					print ("- checking installations ... %N")
					if attached cl.account_installations (acc) as lst then
						across
							lst as inst
						loop
							print ("  |  " + inst.id + ": ")
							print ("%N")
						end
					elseif cl.has_error then
						print_error (cl)
					end
				end
			else
				print ("- cloud service: NOT available %N")
				print_error (cl)
			end
		end

feature -- Status

feature -- Access

feature -- Change

feature {NONE} -- Implementation

	print_error (cl: ES_CLOUD_S)
		require
			cl.has_error
		do
			if attached cl.last_error_message as err then
				print ("Error message: ")
				print (err)
				print ("%N")
			end
		end

invariant
--	invariant_clause: True

end
