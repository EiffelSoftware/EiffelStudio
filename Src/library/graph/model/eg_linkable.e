indexing
	description: "An EG_ITEM can have links to other EG_LINKABLE through an EG_LINK"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_LINKABLE

inherit
	EG_ITEM
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create an EG_LINKABLE
		do
			Precursor {EG_ITEM}
			create internal_links.make (0)
		end

feature -- Access

	cluster: EG_CLUSTER
			-- cluster `Current' is part of.

	links: like internal_links is
			-- Links to other EG_LINKABLEs.
		do
			Result := internal_links.twin
		end
	
feature {EG_LINK} -- Element change

	add_link (a_link: EG_LINK) is
			-- Add `a_link' to `links'.
		require
			a_link_not_void: a_link /= Void
			a_link_links_Current: a_link.source = Current or a_link.target = Current
			not_has_a_link: not links.has (a_link)
		do
			internal_links.extend (a_link)
		ensure
			links_has_a_link: links.has (a_link)
		end
			
feature {EG_CLUSTER} -- Element change

	set_cluster (a_cluster: like cluster) is
			-- Set `cluster' to `a_cluster'.
		require
			a_cluster_not_void: a_cluster /= Void
			a_cluster_has_current: a_cluster.has (Current)
			cluster_void: cluster = Void
		do
			cluster := a_cluster
		ensure
			set: cluster = a_cluster
		end
		
	remove_cluster is
			-- Set `cluster' to Void.
		do
			cluster := Void
		ensure
			set: cluster = Void
		end
		
		
feature {EG_GRAPH} -- Element change

	remove_link (a_link: EG_LINK) is
			-- Remove `a_link' from `links'.
		require
			a_link_not_void: a_link /= Void
			has_a_link: links.has (a_link)
		do
			internal_links.prune_all (a_link)
		ensure
			not_has_a_link: not links.has (a_link)
		end

feature {EG_FIGURE_WORLD, EG_GRAPH} -- Access

	internal_links: ARRAYED_LIST [EG_LINK]
			-- Links to other EG_LINKABLEs.
			
invariant
	internal_links_not_void: internal_links /= Void

end -- class EG_LINKABLE

--|----------------------------------------------------------------
--| EiffelGraph: library of graph components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

