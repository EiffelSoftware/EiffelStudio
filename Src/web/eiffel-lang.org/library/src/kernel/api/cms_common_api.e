note
	description: "Summary description for {WSF_CMS_COMMON_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_COMMON_API

inherit
	WSF_API_UTILITIES

feature {NONE} -- Access

	service: CMS_SERVICE
		deferred
		end

	site_url: READABLE_STRING_8
		do
			Result := service.site_url
		end

	base_url: detachable READABLE_STRING_8
			-- Base url if any.
		do
			Result := service.script_url
		end

feature -- Access

	user_link (u: CMS_USER): like link
		do
			Result := link (u.name, "/user/" + u.id.out, Void)
		end

	node_link (n: CMS_NODE): like link
		do
			Result := link (n.title, "/node/" + n.id.out, Void)
		end

	user_url (u: CMS_USER): like url
		do
			Result := url ("/user/" + u.id.out, Void)
		end

	node_url (n: CMS_NODE): like url
		do
			Result := url ("/node/" + n.id.out, Void)
		end

feature -- Helper

	is_empty (s: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' is Void or empty ?
		do
			Result := s = Void or else s.is_empty
		end

	unix_timestamp (dt: DATE_TIME): INTEGER_64
		do
			Result := (create {HTTP_DATE_TIME_UTILITIES}).unix_time_stamp (dt)
		end

	unix_timestamp_to_date_time (t: INTEGER_64): DATE_TIME
		do
			Result := (create {HTTP_DATE_TIME_UTILITIES}).unix_time_stamp_to_date_time (t)
		end

	string_unix_timestamp_to_date_time (s: READABLE_STRING_8): DATE_TIME
		do
			if s.is_integer_64 then
				Result := (create {HTTP_DATE_TIME_UTILITIES}).unix_time_stamp_to_date_time (s.to_integer_64)
			else
				Result := (create {HTTP_DATE_TIME_UTILITIES}).unix_time_stamp_to_date_time (0)
			end
		end

feature {NONE} -- Implementation

	options_boolean (opts: HASH_TABLE [detachable ANY, STRING]; k: STRING; dft: BOOLEAN): BOOLEAN
		do
			if attached {BOOLEAN} opts.item (k) as h then
				Result := h
			else
				Result := dft
			end
		end

	options_string (opts: HASH_TABLE [detachable ANY, STRING]; k: STRING): detachable STRING
		do
			if attached {STRING} opts.item (k) as s then
				Result := s
			end
		end

--	html_encoder: HTML_ENCODER
--		once ("thread")
--			create Result
--		end

end
