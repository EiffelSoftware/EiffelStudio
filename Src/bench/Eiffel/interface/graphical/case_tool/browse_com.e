indexing
	description: "Allow navigation for generating a CASEGEN"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	BROWSE_COM

inherit
	CASE_COMMAND2
		
creation
	make

feature -- Attributes

	file_s : FILE_SEL_D

feature -- execute

	execute ( a : ANY ) is
		require
			case_w_exists : case_window/= Void
		local
			ok_browse : OK_BROWSE
		do	
			!! file_s.make ("Casegen path : browsing", case_window)
			file_s.set_directory_selection
			!! ok_browse.make (case_window, file_s )
			file_s.add_ok_action ( ok_browse, Void )
		end


end -- class BROWSE_COM
