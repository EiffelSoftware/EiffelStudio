indexing

description: "the root class of the IR";
keywords: "InterfaceRepository, IR";
status: "See notice at end of class";
date: "$Date$";
revision: "$Revision$"

class CORBA_REPOSITORY_IMPL
   -- This is a protype class. THE PROGRAMMER IS EXPECTED TO IMPLEMENT
   -- the body of each routine and add any (private) attributes needed.
   
inherit
   CORBA_REPOSITORY_SKEL
      rename
	 make as make_skel
      end;
   CORBA_CONTAINER_IMPL
      rename
	 make as make_Container
      undefine
	 type_name, consume, valid_message_type,
	 repoid, template, dispatcher, doinvoke, make_skel
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
         logger.trace_enter ("CORBA_REPOSITORY_IMPL", "make")
	 make_skel
	 -- if any parent's creation procedure
	 -- takes arguments add them below.
	 make_Container
	 -- put any other initialization needed here.
	 create private_dk.make (CORBA_dk_Repository)
	 create private_anonymous_types.make (true)
	 
	 -- Make all possible primitive kinds
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_void.make (CORBA_pk_void)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_float.make (CORBA_pk_float)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_double.make (CORBA_pk_double)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_long.make (CORBA_pk_long)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_short.make (CORBA_pk_short)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_ulong.make (CORBA_pk_ulong)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_ushort.make (CORBA_pk_ushort)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_char.make (CORBA_pk_char)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_boolean.make (CORBA_pk_boolean)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_octet.make (CORBA_pk_octet)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_string.make (CORBA_pk_string)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_any.make (CORBA_pk_any)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_objref.make (CORBA_pk_objref)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_typecode.make (CORBA_pk_typecode)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_principal.make (CORBA_pk_principal)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_longlong.make (CORBA_pk_longlong)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_ulonglong.make (CORBA_pk_ulonglong)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_longdouble.make (CORBA_pk_longdouble)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_wchar.make (CORBA_pk_wchar)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_wstring.make (CORBA_pk_wstring)
	 create {CORBA_PRIMITIVEDEF_IMPL}
	 private_pk_value_base.make (CORBA_pk_value_base)
--	 create {CORBA_PRIMITIVEDEF_IMPL}
--       private_pk_abstractbase.make (CORBA_pk_abstractbase)
         logger.trace_leave ("CORBA_REPOSITORY_IMPL", "make")
      end
   
   ------------
   
   lookup_id (search_id : STRING) : CORBA_CONTAINED is
      
      do
	 result := locate_id (search_id)   
      end
   
   ------------
   
   get_canonical_typecode (tc : CORBA_TYPECODE) : CORBA_TYPECODE is
      
      do
      end
   
   ------------
   
   get_primitive (kind : CORBA_PRIMITIVEKIND) : CORBA_PRIMITIVEDEF is
      
      do
	 inspect kind.value
	 when CORBA_pk_void then
	    result := private_pk_void
	 when CORBA_pk_float then
	    result := private_pk_float
	 when CORBA_pk_double then
	    result := private_pk_double
	 when CORBA_pk_long  then
	    result := private_pk_long
	 when CORBA_pk_short then
	    result := private_pk_short
	 when CORBA_pk_ulong then
	    result := private_pk_ulong
	 when CORBA_pk_ushort then
	    result := private_pk_ushort
	 when CORBA_pk_char then
	    result := private_pk_char
	 when CORBA_pk_boolean then
	    result := private_pk_boolean
	 when CORBA_pk_octet then
	    result := private_pk_octet
	 when CORBA_pk_string then
	    result := private_pk_string
	 when CORBA_pk_any then
	    result := private_pk_any
	 when CORBA_pk_objref then
	    result := private_pk_objref
	 when CORBA_pk_typecode then
	    result := private_pk_typecode
	 when CORBA_pk_principal then
	    result := private_pk_principal
	 when CORBA_pk_longlong then
	    result := private_pk_longlong
	 when CORBA_pk_ulonglong then
	    result := private_pk_ulonglong
	 when CORBA_pk_longdouble then
	    result := private_pk_longdouble
	 when CORBA_pk_wchar then
	    result := private_pk_wchar
	 when CORBA_pk_wstring then
	    result := private_pk_wstring
	 when CORBA_pk_value_base then
	    result := private_pk_value_base
--	 when CORBA_pk_abstractbase then
--	    result := private_pk_abstractbase
	 end -- inspect
      end
   
   ------------
   
   create_string (bound : INTEGER) : CORBA_STRINGDEF is
      
      local
	 s : CORBA_STRINGDEF
	 t : CORBA_IDLTYPE
	 
      do
	 create {CORBA_STRINGDEF_IMPL} s.make
	 s.set_bound (bound)
	 t := add_anonymous_type (s)
	 result := CORBA_StringDef_narrow (t)
      end
   
   ------------
   
   create_wstring (bound : INTEGER) : CORBA_WSTRINGDEF is
      
      local
	 s : CORBA_WSTRINGDEF
	 t : CORBA_IDLTYPE
	 
      do
	 create {CORBA_WSTRINGDEF_IMPL} s.make
	 s.set_bound (bound)
	 t := add_anonymous_type (s)
	 result := CORBA_WstringDef_narrow (t)
      end
   
   ------------
   
   create_sequence (bound : INTEGER;
		    element_type : CORBA_IDLTYPE) : CORBA_SEQUENCEDEF is
      
      local
	 s : CORBA_SEQUENCEDEF
	 t : CORBA_IDLTYPE
	 
      do
	 create {CORBA_SEQUENCEDEF_IMPL} s.make
	 s.set_bound (bound)
         s.set_element_type_def (element_type)
	 t := add_anonymous_type (s)
	 result := CORBA_SequenceDef_narrow (t)
      end
   
   ------------
   
   create_array (length : INTEGER;
		 element_type : CORBA_IDLTYPE) : CORBA_ARRAYDEF is
      
      local
	 a : CORBA_ARRAYDEF
	 t : CORBA_IDLTYPE
	 
      do
 	 create {CORBA_ARRAYDEF_IMPL} a.make
	 a.set_element_type_def (element_type)
	 a.set_length (length)
	 t := add_anonymous_type (a)
	 result := CORBA_ArrayDef_narrow (t)
      end
   
   ------------
   
   create_fixed (digits : INTEGER;
		 scale : INTEGER) : CORBA_FIXEDDEF is
      
      local
	 f : CORBA_FIXEDDEF
	 t : CORBA_IDLTYPE
	 
      do
 	 create {CORBA_FIXEDDEF_IMPL} f.make
	 f.set_digits (digits)
	 f.set_scale (scale)
	 t := add_anonymous_type (f)
	 result := CORBA_FixedDef_narrow (t)
      end
   
feature {NONE}
   
   private_pk_void : CORBA_PRIMITIVEDEF
   private_pk_float : CORBA_PRIMITIVEDEF
   private_pk_double : CORBA_PRIMITIVEDEF
   private_pk_long : CORBA_PRIMITIVEDEF
   private_pk_short : CORBA_PRIMITIVEDEF
   private_pk_ulong : CORBA_PRIMITIVEDEF
   private_pk_ushort : CORBA_PRIMITIVEDEF
   private_pk_char : CORBA_PRIMITIVEDEF
   private_pk_boolean : CORBA_PRIMITIVEDEF
   private_pk_octet : CORBA_PRIMITIVEDEF
   private_pk_string : CORBA_PRIMITIVEDEF
   private_pk_any : CORBA_PRIMITIVEDEF
   private_pk_objref : CORBA_PRIMITIVEDEF
   private_pk_typecode : CORBA_PRIMITIVEDEF
   private_pk_principal : CORBA_PRIMITIVEDEF
   private_pk_longlong : CORBA_PRIMITIVEDEF
   private_pk_ulonglong : CORBA_PRIMITIVEDEF
   private_pk_longdouble : CORBA_PRIMITIVEDEF
   private_pk_wchar : CORBA_PRIMITIVEDEF
   private_pk_wstring : CORBA_PRIMITIVEDEF
   private_pk_value_base : CORBA_PRIMITIVEDEF
   
   private_anonymous_types : INDEXED_LIST[CORBA_IDLTYPE]
   
	 ------------
   
   add_anonymous_type (type : CORBA_IDLTYPE) : CORBA_IDLTYPE is

      local
	 i, j                : INTEGER
	 type_tc, current_tc : CORBA_TYPECODE
	 
      do
	 i := private_anonymous_types.count
	 type_tc := type.type
	 
	 -- We can *not* check for duplicate definitions of recursive 
	 -- sequences: the TypeCode of their element_type_def is 
	 -- incomplete at this time!
	 -- ?? CORBA_TYPECODE.equal does now handle the case of 
	 -- inclomplete resursive types (and return false), so we can
	 -- check sequences, too

	 from
	    j := 1
	 until 
	    j > i
	 loop
	    current_tc := private_anonymous_types.at (j).type
	    if equal (current_tc, type_tc) then
	       -- We already have a definition of this type
	       result := private_anonymous_types.at (j)
	    end
	    j := j + 1
	 end -- loop j
	 
	 if result = void then
	    private_anonymous_types.insert (type, i)
	    result := type
	 end
      end
   
invariant
   -- pk_void_novoid       : private_pk_void /= void 
   -- pk_float_novoid      : private_pk_float /= void 
   -- pk_double_novoid     : private_pk_double /= void 
   -- pk_long_novoid       : private_pk_long /= void 
   -- pk_short_novoid      : private_pk_short /= void 
   -- pk_ulong_novoid      : private_pk_ulong /= void 
   -- pk_ushort_novoid     : private_pk_ushort /= void 
   -- pk_char_novoid       : private_pk_char /= void 
   -- pk_boolean_novoid    : private_pk_boolean /= void 
   -- pk_octect_novoid     : private_pk_octet /= void 
   -- pk_string_novoid     : private_pk_string /= void 
   -- pk_any_novoid        : private_pk_any /= void 
   -- pk_objref_novoid     : private_pk_objref /= void 
   -- pk_typecode_novoid   : private_pk_typecode /= void 
   -- pk_principal_novoid  : private_pk_principal /= void 
   -- pk_longlong_novoid   : private_pk_longlong /= void 
   -- pk_ulonglong_novoid  : private_pk_ulonglong /= void 
   -- pk_longdouble_novoid : private_pk_longdouble /= void 
   -- pk_wchar_novoid      : private_pk_wchar /= void 
   -- pk_wstring_novoid    : private_pk_wstring /= void 
   -- pk_value_base_novoid : private_pk_value_base /= void 

   -- anonymous_types      : private_anonymous_types /= void 

end -- class CORBA_REPOSITORY_IMPL

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
