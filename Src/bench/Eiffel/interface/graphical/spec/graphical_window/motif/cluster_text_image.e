indexing

	description: 
		"Graphical text representing normal formatted text.";
	date: "$Date$";
	revision: "$Revision $"

class CLUSTER_TEXT_IMAGE

inherit

	TEXT_FIGURE
		redefine
			stone
		end

feature -- Access

	stone: STONE
			-- Associated stone

	font (values: GRAPHICAL_VALUES): FONT is
			-- Font to be used for text
		do
			Result := values.cluster_font
		end;

	foreground_color (values: GRAPHICAL_VALUES): COLOR is
			-- Foreground color
		do
			Result := values.cluster_color
		end;

end -- class CLUSTER_TEXT_IMAGE
