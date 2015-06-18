note
	description: "Result promise implementation that can be shared between two processors."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_SHARED_RESULT_PROMISE [G, IMPORTER -> CP_IMPORT_STRATEGY [G] create default_create end]

inherit
	CP_RESULT_PROMISE [G]

	CP_SHARED_PROMISE
		redefine
			make
		end

	CP_IMPORTABLE

create
	make, make_from_separate

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			Precursor
			create importer
		end

feature {CP_DYNAMIC_TYPE_IMPORTER}-- Initialization

	make_from_separate (a_object: separate like Current)
			-- <Precursor>
		do
			make
		end

feature -- Access

	item: detachable like {IMPORTER}.import
			-- <Precursor>

feature -- Basic operations

	set_item_and_terminate (a_item: separate G)
			-- Set `item' to `a_item'.
		do
			item := importer.import (a_item)
			terminate
		end

feature {NONE} -- Implementation

	importer: IMPORTER
			-- Importer object for results.

end
