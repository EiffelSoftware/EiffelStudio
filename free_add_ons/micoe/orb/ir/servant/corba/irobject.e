indexing

description: "base interface for all IR objects";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_IROBJECT_IMPL
    -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
    -- the body of each routine and add any (private) attributes needed.

inherit
    CORBA_IROBJECT_SKEL
        rename
            make as make_skel
        end;
        ORB_STATICS
        undefine
           is_equal, copy
        end

creation
    make

feature
   
   make is
         -- You may give this creation procedure
         -- any arguments needed.
      
      do
         make_skel
         -- put any other initialization needed here.
         create private_dk.make (CORBA_dk_none)
         create private_visited.make (true)
      end
   
   ------------
   
   def_kind : CORBA_DEFINITIONKIND is
      
      do
         logger.trace_enter ("CORBA_IROBJECT_IMPL", "def_kind")
         result := private_dk
         logger.trace_leave ("CORBA_IROBJECT_IMPL", "def_kind")
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   destroy is
      
      local
	 no_perm : NO_PERMISSION
	 con     : CORBA_CONTAINED
	 
      do
         logger.trace_enter ("CORBA_IROBJECT_IMPL", "destroy")
	 if private_dk.value = CORBA_dk_Repository or else
	    private_dk.value = CORBA_dk_Primitive then
	    create no_perm.make
	    raise_exception (no_perm)
	 else
	    con := CORBA_Contained_narrow (current)
	    if con /= void then
	       con.defined_in.remove_contained (con)
	    end
	 end
         logger.trace_leave ("CORBA_IROBJECT_IMPL", "destroy")
      end
   
feature {NONE}
   
   private_dk      : CORBA_DEFINITIONKIND
   private_visited : INDEXED_LIST[CORBA_IROBJECT]
   
invariant
   -- dk_nonvoid : private_dk /= void
   -- visited_nonvoid : private_visited /= void

end -- class CORBA_IROBJECT_IMPL

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
