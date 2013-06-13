note
	description: "[
			Light implementation of {OPENID} consumer.
			
			Sign-on with OpenID is a two step process:
			]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OPENID_CONSUMER

create
	make

feature {NONE} -- Initialization

	make (a_server: READABLE_STRING_8)
		do
			trusted_root := a_server
			return_url := a_server
			create required_info.make (0)
			create optional_info.make (0)
		end

feature -- Access

	trusted_root: READABLE_STRING_8

	return_url: READABLE_STRING_8

	required_info: ARRAYED_LIST [READABLE_STRING_8]
	optional_info: ARRAYED_LIST [READABLE_STRING_8]

	error: detachable READABLE_STRING_8

	has_error: BOOLEAN
		do
			Result := error /= Void
		end

feature -- Change

	ask_all_info (is_required: BOOLEAN)
		do
			across
				ax_to_sreg_map as c
			loop
				ask_info (c.key.to_string_32, is_required)
			end
		end

	ask_required_info (s: READABLE_STRING_8)
		do
			required_info.force (s)
		end

	ask_optional_info (s: READABLE_STRING_8)
		do
			optional_info.force (s)
		end

	ask_info (s: READABLE_STRING_8; is_required: BOOLEAN)
		do
			if is_required then
				ask_required_info (s)
			else
				ask_optional_info (s)
			end
		end

	ask_nickname (is_required: BOOLEAN)
		do
			ask_info ("namePerson/friendly", is_required)
		end

	ask_email (is_required: BOOLEAN)
		do
			ask_info ("contact/email", is_required)
		end

	ask_fullname (is_required: BOOLEAN)
		do
			ask_info ("namePerson", is_required)
		end

	ask_birthdate (is_required: BOOLEAN)
		do
			ask_info ("birthDate", is_required)
		end

	ask_gender (is_required: BOOLEAN)
		do
			ask_info ("person/gender", is_required)
		end

	ask_postcode (is_required: BOOLEAN)
		do
			ask_info ("contact/postalCode/home", is_required)
		end

	ask_country (is_required: BOOLEAN)
		do
			ask_info ("contact/country/home", is_required)
		end

	ask_language (is_required: BOOLEAN)
		do
			ask_info ("pref/language", is_required)
		end

	ask_timezone (is_required: BOOLEAN)
		do
			ask_info ("pref/timezone", is_required)
		end

feature -- Query

	auth_url (a_identity: READABLE_STRING_8): detachable READABLE_STRING_8
		do
			error := Void
			if attached discovering_info (a_identity) as d_info then
				if d_info.version = 2 then
					Result := auth_url_v2 (a_identity, d_info)
				else
					Result := auth_url_v1 (a_identity, d_info) -- FIXME for claimed_id
				end
			end
		end

feature {OPENID_CONSUMER_VALIDATION} -- Implementation				

	discovering_info (id: READABLE_STRING_8): detachable OPENID_DISCOVER
		local

			sess: HTTP_CLIENT_SESSION
			ctx: detachable HTTP_CLIENT_REQUEST_CONTEXT
			xrds_location: detachable READABLE_STRING_8
			xml: XML_STANDARD_PARSER
			tree: XML_CALLBACKS_DOCUMENT
			xelt: detachable XML_ELEMENT
			s: READABLE_STRING_32
			r_uri: detachable READABLE_STRING_8
			r_err: BOOLEAN
			r_delegate: detachable READABLE_STRING_8
			r_sreg_supported, r_ax_supported, r_identifier_select: BOOLEAN
			r_version: INTEGER
			l_xrds_content: detachable READABLE_STRING_8
		do
			sess := new_session (id)
			if attached sess.head ("", ctx) as rep then
				if rep.error_occurred then
					report_error ("Unable get answer from openid provider at " + rep.url)
				else
					if
						attached rep.header ("Content-Type") as l_content_type and then
						l_content_type.has_substring ("application/xrds+xml") and then
						attached sess.get ("", ctx) as l_getres
					then
						l_xrds_content := l_getres.body
					elseif attached rep.header ("X-XRDS-Location") as loc then
						xrds_location := loc
					else
						report_error ("Failed (probably %""+ id +"%" is an invalid openid identifier).")
					end
				end
			end
			if l_xrds_content = Void and xrds_location /= Void then
				sess := new_session (xrds_location)
				if attached sess.get ("", ctx) as rep then
					if rep.error_occurred then
						r_err := True
						report_error ("Can not get " + rep.url)
					elseif attached rep.body as l_content then
						l_xrds_content := l_content
					else
						r_err := True
						report_error ("No content: " + rep.url)
					end
				end
			end
			if l_xrds_content = Void then
				r_err := True
				report_error ("Unable to get the XRDS message.")
			else
				create xml.make
				create tree.make_null
				xml.set_callbacks (tree)
				xml.parse_from_string (l_xrds_content)
				if attached tree.document as xrds then
					xelt := Void
					xelt := xrds.elements.first
					xelt := xelt.elements.first
					if attached xelt as l_xrd then
						if attached l_xrd.elements_by_name ("Service") as l_services then
							across
								l_services as c
							until
								r_uri /= Void
							loop
								if attached c.item.elements_by_name ("Type") as l_types then
									across
										l_types as t
									loop
										s := xml_content (t.item)
										if s.same_string ("http://openid.net/sreg/1.0") then
											r_sreg_supported := True
										elseif s.same_string ("http://openid.net/extensions/sreg/1.1") then
											r_sreg_supported := True
										elseif s.same_string ("http://openid.net/srv/ax/1.0") then
											r_ax_supported := True
										elseif s.same_string ("http://specs.openid.net/auth/2.0/signon") then
											r_version := 2
										elseif s.same_string ("http://specs.openid.net/auth/2.0/server") then
											r_version := 2
											r_identifier_select := True
										elseif s.same_string ("http://openid.net/signon/1.1") then
											r_version := 1
										end
									end
								end
								if attached c.item.element_by_name ("URI") as l_uri then
									r_uri := xml_content (l_uri)
								end
								if r_version = 1 then
									if attached c.item.element_by_name ("openid:Delegate") as l_id then
										r_delegate := xml_content (l_id)
									end
									if attached c.item.element_by_name ("LocalID") as l_id then
										r_delegate := xml_content (l_id)
									end
								else
									if attached c.item.element_by_name ("CanonicalID") as l_id then
										r_delegate := xml_content (l_id)
									end
									if attached c.item.element_by_name ("LocalID") as l_id then
										r_delegate := xml_content (l_id)
									end
								end
							end
						end
					end
				end

			end
			if r_uri /= Void then
				create Result.make (r_uri, r_version)
				if r_delegate = Void then
					r_delegate := id
				end
				Result.delegate := r_delegate
				Result.ax_supported := r_ax_supported
				Result.sreg_supported := r_sreg_supported
				Result.identifier_select := r_identifier_select
				Result.has_error := r_err
			end
		end

feature {NONE} -- Implementation		

	auth_url_v1 (a_id: READABLE_STRING_8; a_info: OPENID_DISCOVER): READABLE_STRING_8
		local
			u: URI
			ret: URI
		do
			create u.make_from_string (a_info.server_uri)
			create ret.make_from_string (return_url)
			if
				attached a_info.delegate as l_claimed_id and then
				not a_id.same_string (l_claimed_id)
			then
				ret.add_query_parameter ("openid.claimed_id", l_claimed_id)
			end

			u.add_query_parameter ("openid.return_to", ret.string)
			u.add_query_parameter ("openid.mode", "checkid_setup") -- or "checkid_immediate"
			u.add_query_parameter ("openid.identity", a_id)
			u.add_query_parameter ("openid.trust_root", trusted_root)

			if a_info.sreg_supported then
				add_sreg_parameters_to (u)
			end

			Result := u.string
		end

	auth_url_v2 (a_id: READABLE_STRING_8; a_info: OPENID_DISCOVER): READABLE_STRING_8
		local
			u: URI
		do
			create u.make_from_string (a_info.server_uri)
			u.add_query_parameter ("openid.ns", "http://specs.openid.net/auth/2.0")
			u.add_query_parameter ("openid.mode", "checkid_setup") -- or "checkid_immediate"
			u.add_query_parameter ("openid.return_to", return_url)
			u.add_query_parameter ("openid.realm", trusted_root)

			if a_info.ax_supported then
				add_ax_parameters_to (u)
			end
			if a_info.sreg_supported then
				add_sreg_parameters_to (u)
			end
			if a_info.identifier_select then
				u.add_query_parameter ("openid.identity", "http://specs.openid.net/auth/2.0/identifier_select")
				u.add_query_parameter ("openid.claimed_id", "http://specs.openid.net/auth/2.0/identifier_select")
			else
				u.add_query_parameter ("openid.identity", a_id)
				u.add_query_parameter ("openid.claimed_id", a_id) -- Fixme
			end

			Result := u.string
		end

	add_ax_parameters_to (a_uri: URI)
		local
			lst: ARRAYED_LIST [READABLE_STRING_8]
			l_aliases: HASH_TABLE [READABLE_STRING_8, STRING_8]
			l_counts: HASH_TABLE [INTEGER, STRING_8]
			l_alias: READABLE_STRING_8
			s: STRING
		do
			create lst.make (required_info.count + optional_info.count)
			lst.append (required_info)
			lst.append (optional_info)
			if lst.count > 0 then
				a_uri.add_query_parameter ("openid.ns.ax", "http://openid.net/srv/ax/1.0")
				a_uri.add_query_parameter ("openid.ax.mode", "fetch_request");

				create l_aliases.make (lst.count)
				create l_counts.make (lst.count)
				across
					lst as c
				loop
					l_alias := ax_to_alias (c.item)
					if l_aliases.has (l_alias) then
						if attached l_counts.item (l_alias) as l_count then
							l_counts.replace (l_count + 1, l_alias)
						else
							check has_alias: False end
							l_counts.force (1, l_alias)
						end
					else
						l_aliases.force ("http://axschema.org/" + c.item, l_alias)
						l_counts.force (1, l_alias)
					end
				end
				across
					l_aliases as c
				loop
					a_uri.add_query_parameter ("openid.ax.type." + c.key, c.item)
				end
				across
					l_counts as c
				loop
					if c.item > 1 then
						a_uri.add_query_parameter ("openid.ax.count." + c.key, c.item.out)
					end
				end
					-- required
				create s.make_empty
				across
					required_info as c
				loop
					if not s.is_empty then
						s.append_character (',')
					end
					s.append (ax_to_alias (c.item))
				end
				if not s.is_empty then
					a_uri.add_query_parameter ("openid.ax.required", s)
				end
					-- optional
				create s.make_empty
				across
					optional_info as c
				loop
					if not s.is_empty then
						s.append_character (',')
					end
					s.append (ax_to_alias (c.item))
				end
				if not s.is_empty then
					a_uri.add_query_parameter ("openid.ax.if_available", s)
				end
			end
		end

	ax_to_alias (n: READABLE_STRING_8): STRING_8
		do
			if attached ax_to_sreg (n) as s then
				Result := s
			else
				Result := n.string
				Result.replace_substring_all ("/", "_")
				Result.replace_substring_all (".", "_")
			end
		end

	add_sreg_parameters_to (a_uri: URI)
		local
			s: STRING
		do
			-- We always use SREG 1.1, even if the server is advertising only support for 1.0.
			-- That's because it's fully backwards compatibile with 1.0, and some providers
			-- advertise 1.0 even if they accept only 1.1. One such provider is myopenid.com
			a_uri.add_query_parameter ("openid.ns.sreg", "http://openid.net/extensions/sreg/1.1")
			if not required_info.is_empty then
	            create s.make_empty
	            across
	            	required_info as c
	            loop
	            	if attached ax_to_sreg (c.item) as sreg then
	            		if not s.is_empty then
	            			s.append_character (',')
	            		end
	            		s.append (sreg)
	            	end
	            end
	            if not s.is_empty then
	            	a_uri.add_query_parameter ("openid.sreg.required", s)
	            end
			end

			if not optional_info.is_empty then
	            create s.make_empty
	            across
	            	optional_info as c
	            loop
	            	if attached ax_to_sreg (c.item) as sreg then
	            		if not s.is_empty then
	            			s.append_character (',')
	            		end
	            		s.append (sreg)
	            	end
	            end
	            if not s.is_empty then
	            	a_uri.add_query_parameter ("openid.sreg.optional", s)
	            end
			end
		end

	ax_to_sreg_map: HASH_TABLE [READABLE_STRING_8, STRING_8]
		once
			create Result.make (7)
			Result.compare_objects
			Result.force ("nickname", "namePerson/friendly")
			Result.force ("email", "contact/email")
			Result.force ("fullname", "namePerson")
			Result.force ("dob", "birthDate")
			Result.force ("gender", "person/gender")
			Result.force ("postcode", "contact/postalCode/home")
			Result.force ("country", "contact/country/home")
			Result.force ("language", "pref/language")
			Result.force ("timezone", "pref/timezone")

--			-- extension
--			Result.force ("firstname", "namePerson/first")
--			Result.force ("lastname", "namePerson/last")
		end

	ax_to_sreg (n: READABLE_STRING_8): detachable READABLE_STRING_8
		do
	        if attached ax_to_sreg_map.item (n) as v then
	        	Result := v
	        end
		end

	sreg_to_ax (n: READABLE_STRING_8): detachable READABLE_STRING_8
		do
			if ax_to_sreg_map.has_item (n) and then
				attached ax_to_sreg_map.found_item as v
			then
				Result := v
			end
		end

	report_error (m: READABLE_STRING_8)
		local
			err: like error
		do
			err := error
			if err = Void then
				error := m
			else
				error := err + "%N" + m
			end
			debug
				print (m)
			end
		ensure
			has_error
		end

feature -- Helper		

	xml_content (e: XML_ELEMENT): STRING_8
		do
			create Result.make_empty
			if attached e.contents as lst then
				across
					lst as c
				loop
					Result.append (c.item.content)
				end
			end
		end

	new_session (a_uri: READABLE_STRING_8): HTTP_CLIENT_SESSION
		local
			cl: LIBCURL_HTTP_CLIENT
		do
			create cl.make
			Result := cl.new_session (a_uri)
			Result.set_is_insecure (True)
			Result.set_max_redirects (5)
			Result.add_header ("Accept", "application/xrds+xml, */*")
		end

end
