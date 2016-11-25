note
	description: "Summary description for {WDOCS_FS_STORAGE_LAYER_FACTORY}."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_FS_STORAGE_LAYER_FACTORY

feature {WDOCS_API} -- Factory

	new_layer (a_wdocs_api: WDOCS_API): WDOCS_FS_STORAGE_LAYER
			-- New storage layer
		do
			create Result.make (a_wdocs_api)
		end

end
