indexing

	description: "This class represents a MS_IMPone-line text editor for entering a password"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	PASSWORD_IMP

inherit
	PASSWORD_I

	TEXT_FIELD_IMP
		redefine
			default_style
		select
			default_style
		end

	TEXT_FIELD_IMP
		rename
			default_style as text_field_default_style
		end
create
	make

feature
	default_style: INTEGER is
		once
			Result := text_field_default_style + Es_password
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class PASSWORD_IMP

