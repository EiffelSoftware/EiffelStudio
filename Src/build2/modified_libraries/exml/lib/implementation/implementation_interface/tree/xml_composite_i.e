indexing
   description: "xml node that may hold child nodes";
   status:	"See notice at end of class.";
   author:	"Andreas Leitner";

deferred class
   XML_COMPOSITE_I

inherit
   XML_NODE_I

   DS_BILINEAR [XML_NODE]
      export
	 {XML_COMPOSITE} internal_cursor
      end

feature {ANY} -- Status Report

feature {ANY} -- Element Change

   put_first, force_first (v: XML_NODE) is
	 -- Add `v' to beginning of list.
	 -- Do not move cursors.
	 -- (Performance: O(1).)

      deferred
      end

   put_last, force_last (v: XML_NODE) is
	 -- Add `v' to end of list.
	 -- Do not move cursors.
	 -- (Performance: O(1).)
      deferred
      end

   put_left_cursor, force_left_cursor (v: XML_NODE; a_cursor: like new_cursor) is
	 -- Add `v' to left of `a_cursor' position.
	 -- Do not move cursors.
	 -- (Synonym of `a_cursor.put_left (v)'.)
	 -- (Performance: O(1).)
      deferred
      end

   put_right_cursor, force_right_cursor (v: XML_NODE; a_cursor: like new_cursor) is
	 -- Add `v' to right of `a_cursor' position.
	 -- Do not move cursors.
	 -- (Synonym of `a_cursor.put_right (v)'.)
	 -- (Performance: O(1).)
      deferred
      end

   extend_first, append_first (other: DS_LINEAR [XML_NODE]) is
	 -- Add items of `other' to beginning of list.
	 -- Keep items of `other' in the same order.
	 -- Do not move cursors.
	 -- (Performance: O(other.count).)
      deferred
      end

   extend_last, append_last (other: DS_LINEAR [XML_NODE]) is
	 -- Add items of `other' to end of list.
	 -- Keep items of `other' in the same order.
	 -- Do not move cursors.
	 -- (Performance: O(other.count).)
      deferred
      end

   extend_left_cursor, append_left_cursor (other: DS_LINEAR [XML_NODE]; a_cursor: like new_cursor) is
	 -- Add items of `other' to left of `a_cursor' position.
	 -- Keep items of `other' in the same order.
	 -- Do not move cursors.
	 -- (Synonym of `a_cursor.extend_left (other)'.)
	 -- (Performance: O(other.count).)
      deferred
      end

   extend_right_cursor, append_right_cursor (other: DS_LINEAR [XML_NODE]; a_cursor: like new_cursor) is
	 -- Add items of `other' to right of `a_cursor' position.
	 -- Keep items of `other' in the same order.
	 -- Do not move cursors.
	 -- (Synonym of `a_cursor.extend_right (other)'.)
	 -- (Performance: O(other.count).)
      deferred
      end

feature -- Removal

   remove_first is
	 -- Remove item at beginning of list.
	 -- Move any cursors at this position `forth'.
	 -- (Performance: O(1).)
      deferred
      end

   remove_last is
	 -- Remove item at end of list.
	 -- Move any cursors at this position `forth'.
	 -- (Performance: O(count).)
      deferred
      end

   remove_at_cursor (a_cursor: like new_cursor) is
	 -- Remove item at `a_cursor' position.
	 -- Move any cursors at this position `forth'.
	 -- (Synonym of `a_cursor.remove'.)
	 -- (Performance: O(1).)
      deferred
      end

   remove_left_cursor (a_cursor: like new_cursor) is
	 -- Remove item to left of `a_cusor' position.
	 -- Move any cursors at this position `forth'.
	 -- (Synonym of `a_cursor.remove_left'.)
	 -- (Performance: O(a_cursor.index).)
      deferred
      end

   remove_right_cursor (a_cursor: like new_cursor) is
	 -- Remove item to right of `a_cursor' position.
	 -- Move any cursors at this position `forth'.
	 -- (Synonym of `a_cursor.remove_right'.)
	 -- (Performance: O(1).)
      deferred
      end

   prune_first (n: INTEGER) is
	 -- Remove `n' first items from list.
	 -- Move all cursors `off'.
	 -- (Performance: O(n).)
      deferred
      end

   prune_last (n: INTEGER) is
	 -- Remove `n' last items from list.
	 -- Move all cursors `off'.
	 -- (Performance: O(count-n).)
      deferred
      end

   prune_left_cursor (n: INTEGER; a_cursor: like new_cursor) is
	 -- Remove `n' items to left of `a_cursor' position.
	 -- Move all cursors `off'.
	 -- (Synonym of `a_cursor.prune_left (n)'.)
	 -- (Performance: O(2*a_cursor.index-n).)
      deferred
      end

   prune_right_cursor (n: INTEGER; a_cursor: like new_cursor) is
	 -- Remove `n' items to right of `a_cursor' position.
	 -- Move all cursors `off'.
	 -- (Synonym of `a_cursor.prune_right (n)'.)
	 -- (Performance: O(n).)
      deferred
      end

   keep_first (n: INTEGER) is
	 -- Keep `n' first items in list.
	 -- Move all cursors `off'.
	 -- (Performance: O(n).)
      deferred
      end

   keep_last (n: INTEGER) is
	 -- Keep `n' last items in list.
	 -- Move all cursors `off'.
	 -- (Performance: O(count-n).)
      deferred
      end

   delete (v: XML_NODE) is
	 -- Remove all occurrences of `v'.
	 -- (Use `equality_tester''s comparison criterion
	 -- if not void, use `=' criterion otherwise.)
	 -- Move all cursors `off'.
	 -- (Performance: O(count).)
      deferred
      end




end -- XML_COMPOSITE_I

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