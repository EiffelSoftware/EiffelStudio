indexing

description: "CORBA_ANY and CORBA_TYPECODE are the pillars on which DII rests";
keywords: "DII";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_ANY
    -- We can't call it ANY, since Eiffel has a predefined class ANY.

inherit
    THE_LOGGER
        undefine
            copy, is_equal
        end;
    BUFFER_CONSTANTS
        undefine
            copy, is_equal
        end;
    TYPECODE_STATICS
        redefine
            copy, is_equal
        end

creation
    make, make1, make3, make_with_buffer


feature -- Initialization

    make is

        do
            the_type := Tc_void
            create checker.make
            create {SIMPLE_ENCODER} ec.make
            create {SIMPLE_DECODER} dc.make1 (ec.get_buffer)
        end
----------------------

    make1 (t : CORBA_TYPECODE) is

        do
            the_type  := t
            create checker.make_with_typecode (t)
            create {SIMPLE_ENCODER} ec.make
            create {SIMPLE_DECODER} dc.make1 (ec.get_buffer)
        end
----------------------

    make_with_buffer (t : CORBA_TYPECODE; b : BUFFER) is

        do
            the_type := t
            create checker.make
            create {SIMPLE_ENCODER} ec.make1 (b)
            create {SIMPLE_DECODER} dc.make1 (b)
        end
----------------------

    make3 (t : CORBA_TYPECODE; ddc : DATA_DECODER; dec : DATA_ENCODER) is

        do
            the_type := t
            create checker.make_with_typecode (t) -- This is a deviation
                                                  -- from MICO
            ec := dec
            dc := ddc
        end
----------------------
feature -- Access (The official interface)

    typecode : CORBA_TYPECODE is

        do
            result := get_typecode
        end
----------------------

    idl_object : ANY is
        -- The IDL object transported by `current'.
        -- If it is a basic type then `result' is
        -- an appropriate XXX_REF type.
        -- `result' is void if the value isn't a basic type,
        -- object reference, typecode or principle.
        -- For a constructed IDL type like struct, union, etc.
        -- use the routines in the corresponding helper class.

        local
            tc : CORBA_TYPECODE
            ir : INTEGER_REF
            rr : REAL_REF
            dr : DOUBLE_REF
            cr : CHARACTER_REF
            br : BOOLEAN_REF

        do
            tc := get_typecode.unalias
            inspect tc.kind

            when Tk_short then
                create ir
                ir.set_item (get_short)
                result := ir

            when Tk_ushort then
                create ir
                ir.set_item (get_ushort)
                result := ir

            when Tk_long then
                create ir
                ir.set_item (get_long)
                result := ir

            when Tk_ulong then
                create ir
                ir.set_item (get_ulong)
                result := ir

            when Tk_float then
                create rr
                rr.set_item (get_float)
                result := rr

            when Tk_double then
                create dr
                dr.set_item (get_double)
                result := dr

            when Tk_char then
                create cr
                cr.set_item (get_char)
                result := cr

            when Tk_boolean then
                create br
                br.set_item (get_boolean)
                result := br

            when Tk_octet then
                result := get_octet

            when Tk_string then
                result := get_string (tc.length)

            when Tk_objref then
                result := get_object (tc.name)

            when Tk_typecode then
                result := get_typecode

            when Tk_principal then
                result := get_principal

            else
                -- result is void
            end
        end
----------------------
feature -- Mutation

    set_checker (tcc : TYPECODE_CHECKER) is

        do
            checker := tcc
        end
----------------------

    put_short (val : INTEGER) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_short)
            elseif not checker.basic (Tc_short) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_short (val)
            end
        end
----------------------

    put_long (val : INTEGER) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_long)
            elseif not checker.basic (Tc_long) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_long (val)
            end       
        end
----------------------

    put_longlong (val : INTEGER) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_longlong)
            elseif not checker.basic (Tc_longlong) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_longlong (val)
            end
        end
----------------------

    put_ushort (val : INTEGER) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_ushort)
            elseif not checker.basic (Tc_ushort) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_ushort (val)
            end
        end
----------------------

    put_ulong (val : INTEGER) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_ulong)
            elseif not checker.basic (Tc_ulong) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_ulong (val)
            end
        end
----------------------

    put_ulonglong (val : INTEGER) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_ulonglong)
            elseif not checker.basic (Tc_ulonglong) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_ulonglong (val)
            end
        end
----------------------

    put_float (val : REAL) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_float)
            elseif not checker.basic (Tc_float) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_float (val)
            end
        end
----------------------

    put_double (val : DOUBLE) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_double)
            elseif not checker.basic (Tc_double) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_double (val)
            end
        end
----------------------

    put_longdouble (val : DOUBLE) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_longdouble)
            elseif not checker.basic (Tc_longdouble) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_longdouble (val)
            end
        end
----------------------

    put_any (val : CORBA_ANY) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_any)
            elseif not checker.basic (Tc_any) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_any (val)
            end
        end
----------------------

    put_string (val : STRING; bound : INTEGER) is

        require
            valid_args  : (bound > 0 and then val /= void)
                          implies
                          val.count >= bound
 
        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_string)
            else
                if not checker.basic (Tc_string) then
                    reset
                    return := true
                    check
                        correct_type : false
                    end
                end
            end
            if not return then
                if val = void then
                    ec.put_string ("")
                else
                    ec.put_string (val)
                end
            end
        end
----------------------

    put_wstring (val : ARRAY [INTEGER]; bound : INTEGER) is

        require
            valid_args : bound > 0 implies
                         val.count > bound

        local
            return : BOOLEAN
            ia     : ARRAY [INTEGER]

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_wstring)
            else
                if not checker.basic (Tc_wstring) then
                    reset
                    return := true
                    check
                        correct_type : false
                    end
                end
            end
            if not return then
                if val = void then
                    create ia.make (1, 1)
                    ia.put (0, 1) -- empty wstring
                    ec.put_wstring (ia)
                else
                    ec.put_wstring (val)
                end
            end
        end
----------------------

    put_fixed (val : FIXED_VALUE; digits, scale : INTEGER) is

        require
            valid_arg : val.length = digits + 1

        local
            t      : CORBA_TYPECODE
            return : BOOLEAN

        do
            t := create_fixed_tc (digits, scale)
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (t)
            else
                if not checker.basic (t) then
                    reset
                    check
                        correct_type : false
                    end
                    return := true
                end

                if not return then
                    ec.put_fixed (val, digits, scale)
                end
            end
        end
----------------------

    put_boolean (val : BOOLEAN) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_boolean)
            elseif not checker.basic (Tc_boolean) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_boolean (val)
            end
        end
----------------------

    put_octet (val : OCTET) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_octet)
            elseif not checker.basic (Tc_octet) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_octet (val)
            end
        end
----------------------

    put_octets (val : ARRAY [INTEGER]) is

        local
            i, n : INTEGER
            o    : OCTET

        do
            seq_put_begin (val.count)
            from
                i := val.lower
                n := val.upper
            until
                i > n
            loop
                create o.make (val.item (i))
                put_octet (o)
                i := i + 1
            end
            seq_put_end
        end
----------------------

    put_char (val : CHARACTER) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_char)
            elseif checker.basic (Tc_char) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_char (val)
            end
        end
----------------------

    put_wchar (val : INTEGER) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_wchar)
            elseif checker.basic (Tc_wchar) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_wchar (val)
            end
        end
----------------------

    put_object (clss : STRING; val : CORBA_OBJECT) is

        local
            ior    : IOR
            repoid : STRING
            return : BOOLEAN
--            log    : IO_MEDIUM

        do
            if val = void then
                create ior.make
                repoid := ""
            else
                ior    := val.get_ior
                repoid := ior.get_repoid
            end
            if checker.completed then
                ec.get_buffer.reset  (Buffer_minsize)
                set_tc_if_changed (create_interface_tc (repoid, clss))
            elseif (checker.current_tc.kind /= Tk_objref or else
                    not checker.basic (checker.current_tc)) then
                reset
                return := true
            end

            if not return then
                ec.put_ior (ior)
--                log := logger.log (logger.Log_debug, "GIOP", 
--                                   "CORBA_ANY", "put_object")
--                log.put_string (ec.get_buffer.stringify)
--                log.new_line
            end
        end
----------------------

    put_typecode (val : CORBA_TYPECODE) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_typecode)
            elseif not checker.basic (Tc_typecode) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_typecode (val)
            end
        end
----------------------

    put_context (val : CORBA_CONTEXT) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_context)
            elseif not checker.basic (Tc_context) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_context (val, void)
            end
        end
----------------------

    put_principal (val : PRINCIPAL) is

        local
            return : BOOLEAN

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                set_tc_if_changed (Tc_principal)
            elseif not checker.basic (Tc_principal) then
                reset
                check
                    correct_type : false
                end
                return := true
            end

            if not return then
                ec.put_principal (val)
            end
        end
----------------------

    replace (tc : CORBA_TYPECODE; val : ANY) is
        -- I just hope this doesn't completely miss the boat ...

        do
            reset
            the_type  := tc
        end
----------------------

    set_type (t : CORBA_TYPECODE) is

        do
            the_type := t
        end
----------------------

    reset is

        do
            ec.get_buffer.reset (Buffer_minsize)
            checker.restart
        end
----------------------

    rewind is

        do
            dc.get_buffer.rseek_beg (0)
            checker.restart
        end
----------------------

    struct_put_begin : BOOLEAN is

        do
            prepare_write
            if not checker.struct_begin then
                reset
                check
                    struct_can_begin : false
                end
            else
                ec.struct_begin
                result := true
            end

        ensure
            success : result
        end
----------------------

    struct_put_end is

        do
            if not checker.struct_end then
                reset
                check
                    struct_finished : false
                end
            else
                ec.struct_end
            end
        end
----------------------

    union_put_begin is

        do
            prepare_write
            if not checker.union_begin then
                reset
                check
                    union_can_begin : false
                end
            else
                ec.union_begin
            end
        end
----------------------

    union_put_end is

        do
            if not checker.union_end then
                reset
                check
                    union_finished : false
                end
            else
                ec.union_end
            end
        end
----------------------

    union_put_selection (idx : INTEGER) is

        do
            if not checker.union_selection_at (idx) then
                reset
                check
                    valid_union_selection : false
                end
            end
        end
----------------------

    enum_put (val : INTEGER) : BOOLEAN is

        do
            prepare_write
            if not checker.enumeration (val) then
                reset
                result := false
            else
                ec.put_enumeration_value (val)
                result := true
            end
        end
----------------------

    any_put (val : CORBA_ANY) is

        do
            prepare_write
            val.prepare_read
            copy_any (val)

        rescue
            reset
            val.rewind
        end
----------------------

    any_put_recursive (val : CORBA_ANY) is

        do
            prepare_write
            val.prepare_read
            copy_any_recursive (val)

        rescue
            reset
            val.rewind
        end
----------------------

    seq_put_begin (len : INTEGER) is

        do
            prepare_write
            if not checker.seq_begin (len) then
                reset
                check
                    seqwuence_can_begin : false
                end
            else
                ec.seq_begin (len)
            end
        end
----------------------

    seq_put_end is

        do
            if not checker.seq_end then
                reset
                check
                    sequence_finished : false
                end
            else
                ec.seq_end
            end
        end
----------------------

    arr_put_begin is

        do
            prepare_write
            if not checker.arr_begin then
                reset
                check
                    array_can_begin : false
                end
            else
                ec.arr_begin
            end

        end
----------------------

    arr_put_end is

        do
            if not checker.arr_end then
                reset
                check
                    array_finished : false
                end
            else
                ec.arr_end
            end
        end
----------------------

    except_put_begin (repoid : STRING) is

        do
            prepare_write
            if not checker.except_begin then
                reset
                check
                    exception_can_begin : false
                end
            else
                ec.except_begin (repoid)
            end
        end
----------------------

    except_put_end is

        do
            if not checker.except_end then
                reset
                check
                    exception_finished : false
                end
            else
                ec.except_end
            end
        end
----------------------
feature  -- Encoding and Decoding

    decode (ddc : DATA_DECODER) is

        do
        end
----------------------

    demarshal (tc : CORBA_TYPECODE; ddc : DATA_DECODER) : BOOLEAN is

        require
            nonvoid_args : tc  /= void and then
                           ddc /= void

        local
            a   : CORBA_ANY
            de  : SIMPLE_ENCODER
            ldc : DATA_DECODER

        do
            reset
            set_type (tc)
            create de.make
            ldc := clone (ddc)
            ldc.make3 (ddc.get_buffer, ddc.converter, ddc.wconverter)
            create a.make3 (tc, ldc, de)
            -- cannot use a.prepare_read ...
            a.checker.restart_with_typecode (a.type)
            prepare_write
            copy_any_recursive (a)
            result := true
        end
----------------------

    encode (dec : DATA_ENCODER) is

        do
            dec.put_typecode (type)
            marshal (dec)
        end
----------------------

    marshal (dec : DATA_ENCODER) is

        local
            a   : CORBA_ANY
            b   : BUFFER
            e   : DATA_ENCODER
            sdc : SIMPLE_DECODER

        do
        -- This routine is a trifle tricky; it creates a
        -- CORBA_ANY `a' whose encoder is a clone of `dec'
        -- i.e. it has the same buffer as `dec'. The decoder of
        -- `a' is a dummy of type SIMPLE_DECODER; it plays no
        -- role at all (every CORBA_ANY needs a decoder). Then
        -- it executes a.copy_any (current) wich moves all the
        -- data stored in the buffer of the encoder belonging to
        --  `current' into the encoder of `a' -- that is, into
        -- the buffer of `dec', which is what we wanted. Voila!
        -- Isn't that nifty??
            check
                checker_completed : checker.completed
            end
            create b.make
            create sdc.make1 (b)
            e := clone (dec)
            e.make3 (dec.get_buffer, dec.converter, dec.wconverter)
            create a.make3 (type, sdc, e)
            -- cannot use a.prepare_write since that will clear
            -- the buffer ...
            a.checker.restart_with_typecode (a.type)
            prepare_read
            a.copy_any_recursive (current)
            b.delete
        end
----------------------
feature -- Access

    get_short : INTEGER is

        local
            ir : INTEGER_REF

        do
            prepare_read
            create ir
            if not private_get_short (ir) then
                rewind
            else
                result := ir.item
            end
        end
----------------------

    get_long : INTEGER is

        local
            ir : INTEGER_REF

        do
            prepare_read
            create ir
            if not private_get_long (ir) then
                rewind
            else
                result := ir.item
            end
        end
----------------------

    get_longlong : INTEGER is

        local
            ir : INTEGER_REF

        do
            prepare_read
            create ir
            if not private_get_longlong (ir) then
                rewind
            else
                result := ir.item
            end
        end
----------------------

    get_ushort : INTEGER is

        local
            ir : INTEGER_REF

        do
            prepare_read
            create ir
            if not private_get_ushort (ir) then
                rewind
            else
                result := ir.item
            end
        end
----------------------

    get_ulong : INTEGER is

        local
            ir : INTEGER_REF

        do
            prepare_read
            create ir
            if not private_get_ulong (ir) then
                rewind
            else
                result := ir.item
            end
        end
----------------------

    get_ulonglong : INTEGER is

        local
            ir : INTEGER_REF

        do
            prepare_read
            create ir
            if not private_get_ulonglong (ir) then
                rewind
            else
                result := ir.item
            end
        end
----------------------

    get_float : REAL is

        local
            rr : REAL_REF

        do
            prepare_read
            create rr
            if not private_get_float (rr) then
                rewind
            else
                result := rr.item
            end
        end
----------------------

    get_double : DOUBLE is

        local
            dr : DOUBLE_REF

        do
            prepare_read
            create dr
            if not private_get_double (dr) then
                rewind
            else
                result := dr.item
            end
        end
----------------------

    get_longdouble : DOUBLE is

        local
            dr : DOUBLE_REF

        do
            prepare_read
            create dr
            if not private_get_longdouble (dr) then
                rewind
            else
                result := dr.item
            end
        end
----------------------

    get_any : CORBA_ANY is
        -- If an error occurs, the result is void.

        do
            prepare_read
            if checker.basic (Tc_any) then
                result := dc.get_any
            else
                rewind
            end
        end
----------------------

    get_string (bound : INTEGER) : STRING is
        -- If an error occurs, the result is void.

        local
            tc : CORBA_TYPECODE

        do
            tc := create_string_tc (bound)
            prepare_read
            if checker.basic (tc) then
                result := dc.get_string
            end
            if result = void then
                rewind
            end
        end
----------------------

    get_wstring (bound : INTEGER) : ARRAY [INTEGER] is
        -- If an error occurs, the result is void.

        local
            tc : CORBA_TYPECODE

        do
            tc := create_wstring_tc (bound)
            prepare_read
            if checker.basic (tc) then
                result := dc.get_wstring
            end
            if result = void then
                rewind
            end
        end
----------------------

    get_fixed (digits, scale : INTEGER) : FIXED_VALUE is

        local
            t : CORBA_TYPECODE

        do
            prepare_read
            t := create_fixed_tc (digits, scale)
            create result.make (0,0, 1, 0)
            if checker.basic (t) then
                result.copy (dc.get_fixed (digits, scale))
            else
                rewind
                result := void
            end
        end
----------------------

    get_boolean : BOOLEAN is

        local
            br : BOOLEAN_REF

        do
            prepare_read
            create br
            if not checker.basic (Tc_boolean) then
                rewind
            else
                dc.get_boolean (br)
                result := br.item
            end
        end
----------------------

    get_octet : OCTET is

        do
            prepare_read
            if checker.basic (Tc_octet) then
                result := dc.get_octet
            else
                rewind
            end
        end
----------------------

    get_octets (len : INTEGER_REF) : ARRAY [OCTET] is
        -- Recover an octet sequence and store it's
        -- length in `len'. Return the contents as
        -- `result'.

        require
            nonvoid_arg : len /= void

        local
            i, n : INTEGER
            r    : BOOLEAN

        do
            r := seq_get_begin (len)
            check
                good_begin : r
            end
            from
                n := len.item
                i := 1
                create result.make (i, n)
            until
                i > n
            loop
                result.put (get_octet, i)
                i := i + 1
            end
            seq_get_end
        end
----------------------

    get_char : CHARACTER is

        local
            cr : CHARACTER_REF

        do
            prepare_read
            create cr
            if checker.basic (Tc_char) then
                dc.get_char (cr)
                result := cr.item
            else
                rewind
            end
        end
----------------------

    get_wchar : INTEGER is

        local
            ir : INTEGER_REF

        do
            prepare_read
            create ir
            if checker.basic (Tc_wchar) then
                dc.get_wchar (ir)
                result := ir.item
            else
                rewind
            end
        end
----------------------

    get_object (name : STRING) : CORBA_OBJECT is

        require
            nonvoid_arg : name /= void

        local
            ior : IOR
            dum : BOOLEAN
--            log : IO_MEDIUM

        do
            prepare_read
            check
                right_kind : checker.current_tc.kind = Tk_objref
            end
--            log := logger.log (logger.Log_debug, "GIOP", "CORBA_ANY",
--                               "get_object")
--            log.put_string (dc.get_buffer.stringify)
--            log.new_line

            ior := dc.get_ior
            create result.make_with_ior (ior)
            -- XXX [10-16] says check for zero number of profiles.
            name.copy (checker.current_tc.name)

            -- XXX should compare checker.current_tc.id and
            -- repoid somehow ...

            dum := checker.basic (checker.current_tc)
                -- that's what the man said ...
        end
----------------------

    get_typecode : CORBA_TYPECODE is

        do
            prepare_read
              if not checker.basic (Tc_typecode) then
                  rewind
              else
                result := dc.get_typecode
              end
        end
----------------------

    get_context : CORBA_CONTEXT is

        do
            prepare_read
              if not checker.basic (Tc_context) then
                  rewind
              else
                result := dc.get_context
              end
        end
----------------------

    get_principal : PRINCIPAL is

        do
            prepare_read
              if not checker.basic (Tc_principal) then
                  rewind
              else
                result := dc.get_principal
              end
        end
----------------------

    struct_get_begin : BOOLEAN is

        do
            prepare_read
            result := (checker.struct_begin and then dc.struct_begin)
            if not result then
                rewind
                check
                    struct_can_begin : false
                end
            end

        ensure
            success : result
        end
----------------------

    struct_get_end : BOOLEAN is

        local
            a      : CORBA_ANY
            return : BOOLEAN

        do
            if checker.struct_end then
                result := dc.struct_end
                return := true
                if not result then
                    rewind
                    check
                        struct_finished1 : false
                    end
                end
            end

        if not return then
            if not checker.inside (Tk_struct) then
                -- If subtyping for structs is allowed, then
                -- the additional members of the subtype must
                -- come *after* the members common to both.
                rewind
                return := true
                check
                    inside_struct : false
                end
            else -- remove the rest of the members
                from
                    -- nothing
                until
                    checker.level_finished
                loop
                    a := any_get_recursive
                end
            end -- if not checker.inside (Tk_struct) then ...
        end -- if not return then ...

        if not return then
            if not checker.struct_end or else not dc.struct_end then
                rewind
                check
                    struct_finished2 : false
                end
            else
                result := true
            end
        end -- if not return then ...

        ensure
            success : result
        end
----------------------

    union_get_begin is

        do
            prepare_read
            if not checker.union_begin  then
                rewind
                check
                    union_can_begin : false
                end
            end
            dc.union_begin
        end
----------------------

    union_get_end is

        do
            dc.union_end
            if not checker.union_end then
                rewind
                check
                    union_finished : false
                end
            end
        end
----------------------

    union_get_selection (idx : INTEGER) is

        do
            if not checker.union_selection_at (idx) then
                rewind
                check
                    valid_union_selection : false
                end
            end
        end
----------------------

    enum_get : INTEGER is

        do
            result := dc.get_enumeration_value
            if not checker.enumeration (result) then
                rewind
                check
                    enum_got : false
                end
            end
        end
----------------------

    seq_get_begin (ir : INTEGER_REF) : BOOLEAN is

        require
            nonvoid_arg : ir /= void

        do
            prepare_read
            ir.set_item (dc.seq_begin)
            if not checker.seq_begin (ir.item) then
                rewind
                check
                    sequence_can_begin : false
                end
            else
                result := true
            end

        ensure
            success : result
        end
----------------------

    seq_get_end is

        do
            dc.seq_end
            if not checker.seq_end then
                rewind
                check
                    sequence_finished : false
                end
            end
        end
----------------------

    arr_get_begin is

        do
            dc.arr_begin
            if not checker.arr_begin then
                rewind
                check
                    array_can_begin : false
                end
            end
        end
----------------------

    arr_get_end is

        do
            dc.arr_end
            if not checker.arr_end then
                rewind
                check
                    array_finished : false
                end
            end
        end
----------------------

    except_get_begin : STRING is

        do
            prepare_read
            result := dc.except_begin
            if result = void then
                rewind
                check
                    exception_can_begin : false
                end
            end
            if not checker.except_begin then
                result := void
                rewind
            end
        end
----------------------

    except_get_end is

        local
            a : CORBA_ANY

        do
            if checker.except_end then
                dc.except_end
            elseif not checker.inside (Tk_except) then
                rewind
                check
                    exception_finished : false
                end
            else
                from
                    -- nothing
                until
                    checker.level_finished
                loop
                    a := any_get
                    check
                        got_any : a /= void
                    end
                end
                dc.except_end
                if not checker.except_end then
                    rewind
                end
            end
        end
----------------------

    type : CORBA_TYPECODE is

        do
            result := the_type
        end
----------------------

    length : INTEGER is

        do
        end
----------------------
feature -- Copying

    copy (other : like current) is

        do
            the_type := clone (other.the_type)
            create checker.make
            ec.make1 (other.ec.get_buffer) -- use the same buffer
            dc.make1 (other.dc.get_buffer) -- as `other'.
        end
----------------------
feature -- Equality Test

    omg_equal (other : like current) : BOOLEAN is
        -- This is the routine called `equivalent' in the C++ code.

        local
            tcc1, tcc2 : TYPECODE_CHECKER
            pos1, pos2 : INTEGER

        do
            -- XXX The followeing ugly manipulations are needed because
            -- we are not allowed to change the any's while testing for
            -- equality.
            tcc1 := checker
            tcc2 := other.checker
            pos1 := ec.get_buffer.rpos
            pos2 := other.ec.get_buffer.rpos
            set_checker (clone (tcc1))
            other.set_checker (clone (tcc2))

            prepare_read
            other.prepare_read
            result := compare_any (other)
            set_checker (tcc1)
            ec.get_buffer.rseek_beg (pos1)
            other.set_checker (tcc2)
            other.ec.get_buffer.rseek_beg (pos2)
        end
----------------------

    is_equal (other : like current) : BOOLEAN is

        do
            if (not equal (ec.type, other.ec.type) or else
                not equal (dc.type, other.dc.type)) then
               -- differing (en)coder types
                result := false
            elseif not the_type.omg_equal (other.the_type) then
                result := false
            else
                result := (length = other.length)
            end
        end
----------------------
feature { CORBA_ANY } -- Implementation

    checker : TYPECODE_CHECKER
        -- Used to check that all operations are compatible with
        -- the IDL type described by `the_type'.
    ec : DATA_ENCODER
        -- Used to marshal the "value" of `current' into a byte stream
        -- in its buffer. This is where the "value" is stored, so you
        -- can't examine it with the debugger.
    dc : DATA_DECODER
        -- As a rule this decoder should have the same buffer as `ec'.
        -- It can be used to demarshal the "value" of `current'.
    the_type : CORBA_TYPECODE
        -- Describes the IDL type of the "value" of `current'.    

    compare_any (other : like current) : BOOLEAN is

        local
            atc, mtc : CORBA_TYPECODE
            t1, t2   : ARRAY_TYPECODE
            err      : BOOLEAN
            repoid1  : STRING
            repoid2  : STRING
            i, n     : INTEGER
            adisc    : like current
            mdisc    : like current
            len1     : INTEGER
            len2     : INTEGER
            digits   : INTEGER
            scale    : INTEGER
            ir       : INTEGER_REF
            dum      : BOOLEAN

        do
            if err then
                result := false
            else
                atc := other.checker.current_tc.unalias
                mtc := checker.current_tc.unalias

                -- CORBA_TYPECODE.max returns the "maximum type" of two
                -- typecodes; if both are arithmetic types. Otherwise
                -- returns the target (`current').

                inspect atc.maxtype (mtc).kind

                when Tk_short then
                    result := (get_short = other.get_short)

                when Tk_long then
                    result := (get_long = other.get_long)

                when Tk_longlong then
                    result := (get_longlong = other.get_longlong)

                when Tk_ushort then
                    result := (get_ushort = other.get_ushort)

                when Tk_ulong then
                    result := (get_ulong = other.get_ulong)

                when Tk_ulonglong then
                    result := (get_ulonglong = other.get_ulonglong)

                when Tk_float then
                    result := (get_float = other.get_float)

                when Tk_double then
                    result := (get_double = other.get_double)

                when Tk_boolean then
                    result := (get_boolean = other.get_boolean)

                when Tk_char then
                    result := (get_char = other.get_char)

                when Tk_wchar then
                    result := (get_wchar = other.get_wchar)

                when Tk_any then
                    result := equal (get_any, other.get_any)

                when Tk_objref then
                    repoid1  := ""
                    repoid2  := ""
                    result   := get_object (repoid1).is_equivalent (
                                                  other.get_object (repoid2))

                when Tk_enum then
                    result := (enum_get = other.enum_get)

                when Tk_string then
                    result := equal (get_string (mtc.length),
                                     other.get_string (atc.length))

                when Tk_wstring then
                    result := equal (get_wstring (mtc.length),
                                     other.get_wstring (atc.length))

                when Tk_fixed then
                    digits := atc.fixed_digits
                    scale  := atc.fixed_scale
                    result := equal (get_fixed (digits, scale),
                                     other.get_fixed (digits, scale))

                when Tk_typecode then
                    result := equal (get_typecode, other.get_typecode)

                when Tk_principal then
                    result := equal (get_principal, other.get_principal)

                when Tk_except then
                    repoid1 := except_get_begin
                    repoid2 := other.except_get_begin
                    if not equal (repoid1, repoid2) then
                        result := false
                    elseif atc.member_count /= mtc.member_count then
                        result := false
                    else
                        from
                            i      := 1
                            n      := mtc.member_count
                            result := true
                        until
                            i > n or else not result
                        loop
                            result := compare_any (other) -- that's how
                                                          -- we handle
                                                          -- recursion ...
                            i      := i + 1
                        end
                        except_get_end
                        other.except_get_end
                    end -- if not equal (repoid1, repoid2) then ...

                when Tk_struct then
                    if not struct_get_begin              or else
                       not other.struct_get_begin        or else
                       atc.member_count /= mtc.member_count then
                        result := false
                    else
                        from
                            i      := 1
                            n      := mtc.member_count
                            result := true
                        until
                            i > n or else not result
                        loop
                            result := compare_any (other) -- that's how we 
                                                          -- handle recursion.
                            i      := i + 1
                        end
                        dum := struct_get_end
                        dum := other.struct_get_end
                    end -- if atc.member_count ...

                when Tk_union then
                    union_get_begin
                    other.union_get_begin
                    mdisc := any_get
                    adisc := other.any_get
                    i     := atc.member_index_by_object (adisc)
                    if not mdisc.omg_equal (adisc) then
                        result := false
                    elseif (i /= mtc.member_index_by_object (mdisc)
                            or else i < 0) then
                        result := false
                    else
                        union_get_selection (i)
                        other.union_get_selection (i)
                        result := compare_any (other)
                    end
                    union_get_end
                    other.union_get_end

                when Tk_sequence then
                    create ir
                    dum := seq_get_begin (ir)
                    len1 := ir.item
                    dum  := other.seq_get_begin (ir)
                    len2 := ir.item

                    if len1 /= len2 then
                        result := false
                    else
                        from
                            i      := 1
                            n      := len1
                            result := true
                        until
                            i > n or else not result
                        loop
                            result := compare_any (other)
                            i      := i + 1
                        end -- loop
                        seq_get_end
                        other.seq_get_end
                    end -- if len1 /= len2 then ...

                when Tk_array then
                    t1   ?= atc
                    len1 := t1.length
                    t2   ?= mtc
                    len2 := t2.length
                    if len1 /= len2 then
                        result := false
                    else
                        arr_get_begin
                        other.arr_get_begin
                        from
                            i      := 1
                            n      := len1
                            result := true
                        until
                            i > n or else not result
                        loop
                            result := compare_any (other)
                            i      := i + 1
                        end
                        arr_get_end
                        other.arr_get_end
                    end -- if len1 /= len2 then ...
                end -- inspect
            end -- if err then ...

        rescue
            err := true
            retry
        end
----------------------

    get_tc : CORBA_TYPECODE is

        once
            result := the_type
        end
----------------------

    set_tc (t : CORBA_TYPECODE) is

        do
            the_type := t
        end
----------------------

    set_tc_if_changed (t : CORBA_TYPECODE) is

        do
            if not the_type.is_equal (t) then
                the_type := t
            end
        end
----------------------

    prepare_write is

        do
            if checker.completed then
                ec.get_buffer.reset (Buffer_minsize)
                checker.restart_with_typecode (the_type)
            end
        end
----------------------

    prepare_read is

        do
            if checker.completed then
                dc.get_buffer.rseek_beg (0)
                checker.restart_with_typecode (the_type)
            end
        end
----------------------

    copy_any (other : like current) is

        local
            vidmap : DICTIONARY [INTEGER, INTEGER]

        do
            create vidmap.make
            copy_any3 (other, vidmap, false)
        end
----------------------

    copy_any_recursive (other : like current) is

        local
            vidmap : DICTIONARY [INTEGER, INTEGER]

        do
            create vidmap.make
            copy_any3 (other, vidmap, true)
        end
----------------------

    copy_any2 (other : like current;
            value_id_map : DICTIONARY [INTEGER, INTEGER]) is

        require
            nontrivial_type : not other.checker.completed implies
                             (other.checker.current_tc.unalias.kind /= Tk_null
                              and then
                              other.checker.current_tc.unalias.kind /= Tk_void)
                              and then
                              not checker.completed implies
                              (checker.current_tc.unalias.kind /= Tk_null
                               and then
                               checker.current_tc.unalias.kind /= Tk_void)
            nonvoid_arg     : value_id_map /= void

            do
                copy_any3 (other, value_id_map, true )
            end
----------------------

    copy_any3 (other   : like current;
               vidmap  : DICTIONARY [INTEGER, INTEGER];
               recurse : BOOLEAN) is

        local
            atc   : CORBA_TYPECODE
            ir    : INTEGER_REF
            i, n  : INTEGER
            adisc : CORBA_ANY
            name  : STRING
            dum   : BOOLEAN

        do
            atc := other.checker.current_tc.unalias

            inspect atc.kind

            when Tk_null, Tk_void then
                dum := (other.checker.basic (atc) and then
                        checker.basic (atc))

            when Tk_short then
                put_short (other.get_short)

            when Tk_long then
                put_long (other.get_long)

            when Tk_longlong then
                put_longlong (other.get_longlong)

            when Tk_ushort then
                put_ushort (other.get_ushort)

            when Tk_ulong then
                put_ulong (other.get_ulong)

            when Tk_ulonglong then
                put_ulonglong (other.get_ulonglong)

            when Tk_float then
                put_float (other.get_float)

            when Tk_double then 
                put_double (other.get_double)

            when Tk_longdouble then
                put_longdouble (other.get_longdouble)

            when Tk_boolean then
                put_boolean (other.get_boolean)

            when Tk_char then
                put_char (other.get_char)

            when Tk_wchar then
                put_wchar (other.get_wchar)

            when Tk_octet then
                put_octet (other.get_octet)

            when Tk_any then
                put_any (other.get_any)

            when Tk_objref then
                name := ""
                put_object (name, other.get_object (name))

            when Tk_enum then
                dum := enum_put (other.enum_get)

            when Tk_string then
                put_string (other.get_string (atc.length), atc.length)

            when Tk_wstring then
                put_wstring (other.get_wstring (atc.length),
		atc.length)

            when Tk_fixed then
                put_fixed (other.get_fixed (atc.fixed_digits,
		                            atc.fixed_scale),
                           atc.fixed_digits, atc.fixed_scale)

            when Tk_alias then
                check
                    doesnt_happen : false
                end

            when Tk_typecode then
                put_typecode (other.get_typecode)

            when Tk_principal then
                put_principal (other.get_principal)

            else
                -- it may be a recursive type

            end -- inspect

            if recurse then
                inspect atc.kind

                when Tk_null .. Tk_objref, Tk_enum, Tk_string,
                     Tk_longlong .. Tk_fixed then
                    -- ignore it; taken care of above

                when Tk_except then    
                    except_put_begin (other.except_get_begin)

                    -- The following loop looks nonsensical
                    -- but it's the call to checker.current_tc
                    -- at the beginning of this routine
                    -- that turns the trick. This guarantees
                    -- that we step through the exception
                    -- member by member. The same is true of
                    -- the following recursive data types.

                    from
                        i := 1
                        n := atc.member_count
                    until
                        i > n
                    loop
                        copy_any3 (other, vidmap, true)
                        i := i + 1
                    end
                    other.except_get_end
                    except_put_end

                when Tk_struct then
                    if other.struct_get_begin and then
                       struct_put_begin           then
                        from
                            i := 1
                            n := atc.member_count
                        until
                            i > n
                        loop
                            copy_any3 (other, vidmap, true)
                            i := i + 1
                        end
                    end
                    if other.struct_get_end then
                        struct_put_end
                    end

                when  Tk_union then
                    other.union_get_begin
                    union_put_begin
                    adisc := other.any_get
                    adisc.prepare_read
                    copy_any3 (adisc, vidmap, false)
                    i := atc.member_index_by_object (adisc)
                    if i >= 0 then
                        other.union_get_selection (i)
                        union_put_selection (i)
                        copy_any3 (other, vidmap, true)
                    end
                    other.union_get_end
                    union_put_end

                when Tk_sequence then
                    create ir
                    dum := other.seq_get_begin (ir)
                    n   := ir.item
                    seq_put_begin (n)
                    from
                        i := 1
                    until
                        i > n
                    loop
                        copy_any3 (other, vidmap, true)
                        i := i + 1
                    end
                    other.seq_get_end
                    seq_put_end

                when Tk_array then
                    n := atc.length
                    other.arr_get_begin
                    arr_put_begin
                    from
                        i := 1
                    until
                        i > n
                    loop
                        copy_any3 (other, vidmap, true)
                        i := i + 1
                    end
                    other.arr_get_end
                    arr_put_end

                end -- inspect
            end -- if recurse then ...
        end
----------------------

    private_get_short (ir : INTEGER_REF) : BOOLEAN is

        require
            nonvoid_arg : ir /= void

        do
            result := checker.basic (Tc_short)
            if result then
                dc.get_short (ir)
            end
        end
----------------------

    private_get_long (ir : INTEGER_REF) : BOOLEAN is

        require
            nonvoid_arg : ir /= void

        do
            if checker.basic (Tc_long) then
                dc.get_long (ir)
                result := true
            elseif private_get_short (ir) then
                result := true
            else
                result := private_get_ushort (ir)
            end
        end
----------------------

    private_get_ushort (ir : INTEGER_REF) : BOOLEAN is

        require
            nonvoid_arg : ir /= void

        do
            result := checker.basic (Tc_ushort)
            dc.get_ushort (ir)
        end
----------------------

    private_get_ulong (ir : INTEGER_REF) : BOOLEAN is

        require
            nonvoid_arg : ir /= void

        do
            if checker.basic (Tc_ulong) then
                dc.get_ulong (ir)
                result := true
            else
                result := private_get_ushort (ir)
            end
        end
----------------------

    private_get_longlong (ir : INTEGER_REF) : BOOLEAN is

        require
            nonvoid_arg : ir /= void

        do
            if checker.basic (Tc_longlong) then
                dc.get_longlong (ir)
                result := true
            elseif private_get_long (ir) then
                    result := true
            else
                result := private_get_ulong (ir)
            end
        end
----------------------

    private_get_ulonglong (ir : INTEGER_REF) : BOOLEAN is

        require
            nonvoid_arg : ir /= void

        do
            if checker.basic (Tc_ulonglong) then
                dc.get_ulonglong (ir)
                result := true
            else
                result := private_get_ulong (ir)
            end
        end
----------------------

    private_get_float (rr : REAL_REF) : BOOLEAN is

        require
            nonvoid_arg : rr /= void

        local
            ir : INTEGER_REF

        do
            if checker.basic (Tc_float) then
                dc.get_float (rr)
                result := true
            else
                create ir
                if private_get_short (ir) then
                    rr.set_item (ir.item)
                    result := true
                elseif private_get_ushort (ir) then
                    rr.set_item (ir.item)
                    result := true
                end
            end -- if checker.basic (Tc_float) then ...
        end
----------------------

    private_get_double (dr : DOUBLE_REF) : BOOLEAN is

        require
            nonvoid_arg : dr /= void

        local
            ir : INTEGER_REF
            rr : REAL_REF

        do
            if checker.basic (Tc_double) then
                dc.get_double (dr)
                result := true
            else
                create ir
                create rr
                if private_get_long (ir) then
                    dr.set_item (ir.item)
                    result := true
                elseif private_get_ulong (ir) then
                    dr.set_item (ir.item)
                    result := true
                elseif private_get_float (rr) then
                    dr.set_item (rr.item)
                    result := true
                else
                    result := false
                end
            end -- if check.basic (Tc_double) then ...
        end
----------------------

    private_get_longdouble (dr : DOUBLE_REF) : BOOLEAN is

        require
            nonvoid_arg : dr /= void

        local
            ir : INTEGER_REF

        do
            if checker.basic (Tc_longdouble) then
                dc.get_longdouble (dr)
                result := true
            else
                create ir
                if private_get_longlong (ir) then
                    dr.set_item (ir.item)
                    result := true
                elseif private_get_double (dr) then
                    result := true
                end
            end
        end
----------------------

    any_get : CORBA_ANY is

        do
            create result.make
            prepare_read
            result.set_type (checker.current_tc)
            result.prepare_write
            result.copy_any (current)
        end
----------------------

    any_get_recursive : CORBA_ANY is

        do
            create result.make
            prepare_read
            result.set_type (checker.current_tc)
            result.prepare_write
            result.copy_any_recursive (current)
        end

end -- class CORBA_ANY

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
