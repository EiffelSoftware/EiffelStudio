note
	description: "[
			]"

class
	USER_ACCOUNT_CMS_EXECUTION

inherit
	CMS_EXECUTION

create
	make

feature -- Execution

	process
			-- Computed response message.
		local
			b: STRING_8
			vars: detachable ARRAY [READABLE_STRING_32]
			n: INTEGER
--			vars: detachable WSF_TABLE
		do
			if attached {WSF_TABLE} request.path_parameter ("vars") as tb then
				vars := tb.as_array_of_string
			end
			if vars = Void or else vars.is_empty then
				set_title ("Account")
				create b.make_empty
				b.append ("Account")
				set_main_content (b)
			else
				n := vars.count
				create b.make_empty
				if n >= 1 then
					if vars[1].same_string ("password") then
						set_title ("Password")
						if n >= 2 then
							if vars[2].same_string ("reset") then
								b.append ("Reset password")
							else
								b.append ("password ???")
							end
						end
					elseif vars[1].same_string ("register") then
						set_title ("Registration")
						b.append ("Register new account")
					else
						b.append ("???")
					end
				else
					set_title ("Account/")
					b.append ("...")
				end
				set_main_content (b)
			end
		end

end
