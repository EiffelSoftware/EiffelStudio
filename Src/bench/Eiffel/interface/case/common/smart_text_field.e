indexing
	description: "Text field which has a label"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	SMART_TEXT_FIELD

creation
	make, make_horizontal

feature -- Initialization 

	make (cont: EV_CONTAINER; name:STRING ) is
			-- Initialize ( vertically )
		require
			name_not_void: name /= Void
			container_exists: cont/= Void
		local
			vertical_box: EV_VERTICAL_BOX
		do
			!! vertical_box.make (cont)
			vertical_box.set_vertical_resize (FALSE)
			internal_make(vertical_box,name)
		end

	make_horizontal (cont: EV_CONTAINER; name:STRING ) is
			-- Initialize ( horizontal )
		require
			name_not_void: name /= Void
			container_exists: cont/= Void
		local
			horizontal_box: EV_HORIZONTAL_BOX
		do
			!! horizontal_box.make (cont)
			horizontal_box.set_homogeneous (False)
			internal_make(horizontal_box,name)
			check
				label_exists: label /= Void
				-- should be initialized by internal_make
			end
			label.set_expand (False)
			label.set_vertical_resize (False)
		end


feature {NONE} -- Internal

	internal_make ( b: EV_BOX; name: STRING ) is
		do
			!! label.make (b)
			label.set_text (name)
			!! text_field.make (b)
			--text_field.set_editable (false)

			box := b
		end

feature -- Access

	text: STRING is
			-- Return the text written within the text field
		do
			Result := text_field.text
		ensure
			Result_possible: Result /= Void
		end

	
feature -- Settings 

	set_text(s:STRING) is
			-- Set the text of text_field with `s'
		do
			if s /= Void then
				text_field.set_text(s)
			else
				text_field.set_text ("")
			end
		end

	add_command(c: EV_COMMAND) is
			-- Add a command to be executed when the user press
			-- ENTER
		do
			text_field.add_activate_command(c, Void)
		end

feature -- Implementation

	box: EV_BOX

	text_field : EV_TEXT_FIELD

	label: EV_LABEL
	
end -- class SMART_TEXT_FIELD
