indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class ENVIRONMENT

creation
    make, make_with_principal

feature

    make is

        do
            make_with_principal (void)
        end
----------------------------

    make_with_principal (pr : PRINCIPAL) is

        do
            except := void
            princ  := pr
        end
----------------------------

    exception : CORBA_EXCEPTION is

        do
            result := except
        end
----------------------------

    set_exception (e : CORBA_EXCEPTION) is

        do
            except := e
        end
----------------------------

    principal : PRINCIPAL is

        do
            result := princ
        end
----------------------------

    set_principal (p : PRINCIPAL) is

        do
            princ := p
        end
----------------------------

    clear is

        do
            except := void
        end
----------------------------
feature { NONE } -- Implementation

    except : CORBA_EXCEPTION
    princ  : PRINCIPAL

end -- class ENVIRONMENT

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
