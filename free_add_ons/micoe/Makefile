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

include MakeVars

SYSTEMDIRS = admin adt orb idl/idl2eif 
TOOLDIRS =
# idl/ir_writer idl/ir_reader imr daemon
EXTRADIRS = 
DOCDIRS = doc/manual idl/doc adt/doc
INSTALLDIRS = $(SYSTEMDIRS) $(TOOLSDIRS)
ALLDIRS = $(SYSTEMDIRS) $(TOOLDIRS) $(DOCDIRS) $(EXTRADIRS) 

all: system

system:
	for i in $(SYSTEMDIRS); do (cd $$i; $(MAKE)) || exit 1; done
#	for i in $(TOOLDIRS); do (cd $$i;$(MAKE)) || exit 1; done
 
extras: docs
	for i in $(EXTRADIRS); do (cd $$i; $(MAKE)) || exit 1; done

docs:
	for i in $(DOCDIRS); do (cd $$i; $(MAKE)) || exit 1; done

MakeVars:
	configure

clean:
	for i in $(ALLDIRS); do (cd $$i; $(MAKE) clean) || exit 1; done
	rm -rf tmp

ACEFILES= adt orb idl/idl2eif demo/banking/step1 \
          demo/banking/step2/client demo/banking/step2/server \
          demo/banking/step3/client demo/banking/step3/server \
          demo/codesets/client demo/codesets/server

distclean: clean
	rm -f MakeVars demo/MakeVars
	rm -f config.*
	rm -f orb/c/config.h
	rm -rf tmp
	for i in $(ACEFILES); do rm -f $$i/Ace.ace; done
	rm -f admin/makecsregistry/Ace.ace
	rm -f admin/build_ace
	find . -name '*~' -type f | xargs rm -f

install:
	for i in $(INSTALLDIRS); do (cd $$i;$(MAKE) install) || exit 1; done

uninstall:
	for i in $(INSTALLDIRS); do (cd $$i;$(MAKE) uninstall) || exit 1; done

dist:
	admin/mksrcdist

release:
	admin/mkrelease

manifest: distclean
	admin/mkmanifest
