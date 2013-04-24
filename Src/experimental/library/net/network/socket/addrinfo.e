note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ADDRINFO

feature -- Constants

	frozen AF_INET: INTEGER
		external
			"C"
		alias
			"en_addrinfo_af_inet"
		end

	frozen AF_INET6: INTEGER
		external
			"C"
		alias
			"en_addrinfo_af_inet6"
		end

feature -- Access

	flags: INTEGER
			-- Flags that indicate options used in the getaddrinfo function.
			-- See AI_PASSIVE, AI_CANONNAME, and AI_NUMERICHOST etc
		deferred
		end

	family: INTEGER
		-- Protocol family, such as PF_INET.
		deferred
		end

	socktype: INTEGER
			-- Denotes the type of socket that is wanted: SOCK_STREAM,
            -- SOCK_DGRAM, or SOCK_RAW.  When ai_socktype is zero the
            -- caller will accept any socket type
		deferred
		end

	protocol: INTEGER
			-- Indicates which transport protocol is desired, IPPROTO_UDP
			-- or IPPROTO_TCP.  If ai_protocol is zero the caller will
            -- accept any protocol.
		deferred
		end

	addrlen: INTEGER
			-- Length of the ai_addr member, in bytes.
		deferred
		end

	canonname: STRING
			-- Canonical name for the host.
		deferred
		end

	addr: POINTER
			-- Pointer to a sockaddr structure.
		deferred
		end

	next: detachable ADDRINFO
			-- Pointer to the next structure in a linked list.
			-- This is Void in the last addrinfo structure of a linked list
		deferred
		end

end

