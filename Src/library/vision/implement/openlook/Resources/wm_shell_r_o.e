indexing

	description: "Window manager shell defines";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class  WM_SHELL_R_O
		
feature {NONE}

        OiconPixmap: STRING is "iconPixmap";
						-- Name of openlook resource

		OiconWindow: STRING is "iconWindow";
						-- Name of openlook resource

		OiconMask: STRING is "iconMask";
						-- Name of openlook resource

		OwindowGroup: STRING is "windowGroup";
						-- Name of openlook resource

		Otransient: STRING is "transient";
						-- Name of openlook resource

		Otitle: STRING is "title";
						-- Name of openlook resource

		OiconX: STRING is "iconX";
						-- Name of openlook resource

		OiconY: STRING is "iconY";
						-- Name of openlook resource

		Oinput: STRING is "input";
						-- Name of openlook resource

		OminWidth: STRING is "minWidth";
						-- Name of openlook resource

		OminHeight: STRING is "minHeight";
						-- Name of openlook resource

		OmaxWidth: STRING is "maxWidth";
						-- Name of openlook resource

		OmaxHeight: STRING is "maxHeight";
						-- Name of openlook resource

		OwidthInc: STRING is "widthInc";
						-- Name of openlook resource

		OheightInc: STRING is "heightInc";
						-- Name of openlook resource

		OminAspectY: STRING is "minAspectY";
						-- Name of openlook resource

		OmaxAspectY: STRING is "maxAspectY";
						-- Name of openlook resource

		OminAspectX: STRING is "minAspectX";
						-- Name of openlook resource

		OmaxAspectX: STRING is "maxAspectX";
						-- Name of openlook resource

		OwmTimeout: STRING is "wmTimeout";
						-- Name of openlook resource

		OwaitForWm: STRING is "waitforwm";
						-- Name of openlook resource

	ObaseHeight: STRING is "baseHeight";
			-- Name of openlook resource
			-- From new release 4

	ObaseWidth: STRING is "baseWidth";
			-- Name of openlook resource
			-- From new release 4

	OtitleEncoding: STRING is "titleEncoding";
			-- Name of openlook resource
			-- From new release 4
	OwinGravity: STRING is "winGravity";
			-- Name of openlook resource
			-- From new release 4

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
