indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class GIOP_CONNECTION

inherit
    THE_LOGGER
        undefine
            copy, is_equal
        end;
    EVENT_CONSTANTS
        undefine
            copy, is_equal
        end;
    GIOP_CONSTANTS
        undefine
            copy, is_equal
        end;
    TRANSPORT_CALLBACK
        undefine
            copy, is_equal
        end;
    DISPATCHER_CALLBACK

creation
    make

feature -- Initialization

    make (o       : ORB;
          trans   : TRANSPORT;
          gcb     : GIOP_CONN_CALLBACK;
          codc    : GIOP_CODEC;
          tmout   : INTEGER) is

        require
            nonvoid_arg : codc /= void

        local
            b : BUFFER

        do
            create b.make
            create inctx.make2 (codc, b)
            orb          := o
            transp       := trans
            cb           := gcb
            mycodec      := codc
            create inflags.make (255)
            create inbuf.make
            inlen := mycodec.header_length
            create inbufs.make
            create outbufs.make
            infrag       := void
            idle_tmout   := tmout
            have_tmout   := false
            have_wselect := false

            transp.set_nonblocking
            transport.rselect (orb.dispatcher, current)

            check_idle
        end
----------------------

    callback_t (t : TRANSPORT; evt : INTEGER) is

        do
            inspect evt

            when Read_ev then
                do_read

            when Write_ev then
                do_write
                
            end -- inspect
        end
----------------------

    callback_d (d : DISPATCHER; evt : INTEGER) is

        do
            inspect evt

            when Timer_ev then
                cb.callback_g (current, GIOP_idle)

            end -- inspect
        end
----------------------

    output_from_buffer (b : BUFFER) is

        local
            done  : BOOLEAN
            n     : INTEGER
            wrote : INTEGER
            log   : IO_MEDIUM

        do
            -- try to write as much as possible immediately
            if outbufs.empty then
                log := logger.log (Log_GIOP, "GIOP", 
                                   "GIOP_CONNECTION",
                                   "output_from_buffer")
                log.put_string ("writing ")
                log.put_integer (b.length)
                log.put_string (" octets to fd ")
                log.put_integer (transp.get_fd)
                log.new_line
                log.put_string (b.stringify)
                log.new_line

                n     := b.length
                wrote := transp.write_from_buffer (b, b.length, true)
                done  := (wrote = n)
            end
            if not done then
                outbufs.add (b)
                check_busy
            end
        end
----------------------

    transport : TRANSPORT is

        do
            result := transp
        end
----------------------

    input (pop : BOOLEAN) : BUFFER is
        -- WARNING: This function has side effects if `pop' is true;
        -- in that case the input buffer is removed from the queue.

        do
            if not inbufs.empty then
                result := inbufs.item
                if pop then
                    inbufs.remove
                end
            end
        end
----------------------

    codec : GIOP_CODEC is

        do
            result := mycodec
        end
----------------------

    cancel (reqid : INTEGER) is

        do
            -- XXX kill pending fragment if reqid matches
            -- for now just disallow CancelRequests inbetween fragments

            check
                no_fragment : infrag = void
            end
        end
----------------------
feature { IIOP_PROXY, IIOP_SERVER }

    check_idle is

        do
            if idle_tmout > 0 and then outbufs.empty then
                if have_tmout then
                    orb.dispatcher.remove (current, Timer_ev)
                end
                orb.dispatcher.tm_event (current, idle_tmout)
                have_tmout := true
            end
            if have_wselect and then outbufs.empty then
                transp.wselect (orb.dispatcher, void)
                have_wselect := false
            end
        end
----------------------
feature { NONE } -- Implementation

    Log_GIOP : INTEGER is 8
        -- Dump the GIOP output into the
        -- trace file only if the ORB debug level
        -- is >= 8.

    transp       : TRANSPORT
    outbufs      : QUEUE [BUFFER]
    inbufs       : QUEUE [BUFFER]
    inbuf        : BUFFER
    infrag       : BUFFER
    inlen        : INTEGER
    inflags      : OCTET
    cb           : GIOP_CONN_CALLBACK
    mycodec      : GIOP_CODEC
    orb          : ORB
    idle_tmout   : INTEGER
    have_tmout   : BOOLEAN
    have_wselect : BOOLEAN
    inctx        : GIOP_IN_CONTEXT

----------------------

    check_busy is

        do
            if have_tmout or else not outbufs.empty then
                orb.dispatcher.remove (current, Timer_ev)
                have_tmout := false
            end
            if not have_wselect and then not outbufs.empty then
                transp.wselect (orb.dispatcher, current)
                have_wselect := true
            end
        end
----------------------

    do_read is

        local
            break    : BOOLEAN
            continue : BOOLEAN
            mt       : INTEGER_REF
            sz       : INTEGER_REF
            rd       : INTEGER
            r        : BOOLEAN
            inflag   : FLAGS
            frag_bit : FLAGS
            log      : IO_MEDIUM

        do
            from
            invariant
                positive_inlen : not break implies inlen > 0
            until
                break
            loop
                continue := false
                rd       := transp.read_to_buffer (inbuf, inlen)
                if rd < 0 or else (rd = 0 and then transp.eof) then
                    -- connection broken or EOF
                    transp.rselect (orb.dispatcher, void)
                    transp.wselect (orb.dispatcher, void)
                    cb.callback_g (current, GIOP_closed)
                    break := true
                elseif rd > 0 then
                    log := logger.log (logger.Log_debug, "GIOP",
                                       "GIOP_CONNECTION", "do_read")
                    log.put_string ("read ")
                    log.put_integer (rd)
                    log.put_string (" octets from fd ")
                    log.put_integer (transp.get_fd)
                    log.new_line

                    log := logger.log (Log_GIOP, "GIOP", 
                                       "GIOP_CONNECTION", "do_read")
                    log.new_line
                    log.put_string (inbuf.stringify)
                    log.new_line

                    inlen := inlen - rd
                    if inbuf.length = mycodec.header_length then
                        -- header completely received
                        check
                            zero_inlen : inlen = 0
                        end
                        inctx.set_buffer (inbuf)
                        create mt
                        create sz
                        check
                            nonvoid_inflags : inflags /= void
                        end
                        r     := mycodec.check_header (inctx, mt, sz, inflags)
                        inlen := sz.item
                        if not r then
                            -- garbled message, send it to input handler ...
                            inbufs.add (inbuf)
                            create inbuf.make
                            inlen := mycodec.header_length
                            cb.callback_g (current, GIOP_input_ready)
                            continue := true
                        elseif mt.item = GIOP_fragment then
                            -- a fragment, append contents to infrag ...
                            check
                                nonvoid_infrag : infrag /= void
                            end
                            inbuf.delete
                            inbuf := infrag
                            infrag := void
                        end -- if not r then ...
                    end -- if inbuf.length = mycodec.header_length ...
                    if not continue and then inlen = 0 then
                        -- message completely received
                        create inflag.make (inflags.value, 32)
                        create frag_bit.make (GIOP_fragment_bit, 32)
                        if (inflag & frag_bit).value /= 0 then
                            -- more fragments follow ...
                            check
                                void_infrag : infrag = void
                            end
                            infrag := inbuf
                            create inbuf.make
                            inlen := mycodec.header_length
                        else
                            inbufs.add (inbuf)
                            create inbuf.make
                            inlen := mycodec.header_length
                            cb.callback_g (current, GIOP_input_ready)
                        end -- if (inflag & frag_bit).value /= 0 then ...
                    else -- continue or inlen /= 0
                    end -- if not continue and then inlen = 0 then ...
                elseif rd = 0 then -- and not transp.eof
                    break := true
                else
                    check
                        impossible : false
                    end
                end -- if rd < 0 or else (rd = 0 and then transp.eof) then ...
            end -- loop    
        end
----------------------

    do_write is

        local
            break : BOOLEAN
            b     : BUFFER
            wr    : INTEGER

        do
            from
            invariant
                more_work : not break implies not outbufs.empty
            until
                break
            loop
                b  := outbufs.item
                wr := transp.write_from_buffer (b, b.length, true)
                if wr > 0 then
                    if b.length = 0 then
                        -- message completely sent
                        b.delete
                        outbufs.remove
                        if outbufs.empty then
                            check_idle
                            break := true
                        end -- if outbufs.empty then ...
                    end -- if b.length = 0 then ...
                elseif wr < 0 then
                    -- connection broken
                    transp.rselect (orb.dispatcher, void)
                    transp.wselect (orb.dispatcher, void)
                    cb.callback_g (current, GIOP_closed)
                    break := true
                elseif wr = 0 then
                    break := true
                end -- if wr > 0 then ...
            end -- loop
        end

end -- class GIOP_CONNECTION

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
