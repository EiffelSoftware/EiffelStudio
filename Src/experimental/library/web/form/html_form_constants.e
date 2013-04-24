note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	HTML_FORM_CONSTANTS

feature

	Tag_end: STRING = ">"
	NewLine: STRING = "%N"

feature -- Form

	Form_start: STRING = "<FORM"
	Form_end: STRING = "</FORM>"

	Method: STRING = " METHOD="
	Action: STRING = " ACTION="
	Enctype: STRING = " ENCTYPE="
	Name: STRING = " NAME="

	Post: STRING = "POST"
	Get: STRING = "GET"

feature -- Input

	Input_start: STRING = "<INPUT"

	Type: STRING = " TYPE="
	Value: STRING = " VALUE="
	Src: STRING = " SRC="
	Size: STRING = " SIZE="
	Maxlength: STRING = " MAXLENGTH="
	Align: STRING = " ALIGN="
	Checked: STRING = " CHECKED"

	CheckBox: STRING = "CHECKBOX"
	Hidden: STRING = "HIDDEN"
	Radio: STRING = "RADIO"
	Reset: STRING = "RESET"
	Submit: STRING = "SUBMIT"
	Text: STRING = "TEXT"
	SendFile: STRING = "%"SEND FILE%""
	Image: STRING = "IMAGE"

feature -- TextArea

	TextArea_start: STRING = "<TEXTAREA"
	TextArea_end: STRING = "</TEXTAREA>"

	Rows: STRING = " ROWS="
	Cols: STRING = " COLS="
	Wrap: STRING = " WRAP="

	Off: STRING = "OFF"
	Virtual: STRING = "VIRTUAL"
	Physical: STRING = "PHYSICAL"

feature -- Select

	Select_start: STRING = "<SELECT"
	Select_end  : STRING = "</SELECT>"

	Multiple: STRING = " MULTIPLE"

	Option_start: STRING = "<OPTION"
	Option_end: STRING = ""
	Selected: STRING = " SELECTED";

note
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

