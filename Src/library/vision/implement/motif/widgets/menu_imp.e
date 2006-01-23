indexing

	description: 
		"EiffelVision implementation of menu."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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
				create title_label.make (label_identifier, m_p, True);
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

	title_label: MEL_LABEL_GADGET;;
			-- Title label

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MENU_IMP

