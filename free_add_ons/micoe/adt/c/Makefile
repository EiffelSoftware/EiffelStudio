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

BASICOBJS=file_sys.o format.o math.o rtc12.o os9.o

include ../../MakeVars

all: sys 

sys: eifadt.a

eifadt.a: $(BASICOBJS)
	$(AR) ru eifadt.a $(BASICOBJS)
	$(RANLIB) eifadt.a

install: eifadt.a
	$(IDIRCMD) $(prefix)/lib
	$(ILIBCMD) eifadt.a $(prefix)/lib

clean:
	rm -f eifadt.a *.o










