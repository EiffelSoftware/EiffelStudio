#------------------------------------------------------------------------
#--                                                                    --
#--  MICO/E --- a free CORBA implementation                            --
#--  Copyright (C) 1999 by Robert Switzer                              --
#--                                                                    --
#--  This library is free software; you can redistribute it and/or     --
#--  modify it under the terms of the GNU Library General Public       --
#--  License as published by the Free Software Foundation; either      --
#--  version 2 of the License, or (at your option) any later version.  --
#--                                                                    --
#--  This library is distributed in the hope that it will be useful,   --
#--  but WITHOUT ANY WARRANTY; without even the implied warranty of    --
#--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU --
#--  Library General Public License for more details.                  --
#--                                                                    --
#--  You should have received a copy of the GNU Library General Public --
#--  License along with this library; if not, write to the Free        --
#--  Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.--
#--                                                                    --
#--  Send comments and/or bug reports to:                              --
#--                 micoe@math.uni-goettingen.de                       --
#--                                                                    --
#------------------------------------------------------------------------

include ../../MakeVars

BAPARAM=-b $(eiflib)/micoe -b  $(eiflib)/minimal_support \
	-b $(eiflib)/adt/contain -b $(eiflib)/adt/matcher \
	-b $(eiflib)/adt/basic \
	-i ../.. \
	-o "$(prefix)/lib/eifadt.a" -o "$(prefix)/lib/micoe.a"

all: server/EIFGEN/W_code/server client/EIFGEN/W_code/client

finalized: server/EIFGEN/F_code/server client/EIFGEN/F_code/client 

server/EIFGEN/W_code/server: ../stubs
	cd server; \
	if test $(MAKE_ORB_PRECOMP) != no; then \
		$(prefix)/bin/build_ace $(BAPARAM) -p $(precomp)/micoe; \
	else \
		$(prefix)/bin/build_ace $(BAPARAM); \
	fi
	cd server; echo q | $(EC); cd EIFGEN/W_code;finish_freezing;

server/EIFGEN/F_code/server: ../stubs
	cd server; $(prefix)/bin/build_ace $(BAPARAM);
	cd server; echo q | $(EC) -finalize ; cd EIFGEN/F_code;finish_freezing

client/EIFGEN/W_code/client: ../stubs
	cd client; \
	if test $(MAKE_ORB_PRECOMP) != no; then \
		$(prefix)/bin/build_ace $(BAPARAM) -p $(precomp)/micoe; \
	else \
		$(prefix)/bin/build_ace $(BAPARAM); \
	fi
	cd client; echo q | $(EC); cd EIFGEN/W_code;finish_freezing;

client/EIFGEN/F_code/client:
	cd client; $(prefix)/bin/build_ace $(BAPARAM);
	cd client; echo q | $(EC) -finalize; cd EIFGEN/F_code;finish_freezing;

../stubs: 
	cd ..;$(prefix)/bin/idl2eif --no-servants banking

clean:
	rm -fr server/EIFGEN client/EIFGEN
	rm -rf server/Ace.ace client/Ace.ace
	rm -rf server/server.epr client/client.epr
	cd ..; rm -rf base stub skeleton




