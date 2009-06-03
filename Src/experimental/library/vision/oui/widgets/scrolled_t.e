note
	description: "Text in Scrolled Window"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SCROLLED_T

inherit
	TEXT
		redefine
			make, make_word_wrapped, make_unmanaged,
			make_word_wrapped_unmanaged,
			create_ev_widget, create_ev_widget_ww,
			implementation
		end

create

	make, make_word_wrapped, make_unmanaged, make_word_wrapped_unmanaged

feature {NONE} -- Initialization

	make (a_name: STRING a_parent: COMPOSITE)
			-- Create a scrolled text with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, True)
		end

	make_unmanaged (a_name: STRING a_parent: COMPOSITE)
			-- Create an unmanaged scrolled text with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, False)
		end

	create_ev_widget (a_name: STRING a_parent: COMPOSITE; man: BOOLEAN)
			-- Create a scrolled text with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1
			widget_manager.new (Current, a_parent)
			if a_name /= Void then
				identifier := a_name.twin
			else
				identifier := Void
			end
			create {SCROLLED_T_IMP} implementation.make (Current, man, a_parent)
			implementation.set_widget_default
			set_default
		end

	make_word_wrapped (a_name: STRING a_parent: COMPOSITE)
			-- Create a scrolled text with `a_name' as identifier,
			-- `a_parent' as parent, enable word wrap and then
			-- call `set_default'.
		do
			create_ev_widget_ww (a_name, a_parent, True)
		end

	make_word_wrapped_unmanaged (a_name: STRING a_parent: COMPOSITE)
			-- Create an unmanaged scrolled text with `a_name' as identifier,
			-- `a_parent' as parent, enable word wrap and then
			-- call `set_default'.
		do
			create_ev_widget_ww (a_name, a_parent, False)
		end

	create_ev_widget_ww (a_name: STRING a_parent: COMPOSITE; man: BOOLEAN)
			-- Create a scrolled text with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1
			widget_manager.new (Current, a_parent)
			if a_name /= Void then
				identifier := a_name.twin
			else
				identifier := Void
			end
			create {SCROLLED_T_IMP} implementation.make_word_wrapped (Current, man, a_parent)
			set_default
		end

feature -- Status report

	is_vertical_scrollbar: BOOLEAN
			-- Is vertical scrollbar visible?
		require
			exists: not destroyed
		do
			Result := implementation.is_vertical_scrollbar
		end

	is_horizontal_scrollbar: BOOLEAN
			-- Is horizontal scrollbar visible?
		require
			exists: not destroyed
		do
			Result := implementation.is_horizontal_scrollbar
		end

	tab_length: INTEGER
			-- Size of a tabulation.
		do
			Result := implementation.tab_length
		end

feature -- Status setting

	show_vertical_scrollbar
			-- Make vertical scrollbar visible.
		require
			exists: not destroyed
		do
			implementation.show_vertical_scrollbar
		end

	hide_vertical_scrollbar
			-- Make vertical scrollbar invisible.
		require
			exists: not destroyed
		do
			implementation.hide_vertical_scrollbar
		end

	show_horizontal_scrollbar
			-- Make horizontal scrollbar visible.
		require
			exists: not destroyed
		do
			implementation.show_horizontal_scrollbar
		end

	hide_horizontal_scrollbar
			-- Make horizontal scrollbar invisible.
		require
			exists: not destroyed
		do
			implementation.hide_horizontal_scrollbar
		end

	set_tab_length (new_length: INTEGER)
			-- Set `tab_length' to `new_length'.
		require
			valid_new_length: new_length > 1
		do
			implementation.set_tab_length (new_length)
		ensure
			set: tab_length = new_length
		end

feature -- Implementation

	implementation: SCROLLED_T_I;
			-- Implementation of current text

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SCROLLED_T

