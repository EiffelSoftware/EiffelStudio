indexing

description: "The parent of all stubs";
keywords: "Still to be entered";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class STANDARD_STUB

inherit
    THE_FLAGS;
    TYPECODE_STATICS

feature

    make_with_peer (o : CORBA_OBJECT) is

        require
            nonvoid_arg : o /= void

        do
            peer := o
        end
----------------------

    implementation : CORBA_OBJECT is

        do
            result := peer
        end
----------------------

    begin_request (op : STRING) is

        do
            create current_request.make2 (peer, op)
            the_exception := void
        end
----------------------

    end_request is

        do
            the_exception   := current_request.env.exception
            current_request := void
            out_args        := void
            if the_exception /= void then
                the_exception.throwit
            end
        end
----------------------

    returned_exception : CORBA_EXCEPTION is

        do
            if the_exception = void then
                the_exception := current_request.env.exception
            end
            result := the_exception
        end
----------------------

    invoke is

        do
            check
                request_active : current_request /= void
            end
            if current_request /= void then
                current_request.invoke
            end
        end
----------------------

    send_oneway is

        do
            check
                request_active : current_request /= void
            end
            if current_request /= void then
                current_request.send_oneway
            end
        end
----------------------

    stub_add_in_arg_integer (name : STRING; val : INTEGER) is

        do
            current_request.add_in_arg_with_name (name).put_long (val)
        end
----------------------

    stub_add_in_arg_double (name : STRING; val : DOUBLE) is

        do
            current_request.add_in_arg_with_name (name).put_double (val)
        end
----------------------

    stub_add_in_arg_real (name : STRING; val : REAL) is

        do
            current_request.add_in_arg_with_name (name).put_float (val)
        end
----------------------

    stub_add_in_arg_character (name : STRING; val : CHARACTER) is

        do
            current_request.add_in_arg_with_name (name).put_char (val)
        end
----------------------

    stub_add_in_arg_boolean (name : STRING; val : BOOLEAN) is

        do
            current_request.add_in_arg_with_name (name).put_boolean (val)
        end
----------------------

    stub_add_in_arg_string (name, val : STRING) is

        do
            current_request.add_in_arg_with_name (name).put_string (val, 0)
        end
----------------------

    stub_add_in_arg_wstring (name : STRING; val : ARRAY [INTEGER]) is

        do
            current_request.add_in_arg_with_name (name).put_wstring (val, 0)
        end
----------------------

    stub_add_in_arg_ref (name, clss : STRING; val : CORBA_OBJECT) is

        do
            current_request.add_in_arg_with_name (name).put_object (clss, val)
        end
----------------------

    stub_add_in_arg_any (name : STRING; val : CORBA_ANY) is

         do
            current_request.add_in_arg_with_name (name).copy (val)
         end    
----------------------

    stub_add_in_arg_typecode (name : STRING; val : CORBA_TYPECODE) is

        do
            current_request.add_in_arg_with_name (name).put_typecode (val)
        end
----------------------

    stub_add_in_arg_with_type (name : STRING; type : CORBA_TYPECODE) is

        do
            current_request.add_in_arg_with_name (name).set_type (type)
        end
----------------------

    stub_add_inout_arg_integer (name : STRING; val : INTEGER) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_inout_arg_with_name (name)
            ca.put_long (val)
            out_args.put (ca, name)
        end
----------------------

    stub_add_inout_arg_double (name : STRING; val : DOUBLE) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_inout_arg_with_name (name)
            ca.put_double (val)
            out_args.put (ca, name)
        end
----------------------

    stub_add_inout_arg_real (name : STRING; val : REAL) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_inout_arg_with_name (name)
            ca.put_float (val)
            out_args.put (ca, name)
        end
----------------------

    stub_add_inout_arg_character (name : STRING; val : CHARACTER) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_inout_arg_with_name (name)
            ca.put_char (val)
            out_args.put (ca, name)
        end
----------------------

    stub_add_inout_arg_boolean (name : STRING; val : BOOLEAN) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_inout_arg_with_name (name)
            ca.put_boolean (val)
            out_args.put (ca, name)
        end
----------------------

    stub_add_inout_arg_string (name, val : STRING) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_inout_arg_with_name (name)
            ca.put_string (val, 0)
            out_args.put (ca, name)
        end
----------------------

    stub_add_inout_arg_wstring (name : STRING; val : ARRAY [INTEGER]) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_inout_arg_with_name (name)
            ca.put_wstring (val, 0)
            out_args.put (ca, name)
        end
----------------------

    stub_add_inout_arg_ref (name, clss : STRING; val : CORBA_OBJECT) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_inout_arg_with_name (name)
            ca.put_object (clss, val)
            out_args.put (ca, name)
        end
----------------------

    stub_add_inout_arg_any (name : STRING; val : CORBA_ANY) is

         do
            current_request.add_inout_arg_with_name (name).copy (val)
         end    
----------------------

    stub_add_inout_arg_typecode (name : STRING; val : CORBA_TYPECODE) is

        do
            current_request.add_inout_arg_with_name (name).put_typecode (val)
        end
----------------------

    stub_add_inout_arg_with_type (name : STRING; type : CORBA_TYPECODE) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_inout_arg_with_name (name)
            ca.set_type (type)
            out_args.put (ca, name)
        end
----------------------

    stub_add_out_arg_integer (name : STRING) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_out_arg_with_name (name)
            ca.set_type (Tc_long)
            out_args.put (ca, name)
        end
----------------------

    stub_add_out_arg_double (name : STRING) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_out_arg_with_name (name)
            ca.set_type (Tc_double)
            out_args.put (ca, name)
        end
----------------------

    stub_add_out_arg_real (name : STRING) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_out_arg_with_name (name)
            ca.set_type (Tc_float)
            out_args.put (ca, name)
        end
----------------------

    stub_add_out_arg_character (name : STRING) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_out_arg_with_name (name)
            ca.set_type (Tc_char)
            out_args.put (ca, name)
        end
----------------------

    stub_add_out_arg_boolean (name : STRING) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_out_arg_with_name (name)
            ca.set_type (Tc_boolean)
            out_args.put (ca, name)
        end
----------------------

    stub_add_out_arg_string (name : STRING) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_out_arg_with_name (name)
            ca.set_type (Tc_string)
            out_args.put (ca, name)
        end
----------------------

    stub_add_out_arg_wstring (name : STRING) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_out_arg_with_name (name)
            ca.set_type (Tc_wstring)
            out_args.put (ca, name)
        end
----------------------

    stub_add_out_arg_ref (name : STRING) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_out_arg_with_name (name)
            ca.set_type (Tc_object)
            out_args.put (ca, name)
        end
----------------------

    stub_add_arg_typecode (name : STRING) is

        local
            ca : CORBA_ANY

        do
            if out_args = void then
                create out_args.make
            end
            ca := current_request.add_out_arg_with_name (name)
            ca.set_type (Tc_typecode)
            out_args.put (ca, name)
        end
----------------------

    stub_add_out_arg_with_type (name : STRING; type : CORBA_TYPECODE) is

    local
        ca : CORBA_ANY

    do
        if out_args = void then
            create out_args.make
        end
        ca := current_request.add_out_arg_with_name (name)
        ca.set_type (type)
        out_args.put (ca, name)
    end
----------------------

    add_exception (e : CORBA_TYPECODE) is

        do
            current_request.add_exception (e)
        end
----------------------

    result_is_integer is

        do
            current_request.set_return_type (Tc_long)
        end
----------------------

    result_is_double is

        do
            current_request.set_return_type (Tc_double)
        end
----------------------

    result_is_real is

        do
            current_request.set_return_type (Tc_float)
        end
----------------------

    result_is_character is

        do
            current_request.set_return_type (Tc_char)
        end
----------------------

    result_is_boolean is

        do
            current_request.set_return_type (Tc_boolean)
        end
----------------------

    result_is_string is

        do
            current_request.set_return_type (Tc_string)
        end
----------------------

    result_is_wstring is

        do
            current_request.set_return_type (Tc_wstring)
        end
----------------------

    result_is_ref is

        do
            current_request.set_return_type (Tc_object)
        end
----------------------

    result_is_any is

        do
            current_request.set_return_type (Tc_any)
        end
----------------------

    result_is_typecode is

        do
            current_request.set_return_type (Tc_typecode)
        end
----------------------

    result_is_of_type (tc : CORBA_TYPECODE) is

        do
            current_request.set_return_type (tc)
        end
----------------------

    get_result_integer : INTEGER is

        local
            ca  : CORBA_ANY

        do
            check_exception
            ca     := current_request.return_value
            result := ca.get_long
        end
----------------------

    get_result_double : DOUBLE is

        local
            ca  : CORBA_ANY
        
        do
            check_exception
            ca     := current_request.return_value
            result := ca.get_double
        end
----------------------

    get_result_real : REAL is

        local
            ca  : CORBA_ANY
        
        do
            check_exception
            ca     := current_request.return_value
            result := ca.get_float
        end
----------------------

    get_result_character : CHARACTER is

        local
            ca  : CORBA_ANY

        do
            check_exception
            ca     := current_request.return_value
            result := ca.get_char
        end
----------------------

    get_result_boolean : BOOLEAN is

        local
            ca  : CORBA_ANY

        do
            check_exception
            ca     := current_request.return_value
            result := ca.get_boolean
        end
----------------------

    get_result_string : STRING is

        local
            ca : CORBA_ANY

        do
            check_exception
            ca     := current_request.return_value
            result := ca.get_string (0)
        end
----------------------

    get_result_wstring : ARRAY [INTEGER] is

        local
            ca : CORBA_ANY

        do
            check_exception
            ca     := current_request.return_value
            result := ca.get_wstring (0)
        end
----------------------

    get_result_ref : CORBA_OBJECT is

        local
            ca : CORBA_ANY
            cl : STRING

        do
            check_exception
            ca     := current_request.return_value
            cl     := ""
            result := ca.get_object (cl)
        end
----------------------

    get_result_typecode : CORBA_TYPECODE is

        local
            ca : CORBA_ANY

        do
            check_exception
            ca     := current_request.return_value
            result := ca.get_typecode
        end
----------------------

    get_result_as_any : CORBA_ANY is

        do
            check_exception
            result := current_request.return_value
        end
----------------------

    get_out_result_integer (n : STRING) : INTEGER is

        do
            check_exception
            result := current_request.get_out_arg_integer (n)
        end
----------------------

    get_out_result_boolean (n : STRING) : BOOLEAN is

        do
            check_exception
            result := current_request.get_out_arg_boolean (n)
        end
----------------------

    get_out_result_character (n : STRING) : CHARACTER is

        do
            check_exception
            result := current_request.get_out_arg_character (n)
        end
----------------------

    get_out_result_real (n : STRING) : REAL is

        do
            check_exception
            result := current_request.get_out_arg_real (n)
        end
----------------------

    get_out_result_double (n : STRING) : DOUBLE is

        do
            check_exception
            result := current_request.get_out_arg_double (n)
        end
----------------------

    get_out_result_string (n : STRING) : STRING is

        do
            check_exception
            result := current_request.get_out_arg_string (n)
        end
----------------------

    get_out_result_wstring (n : STRING) : ARRAY [INTEGER] is

        do
            check_exception
            result := current_request.get_out_arg_wstring (n)
        end
----------------------

    get_out_result_any (n : STRING) : CORBA_ANY is

        do
            check_exception
            result := current_request.get_out_arg_any (n)
        end
----------------------

    get_out_result_ref (cl, n : STRING) : CORBA_OBJECT is

        do
            check_exception
            result := current_request.get_out_arg_ref (cl, n)
        end
----------------------
feature { NONE } -- Implementation

    peer            : CORBA_OBJECT
    current_request : CORBA_REQUEST
    out_args        : DICTIONARY [CORBA_ANY, STRING]
    the_exception   : CORBA_EXCEPTION
---------------------

    check_exception is

        do
            the_exception := current_request.env.exception
            if the_exception /= void then
                the_exception.throwit
            end
        end

end -- class STANDARD_STUB

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
