indexing

description: "The parent of any user defined exception";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class CORBA_USER_EXCEPTION

inherit
    THE_EXCEPTIONS;
    CORBA_EXCEPTION

feature

    make is

        do
        end
----------------------

    throwit is

        local
            except : EXCEPTIONS

        do
            raised_exceptions.set_last_exception (current)
            create except
            except.raise ("UserException%N")
        end
----------------------

    repoid : STRING is

        deferred
        end

end -- class CORBA_USER_EXCEPTION

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
