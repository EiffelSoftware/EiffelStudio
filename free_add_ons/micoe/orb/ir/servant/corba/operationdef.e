indexing

description: "the class that represents an operation or value type in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_OPERATIONDEF_IMPL
    -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
    -- the body of each routine and add any (private) attributes needed.

inherit
    CORBA_OPERATIONDEF_SKEL
        rename
            make as make_skel
        end;
    CORBA_CONTAINED_IMPL
        rename
            make as make_Contained
        undefine
            type_name, consume, valid_message_type,
            repoid, template, dispatcher, doinvoke, make_skel
        end

creation
   make
   
feature
   
   make (defined_in_par : CORBA_CONTAINER;
         id_par, name_par, version_par: STRING;
         result_par : CORBA_IDLTYPE; mode_par : CORBA_OPERATIONMODE;
         params_par : CORBA_PARDESCRIPTIONSEQ;
         exs : CORBA_EXCEPTIONDEFSEQ;
         ctx : CORBA_CONTEXTIDSEQ) is
         -- You may give this creation procedure
         -- any arguments needed.
      
      require
         defined_in_nonvoid : defined_in_par /= void
	 id_nonvoid : id_par /= void
	 name_nonvoid : name_par /= void
	 version_nonvoid : version_par /= void
         result_nonvoid : result_par /= void
         mode_nonvoid : mode /= void
         exs_nonvoid : exs /= void
         ctx_nonvoid : ctx /= void
                       
      do
         make_skel
         -- if any parent's creation procedure
         -- takes arguments add them below.
         make_Contained (defined_in_par)
         -- put any other initialization needed here.
         create private_dk.make (CORBA_dk_Operation)
         private_id := id_par
         private_name := name_par
         private_version := version_par
         private_result_def := result_par
         private_mode := mode_par
         private_params := params_par
         private_exceptions := exs
         private_contexts := ctx
      end
   
   ------------
   
   idl_result : CORBA_TYPECODE is
      
      do
         result := private_result_def.type
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   result_def : CORBA_IDLTYPE is
      
      do
         result := private_result_def
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_result_def (value : CORBA_IDLTYPE) is
      
      do
         private_result_def := value
      end
   
   ------------
   
   params : CORBA_PARDESCRIPTIONSEQ is
      
      do
         result := private_params
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_params (value : CORBA_PARDESCRIPTIONSEQ) is
      
      do
         private_params := value
      end
   
   ------------
   
   mode : CORBA_OPERATIONMODE is
      
      do
         result := private_mode
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_mode (value : CORBA_OPERATIONMODE) is
      
      do
         private_mode := value
      end
   
   ------------
   
   contexts : CORBA_CONTEXTIDSEQ is
      
      do
         result := private_contexts
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_contexts (value : CORBA_CONTEXTIDSEQ) is
      
      do
         private_contexts := value
      end
   
   ------------
   
   exceptions : CORBA_EXCEPTIONDEFSEQ is
      
      do
         result := private_exceptions
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_exceptions (value : CORBA_EXCEPTIONDEFSEQ) is
      
      do
         private_exceptions := value
      end
   
   ------------
   
   describe : CORBA_CONTAINED_DESCRIPTION is
  
      local
         d         : CORBA_OPERATIONDESCRIPTION
	 ca        : CORBA_ANY
         j         : INTEGER
	 def_in_id : STRING
	 def_in    : CORBA_CONTAINED
         des       : CORBA_EXCDESCRIPTIONSEQ
         ced       : CORBA_EXCEPTIONDESCRIPTION

      do
	 def_in := CORBA_Contained_narrow (private_defined_in)
	 if def_in = void then
	    def_in_id := def_in.id
	 else
	    -- The Repository doesn't have am RepoID, because it is 
	    -- not a Contained.
	    def_in_id := ""
	 end  
         create result.make_default
	 result.set_kind (private_dk)
         create d.make_default
         d.set_name (private_name)
         d.set_id (private_id)
         d.set_defined_in (def_in_id)
         d.set_version (private_version)
         d.set_idl_result (idl_result)
         d.set_mode (mode)
         d.set_contexts (contexts)
         d.set_parameters (params)
         from
            j := 1
            create des.make_default
         until
            j > exceptions.length
         loop
            ced.make_default
            ced.struct_from_any(exceptions.get_value (j).describe.value)
            des.set_value (ced, j)
            j := j + 1
         end -- loop j
         d.set_exceptions(des)
         create ca.make
         d.struct_to_any (ca)
         result.set_value (ca)
      end

feature {NONE}
   
   private_result_def : CORBA_IDLTYPE
   private_params     : CORBA_PARDESCRIPTIONSEQ
   private_mode       : CORBA_OPERATIONMODE
   private_exceptions : CORBA_EXCEPTIONDEFSEQ
   private_contexts   : CORBA_CONTEXTIDSEQ

invariant
   -- result_def_nonvoid     : private_result_def /= void 
   -- params_def_nonvoid     : private_params /= void 
   -- mode_def_nonvoid       : private_mode /= void      
   -- exceptions_def_nonvoid : private_exceptions /= void 
   -- context_def_nonvoid    : private_contexts /= void  

end -- class CORBA_OPERATIONDEF_IMPL

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
