indexing
	description: "Tree Item which describes a linkable."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	LINKABLE_TREE_ITEM

inherit
	EV_TREE_ITEM
		redefine
			set_parent
		end

	OBSERVER

	ONCES

	CONSTANTS

creation
	make_with_linkable

feature -- Initialization

	make_with_linkable ( par: EV_TREE_ITEM_HOLDER;link: LINKABLE_DATA;pix: EV_PIXMAP)  is
			-- Initialize
		require
			parent_exists: par /= Void
			linkable_exists: link /= Void
		local
			pp: LINKABLE_TREE_ITEM
		do
			make_with_text (par, link.name)
			pp ?= par
			parent_linkable ?= par
			linkable := link
		--	observer_management.add_observer (linkable, Current)
			!! clusters.make(5)
			!! classes.make(5)
			update
		end

feature -- Access

	linkable: LINKABLE_DATA
		-- Data covered by 'current'.

	clusters: HASH_TABLE [ LINKABLE_TREE_ITEM, STRING ]
		-- Clusters within Current.
		-- Only apply when Current is a cluster, of course.

	classes: HASH_TABLE [ LINKABLE_TREE_ITEM, STRING ]
		-- Classes within Current.
		-- Only apply when Current is a cluster, of course.

	name: STRING is
		-- Return name of associated linkable data.
		do
			Result := linkable.name
		ensure
			Result_exists: Result /= Void
		end

	parent_linkable: LINKABLE_TREE_ITEM
		-- Parent of linkable

feature -- Operations


	set_parent (par:LINKABLE_TREE_ITEM) is
		do
			parent_linkable := par
			precursor(parent_linkable)
		end

	remove_entity (link: LINKABLE_TREE_ITEM) is	
			-- Remove entity.
		require
			linkable_exists: link /= Void
			consistent: classes.has(link.linkable.name) or clusters.has(link.linkable.name)
		do
			if link.linkable.is_class then
				classes.remove(link.linkable.name)
			else
				clusters.remove(link.linkable.name)
			end
			link.destroy
		end

	remove is
			-- remove Current item.
		do
			remove_entity(Current)
		end

	update is 
			-- Update Current.
		do
		end

invariant

	consistent: linkable.is_class implies (clusters.empty and classes.empty)
	no_void: linkable /= Void and clusters /= Void and classes /= Void 

end -- class LINKABLE_TREE_ITEM
