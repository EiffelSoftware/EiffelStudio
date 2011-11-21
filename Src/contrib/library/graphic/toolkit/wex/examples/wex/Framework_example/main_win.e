note
	description: "WEX Framework Example Main Window"
	status: "See notice at end of class."
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"


class
	MAIN_WINDOW

inherit
	WEX_MAIN_WINDOW
		redefine
			command_cmd
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

feature {NONE} -- Implementation

feature {COMMAND_CMD}
		
	command_cmd: CUSTOM_COMMAND_CMD
			-- redefine this feature to customize menu and toolbar commands
		once 
			create Result
		end

end -- class MAIN_WINDOW
--|-------------------------------------------------------------------------
--| WEX, Windows Eiffel library eXtension
--| Copyright (C) 1998  Robin van Ommeren, Andreas Leitner
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Robin van Ommeren						Andreas Leitner
--| Eikenlaan 54M								Arndtgasse 1/3/5
--| 7151 WT Eibergen							8010 Graz
--| The Netherlands							Austria
--| email: robin.van.ommeren@wxs.nl		email: andreas.leitner@teleweb.at
--| web: http://home.wxs.nl/~rommeren	web: about:blank
--|-------------------------------------------------------------------------