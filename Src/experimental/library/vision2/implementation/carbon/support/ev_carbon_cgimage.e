note
	description: "Objects that facilitates the interaction with carbons CGImages"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CARBON_CGIMAGE

inherit
	CFBASE_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CFBUNDLE_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CGDATAPROVIDER_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CGIMAGE_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CFURL_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CGCONTEXT_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make_with_file

feature -- Creation

	make_with_file (a_file_name: STRING)
			--
		do
			item := load_image (a_file_name)
		end

feature -- Access

	item: POINTER

feature -- Measurement

	width: INTEGER
			--
		do
			Result := cgimage_get_width_external (item)
		end

	height: INTEGER
			--
		do
			Result := cgimage_get_height_external (item)
		end

feature {NONE} -- Implementation

	load_image (a_file_name: STRING): POINTER
			-- Loads an image from the specified path and returns a CGImageRef
			-- This freature should probably be refactored to some better place so we could use the same code in other places (like EV_PIXMAP_IMP)
		local
			url, provider: POINTER
			cf_filename, cf_dir: EV_CARBON_CF_STRING
			c_name: C_STRING
		do
			create cf_filename.make_unshared_with_eiffel_string (a_file_name)
			create cf_dir.make_unshared_with_eiffel_string ("./")

			url := cfbundle_copy_resource_url_external (cfbundle_get_main_bundle_external, cf_filename.item, null, cf_dir.item)
			if url = null then
				create cf_dir.make_unshared_with_eiffel_string ("./../../../")
				url := cfbundle_copy_resource_url_external (cfbundle_get_main_bundle_external, cf_filename.item, null, cf_dir.item)
			end
			if url = null then
				create c_name.make (a_file_name)
				url := cfurlcreate_from_file_system_representation_external (null, c_name.item, c_name.count, 0)
			end
			if url /= null then
				provider := cgdata_provider_create_with_url_external (url)
				Result := cgimage_create_with_pngdata_provider_external (provider, null, 0, kCGRenderingIntentDefault)

				cgdata_provider_release_external (provider)
				cfrelease_external (url)
			end
		end

	frozen kCGRenderingIntentDefault: INTEGER
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"kCGRenderingIntentDefault"
		end

	frozen NULL: POINTER
		external
			"C [macro <stdio.h>]"
		alias
			"NULL"
		end

--
end
