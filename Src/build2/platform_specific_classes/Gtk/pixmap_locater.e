indexing
	description: "Objects that query the registry to return %
		%the location to the pixmap files when launched by VisualStudio. %
		%This is the Gtk version, and hence does nothing. It is included as %
		%otherwise Build would not compile."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PIXMAP_LOCATER

feature -- Access

	pixmap_path: STRING is
			-- Path to pixmap location when launched
			-- from VisualStudio. As this is the Gtk
			-- file, it should never be executed.
		do
			check
				never_called: False
			end
		end
		
end -- class PIXMAP_LOCATER
