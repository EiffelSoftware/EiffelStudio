indexing
 
	description:
		"A String resource with an edit field.";
	date: "$Date$";
	revision: "$Revision$"
 
class COLOR_PREF_RES
 
inherit
	STRING_PREF_RES
		redefine
			associated_resource
		end

creation
	make

feature {NONE} -- Properties
 
	associated_resource: COLOR_RESOURCE;
			-- Resource Current represnts

end -- class COLOR_PREF_RES
		
