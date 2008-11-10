indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class

	INET_ADDRESS_FACTORY

inherit

	INET_PROPERTIES

	SOCKET_RESOURCES

feature

	create_any_local: INET_ADDRESS is
			--
		do
			Result := impl.any_local_address
		end

	create_localhost: INET_ADDRESS is
			--
		local
			localhostname: STRING
		do
			localhostname := impl.local_host_name
			Result := create_from_name (localhostname)
		end

	create_from_name (hostname: STRING): INET_ADDRESS is
			--
		local
			r: ARRAY[INET_ADDRESS]
		do
			r := get_all_by_name (hostname)
			if r /= Void then
				Result := r.item (1)
			end
		end

	create_from_address (address: ARRAY [NATURAL_8]) : INET_ADDRESS is
			--
		require
			valid_address: address /= Void
		local
			new_addr: ARRAY [NATURAL_8]
		do
		    if address.count = {INET4_ADDRESS}.INADDRSZ then
				create {INET4_ADDRESS} Result.make_from_host_and_address (Void, address)
	    	elseif address.count ={INET6_ADDRESS}.INADDRSZ then
				new_addr := convert_from_ipv4_mappedd_address (address)
				if new_addr /= Void then
					create {INET4_ADDRESS} Result.make_from_host_and_address (Void, new_addr)
				else
					create {INET6_ADDRESS} Result.make_from_host_and_address (Void, new_addr)
				end
			end
		end

	create_from_sockaddr (sockaddr: POINTER) : INET_ADDRESS is
			--
		require
			valid_sockaddr: sockaddr /= default_pointer
		local
			family:	INTEGER
		do
			family := get_sock_family (sockaddr)
			if family = af_inet then
				create {INET4_ADDRESS} Result.make_from_host_and_pointer (Void, sockaddr)
			elseif family = af_inet6 then
				create {INET6_ADDRESS} Result.make_from_host_and_pointer (Void, sockaddr)
				if is_ipv4_mapped_address (Result.raw_address) then
					create {INET4_ADDRESS} Result.make_from_host_and_address (Void, convert_from_ipv4_mappedd_address (Result.raw_address))
				end
			end
		end

feature {NONE} -- Implementation

	impl: INET_ADDRESS_IMPL is
		once
			if is_ipv6_available then
				create {INET_ADDRESS_IMPL_V6} Result
			else
				create {INET_ADDRESS_IMPL_V4} Result
			end
		end

	INT16SZ: INTEGER is 2

    get_all_by_name (a_host: STRING): ARRAY[INET_ADDRESS] is
    	local
    		ipv6_expected: BOOLEAN
    		host: STRING
    		addr_array: ARRAY [NATURAL_8]
    		addr: INET_ADDRESS
    		numeric_zone: INTEGER
    		iface_name: STRING
    		pos: INTEGER
    		failed: BOOLEAN
	do
		host := a_host
		if host = Void or else host.is_empty then
			create Result.make (1, 1)
			Result.put (impl.loopback_address, 1)
		else
			failed := False
			if host.item (1) = '[' then
				if host.count > 2 and then host.item(host.count) = ']' then
					host := host.substring (2, host.count)
					ipv6_expected := True;
	    			else
					-- This was supposed to be a IPv6 address, but it's not!
					-- TODO report error
					failed := True
				end
	    		end
	    		if not failed then
				if host.item(1).is_hexa_digit or else host.item(1) = ':' then
	    				addr_array := text_to_numeric_format_v4 (host)
	    				if addr_array = Void then
						pos :=  host.index_of ('%%', 1)
						if  pos /= 0 then
		    					numeric_zone := check_numeric_zone (host)
							if numeric_zone = -1 then
								iface_name := host.substring (pos+1, host.count)
							end
						end
						addr_array := text_to_numeric_format_v6 (host);
	    				elseif  ipv6_expected then
						-- Means an IPv4 litteral between brackets!
						-- TODO throw new UnknownHostException("["+host+"]");
						-- TODO report error
						failed := True
	    				end
	    				if not failed then
	    					if addr_array /= Void then
							create Result.make (1, 1)
							if addr_array.count = {INET4_ADDRESS}.INADDRSZ then
								create {INET4_ADDRESS} addr.make_from_host_and_address (Void, addr_array)
							else
								if iface_name /= Void then
									create {INET6_ADDRESS} addr.make_from_host_and_address_and_interface_name (Void, addr_array, iface_name)
								else
									create {INET6_ADDRESS} addr.make_from_host_and_address_and_scope (Void, addr_array, numeric_zone)
								end
							end
		    					Result.put (addr, 1)
		    				end
					end
				elseif ipv6_expected then
					-- TODO We were expecting an IPv6 Litteral, but got something else
					-- throw new UnknownHostException("["+host+"]");
					-- TODO report error
					failed := True
					Result := Void
	    			end
	    			if Result = Void and then not failed then
					Result := get_all_by_name_0 (host)
	    			end
	    		end
		end
	end

    check_numeric_zone (s: STRING): INTEGER is
    		--
    	local
    		percent: INTEGER
    		slen: INTEGER
    		i: INTEGER
    		c: CHARACTER
    		done: BOOLEAN
    	do
			percent := s.index_of ('%%', 1)
			slen := s.count
			if percent = 0 then
	    		Result := -1
			else
				from
					i := percent
					done := False
				until
					done or else i > slen
				loop
					c := s.item (i)
	    			if c = ']' then
						if i = percent+1 then
		    				-- empty per-cent field */
		    				Result := -1
						end
						done := True
					end
	    			if not c.is_digit then
						Result := -1
						done := True
					else
	    				Result := (Result * 10) + (c.code - ('0').code)
					end
					i := i + 1
	    		end
			end
		end

    text_to_numeric_format_v4 (src: STRING): ARRAY [NATURAL_8] is
    	require
    		valid_src: src /= Void
    	local
			splitted: ARRAY[STRING]
			val: INTEGER
			i: INTEGER
    	do
			if not src.is_empty then
				create Result.make(1, {INET4_ADDRESS}.INADDRSZ)
				splitted := split (src, '.')
			    inspect splitted.count
			    when 1 then
			    	if splitted.item(1).is_integer_32 then
						val := splitted.item(1).to_integer_32
						if val >= 0 and then val <= 0xffffffff then
							Result.put (((val |>> 24) & 0xff).as_natural_8, 1)
							Result.put ((((val & 0xffffff) |>> 16) & 0xff).as_natural_8, 2)
							Result.put ((((val & 0xffff) |>> 8) & 0xff).as_natural_8, 3)
							Result.put ((val & 0xff).as_natural_8, 4)
						else
							Result := Void
						end
					else
						Result := Void
					end
			    when 2 then
			    	if splitted.item(1).is_integer_32 then
						val := splitted.item(1).to_integer_32
						if val >= 0 and then val <= 0xff then
							Result.put ((val & 0xff).as_natural_8, 1)
							if splitted.item(2).is_integer_32 then
								val := splitted.item(2).to_integer_32
								if val >= 0 and then val <= 0xffffffff then
									Result.put (((val |>> 16) & 0xff).as_natural_8, 2)
									Result.put ((((val & 0xffff) |>> 8) & 0xff).as_natural_8, 3)
									Result.put ((val & 0xff).as_natural_8, 4)
								else
									Result := Void
								end
							else
								Result := Void
							end
						end
					else
						Result := Void
					end
			    when 3 then
			    	from
			    		i := 1
			    	until
			    		i > 2 or else Result = Void
			    	loop
			    		if splitted.item(i).is_integer_32 then
			    			val := splitted.item(i).to_integer_32
		    				if val >= 0 and then val <= 0xff then
		    					Result.put ((val & 0xff).as_natural_8, i)
		    				else
								Result := Void
		    				end
		    			else
		    				Result := Void
		    			end
		    			i := i + 1
			    	end
			    	if splitted.item(3).is_integer_32 then
			    		val := splitted.item(3).to_integer_32
		    			if val >= 0 and then val <= 0xffff then
							Result.put (((val |>> 8) & 0xff).as_natural_8, 3)
							Result.put ((val & 0xff).as_natural_8, 4)
		    			else
							Result := Void
		    			end
		    		else
		    			Result := Void
					end
				end
			end
    	end

    text_to_numeric_format_v6 (src: STRING): ARRAY [NATURAL_8] is
    	require
    		valid_src: src /= Void
    	local
    		percent_position: INTEGER
    		length: INTEGER
    		i, j, k, n, curtok, colon_position: INTEGER
    		saw_xdigit: BOOLEAN
    		val: INTEGER
    		ch: CHARACTER
    		ia4: STRING
    		dot_count, index: INTEGER
    		v4addr: ARRAY [NATURAL_8]
    		done: BOOLEAN
    		new_result: ARRAY [NATURAL_8]
    	do
    		if src.count >= 2 then
    			length := src.count
				percent_position := src.index_of ('%%', 1)
				if percent_position < length then
					create Result.make (1, {INET6_ADDRESS}.INADDRSZ)
					if percent_position /= 0 then
	    				length := percent_position - 1;
					end
					i := 1;
					if src.item (i) = ':' then
						i := i + 1
						if src.item (i) /= ':' then
							Result := Void
						end
					end
					if Result /= Void then
						curtok := i
						saw_xdigit := False
						val := 0
						from
							done := False
						until
							done or else i > length
						loop
	    					ch := src.item (i)
	    					i := i + 1
	    					if ch.is_hexa_digit then
								val := val |<< 4;
								val := val | hex_character_to_integer (ch)
								if val > 0xffff then
		    						Result := Void
		    						done := True
		    					else
		    						saw_xdigit := True
		    					end
		    				elseif ch = ':' then
		    					curtok := i
		    					if not saw_xdigit then
		    						if colon_position /= 0  then
		    							Result := Void
		    							done := True
		    						else
		    							colon_position := j
		    						end
		    					elseif i > length then
									Result := Void
									done := True
		    					end
		    				elseif ch = '.' and then ((j + {INET4_ADDRESS}.INADDRSZ) <= {INET6_ADDRESS}.INADDRSZ+1) then
								ia4 := src.substring(curtok, length);
								from
									dot_count := 0
									index := 1
								until
									index = 0
								loop
									index := ia4.index_of ('.', index)
									if index /= 0 then
										dot_count := dot_count + 1
									end
								end
								if dot_count /= 3 then
		    						Result := Void
		    						done := True
								else
									v4addr := text_to_numeric_format_v4(ia4);
									if v4addr = Void then
		    							Result := Void
		    							done := True
									else
										from
											k := 1
										until
											k > {INET4_ADDRESS}.INADDRSZ
										loop
											Result.put (v4addr.item (k), j)
											j := j + 1
										end
										saw_xdigit := False;
										done := True
									end
								end
							else
								Result := Void
								done := True
		    				end
		    			end
		    			if Result /= Void then
							if saw_xdigit  then
	    						if j + INT16SZ > {INET6_ADDRESS}.INADDRSZ + 1 then
									Result := Void
								else
	    							Result.put (((val |>> 8) & 0xff).as_natural_8, j)
	    							j := j + 1
	    							Result.put ((val & 0xff).as_natural_8, j)
	    							j := j + 1
	    						end
							end
						end
						if Result /= Void then
							if colon_position /= -1 then
	    						n := j - colon_position;
	    						if j = {INET6_ADDRESS}.INADDRSZ + 1 then
									Result := Void
								else
									from
										i := 2
									until
										i > n
									loop
	    								Result.put (((val |>> 8) & 0xff).as_natural_8, j)
										Result.put (Result.item (colon_position + n - i), {INET6_ADDRESS}.INADDRSZ - i)
										Result.put (0, colon_position + n - i)
									end
	    							j := {INET6_ADDRESS}.INADDRSZ
	    						end
							end
							if j /= {INET6_ADDRESS}.INADDRSZ+1 then
	    						Result := Void
	    					else
								new_result := convert_from_ipv4_mappedd_address (Result)
								if new_result /= Void then
	    							Result := new_result;
	    						end
							end
						end
					end
				end
			end
		end


	convert_from_ipv4_mappedd_address (addr: ARRAY [NATURAL_8]): ARRAY [NATURAL_8] is
		local
			i: INTEGER
		do
			if is_ipv4_mapped_address(addr) then
				create Result.make (1, {INET4_ADDRESS}.INADDRSZ)
				from
					i := 1
				until
					i > {INET4_ADDRESS}.INADDRSZ
				loop
					Result.put (addr.item (i + 12), i)
					i := i + 1
				end
			end
		end

	is_ipv4_mapped_address (addr: ARRAY [NATURAL_8]): BOOLEAN is
		require
			valid_addr: addr /= Void
		do
			if addr.count = {INET6_ADDRESS}.INADDRSZ then
				Result :=
					((addr[1] = 0x00) and then (addr[2] = 0x00) and then
					(addr[3] = 0x00) and then (addr[4] = 0x00) and then
					(addr[5] = 0x00) and then (addr[6] = 0x00) and then
					(addr[7] = 0x00) and then (addr[8] = 0x00) and then
					(addr[9] = 0x00) and then (addr[10] = 0x00) and then
					(addr[11] = 0xff) and then (addr[12] = 0xff))
			end
		end

	hex_character_to_integer (c: CHARACTER): NATURAL_8 is
			--
		do
			if c >= '0' and then c <= '9' then
				Result := (c.code - ('0').code).as_natural_8
			elseif c >= 'a' and then c <= 'f' then
				Result := (c.code - ('a').code).as_natural_8
			elseif c >= 'A' and then c <= 'F' then
				Result := (c.code - ('A').code).as_natural_8
			end
		end

	split (src: STRING; delimiter: CHARACTER): ARRAY[STRING] is
		require
    		valid_src: src /= Void
    	local
    		i: INTEGER
    		token: STRING
		do
			create Result.make (1, 0)
			if not src.is_empty then
				from
					i := 1
					create token.make_empty
				until
					i > src.count
				loop
					if src.item (i) = delimiter or else i = src.count then
						Result.force (token, Result.count+1)
						create token.make_empty
					else
						token.extend(src.item (i))
					end
					i := i + 1
				end
			end
		end

	get_all_by_name_0 (host: STRING): ARRAY[INET_ADDRESS] is
		local
			ai: ADDRINFO
			ia: INET_ADDRESS
		do
			ai := getaddrinfo(host)
			if ai /= Void then
				create Result.make (1, 0)
				from
				until
					ai = Void
				loop
					inspect ai.family
					when  {ADDRINFO}.af_inet then
						create {INET4_ADDRESS} ia.make_from_host_and_pointer (host, ai.addr)
						Result.force (ia, Result.count+1)
					when  {ADDRINFO}.af_inet6 then
						if is_ipv6_available then
							create {INET6_ADDRESS} ia.make_from_host_and_pointer (host, ai.addr)
							Result.force (ia, Result.count+1)
						end
					end
					ai := ai.next
				end
				if Result.count = 0  then
					Result := Void
				end
			end
		end

	getaddrinfo (host: STRING): ADDRINFO is
		local
			ext: C_STRING
			p: POINTER
		do
			create ext.make (host)
			p := c_getaddrinfo(ext.item)
			if p /= default_pointer then
				create {ADDRINFO_1} Result.make_from_external (p)
			end
		end

feature {NONE} -- Externals

	c_getaddrinfo (hostname: POINTER): POINTER is
		external
			"C"
		alias
			"en_getaddrinfo"
		end

	get_sock_family (address: POINTER): INTEGER is
			-- Get the family from the address structure.
		external
			"C"
		alias
			"en_sockaddr_get_family"
		end

end
