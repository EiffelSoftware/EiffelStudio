indexing

description: "Various utilities having to do with time.";
keywords: "time", "timing"
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class   SYSTEM_TIME

feature -- Time conversion

    year        : INTEGER
    month       : INTEGER
    day         : INTEGER
    hour        : INTEGER
    minute      : INTEGER
    second      : INTEGER
    day_of_year : INTEGER
    day_of_week : INTEGER

    now : REAL is
        -- The current time (GMT)
        external "C" 
        alias    "RTC12_now"
        end
-----------------------------------------------------------

    localtime (gm_time : REAL) : REAL is
        -- The local time corresponding to
        -- to GMT `gm_time'. Takes timezones
        -- and daylight savings into account.
        external "C" 
        alias    "RTC12_localtime"
        end
-----------------------------------------------------------
                        
    to_time (y, mo, d, h, mi, s : INTEGER) : REAL is

        external "C" 
        alias    "RTC12_d2t"
        end
-----------------------------------------------------------

    to_date (t : REAL) is

        do
            rt_compute (t)

            year        := rt_year
            month       := rt_month
            day         := rt_day
            hour        := rt_hour
            minute      := rt_minute
            second      := rt_second
            day_of_week := rt_day_of_week
            day_of_year := rt_day_of_year
        end
-----------------------------------------------------------
feature -- Timing

    sysclock : INTEGER is
        -- High resolution system clock
        -- Result is in 1/1000 seconds.
        external "C"
        alias    "RTC12_clock"
        end
-----------------------------------------------------------
feature {NONE}
-----------------------------------------------------------

    rt_compute (t : REAL) is

        external "C" -- changed by x_c_cwc
        alias    "RTC12_t2d_compute"
        end
-----------------------------------------------------------

    rt_year : INTEGER is

        external "C" -- changed by x_c_cwc
        alias    "RTC12_year"
        end
-----------------------------------------------------------

    rt_month : INTEGER is

        external "C" -- changed by x_c_cwc
        alias    "RTC12_month"
        end
-----------------------------------------------------------

    rt_day : INTEGER is

        external "C" -- changed by x_c_cwc
        alias    "RTC12_day"
        end
-----------------------------------------------------------

    rt_hour : INTEGER is

        external "C" -- changed by x_c_cwc
        alias    "RTC12_hour"
        end
-----------------------------------------------------------

    rt_minute : INTEGER is

        external "C" -- changed by x_c_cwc
        alias    "RTC12_minute"
        end
-----------------------------------------------------------

    rt_second : INTEGER is

        external "C" -- changed by x_c_cwc
        alias    "RTC12_second"
        end
-----------------------------------------------------------

    rt_day_of_week : INTEGER is

        external "C" -- changed by x_c_cwc
        alias    "RTC12_day_of_week"
        end
-----------------------------------------------------------

    rt_day_of_year : INTEGER is

        external "C" -- changed by x_c_cwc
        alias    "RTC12_day_of_year"
        end
-----------------------------------------------------------

end -- class SYSTEM_TIME

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
