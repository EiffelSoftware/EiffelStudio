indexing

description: "Thunk representing a method invocation";
keywords: "invoke";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class ORB_REQUEST

inherit
    BUFFER_CONSTANTS;
    THE_FLAGS;
    EXCEPTION_STATICS;
    TYPECODE_STATICS

feature

    get_context : INDEXED_LIST [SERVICE_CONTEXT] is

        do
        end
----------------------

    set_context (ctx : INDEXED_LIST [SERVICE_CONTEXT]) is

        do
        end
----------------------

    op_name : STRING is

        deferred
        end
----------------------

    get_in_args_nvl (iparams : CORBA_NV_LIST; ctx : ANY_REF) : BOOLEAN is

        require
            nonvoid_args : iparams /= void and
                           ctx     /= void

        deferred
        end
----------------------

    get_in_args_sal (iparams : INDEXED_LIST [STATIC_ANY];
                     ctx     : ANY_REF) : BOOLEAN is

        require
            nonvoid_args : iparams /= void and
                           ctx     /= void

        deferred
        end
----------------------

    get_in_args_de (de : DATA_ENCODER) : BOOLEAN is

        require
            nonvoid_arg : de /= void

        deferred
        end
----------------------

    get_out_args_nvl (res     : CORBA_ANY;
                      oparams : CORBA_NV_LIST;
                      ex      : ANY_REF) : BOOLEAN is

        require
            nonvoid_args : oparams /= void and
                           ex      /= void

        deferred
        end
----------------------

    get_out_args_sal (res     : STATIC_ANY;
                      oparams : INDEXED_LIST [STATIC_ANY];
                      ex      : ANY_REF) : BOOLEAN is


        require
            nonvoid_args : oparams /= void and
                           ex      /= void

        deferred
        end
----------------------

    get_out_args_de (de        : DATA_ENCODER;
                     is_except : BOOLEAN_REF) : BOOLEAN is

        require
            nonvoid_args : de        /= void and
                           is_except /= void

        deferred
        end
----------------------

    set_out_args_nvl (res : CORBA_ANY; oparams : CORBA_NV_LIST) : BOOLEAN is

        deferred
        end
----------------------

    set_out_args_sal (res     : STATIC_ANY;
                      oparams : INDEXED_LIST [STATIC_ANY]) : BOOLEAN is

        require
            nonvoid_arg : oparams /= void

        deferred
        end
----------------------

    set_out_args_ex (ex : CORBA_EXCEPTION) is

        require
            nonvoid_arg : ex /= void

        deferred
        end
----------------------

    set_out_args_dc (dc : DATA_DECODER; is_except : BOOLEAN) : BOOLEAN is

        require
            non_void_arg : dc /= void

        deferred
        end
----------------------

    copy_out_args (other : ORB_REQUEST) : BOOLEAN is

        require
            nonvoid_arg : other /= void

        deferred
        end
----------------------

    copy_in_args (other : ORB_REQUEST) : BOOLEAN is

        require
            nonvoid_arg : other /= void

        deferred
        end
----------------------

    type : STRING is

        deferred
        end                      
----------------------
feature { ORB_REQUEST } -- Implementation

    svc : INDEXED_LIST [SERVICE_CONTEXT]
----------------------

    copy_svc (req : ORB_REQUEST) is

        do
            svc := req.svc
        end

end -- class ORB_REQUEST

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
