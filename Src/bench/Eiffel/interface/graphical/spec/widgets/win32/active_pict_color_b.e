indexing
	description: "A picture color button whose borders are drawn %
				% when the mouse pointer enter the button.";
	date: "$Date$";
	revision: "$Revision$"

class
	ACTIVE_PICT_COLOR_B

inherit
	PICT_COLOR_B
		redefine
			create_ev_widget, implementation
		end

creation
	make, make_unmanaged

feature

	create_ev_widget (a_name: STRING;  a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a draw button with `a_name' as identifier
			-- and `a_parent' as parent.
		do
			depth := a_parent.depth + 1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			create implementation.make (Current, a_parent, man);
			implementation.set_widget_default;
			set_active (True)
			set_default
		end

feature -- Status

	active: BOOLEAN is
			-- Is button active? 
			--| False means it will be like a PICT_COLOR_B
		do
			Result := implementation.active
		end

feature -- Update

	set_active (flag: BOOLEAN) is
			-- Set `active' to `flag'.
			--| True means that the button will react to the mouse_enter
			--| and mouse_leave events. False means it will behave like
			--| a PICT_COLOR_B.
		do
			implementation.set_active (flag)
		end

feature {NONE} -- Implementation

	implementation: ACTIVE_PICT_COLOR_B_IMP
		-- Implementation class

end -- class ACTIVE_BORDER_PICT_COLOR_B
