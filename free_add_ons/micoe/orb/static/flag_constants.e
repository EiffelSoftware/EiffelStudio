indexing

description: "Some flags needed by various classes";
keywords: "flags", "static", "global";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class FLAG_CONSTANTS

feature

    Arg_in : FLAGS is

        once
            create result.make (1, 32)
        end
----------------------

    Arg_out : FLAGS is

        once
            create result.make (2, 32)
        end
----------------------

    Arg_inout : FLAGS is

        once
            create result.make (4, 32)
        end
----------------------

    Ctx_restrict_scope : FLAGS is

        once
            create result.make (2, 32)
        end
----------------------

    Ctx_delete_descendants : FLAGS is

        once
            create result.make (1, 32)
        end
----------------------

    Zero_flag : FLAGS is

        do
            create result.make (0, 32)
        end

end -- class FLAG_CONSTANTS

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
