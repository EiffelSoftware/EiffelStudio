indexing
	description: "A picture color button wihtout border.";
	date: "$Date$";
	revision: "$Revision$"

class
	NO_BORDER_PICT_COLOR_B

inherit
	PICT_COLOR_B
		redefine
			create_ev_widget
		end

creation
	make, make_unmanaged

feature

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a draw button with `a_name' as identifier
			-- and `a_parent' as parent.
		local
			windows_b: NO_BORDER_PICT_COLOR_B_IMP
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			!! windows_b.make (Current, man, a_parent);
			implementation := windows_b;
			implementation.set_widget_default;
			set_default
		end

end -- class NO_BORDER_PICT_COLOR_B
