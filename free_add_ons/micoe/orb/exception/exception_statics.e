indexing

description: "A trick to achieve the semantics of static features as in %
             %C++ or Java.";
keywords: "static", "global";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"
class EXCEPTION_STATICS

inherit
    THE_LOGGER

feature { NONE } -- Statics for the class CORBA_EXCEPTION

    Completed_yes   : INTEGER is 0
    Completed_no    : INTEGER is 1
    Completed_maybe : INTEGER is 2

    system_exception_create (repoid : STRING;
              minor, completed : INTEGER) : CORBA_SYSTEM_EXCEPTION is

        do
            if equal (repoid, "IDL:omg.org./CORBA/SystemException:1.0") then
                create result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/UNKNOWN:1.0") then
                CREATE {UNKNOWN} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/BAD_PARAM:1.0") then
                create {BAD_PARAM} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/NO_MEMORY:1.0") then
                create {NO_MEMORY} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/IMP_LIMIT:1.0") then
                create {IMP_LIMIT} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/COMM_FAILURE:1.0") then
                create {COMM_FAILURE} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/INV_OBJREF:1.0") then
                create {INV_OBJREF} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/NO_PERMISSION:1.0") then
                create {NO_PERMISSION} result.make_with_minor (minor,
                                                               completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/INTERNAL:1.0") then
                create {CORBA_INTERNAL} result.make_with_minor (minor,
                                                                completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/MARSHAL:1.0") then
                create {MARSHAL} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/INITIALIZE:1.0") then
                create {INITIALIZE} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/NO_IMPLEMENT:1.0") then
                create {NO_IMPLEMENT} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/BAD_TYPECODE:1.0") then
                create {BAD_TYPECODE} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/BAD_OPERATION:1.0") then
                create {BAD_OPERATION} result.make_with_minor (minor,
                                                               completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/NO_RESOURCES:1.0") then
                create {NO_RESOURCES} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/NO_RESPONSE:1.0") then
                create {NO_RESPONSE} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/PERSIST_STORE:1.0") then
                create {PERSIST_STORE} result.make_with_minor (minor,
                                                               completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/BAD_INV_ORDER:1.0") then
                create {BAD_INV_ORDER} result.make_with_minor (minor,
                                                               completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/TRANSIENT:1.0") then
                create {TRANSIENT} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/FREE_MEM:1.0") then
                create {FREE_MEM} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/INV_IDENT:1.0") then
                create {INV_IDENT} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/INV_FLAG:1.0") then
                create {INV_FLAG} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/INTF_REPOS:1.0") then
                create {INTF_REPOS} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/BAD_CONTEXT:1.0") then
                create {BAD_CONTEXT} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/OBJ_ADAPTER:1.0") then
                create {OBJ_ADAPTER} result.make_with_minor (minor, completed)
            elseif equal (repoid, "IDL:omg.org/CORBA/DATA_CONVERSION:1.0") then
                create {DATA_CONVERSION} result.make_with_minor (minor,
                                                                 completed)
            elseif equal (repoid,
                          "IDL:omg.org/CORBA/OBJECT_NOT_EXIST:1.0") then
                create {OBJECT_NOT_EXIST} result.make_with_minor (minor,
                                                                  completed)
            end
        end
----------------------

    is_a_system_exception (repoid : STRING) : BOOLEAN is

        do
            result := (equal (repoid, "IDL:omg.org/CORBA/SystemException:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/UNKNOWN:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/BAD_PARAM:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/NO_MEMORY:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/IMP_LIMIT:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/COMM_FAILURE:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/INV_OBJREF:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/NO_PERMISSION:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/INTERNAL:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/MARSHAL:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/INITIALIZE:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/NO_IMPLEMENT:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/BAD_TYPECODE:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/BAD_OPERATION:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/NO_RESOURCES:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/NO_RESPONSE:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/PERSIST_STORE:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/BAD_INV_ORDER:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/TRANSIENT:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/FREE_MEM:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/INV_IDENT:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/INV_FLAG:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/INTF_REPOS:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/BAD_CONTEXT:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/OBJ_ADAPTER:1.0")
                       or else
                       equal (repoid, "IDL:omg.org/CORBA/DATA_CONVERSION:1.0")
                       or else
                       equal (repoid,
                            "IDL:omg.org/CORBA/OBJECT_NOT_EXIST:1.0"))
        end
----------------------

    system_exception_decode_any (a : CORBA_ANY) : CORBA_SYSTEM_EXCEPTION is

        local
            minor     : INTEGER
            completed : INTEGER
            repoid    : STRING
            r         : BOOLEAN

        do
            repoid := a.except_get_begin
            completed := a.enum_get
            minor := a.get_ulong
            a.except_get_end
            if repoid /= void and then r then
                result := system_exception_create (repoid, minor, completed)
            end
        end
----------------------

    system_exception_decode_decoder
                (dc : DATA_DECODER) : CORBA_SYSTEM_EXCEPTION is

        local
            minor     : INTEGER_REF
            completed : INTEGER
            repoid    : STRING

        do
            repoid := dc.except_begin
            completed := dc.get_enumeration_value
            create minor
            dc.get_ulong (minor)
            dc.except_end
            if repoid /= void then
                result := system_exception_create (repoid,
                                                   minor.item,
                                                   completed)
            end
        end
----------------------

    user_exception_decode_any (a : CORBA_ANY) : CORBA_USER_EXCEPTION is

        do
            create {UNKNOWN_USER_EXCEPTION} result.make_with_any (a)
        end
----------------------

    user_exception_decode_decoder (dc : DATA_DECODER) : CORBA_USER_EXCEPTION is

        do
            create {UNKNOWN_USER_EXCEPTION} result.make_with_decoder (dc)
        end
----------------------

    exception_decode_any (a : CORBA_ANY) : CORBA_EXCEPTION is

        do
            result := system_exception_decode_any (a)            
            if result = void then
                result := user_exception_decode_any (a)
            end
        end
----------------------

    exception_decode_decoder (dc : DATA_DECODER) : CORBA_EXCEPTION is

        local
            rpos : INTEGER

        do
            rpos   := dc.get_buffer.rpos
            result := system_exception_decode_decoder (dc)            
            if result = void then
                dc.get_buffer.rseek_beg (rpos)
                result := user_exception_decode_decoder (dc)
            end
            if result = void then
                dc.get_buffer.rseek_beg (rpos)
            end
        end
----------------------

    exception_throw_failed (ex : CORBA_EXCEPTION) is

        do
            check
                exception_handling_supported : false
            end
            logger.log (logger.Log_err, "General", "EXCEPTION_STATICS",
                        "exception_throw_failed").put_string (
                            "exception handling not supported%N")
            ex.print_it
        end
----------------------

    exception_init is

        do
        end

end -- EXCEPTION_STATICS

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
