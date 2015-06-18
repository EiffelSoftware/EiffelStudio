note
	description: "Utility functions to perform operations on a {separate CP_RESULT_PROMISE} object."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_RESULT_PROMISE_UTILS [G, IMPORTER -> CP_IMPORT_STRATEGY [G] create default_create end]

inherit
	CP_PROMISE_UTILS

feature -- Access

	promise_item (a_promise: separate CP_RESULT_PROMISE [G]): detachable separate G
			-- Item in `a_promise'.
		require
			available: a_promise.is_terminated
		do
			Result := a_promise.item
		end

	promise_imported_item (a_promise: separate CP_RESULT_PROMISE [G]): detachable like importer.import
			-- Imported item in `a_promise'.
		require
			available: a_promise.is_terminated
		do
			if attached a_promise.item as l_item then
				Result := importer.import (l_item)
			end
		end

feature -- Basic operations

	promise_set_item_and_terminate (a_promise: separate CP_SHARED_RESULT_PROMISE [G, IMPORTER]; a_item: separate G)
			-- Set `a_item' in `a_promise'.
		do
			a_promise.set_item_and_terminate (a_item)
		end

feature {NONE} -- Implementation

	importer: IMPORTER
			-- Importer object for results.
		attribute
			create Result
		end

end
