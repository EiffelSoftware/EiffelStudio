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

all: EIFGEN/F_code/idl2eif

EIFGEN/F_code/idl2eif: Ace.ace
	if test $(MAKE_IDL2EIF) != no; then \
	  if test $(MAKE_IDL2EIF_FINALIZE) = yes; then \
	    echo q | $(EC) -finalize 2> compilation.log; \
	    (cd EIFGEN/F_code;finish_freezing) > compilation.log; \
	  else \
	    echo q | $(EC) 2> compilation.log; \
	    (cd EIFGEN/W_code;finish_freezing) >> compilation.log; \
	  fi; \
	fi

Ace.ace:
	$(SRCDIR)/admin/build_ace \
	-b $(SRCDIR)/orb \
	-b $(SRCDIR)/idl/abstract_syntax -b $(SRCDIR)/idl/concrete_parser \
	-b $(SRCDIR)/idl/lex_library -b $(SRCDIR)/idl/parse_library \
	-b $(SRCDIR)/idl/support -b $(SRCDIR)/idl/visitor \
	-b $(SRCDIR)/tmp/minimal_support \
	-b $(SRCDIR)/adt/contain -b $(SRCDIR)/adt/matcher \
	-b $(SRCDIR)/adt/basic -b $(SRCDIR)/adt/graph \
	-o "$(SRCDIR)/adt/c/eifadt.a" -o "$(SRCDIR)/orb/c/micoe.a"; 

install:
	if test $(MAKE_IDL2EIF) != no; then \
	  $(IDIRCMD) $(prefix)/bin; \
	  if test $(MAKE_IDL2EIF_FINALIZE) = yes; then \
	    $(IBINCMD) -s EIFGEN/F_code/idl2eif $(prefix)/bin; \
	  else \
	    $(IBINCMD) EIFGEN/W_code/idl2eif $(prefix)/bin; \
	  fi; \
	fi

uninstall:
	if test $(MAKE_IDL2EIF) != no; then \
	  rm -f $(prefix)/bin/idl2eif; \
	fi

clean:
	rm -fr EIFGEN compilation.log idl2eif.epr Ace.ace




