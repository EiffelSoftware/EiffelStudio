indexing
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ECASE_MS_WINDOWS

inherit
	TOOLKIT_IMP
		redefine
			message_loop
		end

	OBSOLETE_TOOLKIT

--	WINDOWS

creation
	make

feature

	message_loop is
			-- Windows message loop
		local
			msg: WEL_MSG
			accel: WEL_ACCELERATORS
			main_w: WEL_WINDOW
			current_window: WEL_WINDOW
			wel_window_manager: WEL_WINDOW_MANAGER
			done: BOOLEAN
			dlg: POINTER
			hwnd: POINTER
		do
			from
				accel := accelerators
				main_w := application_main_window
				!! msg.make
				!! wel_window_manager
			until
				done
			loop
				msg.peek_all
				if msg.last_boolean_result then
					if msg.quit then
						done := True
					else
						hwnd := msg.hwnd
						current_window := wel_window_manager.windows.item (hwnd)
						if current_window /= Void then
							hwnd := find_top_parent (current_window).item
						else
							hwnd := main_window.wel_item
						end
						dlg := cwin_get_last_active_popup (hwnd)
						if dlg /= hwnd or is_dialog then
							msg.process_dialog_message (dlg)
							if not msg.last_boolean_result then
								msg.translate
								msg.dispatch
							end
						else
							if accel.exists then
								hwnd := msg.hwnd
								current_window := wel_window_manager.windows.item (hwnd)
								if current_window /= Void then
									msg.translate_accelerator (find_top_parent (current_window), accel)
								else
									msg.translate_accelerator (main_w, accel)
								end
							end
							if
								not msg.last_boolean_result or else
								not accel.exists
							then
								msg.translate
								msg.dispatch
							end
						end
					end
				else
					if idle_action_enabled then
						idle_action
					else
						msg.wait
					end
				end
			end
		end


feature {NONE}

	find_top_parent (a_window: WEL_WINDOW): WEL_WINDOW is
		require
			a_window_not_void: a_window /= Void
		local
			parent: WEL_WINDOW
		do
			from
				Result := a_window
				parent := Result.parent
			until
				parent = Void
			loop
				parent := Result.parent
				if parent /= Void then
					Result := parent
				end
			end
		end

feature -- Implementation

	io_handler (an_io_handler: IO_HANDLER): IO_HANDLER_I is
			-- Toolkit implementation of `an_io_handler'
		do
		end;

	label_g (a_label_gadget: LABEL; managed: BOOLEAN;
		oui_parent: COMPOSITE): LABEL_G_I is
			-- Toolkit implementation of `a_label_gadget'
		do
		end;

	prompt (a_prompt: PROMPT; managed: BOOLEAN;
		oui_parent: COMPOSITE): PROMPT_I is
			-- Toolkit implementation of `a_prompt'
		do
		end;

--	scroll_list (a_list: SCROLL_LIST; managed, is_fixed: BOOLEAN;
--		oui_parent: COMPOSITE): SCROLL_L_I is
--			-- Toolkit implementation of `a_list'
--		deferred
--		ensure
--			widget_exists: Result /= Void
--		end;

	toggle_bg (a_toggle_b_gadget: TOGGLE_BG; managed: BOOLEAN;
		oui_parent: COMPOSITE): TOGGLE_BG_I is
			-- Toolkit implementation of `a_toggle_b_gadget'
		do
		end;

	push_bg (a_push_b_gadget: PUSH_BG; managed: BOOLEAN;
		oui_parent: COMPOSITE): PUSH_BG_I is
			-- Toolkit implementation of `a_push_b_gadget'
		do
		end;

	separator_g (a_separator_gadget: SEPARATOR_G; managed: BOOLEAN;
		oui_parent: COMPOSITE): SEPARATO_G_I is
			-- Toolkit implementation of `a_separator_gadget'
		do
		end;

	message (a_message: MESSAGE; managed: BOOLEAN;
		oui_parent: COMPOSITE): MESSAGE_I is
			-- Toolkit implementation of `a_message'
		do
		end;

feature -- modifications 09/97, add functions of class OBSOLETE_MS_WINDOWS

	scroll_list (a_list: SCROLL_LIST; managed, is_fixed: BOOLEAN; 
			oui_parent: COMPOSITE): SCROLL_LIST_WINDOWS is
			-- Ms Windows implementation of `a_list'
		do
			!! Result.make (a_list, managed, is_fixed, oui_parent)
		end;

end -- class ECASE_MS_WINDOWS

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
