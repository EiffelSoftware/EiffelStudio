indexing
   description: "objects representing a element";
   status:			"See notice at end of class.";
   author:			"Andreas Leitner";

class
   XML_ELEMENT
inherit
   XML_COMPOSITE
      rename
	 remove_namespace_declarations_from_attributes as remove_namespace_declarations_from_attributes_recursive
      undefine
	 root_node
      redefine
	 make_from_imp,
	 implementation,
	 remove_namespace_declarations_from_attributes_recursive,
	 resolve_namespaces_start
      end
   
   XML_NAMED_NODE
      redefine
	 implementation,
	 make_from_imp,
	 apply_namespace_declarations
      end

creation
   make_from_imp

feature {NONE} -- Initialisation
   make_from_imp (imp: like implementation) is
      do
	 {XML_COMPOSITE} Precursor (imp)
      end

feature {ANY} -- Access

   has_attribute_by_name (a_name: UCSTRING): BOOLEAN is
  	 -- is an attribute with the name `a_name' present in this
	 -- element?
      require
  	 a_name_not_void: a_name /= Void
      local
	 cs: like new_cursor
	 att: XML_ATTRIBUTE
      do
	 from
	    cs := new_cursor
	    cs.start
	 until
	    cs.off
	 loop
	    att ?= cs.item
	    if 
	       att /= Void and then
	       equal (att.name, a_name)
	     then
	       Result := True
	       cs.go_after
	    else
	       cs.forth
	    end
	 end
      end

	attribute_by_name (a_name: UCSTRING): XML_ATTRIBUTE is
		-- retrieves the attribute with the name `a_name' from element.
		-- returns `Void' if no Attribute was found.
	require
		a_name_not_void: a_name /= Void
	local
		cs: like new_cursor
		att: XML_ATTRIBUTE
	do
	 from
	    cs := new_cursor
	    cs.start
	 until
	    cs.off or Result /= Void
	 loop
	    att ?= cs.item
	    if 
	       att /= Void
		then
			if
				equal (att.name, a_name)
			then
				Result := att
			end
		end
		cs.forth
	end
	ensure
	 result_not_void: Result /= Void
      end
   
   
   namespace_declarations: DS_LINKED_LIST [XML_NAMESPACE] is
	 -- namespaces declared directly in this element
	 -- this list must contain at most one namespace with a
	 -- void prefix. If such a namespace exists it is a declared 
	 -- default namespace
      do
	 if
	    namespace_declarations_cache = Void
	  then
	    namespace_declarations_cache := get_namespace_declarations_from_attributes
	 end
	 result := namespace_declarations_cache
      end
   
   attributes: DS_BILINEAR [XML_ATTRIBUTE] is
      local
	 cs: like new_cursor
	 att: XML_ATTRIBUTE
	 l: DS_BILINKED_LIST [XML_ATTRIBUTE]
      do
	 !! l.make
	 Result := l
	 from
	    cs := new_cursor
	    cs.start
	 until
	    cs.off
	 loop
	    att ?= cs.item
	    if
	       att /= Void
	     then
	       l.force_last (att)
	    end
	    cs.forth
	 end
      end
   
      
feature {ANY} -- Element Change

   add_attributes (a_attributes: DS_BILINEAR [DS_PAIR [DS_PAIR [UCSTRING, UCSTRING], UCSTRING]]) is
	 -- Add `a_attributes' to this element.
      require
	 a_attributes_not_void: a_attributes /= Void
      do
	 implementation.add_attributes (a_attributes, Current)
      end
   
feature {ANY} -- Removal
   
   remove_attribute_by_name (n: UCSTRING) is
  	 -- removes attribute with name `n' from element.
      require
	 n_not_void: n /= Void
	 has_attribute: has_attribute_by_name (n)
      local
	 cs: like new_cursor
	 att: XML_ATTRIBUTE
      do
	 from
	    cs := new_cursor
	    cs.start
	 until
	    cs.off
	 loop
	    att ?= cs.item
	    if
	       att /= Void and then
	       equal (n, att.name)
	     then
	       remove_at_cursor (cs)
	       -- `remove_at_cursor' does implicit `forth' for all cursors
	    else
	       cs.forth
	    end
	 end
      end
   
   remove_namespace_declarations_from_attributes_recursive is
      do
	 remove_namespace_declarations_from_attributes
	 Precursor
      end
   
   remove_namespace_declarations_from_attributes is
	 -- remove all attributes that start with "xmlns:" permanently
      local
	 cs: like new_cursor
	 att: XML_ATTRIBUTE
      do
	 from
	    cs := new_cursor
	    cs.start
	 until
	    cs.off
	 loop
	    att ?= cs.item
	    if
	       att /= Void and then
	       att.is_namespace_declaration
	     then
	       remove_at_cursor (cs)
	       -- `remove_at_cursor' does implicit `forth' for all cursors
	    else
	       cs.forth
	    end
	 end
      end
   
feature {ANY} -- Basic Operations
   
   process (x: XML_NODE_PROCESSOR) is
      do
	 x.process_element (Current)
      end
   
   
   resolve_namespaces_start is
      local
	 decls: XML_NAMESPACE_TABLE
      do
	 create decls.make (10)
	 decls.override_with_list (namespace_declarations)
	 apply_namespace_declarations (decls)
	 resolve_namespaces (decls)
      end
   
   apply_namespace_declarations (decls: XML_NAMESPACE_TABLE) is
	 -- Apply namespace declaration.
      local
	 cs: DS_BILINEAR_CURSOR [XML_ATTRIBUTE]
      do
	 if
	    has_prefix
	  then
	    Precursor (decls)
	 else
	    if
	       decls.has_default
	     then
	       set_namespace (decls.default_ns)
	    end
	 end
	 from
	    cs := attributes.new_cursor
	    cs.start
	 until
	    cs.off
	 loop
	    cs.item.apply_namespace_declarations (decls)
	    cs.forth
	 end
	 
      end


feature {NONE} -- Implementation
   
   get_namespace_declarations_from_attributes: DS_LINKED_LIST [XML_NAMESPACE] is
      local
	 cs: like new_cursor
	 att: XML_ATTRIBUTE
	 l: DS_LINKED_LIST [XML_NAMESPACE]
      do
	 !! l.make
	 Result := l
	 from
	    cs := new_cursor
	    cs.start
	 until
	    cs.off
	 loop
	    att ?= cs.item
	    if
	       att /= Void and then att.is_namespace_declaration
	     then
	       l.force_last (att.namespace_declaration)
	    end
	    cs.forth
	 end
      end
   
   namespace_declarations_cache: DS_LINKED_LIST [XML_NAMESPACE]
   
feature {NONE} -- Implementation
   implementation: XML_ELEMENT_I
   
end -- XML_ELEMENT

--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner and others
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Andreas Leitner
--| Arndtgasse 1/3/5
--| 8010 Graz
--| Austria
--| email: andreas.leitner@chello.at
--| www: http://exml.dhs.org
--|-------------------------------------------------------------------------







