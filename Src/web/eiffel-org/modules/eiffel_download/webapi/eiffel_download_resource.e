note
	description: "Summary description for {EIFFEL_DOWNLOAD_RESOURCE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_DOWNLOAD_RESOURCE

create
	make

feature {NONE} -- Initialization

	make (a_filename: READABLE_STRING_32; a_href: READABLE_STRING_8; a_size: INTEGER_64; a_platform: READABLE_STRING_32)
			-- Create an instance.
			-- Set filename with 'a_filename'.
			-- Set href with 'a_href'.
		do
			filename := a_filename
			href := a_href
			size := a_size
			platform := a_platform
		ensure
			filename_set: filename = a_filename
			href_set: href = a_href
			size_set: size = a_size
			platform_set: platform = a_platform
		end

feature -- Access

	filename: READABLE_STRING_32
			-- Product filename.

	href: READABLE_STRING_8
			-- Download link.

	size: INTEGER_64
			-- file size

	platform: READABLE_STRING_32
			-- target platform.

end
