indexing

description: "Still to be entered";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class GIOP_CODEC

inherit
    BUFFER_CONSTANTS;
    GIOP_CONSTANTS;
    ORB_STATICS;
    CODESET_STATICS

creation
    make

feature -- Initialization

    make (dc : DATA_DECODER; ec : DATA_ENCODER) is

        local
            ctx : GIOP_OUT_CONTEXT

        do
            dc_proto := dc
            ec_proto := ec
            create ctx.make1 (current)
            create giop_ver_major.make (1)
            create giop_ver_minor.make (0)
            size_offset := put_header (ctx, GIOP_request)
            headerlen   := ctx.get_ec.get_buffer.length
        end
----------------------
feature -- Access

    get_dc_proto : DATA_DECODER is

        do
            result := dc_proto
        end
----------------------

    get_ec_proto : DATA_ENCODER is

        do
            result := ec_proto
        end
----------------------
feature -- Encoding

    put_invoke_request (outc         : GIOP_OUT_CONTEXT;
                        req_id       : INTEGER;
                        response_exp : BOOLEAN;
                        obj          : CORBA_OBJECT;
                        req          : ORB_REQUEST;
                        pr           : PRINCIPAL) : BOOLEAN is

        require
            nonvoid_args : outc /= void and then
                           req  /= void

        local
            ec   : DATA_ENCODER
            bo   : INTEGER
            greq : GIOP_REQUEST
            key  : INTEGER
            o    : OCTET
            pr1  : PRINCIPAL

        do
            ec := outc.get_ec
            bo := ec.get_byteorder
            if equal (req.type, "giop") then
                greq ?= req
                ec.set_byteorder (greq.input_byteorder)
            end
            key := put_header (outc, GIOP_request)
            ec.struct_begin
            put_contextlist3 (outc, req.get_context, true)
            ec.put_ulong (req_id)
            ec.put_boolean (response_exp)
            if giop_ver_minor.value /= 0 then
                create o.make (0)
                ec.put_octet (o)
                ec.put_octet (o)
                ec.put_octet (o)
            end
            put_objectkey (outc, obj)
            ec.put_string_raw (req.op_name)
            if pr = void then
                create pr1.make
            else
                pr1 := pr
            end
            ec.put_principal (pr1)
            ec.struct_end
            put_args (outc, req, true)
            put_size (outc, key)
            ec.set_byteorder (bo)
            result := true
        end
----------------------

    put_invoke_reply (outc   : GIOP_OUT_CONTEXT;
                      req_id : INTEGER;
                      stat   : INTEGER;
                      obj    : CORBA_OBJECT;
                      req    : ORB_REQUEST) : BOOLEAN is

        require
            nonvoid_args : outc /= void and then
                           req  /= void

        local
            ec   : DATA_ENCODER
            bo   : INTEGER
            greq : GIOP_REQUEST
            key  : INTEGER

        do
            ec := outc.get_ec
            bo := ec.get_byteorder
            if equal (req.type, "giop") then
                greq ?= req
                ec.set_byteorder (greq.output_byteorder)
            end
            key := put_header (outc, GIOP_reply)
            ec.struct_begin
            put_contextlist2 (outc, req.get_context)
            ec.put_ulong (req_id)
            ec.put_enumeration_value (stat)
            ec.struct_end
            inspect stat

            when GIOP_no_exception, GIOP_user_exception,
                 GIOP_system_exception then
                put_args (outc, req, false)

            when GIOP_location_forward then
                ec.put_ior (obj.get_ior)

            end -- inspect
            put_size (outc, key)

            ec.set_byteorder (bo)
            result := true
        end
----------------------

    put_invoke_reply_offset (outc : GIOP_OUT_CONTEXT;
                             req  : ORB_REQUEST) : BOOLEAN is

        require
            nonvoid_args : outc /= void and then
                           req  /= void

        local
            ec : DATA_ENCODER

        do
            ec := outc.get_ec
            ec.get_buffer.wseek_rel (headerlen)

            ec.struct_begin
            put_contextlist2 (outc, req.get_context)
            ec.put_ulong (0)
            ec.put_enumeration_value (0)
            ec.struct_end
            result := true
        end
----------------------

    put_cancel_request (outc   : GIOP_OUT_CONTEXT;
                        req_id : INTEGER) : BOOLEAN is

        require
            nonvoid_arg : outc /= void

        local
            ec  : DATA_ENCODER
            key : INTEGER

        do
            ec := outc.get_ec

            key := put_header (outc, GIOP_cancel_request)
            ec.struct_begin
            ec.put_ulong (req_id)
            ec.struct_end
            put_size (outc, key)
            result := true
        end
----------------------

    put_locate_request (outc   : GIOP_OUT_CONTEXT;
                        req_id : INTEGER;
                        obj    : CORBA_OBJECT) : BOOLEAN is

        require
            nonvoid_arg : outc /= void

        local
            ec  : DATA_ENCODER
            key : INTEGER

        do
            ec := outc.get_ec

            key := put_header (outc, GIOP_locate_request)
            ec.struct_begin
            ec.put_ulong (req_id)
            put_objectkey (outc, obj)
            ec.struct_end
            put_size (outc, key )
            result := true
        end
----------------------

    put_locate_reply (outc   : GIOP_OUT_CONTEXT;
                      req_id : INTEGER;
                      stat   : INTEGER;
                      obj    : CORBA_OBJECT) : BOOLEAN is

        require
            nonvoid_arg : outc /= void

        local
            ec  : DATA_ENCODER
            key : INTEGER

        do
            ec := outc.get_ec

            key := put_header (outc, GIOP_locate_reply)
            ec.struct_begin
            ec.put_ulong (req_id)
            ec.put_enumeration_value (stat)
            ec.struct_end
            put_size (outc, key)
            result := true
        end
----------------------

    put_bind_request (outc   : GIOP_OUT_CONTEXT;
                      req_id : INTEGER;
                      repoid : STRING;
                      oid    : ARRAY [INTEGER]) : BOOLEAN is

        require
            nonvoid_arg : outc /= void

        local
            ec  : DATA_ENCODER
            key : INTEGER
            ctx : INDEXED_LIST [SERVICE_CONTEXT]
            o   : OCTET
            pr  : PRINCIPAL

        do
            -- mapped to an invocation
            --   _bind (in string repoid,
            --          in sequence<octet> oid,
            --          out object obj);
            ec := outc.get_ec

            key := put_header (outc, GIOP_request)
            ec.struct_begin
            create ctx.make (false)
            put_contextlist2 (outc, ctx)
            ec.put_ulong (req_id)
            ec.put_boolean (true)
            create o.make (0)
            if giop_ver_minor.value /= 0 then
                ec.put_octet (o)
                ec.put_octet (o)
                ec.put_octet (o)
            end
            -- object key
            ec.seq_begin (1)
            ec.put_octet (o)
            ec.seq_end
            ec.put_string_raw ("_bind")
            create pr.make
            ec.put_principal (pr)
            ec.struct_end
            ec.struct_begin
            ec.put_string (repoid)
            ec.seq_begin (oid.count)
            ec.put_octets (oid)
            ec.seq_end
            ec.struct_end
            put_size (outc, key)
            result := true
        end
----------------------

    put_bind_reply (outc   : GIOP_OUT_CONTEXT;
                    req_id : INTEGER;
                    stat   : INTEGER;
                    obj    : CORBA_OBJECT) : BOOLEAN is

        require
            nonvoid_arg : outc /= void

        local
            ec  : DATA_ENCODER
            key : INTEGER
            o   : OCTET
            ctx : INDEXED_LIST [SERVICE_CONTEXT]
            ior : IOR

        do
            -- mapped to an invocation:
            --    _bind (in string repoid,
            --           in sequence<octet> oid,
            --           out object obj);
            ec := outc.get_ec

            key := put_header (outc, GIOP_reply)
            ec.struct_begin
            create ctx.make (false)
            put_contextlist2 (outc, ctx)
            ec.put_ulong (req_id)
            ec.put_enumeration_value (GIOP_no_exception)
            ec.struct_end
            ec.struct_begin
            ec.put_enumeration_value (stat)
            if stat = GIOP_object_here then
                ior := obj.get_ior
            else
                create ior.make
            end
            ec.put_ior (ior)
            ec.struct_end
            put_size (outc, key)
            result := true
        end
----------------------

    put_close_msg (outc : GIOP_OUT_CONTEXT) : BOOLEAN is

        require
            nonvoid_arg : outc /= void

        local
            ec  : DATA_ENCODER
            key : INTEGER

        do
            ec := outc.get_ec

            key := put_header (outc, GIOP_close_connection)
            put_size (outc, key)
            result := true
        end
----------------------

    put_error_msg (outc : GIOP_OUT_CONTEXT) : BOOLEAN is

        require
            nonvoid_arg : outc /= void

        local
            ec  : DATA_ENCODER
            key : INTEGER

        do
            ec := outc.get_ec

            key := put_header (outc, GIOP_message_error)
            put_size (outc, key)
            result := true
        end
----------------------
feature -- Decoding

    header_length : INTEGER is

        do
            result := headerlen;
        end
----------------------

    get_header (in : GIOP_IN_CONTEXT;
                mt : INTEGER_REF;
                sz : INTEGER_REF;
                fl : OCTET) : BOOLEAN is

        require
            nonvoid_args : in /= void and then
                           mt /= void and then
                           sz /= void and then
                           fl /= void

        local
            dc  : DATA_DECODER
            br  : BOOLEAN_REF
            fl1 : FLAGS
            fl2 : FLAGS
            o   : OCTET
            cr  : CHARACTER_REF
            dum : BOOLEAN

        do
            dc := in.get_dc
            create cr
            create br
            dum := dc.struct_begin
            dc.arr_begin
            dc.get_char_raw (cr)
            check
                its_a_G : cr.item = 'G'
            end
            dc.get_char_raw (cr)
            check
                its_an_I : cr.item = 'I'
            end
            dc.get_char_raw (cr)
            check
                its_an_O : cr.item = 'O'
            end
            dc.get_char_raw (cr)
            check
                its_a_P : cr.item = 'P'
            end
            dc.arr_end
            dum := dc.struct_begin

            o := dc.get_octet
            check
                its_a_1 : o.value = 1
            end
            o := dc.get_octet
            check
                its_a_1_or_0 : o.value = 1 or else o.value = 0
            end
            giop_ver_minor := o
            dum := dc.struct_end
            if giop_ver_minor.value = 0 then
                dc.get_boolean (br)
                if br.item then
                    dc.set_byteorder (Byteorder_little_endian)
                    fl.set_value (1)
                else
                    dc.set_byteorder (Byteorder_big_endian)
                    fl.set_value (0)
                end
            else
                fl.copy (dc.get_octet)
                create fl1.make (GIOP_byteorder_bit, 32)
                create fl2.make (fl.value, 32)
                if (fl1 & fl2).value = 0 then
                    dc.set_byteorder (Byteorder_big_endian)
                else
                    dc.set_byteorder (Byteorder_little_endian)
                end
            end -- if giop_ver_minor.value = 0 then ...
            o := dc.get_octet
            mt.set_item (o.value)
            dc.get_ulong (sz)
            dum := dc.struct_end
            result := true
        end
----------------------

    check_header (in : GIOP_IN_CONTEXT;
                  mt : INTEGER_REF;
                  sz : INTEGER_REF;
                  fl : OCTET) : BOOLEAN is

        require
            nonvoid_arg : in /= void and then
                          mt /= void and then
                          sz /= void and then
                          fl /= void

        local
            pos : INTEGER

        do
            pos    := in.get_dc.get_buffer.rpos
            result := get_header (in, mt, sz, fl)
            in.get_dc.get_buffer.rseek_beg (pos)
        end
----------------------

    get_invoke_request (in     : GIOP_IN_CONTEXT;
                        req_id : INTEGER_REF;
                        resp   : BOOLEAN_REF;
                        obj    : CORBA_OBJECT;
                        req    : ANY_REF;
                        pr     : PRINCIPAL) : BOOLEAN is

        require
            nonvoid_args : in /= void and then
                           req_id /= void and then
                           resp   /= void and then
                           obj    /= void and then
                           req    /= void and then
                           pr     /= void

        local
            dc     : DATA_DECODER
            ctx    : INDEXED_LIST [SERVICE_CONTEXT]
            opname : STRING
            o      : OCTET
            dum    : BOOLEAN
            greq   : GIOP_REQUEST

        do
            dc := in.get_dc
            dum :=dc.struct_begin
            ctx := get_contextlist2 (in, true)
            dc.get_ulong (req_id)
            dc.get_boolean (resp)
            if giop_ver_minor.value /= 0 then
                o := dc.get_octet
                o := dc.get_octet
                o := dc.get_octet
            end
            get_objectkey (in, obj)
            opname := dc.get_string_raw
            pr.copy (dc.get_principal)
            dum :=dc.struct_end
            create greq.make (opname, in.retn, current)
            req.set_item (greq)
            greq.set_context (ctx)
            result := true
        end
----------------------

    get_invoke_reply1 (in     : GIOP_IN_CONTEXT;
                       req_id : INTEGER_REF;
                       stat   : INTEGER_REF;
                       ctx    : INDEXED_LIST [SERVICE_CONTEXT]) : BOOLEAN is

        require
            nonvoid_args : in     /= void and then
                           req_id /= void and then
                           stat   /= void and then
                           ctx    /= void
        local
            dc  : DATA_DECODER
            k   : INTEGER
            dum : BOOLEAN

        do
            dc := in.get_dc

            dum := dc.struct_begin
            ctx.copy (get_contextlist1 (in))
            dc.get_ulong (req_id)
            k := dc.get_enumeration_value
            stat.set_item (k)
            dum := dc.struct_end
            result := true
        end
----------------------

    get_invoke_reply2 (in     : GIOP_IN_CONTEXT;
                       req_id : INTEGER_REF;
                       stat   : INTEGER;
                       obj    : CORBA_OBJECT;
                       req    : ORB_REQUEST;
                       ctx    : INDEXED_LIST [SERVICE_CONTEXT]) : BOOLEAN is

        require
            nonvoid_args : in     /= void and then
                           req_id /= void and then
                           obj    /= void and then
                           ctx    /= void

        local
            dc  : DATA_DECODER
            ior : IOR

        do
            dc     := in.get_dc
            result := true
            inspect stat

            when GIOP_no_exception then
                if req /= void then
                    -- it may be void for a bind

                    req.set_context (ctx)
                    result := req.set_out_args_dc (dc, false)
                end

            when GIOP_user_exception, GIOP_system_exception then
                if req /= void then
                    -- it may be void for a bind

                    req.set_context (ctx)
                    result := req.set_out_args_dc (dc, true)
                end

            when GIOP_location_forward then
                ior := dc.get_ior
                obj.make_with_ior (ior)

            end -- inspect
        end
----------------------

    get_cancel_request (in     : GIOP_IN_CONTEXT;
                        req_id : INTEGER_REF) : BOOLEAN is

        require
            nonvoid_args : in     /= void and then
                           req_id /= void
        local
            dc  : DATA_DECODER
            dum : BOOLEAN

        do
            dc := in.get_dc

            dum := dc.struct_begin
            dc.get_ulong (req_id)
            dum := dc.struct_end
            result := true
        end
----------------------

    get_locate_request (in     : GIOP_IN_CONTEXT;
                        req_id : INTEGER_REF;
                        obj    : CORBA_OBJECT) : BOOLEAN is

        require
            nonvoid_args : in     /= void and then
                           req_id /= void and then
                           obj    /= void
        local
            dc  : DATA_DECODER
            dum : BOOLEAN

        do
            dc := in.get_dc

            dum := dc.struct_begin
            dc.get_ulong (req_id)
            get_objectkey (in, obj)
            dum := dc.struct_end
            result := true
        end
----------------------

    get_locate_reply (in     : GIOP_IN_CONTEXT;
                      req_id : INTEGER_REF;
                      stat   : INTEGER_REF;
                      obj    : ANY_REF) : BOOLEAN is

        require
            nonvoid_args : in     /= void and then
                           req_id /= void and then
                           stat   /= void and then
                           obj    /= void

        local
            dc  : DATA_DECODER
            k   : INTEGER
            dum : BOOLEAN
            ior : IOR
            o   : CORBA_OBJECT

        do
            dc := in.get_dc

            dum := dc.struct_begin
            k   := dc.get_enumeration_value
            stat.set_item (k)
            dum := dc.struct_end

            if k = GIOP_object_forward then
                create ior.make
                create o.make_with_ior (ior)
                obj.set_item (o)
            else
                obj.set_item (void)
            end
            result := true
        end
----------------------

    get_bind_request (in    : GIOP_IN_CONTEXT;
                      repoid : STRING;
                      oid    : ARRAY [INTEGER]) : BOOLEAN is

        require
            nonvoid_args : in     /= void and then
                           repoid /= void and then
                           oid    /= void

        local
            dc  : DATA_DECODER
            dum : BOOLEAN
            l   : INTEGER

        do

            dc := in.get_dc
            -- mapped to an invocation
            --    _bind (in string repod,
            --           in sequence<octet> oid,
            --           out object obj);
            -- at this point only the invoke request in args
            -- are left in the buffer ...

            dum := dc.struct_begin
            repoid.copy (dc.get_string)
            l   := dc.seq_begin
            if l > oid.count then
                oid.make (1, l)
            end
            if l > 0 then
                dc.get_octets (oid, l)
            end
            dc.seq_end
            dum := dc.struct_end
            result := true
        end
----------------------

    get_bind_reply (in   : GIOP_IN_CONTEXT;
                    stat : INTEGER_REF;
                    obj  : ANY_REF) : BOOLEAN is

        require
            nonvoid_args : in /= void   and then
                           stat /= void and then
                           obj /= void

        local
            dc  : DATA_DECODER
            dum : BOOLEAN
            k   : INTEGER
            ior : IOR
            o   : CORBA_OBJECT

        do
            dc := in.get_dc
            -- mapped to an invocation:
            --  _bind (in string repoid,
            --         in sequence<octet> oid,
            --         out object obj);
                       
            dum := dc.struct_begin
            k   := dc.get_enumeration_value
            stat.set_item (k)
            ior := dc.get_ior
            dum := dc.struct_end
            if k /= locate_unknown then
                create o.make_with_ior (ior)
                obj.set_item (o)
            else
                obj.set_item (void)
            end
            result := true
        end
----------------------

    get_close_msg (in : GIOP_IN_CONTEXT) : BOOLEAN is

        require
            nonvoid_arg : in /= void

        do
            result := true
        end
----------------------

    get_error_msg (in : GIOP_IN_CONTEXT) : BOOLEAN is

        require
            nonvoid_arg : in /= void

        do
            result := true
        end
----------------------
feature { NONE } -- Implementation

    dc_proto       : DATA_DECODER
    ec_proto       : DATA_ENCODER
    headerlen      : INTEGER
    size_offset    : INTEGER
    giop_ver_major : OCTET
    giop_ver_minor : OCTET
----------------------

    put_header (outc : GIOP_OUT_CONTEXT; mt : INTEGER) : INTEGER is

        local
            ec   : DATA_ENCODER
            o    : OCTET

        do
            ec := outc.get_ec
            ec.struct_begin

            ec.arr_begin
            -- These are really chars, but they must be
            -- encoded in latin1 ...
            ec.put_char_raw ('G')
            ec.put_char_raw ('I')
            ec.put_char_raw ('O')
            ec.put_char_raw ('P')
            ec.arr_end

            ec.struct_begin
            ec.put_octet (giop_ver_major)
            ec.put_octet (giop_ver_minor)
            ec.struct_end

            if giop_ver_minor.value = 0 then
                if ec.get_byteorder = Byteorder_little_endian then
                    ec.put_boolean (true)
                else
                    ec.put_boolean (false)
                end
            else
                if ec.get_byteorder = Byteorder_little_endian then
                    create o.make (GIOP_byteorder_bit)
                else
                    create o.make (0)
                end
                ec.put_octet (o)
            end
            create o.make (mt)
            ec.put_octet (o)
            result := ec.get_buffer.wpos -- position of the size field.
            ec.put_ulong (0) -- reserve space for the size field.
            ec.struct_end
        end
----------------------

    put_size (outc : GIOP_OUT_CONTEXT; key : INTEGER) is
        -- This routine is sort of tricky; it has to calculate the
        -- number of bytes in the message *following the header*
        -- and write this number into the size field of the header.
        -- `key' is the position of the size field.

        local
            ec        : DATA_ENCODER
            end_pos   : INTEGER
            start_pos : INTEGER

        do
            ec      := outc.get_ec
            end_pos := ec.get_buffer.wpos -- Here's where the message ends.
            ec.get_buffer.wseek_beg (key)
            ec.put_ulong (0)
            ec.struct_end
            start_pos := ec.get_buffer.wpos -- And this is the first
                                            -- position after the header.
            ec.get_buffer.wseek_beg (key)
            ec.put_ulong (end_pos - start_pos)
            ec.get_buffer.wseek_beg (end_pos)
        end
----------------------

    put_contextlist2 (outc : GIOP_OUT_CONTEXT;
                     ctx   : INDEXED_LIST [SERVICE_CONTEXT]) is

        do
            put_contextlist3 (outc, ctx, false)
        end
----------------------

    put_contextlist3 (outc    : GIOP_OUT_CONTEXT;
                     ctx      : INDEXED_LIST [SERVICE_CONTEXT];
                     codesets : BOOLEAN) is

        local
            ec          : DATA_ENCODER
            state       : ENCAPS_STATE
            i, n        : INTEGER
            len         : INTEGER
            csid        : INTEGER
            wcsid       : INTEGER
            do_codesets : BOOLEAN

        do
            ec := outc.get_ec

            do_codesets := codesets and then not codeset_disabled (false)

            if ctx /= void then
                len := ctx.count
            end
            if do_codesets then
                len := len + 1
            end
            ec.seq_begin (len)
            if ctx /= void then
                from
                    i := ctx.low_index
                    n := ctx.high_index
                until
                    i > n
                loop
                    ec.struct_begin
                    ec.put_ulong (ctx.at (i).get_context_id)
                    create state
                    ec.encaps_begin (state)
                    if ctx.at (i).get_context_data.count > 0 then
                        ec.put_octets (ctx.at (i).get_context_data)
                    end
                    ec.encaps_end (state)
                    ec.struct_end
                    i := i + 1
                end -- loop
            end -- if ctx /= void then ...
            if do_codesets then
                if ec.converter /= void then
                    csid := ec.converter.get_to.id
                end
                if ec.wconverter /= void then
                    wcsid := ec.wconverter.get_to.id
                end
                ec.struct_begin
                ec.put_ulong (IOP_codesets)
                create state
                ec.encaps_begin (state)
                ec.struct_begin
                ec.put_ulong (csid)
                ec.put_ulong (wcsid)
                ec.struct_end
                ec.encaps_end (state)
                ec.struct_end
            end -- if do_codesets then ...
            ec.seq_end
        end
----------------------

    put_objectkey (outc: GIOP_OUT_CONTEXT; obj : CORBA_OBJECT) is

        local
            ec        : DATA_ENCODER
            prof      : IOR_PROFILE
            objkey    : ARRAY [INTEGER]
            len       : INTEGER_REF

        do
            ec := outc.get_ec

            -- XXX assumes all the profiles of an IOR have the
            -- same objectkey ...
            prof := obj.get_ior.profile
            check
                valid_profile : prof /= void
            end
            create len
            objkey := prof.get_objectkey (len)

            -- XXX encapsulated or simple sequence ???

            ec.seq_begin (objkey.count)
            ec.put_octets (objkey)
            ec.seq_end
        end
----------------------

    put_args (outc: GIOP_OUT_CONTEXT;
              req : ORB_REQUEST;
              inp : BOOLEAN) is

        local
            ec        : DATA_ENCODER
            is_except : BOOLEAN_REF
            dum       : BOOLEAN

        do
            ec := outc.get_ec
            ec.struct_begin
                if inp then
                    dum := req.get_in_args_de (ec)
                else
                    create is_except
                    dum := req.get_out_args_de (ec, is_except)
                end
            ec.struct_end
        end
----------------------

    get_contextlist1 (in : GIOP_IN_CONTEXT): INDEXED_LIST [SERVICE_CONTEXT] is

        require
            nonvoid_arg : in /= void

        do
            result := get_contextlist2 (in, false)
        end
----------------------

    get_contextlist2 (in : GIOP_IN_CONTEXT;
                      codesets : BOOLEAN) : INDEXED_LIST [SERVICE_CONTEXT] is

        require
            nonvoid_arg : in /= void

        local
            dc          : DATA_DECODER
            len         : INTEGER
            csid        : INTEGER_REF
            wcsid       : INTEGER_REF
            i, n        : INTEGER
            state       : INTEGER_REF
            context_id  : INTEGER_REF
            conv        : CODESET_CONVERTER
            wconv       : CODESET_CONVERTER
            do_codesets : BOOLEAN
            dum         : BOOLEAN
            sctx        : SERVICE_CONTEXT
            d           : ARRAY [INTEGER]

        do
            dc := in.get_dc

            do_codesets := codesets and then not codeset_disabled (false)

            len := dc.seq_begin
            create result.make (false)
                from
                    i := 1
                    n := len
                    create context_id
                    create state
                    create csid
                    create wcsid
                until
                    i > n
                loop
                    dum := dc.struct_begin
                    dc.get_ulong (context_id)
                    len := dc.encaps_begin (state)
                    if context_id.item = IOP_codesets then
                        -- code set service ...
                        n   := n - 1
                        dum := dc.struct_begin
                        dc.get_ulong (csid)
                        dc.get_ulong (wcsid)
                        dum := dc.struct_end
                    else -- other services
                        create d.make (1, len)
                        dc.get_octets (d, len)
                        create sctx.make (context_id.item, d)
                        result.append (sctx)
                        i := i + 1
                    end -- if context_id.item ...
                    dc.encaps_end (state.item)
                    dum := dc.struct_end
                end
            dc.seq_end
            -- set up codesets ...
            if do_codesets then
                if csid.item /= 0 then
                    conv := the_codeset_db.find (csid.item,
                                    special_cs (Native_cs).id)
                end
                if wcsid.item /= 0 then
                    wconv := the_codeset_db.find (wcsid.item,
                                     special_cs (Native_wcs).id)
                end
                in.set_converters (conv, wconv)
            end
        end
----------------------

    get_objectkey (in : GIOP_IN_CONTEXT; obj : CORBA_OBJECT)  is

        require
            nonvoid_args : in  /= void and then
                           obj /= void

        local
            dc     : DATA_DECODER
            len    : INTEGER
            objkey : ARRAY [INTEGER]

        do
            dc := in.get_dc

            len    := dc.seq_begin
            objkey := dc.get_buffer.data1 (len)
            dc.get_buffer.rseek_rel (len)
            dc.seq_end

            -- XXX should make sure the seeked over data are
            -- still valid ...
            obj.get_ior.set_objectkey (objkey, len)
        end

end -- class GIOP_CODEC

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
