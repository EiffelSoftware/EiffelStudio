indexing

description: "the class that represents a primitive definition in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_PRIMITIVEDEF_IMPL
    -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
    -- the body of each routine and add any (private) attributes needed.

inherit
    CORBA_PRIMITIVEDEF_SKEL
        rename
            make as make_skel
        end;
    CORBA_IDLTYPE_IMPL
        rename
            make as make_IDLType
        undefine
            type_name, consume, valid_message_type,
            repoid, template, dispatcher, doinvoke, make_skel
        redefine
            type
        end

creation
    make

feature
   
   make (kind_par : INTEGER) is
         -- You may give this creation procedure
         -- any arguments needed.
      
      require
         good_kind: kind_par >= 0
                    and then kind_par <= CORBA_PrimitiveKind_maxvalue
                 
      do
         make_skel
         -- if any parent's creation procedure
         -- takes arguments add them below.
         make_IDLType
         -- put any other initialization needed here.
         create private_dk.make (CORBA_dk_Primitive)
         create private_kind.make (kind_par)
      end
   
   ------------
   
   kind : CORBA_PRIMITIVEKIND is
      
      do
         result := private_kind
      ensure then
         good_kind: result.value >= 0
                    and then result.value <= CORBA_PrimitiveKind_maxvalue
      end
   
   ----------------------
   
   type : CORBA_TYPECODE is
      
      do
         create {BASIC_TYPECODE} result.make (private_kind.value)
      end
   
feature {NONE}
   
   private_kind : CORBA_PRIMITIVEKIND
   
invariant
   -- good_kind : private_kind /= void

end -- class CORBA_PRIMITIVEDEF_IMPL

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
--                                                                    
----
------------------------------------------------------------------------
