indexing

	description: "This class represents a MS_WINDOWS one-line text editor for entering a password";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	PASSWORD_WINDOWS

inherit
	PASSWORD_I

	TEXT_FIELD_WINDOWS
		redefine
			default_style
		select
			default_style
		end

	TEXT_FIELD_WINDOWS
		rename
			default_style as text_field_default_style
		end
creation
	make

feature
	default_style: INTEGER is
		once
			Result := text_field_default_style + Es_password
		end

end -- class PASSWORD_WINDOWS
