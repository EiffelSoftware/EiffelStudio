note
	description: "Factory of {INET_ADDRESS}."
	date: "$Date$"
	revision: "$Revision$"

class

	INET_ADDRESS_FACTORY

inherit

	INET_PROPERTIES

	SOCKET_RESOURCES

feature

	create_any_local: INET_ADDRESS
			-- Address that allows connection from any host.
		do
			Result := impl.any_local_address
		ensure
			create_any_local_attached: Result /= Void
		end

	create_loopback: INET_ADDRESS
			-- Loopback address.
		do
			Result := impl.loopback_address
		ensure
			create_any_localhost_attached: Result /= Void
		end

	create_localhost: INET_ADDRESS
			--
		do
			Result := create_from_name (impl.local_host_name)
			if not attached Result then
				Result := create_from_name ("localhost")
				check attached Result then end
			end
		end

	create_from_name (hostname: READABLE_STRING_8): detachable INET_ADDRESS
			--
		do
			if attached get_all_by_name (hostname) as r and then not r.is_empty then
				Result := r.first
			end
		end

	create_from_address (address: ARRAY [NATURAL_8]): detachable INET_ADDRESS
			--
		require
			valid_address: address /= Void
		local
			new_addr: detachable ARRAY [NATURAL_8]
		do
		    if address.count = {INET4_ADDRESS}.INADDRSZ then
				create {INET4_ADDRESS} Result.make_from_host_and_address (Void, address)
	    	elseif address.count ={INET6_ADDRESS}.INADDRSZ then
				new_addr := convert_from_ipv4_mappedd_address (address)
				if new_addr /= Void then
					create {INET4_ADDRESS} Result.make_from_host_and_address (Void, new_addr)
				else
					create {INET6_ADDRESS} Result.make_from_host_and_address (Void, address)
				end
			end
		end

	create_from_sockaddr (sockaddr: POINTER): detachable INET_ADDRESS
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

	impl: INET_ADDRESS_IMPL
		once
			if is_ipv6_available then
				create {INET_ADDRESS_IMPL_V6} Result
			else
				create {INET_ADDRESS_IMPL_V4} Result
			end
		end

	INT16SZ: INTEGER = 2

    get_all_by_name (a_host: READABLE_STRING_8): detachable ARRAYED_LIST [INET_ADDRESS]
    	local
    		ipv6_expected: BOOLEAN
    		host: READABLE_STRING_8
    		addr_array: detachable ARRAY [NATURAL_8]
    		addr: INET_ADDRESS
    		numeric_zone: INTEGER
    		iface_name: detachable READABLE_STRING_8
    		pos: INTEGER
    		failed: BOOLEAN
		do
			host := a_host
			numeric_zone := -1
			if host = Void or else host.is_empty then
				create Result.make (1)
				Result.extend (impl.loopback_address)
			else
				failed := False
				if host [1] = '[' then
					if host.count > 2 and then host [host.count] = ']' then
						host := host.substring (2, host.count - 1)
						ipv6_expected := True;
					else
							-- This was supposed to be a IPv6 address, but it's not!
							-- TODO report error
						failed := True
					end
				end
				if not failed then
					if host [1].is_hexa_digit or else host [1] = ':' then
						addr_array := text_to_numeric_format_v4 (host)
						if addr_array = Void then
							pos := host.index_of ('%%', 1)
							if pos /= 0 then
								numeric_zone := check_numeric_zone (host)
								if numeric_zone = -1 then
									iface_name := host.substring (pos + 1, host.count)
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
								create Result.make (1)
								if addr_array.count = {INET4_ADDRESS}.INADDRSZ then
									create {INET4_ADDRESS} addr.make_from_host_and_address (Void, addr_array)
								else
									if iface_name /= Void then
										create {INET6_ADDRESS} addr.make_from_host_and_address_and_interface_name (Void, addr_array, iface_name)
									else
										create {INET6_ADDRESS} addr.make_from_host_and_address_and_scope (Void, addr_array, numeric_zone)
									end
								end
								Result.extend (addr)
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

    check_numeric_zone (s: READABLE_STRING_8): INTEGER
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
					i := percent + 1
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
	    			elseif not c.is_digit then
						Result := -1
						done := True
					else
	    				Result := (Result * 10) + (c.code - ('0').code)
					end
					i := i + 1
	    		end
			end
		end

    text_to_numeric_format_v4 (src: READABLE_STRING_8): detachable ARRAY [NATURAL_8]
    	require
    		valid_src: src /= Void
    	local
			splitted: ARRAYED_LIST [READABLE_STRING_8]
			val: INTEGER
			i: INTEGER
    	do
			if not src.is_empty then
				create Result.make_filled ({NATURAL_8} 0, 1, {INET4_ADDRESS}.INADDRSZ)
				splitted := split (src, '.')
			    inspect splitted.count
			    when 1 then
			    	if splitted.i_th (1).is_integer_32 then
						val := splitted.i_th (1).to_integer_32
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
			    	if splitted.i_th (1).is_integer_32 then
						val := splitted.i_th (1).to_integer_32
						if val >= 0 and then val <= 0xff then
							Result.put ((val & 0xff).as_natural_8, 1)
							if splitted.i_th (2).is_integer_32 then
								val := splitted.i_th (2).to_integer_32
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
			    		if splitted.i_th (i).is_integer_32 then
			    			val := splitted.i_th (i).to_integer_32
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
			    	if splitted.i_th (3).is_integer_32 and Result /= Void then
			    		val := splitted.i_th (3).to_integer_32
		    			if val >= 0 and then val <= 0xffff then
							Result.put (((val |>> 8) & 0xff).as_natural_8, 3)
							Result.put ((val & 0xff).as_natural_8, 4)
		    			else
							Result := Void
		    			end
		    		else
		    			Result := Void
					end
				when 4 then
			    	from
			    		i := 1
			    	until
			    		i > 4 or else Result = Void
			    	loop
			    		if splitted.i_th (i).is_integer_32 then
			    			val := splitted.i_th (i).to_integer_32
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
				else
					Result := Void
				end
			end
    	end

    text_to_numeric_format_v6 (src: READABLE_STRING_8): detachable ARRAY [NATURAL_8]
    	require
    		valid_src: src /= Void
    	local
    		percent_position: INTEGER
    		length: INTEGER
    		i, j, k, n, curtok, colon_position: INTEGER
    		saw_xdigit: BOOLEAN
    		val: INTEGER
    		ch: CHARACTER
    		ia4: READABLE_STRING_8
    		v4addr: detachable ARRAY [NATURAL_8]
    		done: BOOLEAN
    		new_result: detachable ARRAY [NATURAL_8]
    	do
    		if src.count >= 2 then
    			length := src.count
				percent_position := src.index_of ('%%', 1)
				if percent_position < length then
					create Result.make_filled ({NATURAL_8} 0, 1, {INET6_ADDRESS}.INADDRSZ)
					if percent_position /= 0 then
	    				length := percent_position - 1;
					end
					i := 1;
					j := 1;
					colon_position := -1
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
							done or else Result = Void or else i > length
						loop
	    					ch := src.item (i)
	    					i := i + 1
	    					if ch.is_hexa_digit then
								val := val |<< 4;
								val := val | hex_character_to_integer (ch)
								if val > 0xffff then
		    						Result := Void
		    					else
		    						saw_xdigit := True
		    					end
		    				elseif ch = ':' then
		    					curtok := i
		    					if not saw_xdigit then
		    						if colon_position /= -1  then
		    							Result := Void
		    						else
		    							colon_position := j
		    						end
		    					elseif i > length then
									Result := Void
		    					else
	    							if j + INT16SZ > {INET6_ADDRESS}.INADDRSZ + 1 then
										Result := Void
									else
	    								Result.put (((val |>> 8) & 0xff).as_natural_8, j)
	    								j := j + 1
	    								Result.put ((val & 0xff).as_natural_8, j)
	    								j := j + 1
	    								saw_xdigit := False
	    								val := 0
	    							end
		    					end
		    				elseif ch = '.' and then ((j + {INET4_ADDRESS}.INADDRSZ) <= {INET6_ADDRESS}.INADDRSZ + 1) then
								ia4 := src.substring(curtok, length);
								if dot_count (ia4) /= 3 then
		    						Result := Void
								else
									v4addr := text_to_numeric_format_v4 (ia4);
									if v4addr = Void then
		    							Result := Void
									else
										from
											k := 1
										until
											k > {INET4_ADDRESS}.INADDRSZ
										loop
											Result.put (v4addr.item (k), j)
											j := j + 1
											k := k + 1
										end
										saw_xdigit := False;
										done := True
									end
								end
							else
								Result := Void
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
										i := 0
									until
										i >= n
									loop
										Result.put (Result.item (colon_position + n - i - 1), {INET6_ADDRESS}.INADDRSZ - i)
										Result.put (0, colon_position + n - i - 1 )
										i := i +1
									end
	    							j := {INET6_ADDRESS}.INADDRSZ + 1
	    						end
							end
							if j /= {INET6_ADDRESS}.INADDRSZ+1 then
	    						Result := Void
	    					else
	    						check result_attached: Result /= Void then
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
		end


	convert_from_ipv4_mappedd_address (addr: ARRAY [NATURAL_8]): detachable ARRAY [NATURAL_8]
		local
			i: INTEGER
		do
			if is_ipv4_mapped_address (addr) then
				create Result.make_filled ({NATURAL_8} 0, 1, {INET4_ADDRESS}.INADDRSZ)
				from
					i := 1
				until
					i > {INET4_ADDRESS}.INADDRSZ
				loop
					Result.put (addr.item (i + 12), i)
					i := i + 1
				end
			end
		ensure
			valid_array: Result /= Void implies Result.count = {INET4_ADDRESS}.INADDRSZ
		end

	is_ipv4_mapped_address (addr: ARRAY [NATURAL_8]): BOOLEAN
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

	hex_character_to_integer (c: CHARACTER): NATURAL_8
			--
		do
			if c >= '0' and then c <= '9' then
				Result := (c.code - ('0').code).as_natural_8
			elseif c >= 'a' and then c <= 'f' then
				Result := (c.code - ('a').code).as_natural_8 + 10
			elseif c >= 'A' and then c <= 'F' then
				Result := (c.code - ('A').code).as_natural_8 + 10
			end
		end

	split (src: READABLE_STRING_8; delimiter: CHARACTER): ARRAYED_LIST [READABLE_STRING_8]
		require
    		valid_src: src /= Void
    	local
    		i: INTEGER
    		token: STRING_8
		do
			create Result.make (10)
			if not src.is_empty then
				from
					i := 1
					create token.make_empty
				until
					i > src.count
				loop
					if src.item (i) = delimiter then
						Result.extend (token)
						create token.make_empty
					elseif i = src.count then
						token.extend(src.item (i))
						Result.extend (token)
					else
						token.extend (src.item (i))
					end
					i := i + 1
				end
			end
		end

	dot_count (src: READABLE_STRING_8): INTEGER
			-- Returns the number of dot ('.') characters found in the given string

		require
    		valid_src: src /= Void
    	local
    		index: INTEGER
		do
			from
				index := src.index_of ('.', 1)
			until
				index = 0
			loop
				Result := Result + 1
				if index < src.count then
					index := src.index_of ('.', index + 1)
				end
			end
		end

	get_all_by_name_0 (host: READABLE_STRING_8): detachable ARRAYED_LIST [INET_ADDRESS]
		local
			ai: detachable ADDRINFO
			ia: INET_ADDRESS
			l_family: INTEGER
		do
			ai := getaddrinfo(host)
			if ai /= Void then
				create Result.make (1)
				from
				until
					ai = Void
				loop
					l_family := ai.family
						-- We could use `{ADDRINFO}.af_inet' and `{ADDRINFO}.af_inet6' but on
						-- .NET it does not work since `ADDRINFO' is deferred. Instead we use
						-- the `ai' insance to get those constants.
					if l_family = ai.af_inet then
						create {INET4_ADDRESS} ia.make_from_host_and_pointer (host, ai.addr)
						Result.extend (ia)
					elseif l_family = ai.af_inet6 then
						if is_ipv6_available then
							create {INET6_ADDRESS} ia.make_from_host_and_pointer (host, ai.addr)
							Result.extend (ia)
						end
					end
					ai := ai.next
				end
				if Result.is_empty then
					Result := Void
				end
			end
		end

	getaddrinfo (host: READABLE_STRING_8): detachable ADDRINFO
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

	c_getaddrinfo (hostname: POINTER): POINTER
		external
			"C"
		alias
			"en_getaddrinfo"
		end

	get_sock_family (address: POINTER): INTEGER
			-- Get the family from the address structure.
		external
			"C"
		alias
			"en_sockaddr_get_family"
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
