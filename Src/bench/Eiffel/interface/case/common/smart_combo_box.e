indexing
	description: "Combo Box with an attached description"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	SMART_COMBO_BOX

creation
	make, make_horizontal,make_editable

feature -- Initialization

	make (cont: EV_CONTAINER; name:STRING ) is
			-- Initialize ( vertical and not editable )
		require
			name_not_void: name /= Void
			container_exists: cont/= Void
		local
			vertical_box: EV_VERTICAL_BOX
		do
			!! vertical_box.make (cont)
			vertical_box.set_vertical_resize (FALSE)
			internal_make(vertical_box, name)
			combo.set_editable ( FALSE )
			box.set_expand (False)
		end

	make_editable (cont: EV_CONTAINER; name:STRING ) is
			-- Initialize ( vertical and editable )
		require
			name_not_void: name /= Void
			container_exists: cont/= Void
		local
			vertical_box: EV_VERTICAL_BOX
		do
			!! vertical_box.make (cont)
			vertical_box.set_vertical_resize (FALSE)
			internal_make(vertical_box, name)
			box.set_expand (False)
		end


	make_horizontal (cont: EV_CONTAINER; name:STRING ) is
			-- Initialize ( horizontal and not editable )
		require
			name_not_void: name /= Void
			container_exists: cont/= Void
		local
			horizontal_box: EV_HORIZONTAL_BOX
		do
			!! horizontal_box.make (cont)
			horizontal_box.set_homogeneous (False)
			internal_make(horizontal_box,name)
			label.set_expand (False)
			label.set_vertical_resize (False)
			combo.set_vertical_resize (False)
			combo.set_editable ( FALSE )
		end

feature {NONE} -- Internal

	internal_make(b: EV_BOX; name: STRING ) is
			-- Common initialization
		require
			box_exists: b /= Void
			name_exists: name /= Void
		do
			!! label.make (b)
			label.set_text(name)
			!! combo.make (b)
			box := b
		ensure
			box_set: box = b
			combo_exists : combo /= Void
			label_exists: label /= Void
		end

feature -- Settings

	set_text(s:STRING) is
			-- Set `s' as text for the combo box ( if editable )
		require
			string_exists : s /= Void
		do
			combo.set_text(s)
		end

	insert ( s: STRING) is
			-- Insert an element to the list of selectable items
		local
			it: EV_LIST_ITEM
		do
			!! it.make_with_text(combo,s)
		end


feature -- Access 

	text: STRING is
			-- Text displayed within the combo box
		do
			Result := combo.text
		end

	selected_item: EV_LIST_ITEM is
			-- Item selected by the user
		do
			Result := combo.selected_item
		end

feature -- Commands 

	add_selection_command (com: EV_COMMAND ) is
			-- add a command to be executed when ENTER is pressed
		do
			combo.add_select_command ( com, Void )			
		end

	select_item (i:INTEGER) is
			-- Select #i and displayed the corresponding content ( here a string )
		do
			combo.select_item(i)
		end

feature -- Access

	box: EV_BOX
		-- Container

	combo: EV_COMBO_BOX
		-- Combo Box

	label: EV_LABEL
		-- Description of the combo box content

end -- class SMART_COMBO_BOX
