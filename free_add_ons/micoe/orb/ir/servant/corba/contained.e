indexing

description: "base interface for all ir object contained in others %
              %(that are all except repository)";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

deferred class CORBA_CONTAINED_IMPL
    -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
    -- the body of each routine and add any (private) attributes needed.

inherit
   CORBA_CONTAINED_SKEL
      rename
	 make as make_skel
      end;
   CORBA_IROBJECT_IMPL
      rename
	 make as make_IRObject
      undefine
	 type_name, consume, valid_message_type,
	 repoid, template, dispatcher, doinvoke, make_skel
      end
   
--creation
--   make
   
feature
   
   make (defined_in_par : CORBA_CONTAINER) is
	 -- You may give this creation procedure
	 -- any arguments needed.
      
      require
	 defined_in_not_void : defined_in_par /= void

      do
	 make_skel
	 -- if any parent's creation procedure
	 -- takes arguments add them below.
	 make_IRObject
	 -- put any other initialization needed here.
	 private_defined_in := defined_in_par
      end
   
   ------------
   
   id : STRING is
      
      do
	 result := clone (private_id)
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_id (value : STRING) is
      
      local
	 repo      : CORBA_REPOSITORY
	 con, cur  : CORBA_CONTAINED
	 i, j      : INTEGER
	 intf      : INTF_REPOS
	 
      do
	 repo := containing_repository
	 con := repo.lookup_id (value)
	 cur ?= current
	 if con /= void and then not equal (cur, con) then
	    create intf.make
	    raise_exception (intf)
	 else
	    private_id := value
	    from
	       i := 0
	       j := value.index_of (':', 0)
	    until
	       j = 0
	    loop
	       i := j
	       j := value.index_of (':', i)		
	    end -- loop
	    if i > 0 then
	       private_version := value.substring (i + 1,
						   value.count)
	    end
	 end -- if
      end
   
   ------------
   
   name : STRING is
      
      do
         logger.trace_enter ("CONTAINED", "name")
	 result := clone (private_name)
         logger.trace_leave ("CONTAINED", "name")
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_name (value : STRING) is

      do
	 private_name := clone (value)
      end
   
   ------------
   
   version : STRING is
      
      do
	 result := clone (private_version)
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_version (value : STRING) is
      
      local
	 i, j : INTEGER
	 
      do
	 from
	    i := 0
	    j := value.index_of (':', 0)
	 until
	    j = 0
	 loop
	    i := j
	    j := value.index_of (':', i)		
	 end -- loop

	 if i > 0 then
	    private_id := private_id.substring (0, i + 1)
	 end
	 private_id.append (value)
      end
   
   ------------
   
   defined_in : CORBA_CONTAINER is
      
      do
	 result := private_defined_in
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   absolute_name : STRING is
      
      local
	 con : CORBA_CONTAINED
	 
      do
	 check -- obsolete if class invariants work
	    defined_in_nonvoid : private_defined_in /= void
	 end
	 inspect private_defined_in.def_kind.value
	 when CORBA_dk_Repository then
	    result := "::"
	    result.append (name)
	 when CORBA_dk_Value, CORBA_dk_Interface,   
	    CORBA_dk_Module, CORBA_dk_Struct,
	    CORBA_dk_Union, CORBA_dk_Exception then
	    con := CORBA_Contained_narrow (private_defined_in)
	    check
	       our_container_is_a_contained : con /= void
	    end
	    result := con.absolute_name
	    result.append ("::")
	    result.append (private_name)
	 end -- inspect
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   containing_repository : CORBA_REPOSITORY is
      
      local
	 r      : CORBA_REPOSITORY
	 c      : CORBA_CONTAINED
	 
      do
	 check -- obsolete if class invariants work
	    our_container_is_not_void : private_defined_in /= void
	 end
	 r := CORBA_Repository_narrow (private_defined_in)
	 if r /= void then
	    result := r
	 else
	    c := CORBA_Contained_narrow (private_defined_in)
	    check
	       our_container_is_a_contained : c /= void
	    end
	    result := c.containing_repository
	 end
      ensure then
	 result_nonvoid : result /= void
      end
   
   ------------
   
   describe : CORBA_CONTAINED_DESCRIPTION is
      --	 supported : CORBA_INTERFACEDEF
      deferred
      ensure then
	 result_nonvoid : result /= void
      end
   
   ------------
   
   move (new_container : CORBA_CONTAINER;
	 new_name : STRING;
	 new_version : STRING) is

      do
	 private_defined_in.remove_contained (current)
	 private_name := clone (new_name)
	 private_version := clone (new_version)
	 new_container.add_contained (current)
      end
   
feature {NONE}
   
   private_id           : STRING
   private_name         : STRING
   private_version      : STRING
   private_defined_in   : CORBA_CONTAINER
   
   private_container_id : STRING
   
invariant
   -- id_nonvoid : private_id /= void
   -- name_nonvoid : private_name /= void
   -- version_nonvoid : private_version /= void
   -- defined_in_nonvoid : private_defined_in /= void
   -- container_id_nonvoid : private_container_id /= void

end -- class CORBA_CONTAINED_IMPL

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
