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

CLUSTER=adapter boa data_representation dii dsi exception giop \
homebrew imr intercept ir object orb static support transport \
type

all: EIFGEN

Ace.ace:
	$(SRCDIR)/admin/build_ace \
	-b  $(SRCDIR)/tmp/minimal_support \
	-b $(SRCDIR)/adt/contain -b $(SRCDIR)/adt/matcher \
	-b $(SRCDIR)/adt/basic \
	-o "$(SRCDIR)/adt/c/eifadt.a" -o "$(SRCDIR)/orb/c/micoe.a"; 

EIFGEN: cpart Ace.ace
	if test $(MAKE_ORB_PRECOMP) != no; then \
		echo q | $(EC) -precompile 2> compilation.log; \
		(cd EIFGEN/W_code;finish_freezing) >> compilation.log; \
	fi

cpart:
	cd c;$(MAKE) sys

.PHONY: ROADMAP

ROADMAP:
	ls -1 -R * | grep -v CVS |grep -v Entries |grep -v Repository |grep -v Root > ROADMAP

install: 
	if test $(MAKE_ORB) != no; then \
		(cd c;$(MAKE) install); \
		rm -rf $(eiflib)/micoe; \
		$(IDIRCMD) $(eiflib)/micoe; \
		for i in $(CLUSTER); do	$(CP) -r $$i $(eiflib)/micoe; done; \
		cd $(eiflib)/micoe; $(SRCDIR)/admin/build_ace \
		-b  $(eiflib)/minimal_support \
		-b $(eiflib)/adt/contain -b $(eiflib)/adt/matcher \
		-b $(eiflib)/adt/basic \
		-o "$(prefix)/lib/eifadt.a" -o "$(prefix)/lib/micoe.a"; \
	fi
	if test $(MAKE_ORB_PRECOMP) != no; then \
		rm -rf $(precomp)/micoe; \
		$(IDIRCMD) $(precomp)/micoe; \
		$(CP) -r EIFGEN $(precomp)/micoe; \
	fi

uninstall: 
	if test $(MAKE_ORB) != no; then \
		rm -rf $(eiflib)/micoe; \
	fi
	if test $(MAKE_ORB_PRECOMP) != no; then \
		rm -rf $(precomp)/micoe; \
	fi

clean:
	cd c;$(MAKE) clean
	rm -rf EIFGEN  Ace.ace compilation.log


