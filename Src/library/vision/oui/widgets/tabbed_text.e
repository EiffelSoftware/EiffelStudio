indexing

	description: "Text in Scrolled Window which can have tabs set";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class TABBED_TEXT

inherit

	SCROLLED_T
		redefine
			create_ev_widget, create_ev_widget_ww,
			implementation
		end

creation

	make, make_word_wrapped, make_unmanaged, make_word_wrapped_unmanaged
	
feature {NONE} -- Creation

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

	tab_positions: ARRAY [INTEGER]
			-- Positions of tabs.

feature -- Status setting

	set_no_tabs is
			-- Turn of tabulation.
		do
			implementation.set_no_tabs
		end
	
	set_tab_position (tab_position: INTEGER) is
			-- Set tabs at every `tab_position'.
		require
			valid_tab_position: tab_position > 1
		do
			implementation.set_tab_position (tab_position)
		ensure
			tab_position_set: tab_positions.item (1) = tab_position
		end

	set_tab_positions (tab_position_array: ARRAY [INTEGER]) is
			-- Set tabs at positions specified in `tab_position_array'.
		require
			tab_position_array_exists: tab_position_array /= Void
			tab_position_array_filled: not tab_position_array.empty
		do
			implementation.set_tab_positions (tab_position_array)
		ensure
			tabs_set: tab_positions.is_equal (tab_position_array)
		end

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: TABBED_TEXT_I
			-- Implementation of current text

end -- class TABBED_TEXT


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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
