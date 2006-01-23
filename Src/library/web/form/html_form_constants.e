indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	HTML_FORM_CONSTANTS

feature

	Tag_end: STRING is ">"
	NewLine: STRING is "%N"

feature -- Form

	Form_start: STRING is "<FORM"
	Form_end: STRING is "</FORM>"

	Method: STRING is " METHOD="
	Action: STRING is " ACTION="
	Enctype: STRING is " ENCTYPE="
	Name: STRING is " NAME="

	Post: STRING is "POST"
	Get: STRING is "GET"

feature -- Input

	Input_start: STRING is "<INPUT"

	Type: STRING is " TYPE="
	Value: STRING is " VALUE="
	Src: STRING is " SRC="
	Size: STRING is " SIZE="
	Maxlength: STRING is " MAXLENGTH="
	Align: STRING is " ALIGN="
	Checked: STRING is " CHECKED"

	CheckBox: STRING is "CHECKBOX"
	Hidden: STRING is "HIDDEN"
	Radio: STRING is "RADIO"
	Reset: STRING is "RESET"
	Submit: STRING is "SUBMIT"
	Text: STRING is "TEXT"
	SendFile: STRING is "%"SEND FILE%""
	Image: STRING is "IMAGE"

feature -- TextArea

	TextArea_start: STRING is "<TEXTAREA"
	TextArea_end: STRING is "</TEXTAREA>"

	Rows: STRING is " ROWS="
	Cols: STRING is " COLS="
	Wrap: STRING is " WRAP="

	Off: STRING is "OFF"
	Virtual: STRING is "VIRTUAL"
	Physical: STRING is "PHYSICAL"

feature -- Select

	Select_start: STRING is "<SELECT"
	Select_end  : STRING is "</SELECT>"

	Multiple: STRING is " MULTIPLE"

	Option_start: STRING is "<OPTION"
	Option_end: STRING is ""
	Selected: STRING is " SELECTED";

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




end -- class HTML_FORM_CONSTANTS

