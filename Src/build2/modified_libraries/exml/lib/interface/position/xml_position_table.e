-- very slow implementation for now, needs improvement
class
   XML_POSITION_TABLE
creation
   make
feature {ANY}
   make is
      do
	 !! table.make
      end

feature {ANY}
   put (pos: XML_POSITION; node: XML_NODE) is
      local
	 pair: DS_PAIR [XML_POSITION, XML_NODE]
      do
	 !! pair.make (pos, node)
	 table.put_last (pair)
      end
   
   has (node: XML_NODE): BOOLEAN is
      local
	 cs: DS_LINKED_LIST_CURSOR [DS_PAIR [XML_POSITION, XML_NODE]]
      do
	 from
	    cs := table.new_cursor
	    cs.start
	 until
	    cs.off or Result = True
	 loop
	    if
	       cs.item.second = node
	     then
	       Result := True
	    else
	       cs.forth
	    end
	 end
      end
   
   item (node: XML_NODE): XML_POSITION is
      require
	 has_node: has (node)
      local
	 cs: DS_LINKED_LIST_CURSOR [DS_PAIR [XML_POSITION, XML_NODE]]
      do
	 from
	    cs := table.new_cursor
	    cs.start
	 until
	    cs.off or Result /= Void
	 loop
	    if
	       cs.item.second = node
	     then
	       Result := cs.item.first
	    else
	       cs.forth
	    end
	 end
      ensure
	 result_not_void: Result /= Void
      end
   
feature {NONE}
   
   table: DS_LINKED_LIST [DS_PAIR [XML_POSITION, XML_NODE]]
end   
   

   
