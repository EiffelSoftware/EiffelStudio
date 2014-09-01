note
	description: "[
			Summary description for CMS_SESSION_CONTROLER.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SESSION_CONTROLER

inherit
	ANY

	WSF_SESSION_FACTORY [WSF_SESSION]

create
	make

feature -- Initialization

	make (req: WSF_REQUEST; a_mngr: like session_manager; a_site_id: READABLE_STRING_8)
		do
			site_id := a_site_id
			session_manager := a_mngr
			initialize
			create discarded_sessions.make
			get_session (req)
		end

	initialize
		do
			session_id_name := "_EWF_CMS_SESSID__" + site_id
		end

feature -- Session access

	site_id: READABLE_STRING_8
			-- Associated CMS site id.

	session: WSF_SESSION

	has_pending_session: BOOLEAN

	discarded_sessions: LINKED_LIST [like session]

feature -- Session operation

	session_commit (page: CMS_HTML_PAGE_RESPONSE; e: CMS_EXECUTION)
		do
			if has_pending_session then
				session.apply_to (page.header, e.request, e.request.script_url ("/"))
			end
			session.commit
		end

	apply_sessions_to (h: HTTP_HEADER; req: WSF_REQUEST; a_path: detachable READABLE_STRING_8)
		do
			session.apply_to (h, req, a_path)
			across
				discarded_sessions as c
			loop
				c.item.apply_to (h, req, a_path)
			end
		end

	start_session (req: WSF_REQUEST)
			-- Start a new session
		local
			s: like session
		do
			close_session (req)
			s := new_session (req, False, session_manager)
			req.set_execution_variable (session_request_variable_name, s)
			session := s
			if s.is_pending then
				has_pending_session := True
			end
		ensure
			session_attached: session /= Void
		end

	get_session (req: WSF_REQUEST)
			-- Get existing session, or start a new one
		local
			s: like session
		do
			if attached {like session} req.execution_variable (session_request_variable_name) as r_session then
				session := r_session
			else
				s := new_session (req, True, session_manager)
--				create {CMS_SESSION} s.make (req, "_EWF_CMS_SESSID")
				if s.is_pending then
					has_pending_session := True
				end
				session := s
				req.set_execution_variable (session_request_variable_name, s)
			end
			if session.expired then
				start_session (req)
			end
		end

	close_session (req: WSF_REQUEST)
			-- Close `session' if any
		do
			if session.is_pending then
				has_pending_session := has_pending_session or not discarded_sessions.is_empty
			else
				has_pending_session := True
				discarded_sessions.extend (session)
			end
			session.destroy
		end

feature -- Session internal

	session_manager: WSF_SESSION_MANAGER

	new_session (req: WSF_REQUEST; a_reuse: BOOLEAN; m: WSF_SESSION_MANAGER): like session
		local
			s: CMS_SESSION
			dt: DATE_TIME
		do
			if a_reuse then
				create s.make (req, session_id_name, m)
			else
				create s.make_new (session_id_name, m)
				create dt.make_now_utc
				dt.day_add (31)
				s.set_expiration (dt)
			end
			Result := s
		end

	session_request_variable_name: STRING = "_EWF_CMS_SESSION_"

	session_id_name: READABLE_STRING_8

end
