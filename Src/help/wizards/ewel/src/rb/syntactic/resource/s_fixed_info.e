indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Fixed_info -> File_version Product_version File_flags_mask File_flags File_OS
--		 File_type File_subtype

class S_FIXED_INFO

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "FIXED_INFO"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			file_version: FILE_VERSION
			product_version: PRODUCT_VERSION
			file_flags_mask: FILE_FLAGS_MASK
			file_flags: FILE_FLAGS
			fileOS :FILE_OS
                        file_type: FILE_TYPE
			file_subtype: FILE_SUBTYPE
		once
			!! Result.make
			Result.forth

			!! file_version.make
			put (file_version)

			!! product_version.make
			put (product_version)

			!! file_flags_mask.make
			put (file_flags_mask)
			
			!! file_flags.make
			put (file_flags)
			file_flags.set_optional

			!! fileOS.make
			put (fileOS)

			!! file_type.make
			put (file_type)

			!! file_subtype.make
			put (file_subtype)
			file_subtype.set_optional
		end

end -- class S_FIXED_INFO

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
