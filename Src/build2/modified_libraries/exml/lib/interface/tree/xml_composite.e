indexing
   description: "XML nodes that may hold children (element and document)";
   status:	"See notice at end of class.";
   author:	"Andreas Leitner";

deferred class
   XML_COMPOSITE
inherit
   XML_NODE
      redefine
	 implementation,
	 root_node,
	 make_from_imp
      end

   DS_BILINEAR [XML_NODE]
      redefine
	 valid_cursor
      end

feature {ANY} -- Access
   
   make_from_imp (imp: like implementation) is
      do
	 Precursor (imp)
	 !! namespaces.make (10)
      end

feature {ANY} -- Access

   first: XML_NODE is
	 -- First item in container
      do
	 Result := implementation.first
      end

   last: XML_NODE is
	 -- First item in container
      do
	 Result := implementation.last
      end

   new_cursor: DS_BILINEAR_CURSOR [XML_NODE] is
	 -- New external cursor for traversal
      do
	 Result := implementation.new_cursor
      end


   root_node: XML_COMPOSITE is
	 -- the root node of this node. In most cases this will be of
	 -- type XML_DOCUMENT
      do
	 if
	    is_root_node
	  then
	    Result := Current
	 else
	    Result := Precursor
	 end
      end


-- FIXME: This feature does not work right now, fix needed
--     new_element_cursor: DS_BILINEAR_CURSOR [XML_ELEMENT] is
--  	 -- New external cursor. This cursor will ignore all nodes
--  	 -- but elements.
--        do
--  	 !XML_ELEMENT_CURSOR! Result.make (new_cursor)
--        end

   has_element_by_name (a_name: UCSTRING): BOOLEAN is
	 -- Has this element at least 1 direct child element with the name `a_name'?
      require
	 a_name_not_void: a_name /= Void
      local
	 cs: like new_cursor
	 e: XML_ELEMENT
      do
	 from
	    cs := new_cursor
	    cs.start
	 until
	    cs.off
	 loop
	    e ?= cs.item
	    if
	       e /= Void and then
	       equal (e.name, a_name)
	     then
	       Result := True
	    end
	    cs.forth
	 end
      end

   element_by_name (a_name: UCSTRING): XML_ELEMENT is
	 -- retrieve direct child element with name `a_name'.
	 -- if there are more than one elements with that name,
	 -- anyone may be returned.
	 -- Returns Void if no element with that name is a child of Current
      require
	 a_name_not_void: a_name /= Void
      local
	 cs: like new_cursor
	 e: XML_ELEMENT
      do
	 from
	    cs := new_cursor
	    cs.start
	 until
	    cs.off
	 loop
	    e ?= cs.item
	    if
	       e /= Void and then
	       equal (e.name, a_name)
	     then
	       Result := e
	    end
	    cs.forth
	 end
      ensure
	 result_not_void: has_element_by_name (a_name) = (Result /= Void)
      end
   
   namespaces: XML_NAMESPACE_TABLE
   
feature {ANY} -- Status Report
   valid_cursor (a_cursor: DS_CURSOR [XML_NODE]): BOOLEAN is
	 -- Is `a_cursor' a valid cursor?
      do
	 Result := implementation.valid_cursor (a_cursor)
      end

feature {ANY} -- Messurement

   count: INTEGER is
	 -- Number of items in container
      do
	 Result := implementation.count
      end

feature {ANY} -- Basic Routines



   process_children (x: XML_NODE_PROCESSOR) is
	 -- process direct children
      require
	 x_not_void: x /= Void
      local
	 cs: like new_cursor
      do
	 from
	    cs := new_cursor
	    cs.start
	 until
	    cs.off
	 loop
	    cs.item.process (x)
	    cs.forth
	 end
      end

   process_children_recursive (x: XML_NODE_PROCESSOR) is
	 -- process direct and indirect children
      require
	 x_not_void: x /= Void
      local
	 cs: like new_cursor
	 e: XML_ELEMENT
      do
	 from
	    cs := new_cursor
	    cs.start
	 until
	    cs.off
	 loop
	    cs.item.process (x)
	    e ?= cs.item
	    if
	       e /= Void
	     then
	       e.process_children_recursive (x)
	    end
	    cs.forth
	 end
      end



feature {ANY} -- Element change
   
   resolve_namespaces_start is
      local
	 decls: XML_NAMESPACE_TABLE
      do
	 create decls.make (10)
	 resolve_namespaces (decls)
      end
      
   resolve_namespaces (decls: XML_NAMESPACE_TABLE) is
	 -- checks for "xmlns" attributes and sets
	 -- the correspondig namespace and namespace_declaration
	 -- features in elements and attributes
	 -- additionally the prefixes are removed from the attribute names
	 -- (except for "xmlns", see `remove_namespace_declaration_from_attributes'
	 -- to remove those as well
      require
	 decls_not_void: decls /= Void
      local
	 element: XML_ELEMENT
	 comp: XML_COMPOSITE
	 cs: like new_cursor
      do
	 from
	    cs := new_cursor
	    cs.start
	 until
	    cs.off
	 loop
	    element ?= cs.item
	    if
	       element /= Void
	     then
	       -- found an element, now let's check if it has "xmlns" 
	       -- attributes are defined
	       decls.override_with_list (element.namespace_declarations)
	       element.apply_namespace_declarations (decls)
	    end
	    comp ?= cs.item
	    if
	       comp /= Void
	     then
	       comp.resolve_namespaces (decls)
	    end
	    cs.forth
	 end
      end
   
   
   remove_namespace_declarations_from_attributes is
	 -- Removes all attributes that are namesapce declarations.
	 -- That is any attribute whos name starts with "xmlns".
      local
	 element: XML_COMPOSITE
	 cs: like new_cursor
      do
	 from
	    cs := new_cursor
	    cs.start
	 until
	    cs.off
	 loop
	    element ?= cs.item
	    if
	       element /= Void
	     then
	       -- found an element, now let's check if it has "xmlns" 
	       -- attributes are defined
	       element.remove_namespace_declarations_from_attributes
	    end
	    cs.forth
	 end
      end
   
   join_text_nodes is
	 -- joins sequences of text nodes
      local
	 text_node: XML_CHARACTER_DATA
	 joint_text_node: XML_CHARACTER_DATA
	 cs: like new_cursor
      do
	 from
	    cs := new_cursor
	    cs.start
	 until
	    cs.off
	 loop
	    text_node ?= cs.item
	    if
	       text_node /= Void
	     then
	       -- found a text node
	       -- now join all text-nodes that are
	       -- more forward until there
	       -- is a node that is no text-node
	       joint_text_node := clone (text_node)
	       remove_at_cursor (cs)
	       from
	       until
		  cs.off or text_node = Void
	       loop
		  text_node ?= cs.item
		  if
		     text_node /= Void
		   then
		     -- found another text-node -> join
		     joint_text_node.append_content (text_node)
		     remove_at_cursor (cs)
		  else
		     cs.forth
		  end
	       end
	       force_left_cursor (joint_text_node, cs)
	    else
	       cs.forth
	    end
	 end
      end

   put_first, force_first (v: XML_NODE) is
	 -- Add `v' to beginning of list.
	 -- Do not move cursors.
	 -- (Performance: O(1).)

      do
	 implementation.put_first (v)
      end

   put_last, force_last (v: XML_NODE) is
	 -- Add `v' to end of list.
	 -- Do not move cursors.
	 -- (Performance: O(1).)
      do
	 implementation.put_last (v)
      end

   put_left_cursor, force_left_cursor (v: XML_NODE; a_cursor: like new_cursor) is
	 -- Add `v' to left of `a_cursor' position.
	 -- Do not move cursors.
	 -- (Synonym of `a_cursor.put_left (v)'.)
	 -- (Performance: O(1).)
      do
	 implementation.put_left_cursor (v, a_cursor)
      end

   put_right_cursor, force_right_cursor (v: XML_NODE; a_cursor: like new_cursor) is
	 -- Add `v' to right of `a_cursor' position.
	 -- Do not move cursors.
	 -- (Synonym of `a_cursor.put_right (v)'.)
	 -- (Performance: O(1).)
      do
	 implementation.put_right_cursor (v, a_cursor)
      end

   extend_first, append_first (other: DS_LINEAR [XML_NODE]) is
	 -- Add items of `other' to beginning of list.
	 -- Keep items of `other' in the same order.
	 -- Do not move cursors.
	 -- (Performance: O(other.count).)
      do
	 implementation.extend_first (other)
      end

   extend_last, append_last (other: DS_LINEAR [XML_NODE]) is
	 -- Add items of `other' to end of list.
	 -- Keep items of `other' in the same order.
	 -- Do not move cursors.
	 -- (Performance: O(other.count).)
      do
	 implementation.extend_last (other)
      end

   extend_left_cursor, append_left_cursor (other: DS_LINEAR [XML_NODE]; a_cursor: like new_cursor) is
	 -- Add items of `other' to left of `a_cursor' position.
	 -- Keep items of `other' in the same order.
	 -- Do not move cursors.
	 -- (Synonym of `a_cursor.extend_left (other)'.)
	 -- (Performance: O(other.count).)
      do
	 implementation.extend_left_cursor (other, a_cursor)
      end

   extend_right_cursor, append_right_cursor (other: DS_LINEAR [XML_NODE]; a_cursor: like new_cursor) is
	 -- Add items of `other' to right of `a_cursor' position.
	 -- Keep items of `other' in the same order.
	 -- Do not move cursors.
	 -- (Synonym of `a_cursor.extend_right (other)'.)
	 -- (Performance: O(other.count).)
      do
	 implementation.extend_right_cursor (other, a_cursor)
      end

feature -- Removal

   remove_first is
	 -- Remove item at beginning of list.
	 -- Move any cursors at this position `forth'.
	 -- (Performance: O(1).)
      do
	 implementation.remove_first
      end

   remove_last is
	 -- Remove item at end of list.
	 -- Move any cursors at this position `forth'.
	 -- (Performance: O(count).)
      do
	 implementation.remove_last
      end

   remove_at_cursor (a_cursor: like new_cursor) is
	 -- Remove item at `a_cursor' position.
	 -- Move any cursors at this position `forth'.
	 -- (Synonym of `a_cursor.remove'.)
	 -- (Performance: O(1).)
      do
	 implementation.remove_at_cursor (a_cursor)
      end

   remove_left_cursor (a_cursor: like new_cursor) is
	 -- Remove item to left of `a_cusor' position.
	 -- Move any cursors at this position `forth'.
	 -- (Synonym of `a_cursor.remove_left'.)
	 -- (Performance: O(a_cursor.index).)
      do
	 implementation.remove_left_cursor (a_cursor)
      end

   remove_right_cursor (a_cursor: like new_cursor) is
	 -- Remove item to right of `a_cursor' position.
	 -- Move any cursors at this position `forth'.
	 -- (Synonym of `a_cursor.remove_right'.)
	 -- (Performance: O(1).)
      do
	 implementation.remove_right_cursor (a_cursor)
      end

   prune_first (n: INTEGER) is
	 -- Remove `n' first items from list.
	 -- Move all cursors `off'.
	 -- (Performance: O(n).)
      do
	 implementation.prune_first (n)
      end

   prune_last (n: INTEGER) is
	 -- Remove `n' last items from list.
	 -- Move all cursors `off'.
	 -- (Performance: O(count-n).)
      do
	 keep_first (count - n)
      end

   prune_left_cursor (n: INTEGER; a_cursor: like new_cursor) is
	 -- Remove `n' items to left of `a_cursor' position.
	 -- Move all cursors `off'.
	 -- (Synonym of `a_cursor.prune_left (n)'.)
	 -- (Performance: O(2*a_cursor.index-n).)
      do
	 implementation.prune_left_cursor (n, a_cursor)
      end

   prune_right_cursor (n: INTEGER; a_cursor: like new_cursor) is
	 -- Remove `n' items to right of `a_cursor' position.
	 -- Move all cursors `off'.
	 -- (Synonym of `a_cursor.prune_right (n)'.)
	 -- (Performance: O(n).)
      do
	 implementation.prune_right_cursor (n, a_cursor)
      end

   keep_first (n: INTEGER) is
	 -- Keep `n' first items in list.
	 -- Move all cursors `off'.
	 -- (Performance: O(n).)
      do
	 implementation.keep_first (n)
      end

   keep_last (n: INTEGER) is
	 -- Keep `n' last items in list.
	 -- Move all cursors `off'.
	 -- (Performance: O(count-n).)
      do
	 prune_first (count - n)
      end

   delete (v: XML_NODE) is
	 -- Remove all occurrences of `v'.
	 -- (Use `equality_tester''s comparison criterion
	 -- if not void, use `=' criterion otherwise.)
	 -- Move all cursors `off'.
	 -- (Performance: O(count).)
      do
	 implementation.delete (v)
      end

   wipe_out is
	 -- Remove all items from container.
      do
	 implementation.wipe_out
      end

feature {NONE} -- Implementation
   implementation: XML_COMPOSITE_I

   internal_cursor: like new_cursor is
	 -- Internal cursor
      do
	 Result := implementation.internal_cursor
      end

invariant
   namespaces_not_void: namespaces /= Void
end -- XML_COMPOSITE

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
