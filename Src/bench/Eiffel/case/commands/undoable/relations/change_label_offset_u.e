class CHANGE_LABEL_OFFSET_U

inherit

	UNDOABLE_EFC;
	EC_COMMAND
		redefine
			is_template
		end

feature -- Property

	is_template: BOOLEAN is True;

	name: STRING is 
			-- Name of Command
		do
			if reverse then
				Result := "Change reverse relation offsets"
			else
				Result := "Change relation offsets"
			end
		end 

feature -- Redo/undo

	redo is
			-- Re-execute command (after it was undone)
		do
			if reverse then
				relation.reverse_label.set_x_y_offset (new_x_offset,
									new_y_offset)
			else
				relation.label.set_x_y_offset (new_x_offset,
									new_y_offset)
			end;
			update
		end; -- redo

	undo is
			-- Cancel effect of executing the command
		do
			if reverse then
				relation.reverse_label.set_x_y_offset (old_x_offset,
									old_y_offset)
			else
				relation.label.set_x_y_offset (old_x_offset,
									old_y_offset)
			end;
			update
		end -- undo

feature -- Execution

	execute (arg: ANY) is
		local
			l: LABEL_DATA
			label_page: RELATION_LABEL_PAGE;
--			offset_form: INPUT_FORM
		do
		--	label_page ?= arg;
		--	if label_page /= Void then
		--		set_watch_cursor;
		--		relation := label_page.relation_window.clientele_link;
		--		offset_form := label_page.x_offset_form;
		--		new_x_offset := offset_form.integer_value;
		--		offset_form := label_page.y_offset_form;
		--		new_y_offset := offset_form.integer_value;
		--		reverse := label_page.relation_window.reverse_side;
		--		if reverse then
		--			l := relation.reverse_label
		--		else
		--			l := relation.label
		--		end
		--		old_x_offset := l.x_offset;
		--		old_y_offset := l.y_offset;
		--		if new_x_offset /= old_x_offset or else
		--			new_y_offset /= old_y_offset
		--		then
		--			record;
		--			redo;
		--		end;
		--		restore_cursor;
		--	end
		end

feature {NONE} -- Private datas

	relation: CLI_SUP_DATA;
			-- Relation modified created

	new_x_offset, new_y_offset: INTEGER;
			-- New offsets given to the relation

	old_x_offset, old_y_offset: like new_x_offset;
			-- Relation's old offsets

	reverse: BOOLEAN

feature {NONE} -- Implementation

	update is
			--
		local
			relation_window: EC_RELATION_WINDOW
		do
			workareas.change_label (relation, reverse);
			workareas.refresh;
			relation_window := windows.relation_window (relation);
			if relation_window /= Void then
				relation_window.update_offsets
			end;
			System.set_is_modified
		end

invariant

	has_relation: relation /= void;

end
