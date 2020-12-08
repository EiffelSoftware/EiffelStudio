note
	description: "Summary description for {JWT_AUTH_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_AUTH_TOKEN

create
	make

feature {NONE} -- Initialization

	make (a_user: CMS_USER; a_token: like token; a_refresh_key: like refresh_key)
		do
			user := a_user
			refresh_key := a_refresh_key
			token := a_token
		end

feature -- Access

	user: CMS_USER

	token: READABLE_STRING_8
			-- JWT value.

	refresh_key: READABLE_STRING_8
			-- Optional refresh token.

	secret: detachable READABLE_STRING_8
			-- Value used to sign `token`.

	applications: detachable LIST [READABLE_STRING_GENERAL]
			-- Applications accepting `token`.

	applications_as_csv: detachable STRING_32
			-- `applications` list as comma separated value.
		do
			if attached applications as apps and then not apps.is_empty then
				create Result.make_empty
				across
					apps as ic
				loop
					if not Result.is_empty then
						Result.append_character (',')
					end
					Result.append_string_general (ic.item)
				end
			end
		end

feature -- Status report

	is_expired (dt: detachable DATE_TIME): BOOLEAN
		local
			tok: like jwt
		do
			tok := jwt
			Result := tok = Void
				or else (
					tok.has_error
					or else tok.is_expired (dt)
				)
		end

	jwt: detachable JWT
			-- JWT parser token.
		local
			jwt_loader: JWT_LOADER
			ctx: JWT_CONTEXT
			sec: READABLE_STRING_8
		do
			Result := internal_jwt
			if Result = Void then
				create jwt_loader
				create ctx
				sec := secret
				if sec = Void or else sec.is_whitespace then
					ctx.ignore_validation (True)
					sec := ""
				end
				Result := jwt_loader.token (token, {JWT_ALG_HS256}.name, sec, ctx)
				internal_jwt := Result
			end
		end

feature {NONE} -- Internal

	internal_jwt: detachable JWT

	reset_jwt
		do
			internal_jwt := Void
		end

feature -- Element change

	set_user (u: like user)
		do
			user := u
			reset_jwt
		end

	set_secret (sec: like secret)
		do
			secret := sec
			reset_jwt
		end

	set_application (app: READABLE_STRING_GENERAL)
		local
			lst: like applications
			s: STRING_32
		do
			lst := applications
			if lst = Void then
				create {ARRAYED_LIST [READABLE_STRING_GENERAL]} lst.make (1)
				applications := lst
			end
			s := app.as_string_32
			s.left_adjust
			s.right_adjust
			lst.force (s)
			reset_jwt
		end

	unset_application (app: READABLE_STRING_GENERAL)
		local
			lst: like applications
		do
			lst := applications
			if lst /= Void and then not lst.is_empty then
				from
					lst.start
				until
					lst.after
				loop
					if app.is_case_insensitive_equal (lst.item) then
						lst.remove
					else
						lst.forth
					end
				end
			end
			reset_jwt
		end

end
