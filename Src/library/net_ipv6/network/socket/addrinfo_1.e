indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class

	ADDRINFO_1

inherit

	ADDRINFO

	EXTERNAL_OBJECT

create

	make_from_external

feature -- Access

	flags: INTEGER_32 is
		do
			Result := c_ai_flags (object_ptr)
		end

	family: INTEGER is
		do
			Result := c_ai_family (object_ptr)
		end

	socktype: INTEGER is
		do
			Result := c_ai_socktype (object_ptr)
		end

	protocol: INTEGER is
		do
			Result := c_ai_protocol (object_ptr)
		end

	addrlen: INTEGER
		do
			Result := c_ai_addrlen (object_ptr)
		end

	canonname: STRING is
		do
			Result := c_ai_canonname (object_ptr)
		end

	addr: POINTER is
		do
			Result := c_ai_addr (object_ptr)
		end

	next: ADDRINFO is
		local
			p: POINTER
		do
			p := c_ai_next (object_ptr)
			if p /= default_pointer then
				create {ADDRINFO_2} Result.make_from_external (p)
			end
		end

feature {NONE} -- Externals

	c_ai_flags (obj_ptr: POINTER): INTEGER_32 is
		external
			"C"
		alias
			"en_addrinfo_ai_flags"
		end

	c_ai_family (obj_ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"en_addrinfo_ai_family"
		end

	c_ai_socktype (obj_ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"en_addrinfo_ai_socktype"
		end

	c_ai_protocol (obj_ptr: POINTER): INTEGER is
		external
			"C"
		alias
			"en_addrinfo_ai_protocol"
		end

	c_ai_addrlen (obj_ptr: POINTER): INTEGER
		external
			"C"
		alias
			"en_addrinfo_ai_addrlen"
		end

	c_ai_canonname (obj_ptr: POINTER): STRING is
		external
			"C"
		alias
			"en_addrinfo_ai_canonname"
		end

	c_ai_addr (obj_ptr: POINTER): POINTER is
		external
			"C"
		alias
			"en_addrinfo_ai_addr"
		end

	c_ai_next (obj_ptr: POINTER): POINTER is
		external
			"C"
		alias
			"en_addrinfo_ai_next"
		end

	c_free (obj_ptr: POINTER) is
		external
			"C"
		alias
			"en_free_addrinfo"
		end

end

