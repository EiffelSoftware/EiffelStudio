indexing

description: "Some standard tokens generally needed";
keywords: "Lex framework";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class LEX_TOKENS

feature

    Error_token         : INTEGER is 0
    End_of_text         : INTEGER is 1
    Space               : INTEGER is 2
    Identifier          : INTEGER is 3
    String_literal      : INTEGER is 4
    Character_literal   : INTEGER is 5
    Integer_literal     : INTEGER is 6
    Real_literal        : INTEGER is 7
    Boolean_literal     : INTEGER is 8
    Minus_token         : INTEGER is 9

end -- class LEX_TOKENS

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
