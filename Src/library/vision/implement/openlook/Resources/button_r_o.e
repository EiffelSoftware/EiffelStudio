--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Buttons defines

indexing

		date: "$Date$";
		revision: "$Revision$"

class  BUTTON_R_O

feature {NONE}

	OfontList: STRING is "font";
				-- Name of openlook resource

	OlabelString: STRING is "label";
				-- Name of openlook resource

	OrecomputeSize: STRING is "recomputeSize";
				-- Name of openlook resource

	OlabelJustify: STRING is "labelJustify";
				-- Name of openlook resource

	OL_LEFT: INTEGER is 35;
				-- OpenLook constant value
 
	OL_CENTER: INTEGER is 7;
				-- OpenLook constant value
 
end 
