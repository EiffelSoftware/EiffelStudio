--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Toggle button defines

indexing

        date: "$Date$";
        revision: "$Revision$"

class  TOGGLE_R_O



        
feature {NONE}

        Oarm: STRING is "select";
                        -- Name of openlook resource

        Odisarm: STRING is "unselect";
                        -- Name of openlook resource

        Oset: STRING is "set";
                        -- Name of openlook resource

end 
