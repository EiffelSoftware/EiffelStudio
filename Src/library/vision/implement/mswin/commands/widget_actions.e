indexing 

	description: "This class represents a MS_WINDOWS event handler for a widget and a command";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 

class
	WIDGET_ACTIONS

inherit
	EVENT_HDL

creation
	make

feature {NONE} -- Implementation

	make (w: WIDGET_IMP) is
		require
			w_exists: w /= Void
		do
			widget := w
			!! actions.make
		ensure
			widget_set: widget = w
		end

feature -- Access

	actions: LINKED_LIST [ACTION_WINDOWS]
			-- Actions to be performed

	exact_checking: BOOLEAN
			-- Is there a translation that must match exactly?

	translations: LINKED_LIST [TRANSLATION_COMMAND]
			-- Translation commands for this widget

	widget: WIDGET_IMP
			-- Widget for actions to be performed on

feature -- Element change

	put (a: ACTION_WINDOWS) is
			-- Add an action
		require
			a_exists: a /= Void
		local
			tr: TRANSLATION_COMMAND
		do
			actions.extend (a)
			tr ?= a.command
			if tr /= Void then
				if translations = Void then
					!! translations.make
				end
				translations.extend (tr)
				exact_checking := exact_checking or tr.exact
			end
		end

	execute (cd: CONTEXT_DATA) is
			-- Execute the actions
		local
			acts: LINKED_LIST [ACTION_WINDOWS]
			action: ACTION_WINDOWS
			action_command: COMMAND
		do
			if exact_checking then
				reset_translations
				find_matching_translation (cd)
			end
			from
				acts := actions
				acts.start
			until
				acts.after
			loop
				action := acts.item
				action_command := action.command
				if action_command.context_data_useful then
					action_command.set_context_data (clone(cd))
				end
				action_command.execute (action.argument)
				if not acts.after then
					acts.forth
				end
			end
			if translations /= Void and then not translations.is_empty then
				translations.first.set_no_execute_now
			end
		end

	reset_translations is
			-- Reset translation execution status
		local
			translation_list: LINKED_LIST [TRANSLATION_COMMAND]
		do
			from
				translation_list := translations
				translation_list.start
			until
				translation_list.off
			loop
				translation_list.item.set_no_execute_now
				translation_list.forth
			end
		end


	find_matching_translation (cd: CONTEXT_DATA) is
		local
			trans: TRANSLATION_COMMAND
			translation_list: LINKED_LIST [TRANSLATION_COMMAND]
		do
			from
				translation_list := translations
				translation_list.start
			until
				translation_list.after or else translation_list.item.exact_to_execute
			loop
				trans := translation_list.item
				trans.set_context_data (cd) 
				if trans.exact and then trans.conditions_met then
					debug ("ACTION")
						io.error.putstring ("Found one! ")
						io.error.putstring (trans.out)
					end
					trans.set_exact_to_execute
					debug ("ACTION")
						io.error.putstring ("set exact to execute translation%N")
					end
				else
					translation_list.forth
				end
			end
			debug ("ACTION")
				io.error.putstring ("At end of find matching trans ")
				if not translation_list.off then
					io.error.putstring (translation_list.item.translation)
				else
					io.error.putstring ("No match found")
				end
				io.error.new_line
			end
		end

	remove (c: COMMAND; arg: ANY) is
			-- Remove command `c' and `arg' on `widget'
		local
			act: LINKED_LIST [ACTION_WINDOWS]
			tr: TRANSLATION_COMMAND
		do
			act := actions
			from
				act.start
			variant
				act.count + 1 - act.index
			until
				act.after
			loop
				if (act.item.command = c) and then
					equal (arg, act.item.argument) then
					act.remove
				end
				if not act.after then
					act.forth
				end
			end
			act.start
			tr ?= c
			if tr /= Void then
				translations.prune_all (tr)
				if exact_checking then
					from
						translations.start
						exact_checking := false
					until
						exact_checking or translations.after
					loop
						exact_checking := translations.item.exact
						translations.forth
					end
				end
			end
		end	

invariant

	widget_exists: widget /= Void
	actions_exist: actions /= Void

end -- WIDGET_ACTIONS
 
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

