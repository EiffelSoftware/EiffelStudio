indexing
	description: "Text in Scrolled Window which can have tabs set";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	TABBED_TEXT

inherit
	SCROLLED_T
		redefine
			create_ev_widget, create_ev_widget_ww,
			implementation
		end

creation

	make, make_word_wrapped, make_unmanaged, make_word_wrapped_unmanaged
	
feature {NONE} -- Initialization

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a scrolled text with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			implementation := toolkit.tabbed_text (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

	create_ev_widget_ww (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a scrolled text with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth + 1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			implementation := toolkit.tabbed_text_word_wrapped (Current, man, a_parent);
			set_default
		end

feature -- Status report

	tab_length: INTEGER is
			-- Size for each tabulation
		do
			Result := implementation.tab_length
		ensure
			result_greater_than_one: Result > 1
		end
	
feature -- Status setting

	set_tab_length (new_length: INTEGER) is
			-- Set `tab_length' to `new_length'.
		require
			length_greater_than_one: new_length > 1
		do
			implementation.set_tab_length (new_length)
		ensure
			set: tab_length = new_length
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: TABBED_TEXT_I
			-- Implementation of current text

end -- class TABBED_TEXT


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

