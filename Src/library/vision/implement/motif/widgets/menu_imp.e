indexing

	description: 
		"EiffelVision implementation of menu.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	MENU_IMP

inherit

	MANAGER_IMP

feature -- Access

	children_has_accelerators: BOOLEAN is
			-- Can children have accelerators
			-- (Default is True)
		do
			Result := True
		end;

feature -- Status report

	title: STRING is
			-- Title of current menu
		do
			if title_label /= Void then
				Result := title_label.label_as_string
			end
		end;

feature -- Status setting

	set_title (a_title: STRING) is
			-- Set menu title to `a_title'.
		require
			not_title_void: a_title /= Void
		local
			label_identifier: STRING;
			m_p: MEL_COMPOSITE
		do
			if title_label = Void then
				label_identifier := clone (abstract_menu.identifier);
				label_identifier.append (" Title");
				m_p ?= abstract_menu.implementation;
				!! title_label.make (label_identifier, m_p, True);
			end;
			title_label.set_label_as_string (a_title)
		end;

	remove_title is
			-- Remove current menu title if any.
		do
			if title_label /= Void then
				title_label.destroy
				title_label := Void;
			end
		end;

feature {NONE} -- Implementation

	abstract_menu: MENU;
			-- Current abstract menu

	title_label: MEL_LABEL_GADGET;
			-- Title label

end -- class MENU_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

