indexing

	description: "General message box implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

deferred class OBSOLETE_TOOLKIT

inherit

	TOOLKIT
	
feature -- Access

	io_handler (an_io_handler: IO_HANDLER): IO_HANDLER_I is
			-- Toolkit implementation of `an_io_handler'
		deferred
		ensure
			handler_exists: Result /= Void
		end;

	label_g (a_label_gadget: LABEL; managed: BOOLEAN;
		oui_parent: COMPOSITE): LABEL_G_I is
			-- Toolkit implementation of `a_label_gadget'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	prompt (a_prompt: PROMPT; managed: BOOLEAN;
		oui_parent: COMPOSITE): PROMPT_I is
			-- Toolkit implementation of `a_prompt'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	scroll_list (a_list: SCROLL_LIST; managed, is_fixed: BOOLEAN;
		oui_parent: COMPOSITE): SCROLL_L_I is
			-- Toolkit implementation of `a_list'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	toggle_bg (a_toggle_b_gadget: TOGGLE_BG; managed: BOOLEAN;
		oui_parent: COMPOSITE): TOGGLE_BG_I is
			-- Toolkit implementation of `a_toggle_b_gadget'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	push_bg (a_push_b_gadget: PUSH_BG; managed: BOOLEAN;
		oui_parent: COMPOSITE): PUSH_BG_I is
			-- Toolkit implementation of `a_push_b_gadget'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	separator_g (a_separator_gadget: SEPARATOR_G; managed: BOOLEAN;
		oui_parent: COMPOSITE): SEPARATO_G_I is
			-- Toolkit implementation of `a_separator_gadget'
		deferred
		ensure
			widget_exists: Result /= Void
		end;

	message (a_message: MESSAGE; managed: BOOLEAN;
		oui_parent: COMPOSITE): MESSAGE_I is
			-- Toolkit implementation of `a_message'
		deferred
		ensure
			widget_exists: Result /= Void
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




end -- class OBSOLETE_TOOLKIT

