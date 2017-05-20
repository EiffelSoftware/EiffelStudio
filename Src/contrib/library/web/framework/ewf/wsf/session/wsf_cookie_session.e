note
	description: "Summary description for {WSF_SESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_COOKIE_SESSION

inherit
	WSF_SESSION

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

create
	make,
	make_new

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; a_cookie_name: detachable like cookie_name; a_manager: WSF_SESSION_MANAGER)
		local
			l_uuid: detachable READABLE_STRING_32
		do
			manager := a_manager
			initialize (a_cookie_name)
			if attached {WSF_STRING} req.cookie (cookie_name) as c_uuid then
				l_uuid := c_uuid.value
			elseif attached {WSF_STRING} req.query_parameter (cookie_name) as q_uuid then
				l_uuid := q_uuid.value
			end
			if
				l_uuid /= Void and then
				l_uuid.is_valid_as_string_8 and then
				session_exists (l_uuid)
			then
				uuid := l_uuid.to_string_8
				load
			else
				is_pending := True
				build
			end
		end

	make_new (a_cookie_name: detachable like cookie_name; a_manager: WSF_SESSION_MANAGER)
		do
			manager := a_manager
			initialize (a_cookie_name)
			is_pending := True
			build
		end

	initialize (a_cookie_name: detachable like cookie_name)
		do
			if a_cookie_name = Void or else a_cookie_name.is_empty then
				cookie_name := "_EWF_SESSION_ID"
			else
				cookie_name := a_cookie_name
			end
		end

feature -- Cookie

	apply_to (h: HTTP_HEADER_MODIFIER; a_request: WSF_REQUEST; a_path: detachable READABLE_STRING_8)
			-- <Precursor>
		local
			dt: detachable DATE_TIME
			l_domain: detachable READABLE_STRING_8
		do
			l_domain := a_request.server_name
			if l_domain.same_string ("localhost") then
					-- Due to limitation of specific handling of local cookies
					-- it is recommended to use Void or IP instead of "localhost"
				l_domain := Void
			end
			if is_destroyed then
				h.put_cookie (cookie_name, "deleted", "Thu, 01 Jan 1970 00:00:00 GMT", a_path, l_domain, False, True)
			else
				dt := expiration
				if dt = Void then
					create dt.make_now_utc
					dt.day_add (40)
				end
				h.put_cookie_with_expiration_date (cookie_name, id, dt, a_path, l_domain, False, True)
			end
		end

	cookie_name: READABLE_STRING_8

feature -- Access	

	id: READABLE_STRING_8
		do
			Result := uuid
		end

	uuid: READABLE_STRING_8

	data: WSF_SESSION_DATA

	expiration: detachable DATE_TIME

feature -- status

	is_pending: BOOLEAN

	is_destroyed: BOOLEAN

feature -- Control

	destroy
		do
			is_destroyed := True
			data.wipe_out
			delete
		end

	commit
		do
			save
		end

	set_expiration (dt: like expiration)
		do
			expiration := dt
		end

feature {NONE} -- Storage

	manager: WSF_SESSION_MANAGER

	session_exists (a_uuid: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := manager.session_exists (a_uuid)
		end

	init_data
		do
 			create data.make (0)
			data.compare_objects
		end

	load
		do
			if manager.session_exists (id) then
				if attached manager.session_data (id) as d then
					data := d
					set_expiration (data.expiration)
				else
					init_data
					save
				end
			else
				build
			end
		rescue
			debug ("wsf")
				io.error.put_string ("Error while loading Cookie session...!%N")
			end
		end

	build
		do
			uuid := uuid_generator.generate_uuid.out
			init_data
			save
		end

	save
		do
			manager.save_session (Current)
		end

	delete
		do
			manager.delete_session (Current)
		end

feature {NONE} -- Implementation

	uuid_generator: UUID_GENERATOR
		once
			create Result
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

