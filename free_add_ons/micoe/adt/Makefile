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

include ../MakeVars

CLUSTER=basic contain graph sorter matcher

all: EIFGEN

EIFGEN: cpart 
	if test $(MAKE_ADT_PRECOMP) != no; then \
	  echo q | es4 -precompile 2> compilation.log; \
	  (cd EIFGEN/W_code;finish_freezing) >> compilation.log; \
	fi

cpart:
	cd c; $(MAKE) sys

install:
	if test $(MAKE_ADT) != no; then \
	  (cd c; $(MAKE) install); \
	  rm -rf $(eiflib)/adt; \
	  $(IDIRCMD) $(eiflib)/adt; \
	  for i in $(CLUSTER); do	$(CP) -r $$i $(eiflib)/adt; done \
	fi
	if test $(MAKE_ADT_PRECOMP) != no; then \
	  rm -rf $(precomp)/adt; \
	  $(IDIRCMD) $(precomp)/adt; \
	  $(CP) -r EIFGEN $(precomp)/adt; \
	fi 

uninstall:
	if test $(MAKE_ADT) != no; then \
	  rm -rf $(eiflib)/adt; \
	fi
	if test $(MAKE_ADT_PRECOMP) != no; then \
	  rm -rf $(precomp)/adt; \
	fi 

clean:
	cd c;$(MAKE) clean
	rm -fr EIFGEN compilation.log

