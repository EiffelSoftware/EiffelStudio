note
	description: "Summary description for {CMS_MODULE_COLLECTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MODULE_COLLECTION

inherit
	ITERABLE [CMS_MODULE]

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create modules.make (nb)
		end

feature -- Access

	new_cursor: INDEXABLE_ITERATION_CURSOR [CMS_MODULE]
			-- <Precursor>
		do
			Result := modules.new_cursor
		end

feature -- Status report

	has (a_module: CMS_MODULE): BOOLEAN
			-- Has `a_module'?
		do
			Result := modules.has (a_module)
		end

	count: INTEGER
			-- Number of modules.
		do
			Result := modules.count
		end

feature -- Element change

	extend (a_module: CMS_MODULE)
			-- Add module
		do
			modules.force (a_module)
		end

	remove (a_module: CMS_MODULE)
			-- Remove module
		do
			modules.prune_all (a_module)
		end

feature {NONE} -- Implementation		

	modules: ARRAYED_LIST [CMS_MODULE]
			-- List of available modules.

end
