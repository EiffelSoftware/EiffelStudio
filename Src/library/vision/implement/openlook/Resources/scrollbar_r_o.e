--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Scrollbar defines

indexing

        date: "$Date$";
        revision: "$Revision$"

class  SCROLLBAR_R_O

        
feature {NONE}

        OpageIncrement: STRING is "proportionLength";
                        -- Name of openlook resource

        OinitialDelay: STRING is "initialDelay";
                        -- Name of openlook resource

        OrepeatDelay: STRING is "repeatRate";
                        -- Name of openlook resource

end 
