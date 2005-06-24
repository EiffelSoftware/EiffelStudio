indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred 
class
	ES_NOTEBOOK_ATTACHABLE

feature -- Attachement

	attach_to_notebook (a_nb: ES_NOTEBOOK) is
		require
			notebook_exists: a_nb /= Void
			not_attached: notebook_item = Void			
		do
			if notebook_item = Void then
				build_notebook_item (a_nb)
			else
			end
		ensure
			notebook_item_exists: notebook_item /= Void
		end
		
	unattach_from_notebook is
		require
			attached: notebook_item /= Void
		do
			if not notebook_item.is_destroyed then
				notebook_item.close
			end
			notebook_item := Void
		ensure
			notebook_item = Void
		end
		
	change_attach_notebook (a_nb: ES_NOTEBOOK) is
		require
			a_nb_exists: a_nb /= Void
			attached: notebook_item /= Void
		do
			if notebook_item.parent /= a_nb then
				unattach_from_notebook
				attach_to_notebook (a_nb)
			end
		end

feature -- Access

	notebook_item: ES_NOTEBOOK_ITEM
			-- Associated note book tab.

feature {NONE} -- Build implementation

	build_notebook_item (a_nb: ES_NOTEBOOK) is
			-- Build associated notebook tab
			-- and add it to `a_nb'
		require
			a_nb /= Void
		deferred
		ensure
			notebook_item /= Void
		end

end
