indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CODESET_TYPES
    -- This actually an enum

creation
    make

feature -- Initialization

    make is

        do
            C_ascii7       := ascii7
            C_ebcdic       := ebcdic
            C_html3        := html3
            C_ko18_r       := ko18_r
            C_iso8859_1    := iso8859_1
            C_iso8859_2    := iso8859_2
            C_iso8859_3    := iso8859_3
            C_iso8859_4    := iso8859_4
            C_iso8859_5    := iso8859_5
            C_iso8859_6    := iso8859_6
            C_iso8859_7    := iso8859_7
            C_iso8859_8    := iso8859_8
            C_iso8859_9    := iso8859_9
            C_iso8859_10   := iso8859_10
            C_ibm_437      := ibm_437
            C_ibm_850      := ibm_850
            C_ibm_852      := ibm_852
            C_ibm_860      := ibm_860
            C_ibm_863      := ibm_863
            C_ibm_865      := ibm_865
            C_win31_latin1 := win31_latin1
            C_ucs4         := ucs4
            C_utf16        := utf16
            C_utf8         := utf8
            C_utf7         := utf7
        end
-----------------------------------------------
feature -- The enum values

    C_ascii7     : INTEGER
    C_ebcdic     : INTEGER
    C_html3      : INTEGER
    C_macintosh  : INTEGER
    C_ko18_r     : INTEGER
    C_iso8859_1  : INTEGER
    C_iso8859_2  : INTEGER
--    C_iso8859_2  : INTEGER
    C_iso8859_3  : INTEGER
    C_iso8859_4  : INTEGER
    C_iso8859_5  : INTEGER
    C_iso8859_6  : INTEGER
    C_iso8859_7  : INTEGER
    C_iso8859_8  : INTEGER
    C_iso8859_9  : INTEGER
    C_iso8859_10 : INTEGER
    C_ibm_437    : INTEGER
    C_ibm_850    : INTEGER
    C_ibm_852    : INTEGER
    C_ibm_860    : INTEGER
    C_ibm_863    : INTEGER
    C_ibm_865    : INTEGER
    C_win31_latin1 : INTEGER
    C_ucs4         : INTEGER
    C_utf16        : INTEGER
    C_utf8         : INTEGER
    C_utf7         : INTEGER
------------------------------------------
feature { NONE } -- External initialization routines

    ascii7 : INTEGER is

        external "C"
        alias "MICO_ascii7"

        end
------------------------------------------

    ebcdic : INTEGER is

        external "C"
        alias "MICO_ebcdic"

        end
------------------------------------------

    html3 : INTEGER is

        external "C"
        alias "MICO_html3"

        end
------------------------------------------

    macintosh : INTEGER is

        external "C"
        alias "MICO_macintosh"

        end
------------------------------------------

    ko18_r : INTEGER is

        external "C"
        alias "MICO_ko18_r"

        end
------------------------------------------

    iso8859_1 : INTEGER is

        external "C"
        alias "MICO_iso8859_1"

        end
------------------------------------------

    iso8859_2 : INTEGER is

        external "C"
        alias "MICO_iso8859_2"

        end
------------------------------------------

    iso8859_3 : INTEGER is

        external "C"
        alias "MICO_iso8859_3"

        end
------------------------------------------

    iso8859_4 : INTEGER is

        external "C"
        alias "MICO_iso8859_4"

        end
------------------------------------------

    iso8859_5 : INTEGER is

        external "C"
        alias "MICO_iso8859_5"

        end
------------------------------------------

    iso8859_6 : INTEGER is

        external "C"
        alias "MICO_iso8859_6"

        end
------------------------------------------

    iso8859_7 : INTEGER is

        external "C"
        alias "MICO_iso8859_7"

        end
------------------------------------------

    iso8859_8 : INTEGER is

        external "C"
        alias "MICO_iso8859_8"

        end
------------------------------------------

    iso8859_9 : INTEGER is

        external "C"
        alias "MICO_iso8859_9"

        end
------------------------------------------

    iso8859_10 : INTEGER is

        external "C"
        alias "MICO_iso8859_10"

        end
------------------------------------------

    ibm_437 : INTEGER is

        external "C"
        alias "MICO_ibm_437"

        end
------------------------------------------

    ibm_850 : INTEGER is

        external "C"
        alias "MICO_ibm_850"

        end
------------------------------------------

    ibm_852 : INTEGER is

        external "C"
        alias "MICO_ibm_852"

        end
------------------------------------------

    ibm_860 : INTEGER is

        external "C"
        alias "MICO_ibm_860"

        end
------------------------------------------

    ibm_863 : INTEGER is

        external "C"
        alias "MICO_ibm_863"

        end
------------------------------------------

    ibm_865 : INTEGER is

        external "C"
        alias "MICO_ibm_865"

        end
------------------------------------------

    win31_latin1 : INTEGER is

        external "C"
        alias "MICO_win31_latin1"

        end
------------------------------------------

    ucs4 : INTEGER is

        external "C"
        alias "MICO_ucs4"

        end
------------------------------------------

    utf16 : INTEGER is

        external "C"
        alias "MICO_utf16"

        end
------------------------------------------

    utf8 : INTEGER is

        external "C"
        alias "MICO_utf8"

        end
------------------------------------------

    utf7 : INTEGER is

        external "C"
        alias "MICO_utf7"

        end


end -- class CODESET_TYPES

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
