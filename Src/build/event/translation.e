
class TRANSLATION 

inherit

	EVENT
		rename
			specific_add as event_specific_add
		redefine
			label, data, make,
			internal_name
		end;
	EVENT_LABELS;
	REMOVABLE;
	WINDOWS

creation

	make

feature {NONE}

	symbol: PIXMAP is
		do
			Result := Pixmaps.translation_pixmap
		end;

	make is
		do
			identifier := integer_generator.value;
			integer_generator.next;
			text := "<Key>";
		ensure then
			translation_is_x: text.is_equal ("<Key>")
		end;

feature

	data: TRANSLATION is
		do
			Result := Current
		end;

	identifier: INTEGER;

	
feature {CAT_EV_IS}

	remove_yourself is
		local
			cut_current: TRANSL_CUT
		do
			!!cut_current;
			cut_current.execute (Current)
		end;

	integer_generator: INT_GENERATOR is
			-- Integer generator for each type of context
		once
			!!Result;
			Result.set (100);
		end;
 
	namer: NAMER is
		once
			!!Result.make ("Translation");
		end;

feature 

	editor: TRANSL_EDITOR;
			-- Translation editor

	edited: BOOLEAN is
			-- Is current translation being edited?
		do
			Result := (editor /= Void)
		end;

	set_editor (ed: TRANSL_EDITOR) is
			-- Set editor to `ed'.
		do
			editor := ed
		end;

	reset is
			-- "Forget" editor.
		do
			editor := Void
		end;

feature -- Translation names

	internal_name: STRING;
	text: STRING;

	set_text (s: STRING) is
		do
			text := clone (s);	
			context_catalog.update_translation_page;
		end;

	label: STRING is
		do
			Result := text
		end;

	set_internal_name (s: STRING) is
		do
			internal_name := clone(s);
		end;

	generate_internal_name is
		do
			namer.next;
			internal_name := namer.value;
		end;

	eiffel_text: STRING is
		do
			!!Result.make (0);
			Result.append ("set_action (%"");
			Result.append (text);
			Result.append ("%", ");
		end;

	event_specific_add (a_widget: WIDGET; a_command: COMMAND) is
			-- Useless.
		do
		end
	
	specific_remove (a_widget: WIDGET; a_command: COMMAND	) is
			-- Useless.
		do
		end
invariant
	
	text_not_void: text /= Void
	
end
