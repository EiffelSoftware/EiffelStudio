note
	description: "Processor-local proxy to a {separate CP_RESULT_PROMISE} object."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_RESULT_PROMISE_PROXY [G, IMPORTER -> CP_IMPORT_STRATEGY [G] create default_create end]

inherit

	CP_RESULT_PROMISE [G]

	CP_PROMISE_PROXY
		redefine
			utils, subject
		end

create
	make

feature -- Access

	subject: separate CP_SHARED_RESULT_PROMISE [G, IMPORTER]
			-- <Precursor>

	item: detachable like {IMPORTER}.import
			-- <Precursor>
			-- Blocks if the result is not yet available.
		require else
			True
		do
			if not is_imported then
				is_imported := True
				imported_item := utils.promise_imported_item (subject)
			end
			Result := imported_item
		end

feature {NONE} -- Implementation

	utils: CP_RESULT_PROMISE_UTILS [G, IMPORTER]
			-- <Precursor>

	is_imported: BOOLEAN
			-- Is the future already imported into `Current'?

	imported_item: detachable like utils.importer.import
			-- The imported item.

end
