indexing

description: "Supports logging with different log levels. Target can be set %
             % as attribute.";
keywords: "logging", "diagnostics";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class LOGGER

creation
    make, make_with_target

feature -- Predefined log levels

            -- System log levels. Should normally not be used.
       Log_emerg : INTEGER is 0
            -- system is unusable
       Log_alert : INTEGER is 1
            -- action must be taken immediately
       Log_crit : INTEGER is 2
            --  critical conditions
----------------------
feature -- Application log levels.

       Log_err : INTEGER is 3
            -- error conditions (should be used when immediately followed
            -- by a false check clause or otherwise explicitly raised
            -- exception)
       Log_warning : INTEGER is 4
            -- warning conditions (should be used when an error does not 
            -- immediately lead to an exception)
       Log_notice : INTEGER is 5
            --  normal, but significant, condition
       Log_info : INTEGER is 6
            -- informational message
       Log_debug : INTEGER is 7
            -- debug-level message
----------------------
feature -- Initialization

    make is

	do
	    set_target (io.error)
            debug_level := Log_warning
	end
----------------------

    make_with_target (new_target : IO_MEDIUM) is

        do
            set_target (new_target)
            debug_level := Log_warning
        end
----------------------

    debug_level : INTEGER

    set_debug_level (new_level : INTEGER) is

        do
            debug_level := new_level
        end
----------------------

    set_target (new_target : IO_MEDIUM) is

        require
            is_valid : new_target.is_plain_text
                       and then new_target.is_open_write

        do
            target := new_target
        end
----------------------

    log (level : INTEGER; 
         category, log_class, function : STRING) : IO_MEDIUM is
            -- A typical usage looks something like this:
            --  log := logger.log (logger.Log_debug, "GIOP", 
            --                     "GIOP_CONNECTION",
            --                     "output_from_buffer")
            --  log.put_string ("GIOPConn.output%N")
            --  log.put_string (b.stringify)
            --  log.new_line

        require
            is_open : target_is_open_write

        do
            if level <= debug_level then
                target.put_string (category)
                target.put_string (" - ")
                target.put_string (log_class)
                target.put_character ('.')
                target.put_string (function)
                target.put_string (": ")
                result := target
            else
                result := null_device
            end -- if level <= debug_level then ...
        end
----------------------

    trace_enter (class_name, function : STRING) is

        do
            log (Log_debug, "Trace",
                 class_name, function).put_string ("enter%N")
        end
----------------------

    trace_leave (class_name, function : STRING) is

        do
            log (Log_debug, "Trace",
                 class_name, function).put_string ("leave%N")
        end
----------------------

    target_is_open_write : BOOLEAN is

        do
            result := target.is_open_write
        end
----------------------

    panic_mode (msg : STRING) is

        do
            except.raise (msg)
        end
----------------------
feature { NONE } -- Implementation

    target : IO_MEDIUM
        -- We use an IO_MEDIUM here to allow some kind of syslog device.

    null_device : NULL_DEVICE is
        -- This is necessary because a bug in ISE's class IO_MEDIUM
        -- makes it impossible to use "/dev/null" as output medium.

        once
            create result
        end

    except : EXCEPTIONS is

        once
            create result
        end

end -- class LOGGER

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
