indexing
	description: "Context that represents a text component (EV_TEXT_COMPONENT)."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEXT_COMPONENT_C

inherit
	PRIMITIVE_C
		redefine
			gui_object
		end

feature -- Status report

	text: STRING is
		do
			Result := gui_object.text
		end

feature -- Status setting

	set_text (txt: STRING) is
		do
			gui_object.set_text (txt)
		end

feature -- Implementation

	gui_object: EV_TEXT_COMPONENT

end -- class TEXT_COMPONENT_C

