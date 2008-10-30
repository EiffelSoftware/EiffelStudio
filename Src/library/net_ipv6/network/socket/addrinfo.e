indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class

	ADDRINFO

feature -- Constants

	AI_PASSIVE: INTEGER = 0x0001
	AI_CANONNAME: INTEGER = 0x0002
	AI_NUMERICHOST: INTEGER = 0x0004
	AI_V4MAPPED: INTEGER = 0x0008
	AI_ALL: INTEGER = 0x0010
	AI_ADDRCONFIG: INTEGER = 0x0020

	AF_UNSPEC: INTEGER = 0
	AF_UNIX: INTEGER = 1
	AF_INET: INTEGER = 2
	AF_INET6: INTEGER = 23

	PF_UNSPEC: INTEGER = 0
	PF_UNIX: INTEGER = 1
	PF_INET: INTEGER = 2

feature -- Access

	flags: INTEGER_32 is
			-- Flags that indicate options used in the getaddrinfo function.
			-- See AI_PASSIVE, AI_CANONNAME, and AI_NUMERICHOST etc
		deferred
		end

	family: INTEGER is
		-- Protocol family, such as PF_INET.
		deferred
		end

	socktype: INTEGER is
			-- Denotes the type of socket that is wanted: SOCK_STREAM,
            -- SOCK_DGRAM, or SOCK_RAW.  When ai_socktype is zero the
            -- caller will accept any socket type
		deferred
		end

	protocol: INTEGER is
			-- Indicates which transport protocol is desired, IPPROTO_UDP
			-- or IPPROTO_TCP.  If ai_protocol is zero the caller will
            -- accept any protocol.
		deferred
		end

	addrlen: INTEGER
			-- Length of the ai_addr member, in bytes.
		deferred
		end

	canonname: STRING is
			-- Canonical name for the host.
		deferred
		end

	addr: POINTER is
			-- Pointer to a sockaddr structure.
		deferred
		end

	next: ADDRINFO is
			-- Pointer to the next structure in a linked list.
			-- This is Void in the last addrinfo structure of a linked list
		deferred
		end

end

