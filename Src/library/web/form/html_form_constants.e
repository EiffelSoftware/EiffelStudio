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
	Selected: STRING is " SELECTED"

end -- class HTML_FORM_CONSTANTS

--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel.
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

