indexing

	description: "Label defines";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class  LABEL_R_O
        
feature {NONE}

        Oalignment: STRING is "alignment";
                        -- Name of openlook resource

        OfontList: STRING is "font";
                        -- Name of openlook resource

        OlabelString: STRING is "string";
                        -- Name of openlook resource

        OrecomputeSize: STRING is "recomputeSize";
                        -- Name of openlook resource

        OL_LEFT: INTEGER is 35;
                        -- OpenLook constant value

        OL_CENTER: INTEGER is 7;
                        -- OpenLook constant value

        OL_RIGHT: INTEGER is 58;
                        -- openlook constant value

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
