indexing
   
   description: "An address according to the internet protocol.";
   keywords: "GIOP framework", "address", "TCP/IP";
   status: "See notice at end of class";
   date: "$Date$";
   revision: "$Revision$"
   
class INET_ADDRESS
   
inherit
   ADDRESS
   
creation
   make, make0, make1, make2, make_vect
   
   
feature -- Initialization
   
   make (sin : SOCKADDR_IN) is
      
      do
	 set_sockaddr (sin)
	 addr_data := ext_create
	 resolve_host
      end
   --------------------------------------

   make0 is
      
      do
	 make2 (void, 0)
      end
   --------------------------------------

   make1 (a_host : STRING) is
      
      do
	 make2 (a_host, 0)
      end
   
   --------------------------------------
   
   make2 (a_host : STRING; a_port : INTEGER) is
      
      do
	 if a_host = void or else a_host.count = 0 then
	    host := hostname
	 else
	    host := a_host
	 end
	 port      := a_port
	 ipvec := void
	 addr_data := ext_create
	 
	 resolve_ip
      end
   --------------------------------------
   
   make_vect (ip : ARRAY [INTEGER]; a_port : INTEGER) is
      
      local
	 i, j, n : INTEGER
	 
      do
	 port      := a_port
	 -- Cloning ip seems to produce wrong results
	 from
	    create ipvec.make (1, ip.count)
	    i := ip.lower
	    n := ip.upper
	    j := 1
	 until
	    i > n
	 loop
	    ipvec.put (ip.item (i), j)
	    i := i + 1
	    j := j + 1
	 end
	 host      := ""
	 addr_data := ext_create
	 resolve_host
      end
   --------------------------------------    
feature -- Access
   
   stringify : STRING is
      
      do
	 result := proto
	 result.extend (':')
	 result.append (host)
	 result.extend (':')
	 result.append_integer (port)
      end
   --------------------------------------
   
   proto : STRING is
      
      do
	 result := "inet"
      end
   --------------------------------------
   
   make_transport : TRANSPORT is
      
      do
	 create {TCP_TRANSPORT} result.make
      end
   --------------------------------------
   
   make_transport_server : TRANSPORT_SERVER is
      
      do
	 create {TCP_TRANSPORT_SERVER} result.make
      end
   --------------------------------------
   
   make_ior_profile (key : ARRAY [INTEGER];
		     mc : MULTI_COMPONENT) : IOR_PROFILE is
      
      local
	 sin : SOCKADDR_IN
	 ia  : like current
	 
      do
	 sin := get_sockaddr
	 if sin.get_addr = inaddr_any then
	    create ia.make2 (hostname, port)
	    create {IIOP_PROFILE} result.make3 (key, ia, mc)
	 else
	    create {IIOP_PROFILE} result.make3 (key, current, mc)
	 end
      end
   --------------------------------------
   
   is_local : BOOLEAN is
      
      do
	 result := false
      end
   --------------------------------------
   
   valid : BOOLEAN is
      
      do
	 result := true
      end
   --------------------------------------  
   
   get_host : STRING is
      
      do
	 result := host
      end
   --------------------------------------
   
   get_port : INTEGER is
      
      do
	 result := port
      end
   --------------------------------------
   
   ipaddr : ARRAY [INTEGER] is
      
      do
	 result := ipvec
      end
   --------------------------------------
   
   get_sockaddr : SOCKADDR_IN is
      
      local
	 pex : ANY
	 r   : BOOLEAN
	 
      do
	 pex := ipvec.to_c
	 r   := ipvec_to_ipaddr (addr_data, $pex, ipvec.count)
	 check
	    address_conversion_ok : r
	 end
	 create result.make (Af_inet, port, addr_data)
      end
   
   --------------------------------------
feature -- Mutation
   
   set_sockaddr (sin : SOCKADDR_IN) is
      
      local
	 pex : ANY
	 r   : BOOLEAN
	 
      do
	 host := ""
	 create ipvec.make (1, 4)
	 pex := ipvec.to_c
	 r := get_ipvec(sin.get_addr, $pex, 4)
	 check
	    got_ipvec : r
	 end
	 port := sin.get_port
	 
      ensure
	 ipvec_set : ipvec /= void and then ipvec.count > 0
      end
   --------------------------------------
   
   set_port (a_port : INTEGER) is
      
      do
	 port := a_port
      end
   --------------------------------------
   
   set_host (h : STRING) is
      
      do
	 host      := h
	 resolve_ip
	 
      end
   --------------------------------------

   set_ipaddr (ipa : ARRAY [INTEGER]) is
      
      do
	 ipvec := ipa
	 resolve_host
	
      end

   --------------------------------------
feature -- Comparison
   
   compare (other : like current) : INTEGER is
      
      local
	 i, n   : INTEGER
	 a1, a2 : ARRAY [INTEGER]
	 
      do
	 if proto < other.proto then
	    result := -1
	 elseif proto > other.proto then
	    result := 1
	 elseif valid then
	    a1 := ipaddr
	    a2 := other.ipaddr
	    if a1.count <= a2.count then
	       n := a1.count
	    else
	       n := a2.count
	    end
	    from
	       i := 1
	    until
	       i > n or else result /= 0
	    loop
	       result := a1.item (i) - a2.item (i)
	       i      := i + 1
	    end
	    if result = 0 then
	       result := a1.count - a2.count
	    end
	 end
	 
	 if result = 0 then
	    result := port - other.port
	 end
      end
   --------------------------------------
feature -- Hashing
   
   hash_code : INTEGER is
      
      local
	 i, n : INTEGER
      do
	 from
	    i := 1
	    n := ipvec.count
	 until
	    i > n
	 loop
	    result := 256 * result + ipvec.item (i)
	    i      := i + 1
	 end
	 if result < 0 then
	    result := -result
	 end
      end
   --------------------------------------
feature { INET_ADDRESS } -- Implementation
   
   addr_data : POINTER
   sockaddr  : SOCKADDR_IN
   ipvec     : ARRAY [INTEGER]
   port      : INTEGER
   host      : STRING
   
   resolve_ip is
      
      require
	 host_is_known : (host /= void and then host.count > 0)
			 
      local
	 a   : ANY
	 n   : INTEGER
	 r   : BOOLEAN
	 log : IO_MEDIUM
	 
      do
	 if ipvec = void or else ipvec.count = 0 then
	    a := host.to_c
	    n := gethostbyname (addr_data, $a)
	    check
	       got_host : n >= 0
	    end
	    create ipvec.make (1, 4)
	    a := ipvec.to_c
	    r := get_ipvec(addr_data, $a, 4)
	    if not r then
	       log := logger.log (logger.Log_err, "General",
				  "INET_ADDRESS", "resolve_ip")
	       log.put_string ("cannot resolve hostname '")
	       log.put_string (host)
	       log.put_string ("' into an IP address%N")
	    end
	    check
	       got_ipvec : r
	    end
	 end
	 
      ensure
	 got_ipvec : ipvec /= void and then ipvec.count > 0
      end
   --------------------------------------
   
   resolve_host is
      
      require
	 ip_address_is_known : (ipvec /= void and then ipvec.count > 0)
			       
      local
	 s    : STRING
	 p    : POINTER
	 i, n : INTEGER
	 a    : ANY
	 r    : BOOLEAN
	 
      do
	 if host = void or else host.count = 0 then
	    a := ipvec.to_c
	    s := ""
	    r := gethostbyaddr (addr_data, $a, $p, ipvec.count)
	    check
	       got_host : r
	    end
	    if r then
	       -- don't let a dead host pull the server down ...
	       s.from_c (p)
	       if s.index_of ('.', 1) > 0 or else
		  equal (s, "localhost") then
		  host := s
               else
		  -- official name is not the FQDN.
		  -- Search the alias list.
		  from
		     n := get_nr_aliases (addr_data)
		     i := 1
		  until
		     i > n or else host /= void
		  loop
		     s := ""
		     s.from_c (get_an_alias (addr_data, i))
		     if s.index_of ('.', 1) > 0 then
			host := s
		     end
		     i := i + 1
		  end -- loop
	       end -- if s.index_of ('.', 1) > 0 then ...
	    else -- gethostbyaddr failed
	       logger.log (logger.Log_warning, "General", "INET_ADDRESS", 
			   "resolve_host").put_string (
						 "gethostbyaddr failed%N")
	    end -- if r then ...
	 end
	 
      ensure
	 got_host : host /= void and then host.count > 0
      end
   --------------------------------------
   
   inaddr_any : POINTER is
      
      once
	 result := ext_inaddr_any
      end
   --------------------------------------
   
   ext_create : POINTER is
      
      external "C"
      alias    "ADDR_create"
	 
      end
   --------------------------------------
   
   gethostbyname (a, n : POINTER) : INTEGER is
      
      external "C"
      alias "ADDR_gethostbyname"
	 
      end
   --------------------------------------
   
   gethostbyaddr (ad, a, p : POINTER; n : INTEGER) : BOOLEAN is
      
      external "C"
      alias "ADDR_gethostbyaddr"
	 
      end
   --------------------------------------
   
   get_nr_aliases (ad : POINTER) : INTEGER is
      
      external "C"
      alias "ADDR_get_nr_aliases"
	 
      end
   --------------------------------------
   
   get_an_alias (ad : POINTER; i : INTEGER) : POINTER is
      
      external "C"
      alias "ADDR_get_an_alias"
	 
      end
   --------------------------------------
   
   get_ipvec (ad, vp : POINTER; cnt : INTEGER) : BOOLEAN is
      
      external "C"
      alias    "ADDR_get_ipvec"
	 
      end
   --------------------------------------
   
   ext_inaddr_any : POINTER is
      
      external "C"
      alias "ADDR_inaddr_any"
	 
      end
   --------------------------------------
   
   Af_inet : INTEGER is
      
      external "C"
      alias "ADDR_Af_inet"
	 
      end
   --------------------------------------
   
   Af_unix : INTEGER is
      
      external "C"
      alias "ADDR_Af_unix"
	 
      end
   ----------------------
   
   ipvec_to_ipaddr (ap, pv : POINTER; n : INTEGER) : BOOLEAN is
      
      external "C"
      alias "MICO_ipvec_to_ipaddr"
      end


invariant
   
   adress_is_valid : (host /= void and then host.count > 0) and then
   (ipvec /= void and then ipvec.count > 0)

end -- class INET_ADDRESS

------------------------------------------------------------------------
--                                                                    --
--  MICO/E --- a free CORBA implementation                            --
--  Copyright (C) 1999 by Robert Switzer                              --
--                                                                    --
--  This library is free software; you can redistribute it and/or     --
--  modify it under the terms of the GNU Library General Public       --
--  License as published by the Free Software Foundation; either      --
--  version 2 of the License, or (at your option) any later version.  --
--                                                                    --
--  This library is distributed in the hope that it will be useful,   --
--  but WITHOUT ANY WARRANTY; without even the implied warranty of    --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
--  Library General Public License for more details.                  --
--                                                                    --
--  You should have received a copy of the GNU Library General Public --
--  License along with this library; if not, write to the Free        --
--  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.--
--                                                                    --
--  Send comments and/or bug reports to:                              --
--                 micoe@math.uni-goettingen.de                       --
--                                                                    --
------------------------------------------------------------------------
