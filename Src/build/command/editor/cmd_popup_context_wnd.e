indexing
	description: "Choice window to edit a context correspoding to %
				% the current instance."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	CMD_POPUP_CONTEXT_WND

inherit

	CHOICE_WND
		redefine
			continue_after_popdown
		end

creation

	make

feature
	
	data_list: LINKED_LIST [EDITABLE]

	popup_with_list (l: LINKED_LIST [EDITABLE]) is
		require
			valid_list: l /= Void 
		local
			string_list: LINKED_LIST [STRING]
			ed: EDITABLE
		do
			!! string_list.make
			data_list := l
			from
				l.start
			until
				l.after
			loop
				ed := l.item
				string_list.extend (ed.label)
				l.forth
			end
			if not l.empty then
				string_list.extend (" Edit all")
			end
			popup (string_list)
		end

	continue_after_popdown is
		local
			editable: EDITABLE 
		do
			if position = data_list.count + 1 then
						--| Selected edit all
				from
					data_list.start
				until
					data_list.after
				loop
					editable := data_list.item
					editable.create_editor
					data_list.forth
				end
			else	
				editable := data_list.i_th (position - 1)
				editable.create_editor
			end
			data_list := Void
		end

end -- class CMD_POPUP_CONTEXT_WND
