note
	description: "[
		Structures of walkable containers. Walkable means that every item of
		the container can be connected via a (directed or undirected) link to
		any other item.
		
		Traversal is done by moving	a cursor over the datastructure, looking 
		at a specific link towards another element of the container. 
		`left' and `right' will turn to	the next or previous available link, 
		`forth' will move to the target of the current link.

		While the number of items may be infinite, the number of
		links for any item has to be finite.
	]"
	author: "Bernd Schoeller (bernd@fams.de)"
	institution: "ETH Zurich"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WALKABLE [G]

inherit
	TRAVERSABLE [G]

feature -- Access

	target: G
			-- Item at the target of the current edge
		require
			not_off: not off
			has_links: has_links
		deferred
		end

feature -- Measurement

	link_count: INTEGER
			-- Number of links of item
		require
			not_off: not off
		deferred
		end

feature -- Status report

	has_links: BOOLEAN
			-- Are there any links from item ?
		require
			not_off: not off
		deferred
		end

	exhausted: BOOLEAN
			-- Last `left' or `right' turned to the first link ?
		require
			not_off: not off
		deferred
		ensure
			no_links_always_exhausted: not has_links implies exhausted
		end

	has_previous: BOOLEAN
			-- Is there another node in the traversal history?
			-- Must be True in order to use the `back' command.
		deferred
		end

	is_first: BOOLEAN
			-- Am I on the first link ?
		require
			not_off: not off
			has_links: has_links
		deferred
		end

feature -- Cursor movement

	left
			-- Turn to the left link.
		require
			not_off: not off
			has_links: has_links
		deferred
		ensure
			went_around: is_first = exhausted
		end

	right
			-- Turn to the right link.
		require
			not_off: not off
			has_links: has_links
		deferred
		ensure
			went_around: is_first = exhausted
		end

	turn_to (t: like target)
			-- Try to turn the cursor towards `t'.
			-- If not possible, `exhausted' will be set
		require
			not_off: not off
		do
			from
				start
			until
				exhausted or else
				(object_comparison and equal(attached {ANY} target as t1, attached {ANY} t as t2)) or
				(not object_comparison and (target = t))
			loop
				left
			end
		ensure
			item_found: (not exhausted and not object_comparison) implies target = t
			object_found: (not exhausted and object_comparison) implies equal(attached {ANY} target as t1, attached {ANY} t as t2)
		end

	back
			-- Move the cursor back to the previous node.
		require
			can_go_back: has_previous
		deferred
		end

	forth
			-- Move the cursor to the target item by following the link that it is
			-- currently pointing to. If there are no links, the cursor
			-- will be moved to `off'.
		require
			not_off: not off
		deferred
		ensure
			moved_to_target: item = old target
			move_to_off: not old has_links = off
		end

	start
			-- Turn to the first link.
		require else
			not_off: not off
		deferred
		ensure then
			pointing_to_first: has_links implies is_first
			exhausted_iff_no_links: not has_links = exhausted
		end

	search (a_item: G)
			-- Move to the item equal to `a_item' are equal.
			-- (Reference or object equality)
			-- If no such position exists, `off' will be true
		deferred
		ensure
			item_found: (not off and not object_comparison) implies a_item = item
			object_found: (not off and object_comparison) implies equal(attached {ANY} a_item as item1, attached {ANY} item as item2)
		end

invariant

	zero_link_count: not off implies (has_links = (link_count > 0))

	exhausted_if_no_links: (not off and not has_links) implies exhausted

end -- class WALKABLE
