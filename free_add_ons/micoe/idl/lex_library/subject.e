indexing

description: "Cooperates with OBSERVER in Publish and Subscribe pattern";
keywords: "Lex framework", "Observer Pattern";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class SUBJECT

feature

    subject_make is

        do
            create observers.make (false)
        end
---------------------------------------------------

    add_observer (o : OBSERVER) is

        do
            observers.append (o)
        end
---------------------------------------------------

    remove_observer (o : OBSERVER) is

        do
            observers.remove (o)
        end
---------------------------------------------------
feature { NONE }

    observers : INDEXED_LIST [OBSERVER]

    notify_all is

        local
            i, n : INTEGER

        do
            from
                i := observers.low_index
                n := observers.high_index
            until
                i > n
            loop
                observers.at (i).update(current)
                i := i + 1
            end
        end

end -- class SUBJECT

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
