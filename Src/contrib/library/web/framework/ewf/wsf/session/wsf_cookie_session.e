note
	description: "Summary description for {WSF_SESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_COOKIE_SESSION

inherit
	WSF_SESSION

create
	make,
	make_new

create {WSF_COOKIE_SESSION}
	make_with_uuid

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; a_cookie_name: detachable like cookie_name; a_manager: WSF_SESSION_MANAGER)
		local
			l_uuid: detachable READABLE_STRING_32
			s: WSF_COOKIE_SESSION
		do
			manager := a_manager
			initialize (a_cookie_name)
			if attached req.cookie (cookie_name) as c_value then
				if attached {WSF_STRING} c_value as c_uuid then
					l_uuid := c_uuid.value
				elseif attached {WSF_MULTIPLE_STRING} c_value as c_uuid_lst then
						-- This is not expected, thus clean existing cookies
						-- Question: maybe we could store the name of current server
						--			 to allow multiple cookies ?
					across
						c_uuid_lst as c
					loop
						create s.make_with_uuid (c.item.value, cookie_name, a_manager)
						s.destroy
						register_pending_session (req, s)
					end
				end
			elseif attached {WSF_STRING} req.query_parameter (cookie_name) as q_uuid then
				l_uuid := q_uuid.value
			end
			if l_uuid /= Void and then session_exists (l_uuid) then
				uuid := l_uuid
				load
			else
				is_pending := True
				build
			end
		end

	make_with_uuid (a_uuid: READABLE_STRING_32; a_cookie_name: detachable like cookie_name; a_manager: WSF_SESSION_MANAGER)
		do
			manager := a_manager
			initialize (a_cookie_name)
			if a_uuid /= Void and then session_exists (a_uuid) then
				uuid := a_uuid
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

	apply_to (h: HTTP_HEADER; req: WSF_REQUEST; a_path: detachable READABLE_STRING_8)
		local
			dt: detachable DATE_TIME
			l_domain: detachable READABLE_STRING_8
		do
			apply_pending_sessions_to (h, req, a_path)
			if is_pending then
				l_domain := req.server_name
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
					h.put_cookie_with_expiration_date (cookie_name, uuid, dt, a_path, l_domain, False, True)
				end
--				is_pending := False
			end
		end

	cookie_name: READABLE_STRING_8

feature -- Access		

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

	session_exists (a_uuid: like uuid): BOOLEAN
		do
			Result := manager.session_exists (a_uuid)
		end

	init_data
		do
 			create data.make (0)
			data.compare_objects
		end

	sessions_folder_name: READABLE_STRING_8
		local
			dn: DIRECTORY_NAME
		once
			create dn.make_from_string ((create {EXECUTION_ENVIRONMENT}).current_working_directory)
			dn.extend ("_sessions_")
			Result := dn.string
		end

	load
		do
			if manager.session_exists (uuid) then
				if attached manager.session_data (uuid) as d then
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

feature {NONE} -- Pending sessions


	register_pending_session (req: WSF_REQUEST; s: WSF_SESSION)
		local
			lst: LIST [WSF_SESSION]
			n: READABLE_STRING_8
		do
			n := cookie_name + "::pending_sessions"
			if attached {LIST [WSF_SESSION]} req.execution_variable (n) as v_lst then
				lst := v_lst
				lst.force (s)
			else
				create {ARRAYED_LIST [WSF_SESSION]} lst.make (1)
				lst.extend (s)
				req.set_execution_variable (n, lst)
			end
		end

	apply_pending_sessions_to (h: HTTP_HEADER; req: WSF_REQUEST; a_path: detachable READABLE_STRING_8)
		local
			s: WSF_SESSION
			n: READABLE_STRING_8
		do
			n := cookie_name + "::pending_sessions"
			if attached {LIST [WSF_SESSION]} req.execution_variable (n) as v_lst then
				req.unset_execution_variable (n)
				across
					v_lst as c
				loop
					s := c.item
					if s.is_pending then
						s.apply_to (h, req, a_path)
						check session_applied: not s.is_pending end
					end
				end
			end
		end

feature {NONE} -- Implementation

	uuid_generator: UUID_GENERATOR
		once
			create Result
		end

note
	copyright: "2011-2013, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

