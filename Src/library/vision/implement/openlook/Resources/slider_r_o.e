
-- Slider defines (Scrollbar and Scale)

indexing

	status: "See notice at end of class";
        date: "$Date$";
        revision: "$Revision$"

class  SLIDER_R_O

        
feature {NONE}

	Odrag: STRING is "sliderMoved";
                        -- Name of openlook resource

        Ominimum: STRING is "sliderMin";
                        -- Name of openlook resource

        Omaximum: STRING is "sliderMax";
                        -- Name of openlook resource

        Oorientation: STRING is "orientation";
                        -- Name of openlook resource

        Ogranularity: STRING is "granularity";
                        -- Name of openlook resource

        Ovalue: STRING is "sliderValue";
                        -- Name of openlook resource

        OfontList: STRING is "";
                        -- No equivalent ressource in openlook

        OVERTICAL: INTEGER is 70;
                        -- OpenLook constant value

        OHORIZONTAL: INTEGER is 30;
                        -- OpenLook constant value

		OminLabel: STRING is "minLabel"

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
