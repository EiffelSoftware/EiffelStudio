
class TRANSL_HOLE 

inherit

	DRAG_SOURCE;
	EVENT_STONE;
	HOLE
		redefine
			process_event
		select
			init_toolkit
		end;
	EB_BUTTON_COM

creation

	make
	
feature {NONE} -- Stone information

	eiffel_text: STRING is
		do
			Result := data.eiffel_text
		end;

	data: TRANSLATION is
		do
			Result := editor.edited_translation
		end;

	source, target: WIDGET is
		do
			Result := Current
		end;

feature {NONE}

	editor: TRANSL_EDITOR;

	make (ed: TRANSL_EDITOR; a_parent: COMPOSITE) is
		do
			editor := ed;
			make_visible (a_parent);
			register;
			initialize_transport
			-- added by samik
			set_focus_string (Focus_labels.translation_label)
			-- end of samik
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.event_pixmap
		end;

	full_symbol: PIXMAP is
		do
			Result := Pixmaps.event_dot_pixmap
		end;

feature {NONE}

	process_event (dropped: EVENT_STONE) is
		local
			translation: TRANSLATION;
		do
			translation ?= dropped.data;
			if translation /= Void then
				editor.set_edited_translation (translation);
			end;
		end;

	execute (arg: ANY) is
		local
			transl_add: TRANSL_ADD;
			edited_translation: TRANSLATION
		do
			!!transl_add;
			!!edited_translation.make;
			edited_translation.generate_internal_name;
			editor.set_edited_translation (edited_translation);
			transl_add.execute (edited_translation);
		end;

feature

	set_empty_symbol is
		do
			if pixmap /= symbol then
				set_symbol (symbol)
			end
		end

	set_full_symbol is
		do
			if pixmap /= full_symbol then
				set_symbol (full_symbol)
			end
		end

end
