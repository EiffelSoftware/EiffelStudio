indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class UNIX_SHARED_LIBRARY

inherit
    SHARED_LIBRARY

creation
    make

feature


    make (the_name : STRING) is

        local
            exts : ANY

        do
            my_name := the_name
            exts    := the_name.to_c
            handle  := ext_dlopen ($exts)
        end
----------------------

    name : STRING is

        do
            result := my_name
        end
----------------------

    lookup_symbol (s : STRING) : POINTER is

        local
            exts : ANY

        do
            exts   := s.to_c
            result := ext_dlsym (handle, $exts)
        end
----------------------

    error : STRING is

        do
            if last_error = void then
                last_error := ""
                last_error.from_c (ext_dlerror)
            end
            result := last_error
        end
----------------------
feature { NONE } -- Implementation

    handle     : POINTER
    my_name    : STRING
    last_error : STRING
----------------------

    ext_dlerror : POINTER is

        external "C"
        alias "MICO_dlerror"
        end
----------------------

    ext_dlsym (hdl, sym : POINTER) : POINTER is

        external "C"
        alias "MICO_dlsym"
        end
----------------------

    ext_dlopen (nm : POINTER) : POINTER is

        external "C"
        alias "MICO_dlopen"
        end

end -- class UNIX_SHARED_LIBRARY

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
