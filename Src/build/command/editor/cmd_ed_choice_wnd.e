class CMD_ED_CHOICE_WND

inherit

	CHOICE_WND
		redefine
			continue_after_popdown
		end

creation

	make

feature

	data_list: LINKED_LIST [EDITABLE];

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
				ed := l.item;
				string_list.extend (ed.label)
				l.forth
			end;
			if not l.empty then
				string_list.extend (" Edit all ")
			end;
			popup (string_list)
		end;

	continue_after_popdown is
		local
			editable: EDITABLE
			pos: INTEGER
		do
			pos := position;
			if pos /= 1 then
				if pos = data_list.count + 2 then
					-- Selected edit all
					from
						data_list.start
					until
						data_list.after
					loop
						editable := data_list.item;
						editable.create_editor
						data_list.forth
					end
				else	
					editable := data_list.i_th (pos - 1)
					editable.create_editor
				end
			end;
			data_list := Void;
		end;

end
