note
	description: "[
			Objects that provide access to constants loaded from files.
			Perform and desired constant redefinitions in this class.
			Note that if you are loading constants from a file and wish to
			change the location of the file, redefine `initialize_constants' in this
			class to load from the desired location.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSTANTS

inherit
	CONSTANTS_IMP
	
end
