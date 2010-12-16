note
	description: "[
					Class to give the user a chance to redefine the optional methods
					implemented by delegates os NSApplication objects.
				  ]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_DELEGATE

inherit
	NS_OBJECT
		redefine
			make
		end

	NS_APPLICATION_DELEGATE_PROTOCOL

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
				-- Add Objective-C callbacks here.
			--add_objc_callback ("aSelector:", agent an_eiffel_routine)
			Precursor
		end

feature -- NS_APPLICATION_DELEGATE_PROTOCOL



end
