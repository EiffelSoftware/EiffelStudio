indexing
	description: "Text field which are used by the Wizard"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SMART_TEXT_FIELD

inherit
	EV_VERTICAL_BOX
			
creation	
	make

feature -- Initialization

	make(lab,some_text: STRING;lab_size,text_size: INTEGER; caller: WIZARD_STATE_WINDOW) is
		do
			default_Create
			Create label.make_with_text(lab)
			Create tf.make_with_text(some_text)
			label.set_minimum_width(lab_size)
			label.align_text_left
			tf.set_capacity(text_size)
			tf.return_actions.extend(caller~next)
			tf.change_actions.extend(caller~change_entries)
			extend(label)
			extend(tf)		
		end

feature -- Access

	text: STRING is 
		do
			Result := tf.text
		ensure
			not_void: Result /= Void
		end


	change_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			Result := tf.change_actions
		end

feature -- Settings

	set_text(txt: STRING) is
		do
			tf.set_text(txt)
		end

feature {NONE} -- Implementation

	tf: EV_TEXT_FIELD

	label: EV_LABEL

end -- class WIZARD_SMART_TEXT_FIELD
