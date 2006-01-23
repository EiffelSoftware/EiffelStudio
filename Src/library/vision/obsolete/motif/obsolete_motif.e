indexing

	description: 
		"Toolkit instantiation of obsolete classes."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class OBSOLETE_MOTIF 

inherit

	MOTIF;
	OBSOLETE_TOOLKIT
	
create
	make

feature -- Access

	io_handler (an_io_handler: IO_HANDLER): IO_HANDLER_X is
			-- Motif implementation of `an_io_handler'
		do
			create Result
		end;

	label_g (a_label_gadget: LABEL_G; managed: BOOLEAN; 
		oui_parent: COMPOSITE): LABEL_G_M is
			-- Motif implementation of `a_label_gadget'
		do
			create Result.make (a_label_gadget, managed, oui_parent)
		end;

	prompt (a_prompt: PROMPT; managed: BOOLEAN; oui_parent: COMPOSITE): PROMPT_M is
			-- Motif implementation of `a_prompt'
		do
			create Result.make (a_prompt, managed, oui_parent)
		end;

	scroll_list (a_list: SCROLL_LIST; managed, is_fixed: BOOLEAN; 
			oui_parent: COMPOSITE): SCROLL_L_M is
			-- Motif implementation of `a_list'
		do
			create Result.make (a_list, managed, is_fixed, oui_parent)
		end;

	toggle_bg (a_toggle_b_gadget: TOGGLE_BG; managed: BOOLEAN; 
		oui_parent: COMPOSITE): TOGGLE_BG_M is
			-- Motif implementation of `a_toggle_b_gadget'
		do
			create Result.make (a_toggle_b_gadget, managed, oui_parent)
		end;

	push_bg (a_push_b_gadget: PUSH_BG; managed: BOOLEAN; 
		oui_parent: COMPOSITE): PUSH_BG_M is
			-- Motif implementation of `a_push_b_gadget'
		do
			create Result.make (a_push_b_gadget, managed, oui_parent)
		end;

	separator_g (a_separator_gadget: SEPARATOR_G; managed: BOOLEAN; 
		oui_parent: COMPOSITE): SEPARATO_G_M is
			-- Motif implementation of `a_separator_gadget'
		do
			create Result.make (a_separator_gadget, managed, oui_parent)
		end;

	message (a_message: MESSAGE; managed: BOOLEAN;
		oui_parent: COMPOSITE): MESSAGE_M is
			-- Motif implementation of `a_message'
		do
			create Result.make (a_message, managed, oui_parent)
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




end -- class OBSOLETE_MOTIF

