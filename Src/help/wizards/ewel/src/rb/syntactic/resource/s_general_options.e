indexing
	description: "xxx"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- General_options -> Characteristics_option | Language_option | Version_option

class S_GENERAL_OPTIONS 

inherit
	RB_CHOICE

feature 

	construct_name: STRING is
		once
			Result := "GENERAL_OPTIONS"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			characteristics: CHARACTERISTICS_OPTION
			language: LANGUAGE_OPTION
			version: VERSION_OPTION
		once
			!! Result.make
			Result.forth

			!! characteristics.make
			put (characteristics)

			!! language.make
			put (language)

			!! version.make
			put (version)
		end

end -- class S_GENERAL_OPTIONS

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
