indexing

	description: 
		"Filename field in the class window.";
	date: "$Date$";
	revision: "$Revision $"

class FILENAME_TEXT_FIELD

inherit

	EV_COMMAND

creation

	make

feature -- Properties

	window: EC_CLASS_WINDOW;
			-- Associated class window

	text_field: SMART_TEXT_FIELD

feature -- Initialization

	make (c: like window; t: like text_field) is
		do
			window := c
			text_field := t
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Change file name when entered is entered in
			-- the text field.
		local
			tmp: STRING;
			change_file_name: CHANGE_FILE_NAME_U
			class_data: CLASS_DATA
		do
			tmp := clone (text_field.text);
			if tmp.count > 2 then
				tmp.tail (2);
			end;
			tmp.to_lower;
			if tmp.is_equal (".e") then
				tmp := clone (text_field.text)
			else
				tmp := clone (text_field.text);
				tmp.append (".e");
				text_field.set_text (tmp);
			end;

			class_data ?= window.entity

			if class_data /= Void then
				!! change_file_name.make (class_data, tmp);
			end
		end;

end -- class FILENAME_TEXT_FIELD
