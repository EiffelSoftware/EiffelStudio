note
	description: "Child window without a background brush"
	author: "Robin van Ommeren"
	date: "$Date$"
	revision: "$Revision$"

class
	WEX_CONTROL_WINDOW_NO_BACKGROUND

inherit
	WEL_CONTROL_WINDOW
		redefine
			class_name,
			class_background
		end

create
	make

feature {NONE} -- Implementation

	class_name: STRING_32
		once
			Result := "ControlWindowNoBackgroundWEX"
		end

	class_background: WEL_NULL_BRUSH
		once
			create Result.make
		end

end -- class WEX_CONTROL_WINDOW_NO_BACKGROUND

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
