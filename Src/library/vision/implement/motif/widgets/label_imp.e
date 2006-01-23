indexing

	description: 
		"EiffelVision implementation of Motif label."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	LABEL_IMP

inherit

	LABEL_I;

	PRIMITIVE_IMP
		rename
			is_shown as shown
		undefine
			shown
		end;

	FONTABLE_IMP;

	BUTTON_IMP
		redefine
			is_label
		end

create

	make

feature {NONE} -- Initialization

	make (a_label: LABEL; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif label.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			mel_label_make (a_label.identifier, mc, man);
			a_label.set_font_imp (Current)
		end;

feature -- Access

	is_label: BOOLEAN is
			-- Is current button a label?
			-- (False by default)
		do
			Result := True
		end;

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




end -- class LABEL_IMP

