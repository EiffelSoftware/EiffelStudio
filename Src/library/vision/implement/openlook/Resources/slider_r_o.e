--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Slider defines (Scrollbar and Scale)

indexing

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
