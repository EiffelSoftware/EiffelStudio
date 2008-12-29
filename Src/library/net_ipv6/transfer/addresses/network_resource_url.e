note
	description:
		"URLs for network resources"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class NETWORK_RESOURCE_URL inherit

	URL
		redefine
			make, is_equal
		end

	HOST_VALIDITY_CHECKER
		rename
			host_ok as proxy_host_ok
		undefine
			is_equal
		end

feature {NONE} -- Initialization

	make (a: STRING)
			-- Create address.
		do
			create username.make (0)
			create password.make (0)
			Precursor {URL} (a)
		end

feature -- Access

	host: STRING
			-- Name or IP address of host

	path: STRING
			-- Path of resource

	username: STRING
			-- Optional username

	password: STRING
			-- Optional password

	location: STRING
			-- Full URL of resource
		do
			Result := service.twin
			Result.append ("://")
			Result.append (host)
			Result.extend ('/')
			if path /= Void and then not path.is_empty then
				Result.append (path)
			end
		end

	hash_code: INTEGER
			-- Hash function
		local
			str: STRING
		do
			str := host.twin
			if not username.is_empty then
				str.precede (':')
				str.prepend (username)
			end
			Result := str.hash_code
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is equal to `other'?
		do
			if host /= Void and username /= Void and other /= Void then
				Result := equal (host, other.host) and
					equal (username, other.username)
				if Result then
					Result := equal (is_proxy_used, other.is_proxy_used)
					if Result and is_proxy_used then
						Result := equal (proxy_host, other.proxy_host)
					end
				end
			end
		end

feature -- Status report

	is_host_correct (h: STRING): BOOLEAN
			-- Is host `h' name correct?
		do
			Result :=  h /= Void and then host_charset.contains_string (h)
		end

	is_path_correct (p: STRING): BOOLEAN
			-- Is path name correct?
		do
			Result := p /= Void and then path_charset.contains_string (p)
		end

	is_correct: BOOLEAN
			-- Is address correct?
		do
			Result := is_host_correct (host) and then is_path_correct (path)
		end

	is_password_accepted: BOOLEAN
			-- Can a password be set?
		do
			Result := not username.is_empty
		end

feature -- Status setting

	set_username (un: STRING)
			-- Set username.
		do
			username := un
		ensure then
			username_set: username = un
		end

	set_password (pw: STRING)
			-- Set password.
		do
			password := pw
		ensure then
			password_set: password = pw
		end

feature {NONE} -- Basic operations

	analyze
			-- Analyze address.
		local
			pos, pos2: INTEGER
			l_sep_pos: INTEGER
		do
			pos := address.index_of ('/', 1)
			if pos = 0 then
					-- Make sure there is a `/'
				address.extend ('/')
				pos := address.count
			end
			l_sep_pos := address.substring_index ("//", 1)
			if pos > 1 and l_sep_pos = 0 and
				address.substring_index (Service + ":", 1) = 0 then
				host := address.substring (1, pos - 1)
				address.remove_head (pos)
				path := address.twin
			elseif l_sep_pos > 0 and
				address.substring_index (Service + ":", 1) > 0 then
				pos2 := address.index_of ('/', pos + 2)
				host := address.substring (pos + 2, pos2 - 1)
				address.remove_head (pos2)
				path := address.twin
			end

			if not host.is_empty and has_username and
				host.occurrences ('@') = 1 then
				pos := host.index_of ('@', 1)
				username := host.substring (1, pos - 1)
				host.remove_head (pos)
				if not username.is_empty and
					username.occurrences (':') = 1 then
					pos := username.index_of (':', 1)
					password := username.substring (pos + 1, username.count)
					username.keep_head (pos - 1)
				end
			end

			host.to_lower
			if not host.is_empty then
					--  look for port
				if host.item (1) = '[' then
					-- IPv6 numeric address ?
					pos := host.last_index_of (']', host.count)
					if pos /= 0 then
						pos := host.index_of (':', pos)
					else
						-- TODO this is an incorrect situation actually
						-- The IPv6 address should be terminated by the ']'
						-- We should handle it somehow
					end
				else
					pos := host.last_index_of (':', host.count)
				end
				if pos = host.count then
					host.remove_tail (1)
				elseif pos > 0 and host.substring (pos + 1, host.count).is_integer then
					port := host.substring (pos + 1, host.count).to_integer
					host.keep_head (pos - 1)
				end
			end
		end

feature {NONE} -- Implementation

	path_charset: CHARACTER_SET
			-- Character set for path names
		once
			Result := Host_charset.twin
			Result.add ("%%/_")
		ensure
			path_charset_not_void: Result /= Void
			path_charset_not_empty: not path_charset.is_empty
		end

invariant
	username_exists: username /= Void
	password_exists: password /= Void
	password_constraint: not password.is_empty implies not username.is_empty

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class NETWORK_RESOURCE_URL

