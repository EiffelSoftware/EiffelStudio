indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class GIOP_REQUEST

inherit
    ORB_REQUEST;
    CODESET_STATICS

creation
    make

feature -- Initialization

    make (op : STRING; indata : DATA_DECODER; gc : GIOP_CODEC) is

        local
            conv   : CODESET_CONVERTER
            wconv  : CODESET_CONVERTER
            rconv  : CODESET_CONVERTER
            rwconv : CODESET_CONVERTER
            b      : BUFFER

        do
            conv  := indata.converter
            wconv := indata.wconverter
            codec := gc

            if conv /= void then
                rconv := the_codeset_db.reverse (conv)
            end
            if wconv /= void then
                rwconv := the_codeset_db.reverse (wconv)
            end
            opname := op
            idc    := indata
            istart := idc.get_buffer.rpos
            create b.make
            odc := clone (idc)
            odc.make3 (b, conv, wconv)
            oec       := odc.encoder3 (odc.get_buffer, rconv, rwconv)
            ostart    := 0
            is_except := false
        end
----------------------
feature -- Access

    op_name : STRING is

        do
            result := opname
        end
----------------------

    get_in_args_nvl (iparams : CORBA_NV_LIST; ctx : ANY_REF) : BOOLEAN is

        local
            a    : CORBA_ANY
            tc   : CORBA_TYPECODE
            nv   : CORBA_NAMED_VALUE
            test : FLAGS
            i, n : INTEGER
            ctx1 : CORBA_CONTEXT

        do
            result := true
            test   := Flags.Arg_in | Flags.Arg_inout
            from
                i := 1
                n := iparams.count
            until
                i > n or else not result
            loop
                nv := iparams.item (i)
                if (nv.my_flags & test).value /= 0 then
                    a      := nv.value
                    tc     := a.type
                    result := a.demarshal (tc, idc)
                end
                i := i + 1
            end
--            if result and then idc.get_buffer.length > 0 then
--                ctx.set_item (idc.get_context)
--            end
        end
----------------------

    get_in_args_sal (iparams : INDEXED_LIST [STATIC_ANY];
                     ctx : ANY_REF) : BOOLEAN is

        local
            i, n : INTEGER

        do
            result := true
            idc.get_buffer.rseek_beg (istart)
            from
                i := iparams.low_index
                n := iparams.high_index
            until
                i > n or else not result
            loop
                result := iparams.at (i).demarshal (idc)
                i      := i + 1
            end
            if result and then idc.get_buffer.length > 0 then
                ctx.set_item (idc.get_context)
            end
        end
----------------------

    get_in_args_de (ec : DATA_ENCODER) : BOOLEAN is

        do
            -- XXX alignment, byteorder, differing codecs ???
            check
                matching_types     : equal (ec.type, idc.type)
                matching_byteorder : ec.get_byteorder = idc.get_byteorder
            end
            idc.get_buffer.rseek_beg (istart)
            ec.put_octets (idc.get_buffer.data)
            result := true
        end
----------------------

    get_out_args_nvl (res     : CORBA_ANY;
                      oparams : CORBA_NV_LIST;
                      except  : ANY_REF) : BOOLEAN is

        local
            e    : CORBA_EXCEPTION
            a    : CORBA_ANY
            tc   : CORBA_TYPECODE
            i, n : INTEGER

        do
            result := true
            odc.get_buffer.rseek_beg (ostart)
            if is_except then
                e := exception_decode_decoder (odc)
                check
                    valid_exception : e /= void
                end
                except.set_item (e)
            else
                except.set_item (void)
                if res /= void then
                    tc := res.type
                    if not tc.omg_equal (Tc_void) then
                        result := res.demarshal (tc, odc)
                    end
                end
                from
                    i := 1
                    n := oparams.count
                until
                    i > n or else not result
                loop
                    a      := oparams.item (i).value
                    tc     := a.type
                    result := a.demarshal (tc, odc)
                    i      := i + 1
                end
            end
        end
----------------------

    get_out_args_sal (res     : STATIC_ANY;
                      oparams : INDEXED_LIST [STATIC_ANY];
                      except  : ANY_REF) : BOOLEAN is

        local
            e    : CORBA_EXCEPTION
            i, n : INTEGER

        do
            result := true
            odc.get_buffer.rseek_beg (ostart)
            if is_except then
                e := exception_decode_decoder (odc)
                check
                    valid_exception : e /= void
                end
                except.set_item (e)
            else
                except.set_item (void)
                if res /= void then
                    result := res.demarshal (odc)
                end
                from
                    i := oparams.low_index
                    n := oparams.high_index
                until
                    i > n or else not result
                loop
                    result := oparams.at (i).demarshal (odc)
                    i      := i + 1
                end
            end
        end
----------------------

    get_out_args_de (ec    : DATA_ENCODER;
                     is_ex : BOOLEAN_REF) : BOOLEAN is

        do
            -- XXX alignment, byteorder, differing codecs ???
            check
                matching_types     : equal (ec.type, odc.type)
                matching_byteorder : ec.get_byteorder = odc.get_byteorder
            end
            odc.get_buffer.rseek_beg (ostart)
            ec.put_octets (odc.get_buffer.data)
            is_ex.set_item (is_except)
            result := true
        end
----------------------

    type : STRING is

        do
            result := "giop"
        end
----------------------

    input_byteorder : INTEGER is

        do
            result := idc.get_byteorder
        end
----------------------

    output_byteorder : INTEGER is

        do
            result := odc.get_byteorder
        end
----------------------

    csid : INTEGER is

        do
            if idc.converter /= void then
                result := idc.converter.get_from.id
            end
        end
----------------------

    wcsid : INTEGER is

        do
            if idc.wconverter /= void then
                result := idc.wconverter.get_from.id
            end
        end
----------------------
feature -- Mutation

    set_out_args_nvl (res     : CORBA_ANY;
                      oparams : CORBA_NV_LIST) : BOOLEAN is

        local
            i, n : INTEGER
            test : FLAGS
            outc : GIOP_OUT_CONTEXT
            dum  : BOOLEAN

        do
            oec.get_buffer.reset (Buffer_minsize)

            -- this is to get alignment right
            create outc.make_ec (oec)
            dum := codec.put_invoke_reply_offset (outc, current)
            ostart := oec.get_buffer.wpos
            oec.get_buffer.rseek_beg (ostart)

            is_except := false
            if res /= void then
                res.marshal (oec)
            end
            n := oec.get_buffer.wpos -- for debugging
            if oparams /= void then
                from
                    i    := 1
                    n    := oparams.count
                    test := Flags.Arg_out | Flags.Arg_inout
                until
                    i > n
                loop
                    if (oparams.item (i).my_flags & test).value /= 0 then
                        oparams.item (i).value.marshal (oec)
                    end
                    i := i + 1
                end -- loop
            end -- if oparams /= void then ...
            result := true
        end
----------------------

    set_out_args_sal (res     : STATIC_ANY;
                      oparams : INDEXED_LIST [STATIC_ANY]) : BOOLEAN is

        local
            i, n : INTEGER
            test : FLAGS
            outc : GIOP_OUT_CONTEXT
            dum  : BOOLEAN

        do
            oec.get_buffer.reset (Buffer_minsize)

            -- this is to get alignment right
            create outc.make_ec (oec)
            dum    := codec.put_invoke_reply_offset (outc, current)
            ostart := oec.get_buffer.wpos
            oec.get_buffer.rseek_beg (ostart)

            is_except := false
            if res /= void then
                res.marshal (oec)
            end
            test := Flags.Arg_out | Flags.Arg_inout
            from
                i := oparams.low_index
                n := oparams.high_index
            until
                i > n
            loop
                if (oparams.at (i).flags & test).value /= 0 then
                    oparams.at (i).marshal (oec)
                end
                i := i + 1
            end
            result := true
        end
----------------------

    set_out_args_ex (except : CORBA_EXCEPTION) is

        local
            outc : GIOP_OUT_CONTEXT
            dum  : BOOLEAN

        do
            oec.get_buffer.reset (Buffer_minsize)

            -- this is to get alignment right
            create outc.make_ec (oec)
            dum    := codec.put_invoke_reply_offset (outc, current)
            ostart := oec.get_buffer.wpos
            oec.get_buffer.rseek_beg (ostart)

            is_except := true
            except.encode (oec)
        end
----------------------

    set_out_args_dc (dc       : DATA_DECODER;
                     is_ex : BOOLEAN) : BOOLEAN is

        local
            outc : GIOP_OUT_CONTEXT
            dum  : BOOLEAN

        do
            oec.get_buffer.reset (Buffer_minsize)

            -- this is to get alignment right
            create outc.make_ec (oec)
            dum    := codec.put_invoke_reply_offset (outc, current)
            ostart := oec.get_buffer.wpos
            oec.get_buffer.rseek_beg (ostart)

            -- XXX alignment, byteorder, differing codecs ???
            check
                matching_types     : equal (dc.type, oec.type)
                matching_byteorder : dc.get_byteorder = oec.get_byteorder
            end
            oec.put_octets (dc.get_buffer.data)
            dc.get_buffer.rseek_rel (dc.get_buffer.length)
            is_except := is_ex
            result    := true
        end
----------------------

    copy_out_args (req : ORB_REQUEST) : BOOLEAN is

        local
            outc : GIOP_OUT_CONTEXT
            dum  : BOOLEAN

        do
            result := true
            if current /= req then
                -- copy service context list
                copy_svc (req)

                check
                    valid_encoder : oec /= void
                end
                oec.get_buffer.reset (Buffer_minsize)

                -- this is to get alignment right
                create outc.make_ec (oec)
                dum    := codec.put_invoke_reply_offset (outc, current)
                ostart := oec.get_buffer.wpos
                oec.get_buffer.rseek_beg (ostart)

                dum := req.get_out_args_de (oec, is_except)
            end
        end
----------------------

    copy_in_args (req : ORB_REQUEST) : BOOLEAN is

        do
            check
                never_called : false
            end
        end
----------------------
feature { NONE } -- Implementation

    opname    : STRING
    idc       : DATA_DECODER
    istart    : INTEGER
    oec       : DATA_ENCODER
    odc       : DATA_DECODER
    ostart    : INTEGER
    codec     : GIOP_CODEC
    is_except : BOOLEAN

end -- class GIOP_REQUEST






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
