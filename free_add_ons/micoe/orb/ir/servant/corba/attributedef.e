indexing

description: "the class that represents a attribute or value type in the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_ATTRIBUTEDEF_IMPL
    -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
    -- the body of each routine and add any (private) attributes needed.

inherit
    CORBA_ATTRIBUTEDEF_SKEL
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
	 type_def_par : CORBA_IDLTYPE; mode_par : CORBA_ATTRIBUTEMODE) is
	 -- You may give this creation procedure
	 -- any arguments needed.
      
      require
         defined_in_nonvoid : defined_in /= void
         id_nonvoid         : id_par /= void
         name_nonvoid       : name_par /= void
         version_nonvoid    : version_par /= void
         type_def_nonvoid   : type_def_par /= void
         mode_nonvoid       : mode_par /= void
                        
      do
         make_skel
         -- if any parent's creation procedure
         -- takes arguments add them below.
         make_Contained (defined_in_par)
         -- put any other initialization needed here.
         create private_dk.make (CORBA_dk_Attribute)
         private_id := id_par
         private_name := name_par
         private_version := version_par
         private_type_def := type_def_par
         private_mode := mode_par
      end
   
   ------------
   
   type : CORBA_TYPECODE is
      
      do
         result := private_type_def.type
      end
   
   ------------
   
   type_def : CORBA_IDLTYPE is
      
      do
         result := private_type_def
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_type_def (value : CORBA_IDLTYPE) is
      
      do
         private_type_def := value
      end
   
   ------------
   
   mode : CORBA_ATTRIBUTEMODE is
      
      do
         result := private_mode
      ensure then
         result_nonvoid : result /= void
      end
   
   ------------
   
   set_mode (value : CORBA_ATTRIBUTEMODE) is
      
      do
         private_mode := value
      end
   
   ------------
   
   describe : CORBA_CONTAINED_DESCRIPTION is

      local
	 d        : CORBA_ATTRIBUTEDESCRIPTION
         ca        : CORBA_ANY
	 def_in_id : STRING
	 def_in    : CORBA_CONTAINED

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
         create d.make(private_name, private_id, def_in_id,
                        private_version, type, mode)
         create ca.make
         d.struct_to_any (ca)
         result.set_value (ca)
      end

feature {NONE}
   
   private_type_def : CORBA_IDLTYPE
   private_mode     : CORBA_ATTRIBUTEMODE
   
invariant
   -- type_def_nonvoid : private_type_def /= void
   -- mode_nonvoid     : private_mode /= void

end -- class CORBA_ATTRIBUTEDEF_IMPL

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
