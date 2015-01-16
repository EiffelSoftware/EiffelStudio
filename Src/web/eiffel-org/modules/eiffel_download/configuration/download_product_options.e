note
	description: "Summary description for {DOWNLOAD_PRODUCT_OPTIONS}."
	date: "$Date$"
	revision: "$Revision$"

class
	DOWNLOAD_PRODUCT_OPTIONS

feature -- Access

	key: detachable READABLE_STRING_32
			-- Associated key

	md5: detachable READABLE_STRING_32
			-- Associated md5.

	size: INTEGER_64
			-- Product size.

	filename: detachable READABLE_STRING_32
			-- Product filename.

	platform: detachable READABLE_STRING_32
			-- Product platform.

feature -- Element change

	set_key (a_key: like key)
			-- Assign `key' with `a_key'.
		do
			key := a_key
		ensure
			key_assigned: key = a_key
		end

	set_md5 (a_md5: like md5)
			-- Assign `md5' with `a_md5'.
		do
			md5 := a_md5
		ensure
			md5_assigned: md5 = a_md5
		end

	set_size (a_size: like size)
			-- Assign `size' with `a_size'.
		do
			size := a_size
		ensure
			size_assigned: size = a_size
		end

	set_filename (a_filename: like filename)
			-- Assign `filename' with `a_filename'.
		do
			filename := a_filename
		ensure
			filename_assigned: filename = a_filename
		end

	set_platform (a_platform: like platform)
			-- Assign `platform' with `a_platform'.
		do
			platform := a_platform
		ensure
			platform_assigned: platform = a_platform
		end

end
