indexing
	description: "Component which allows (re)naming entities"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_WINDOW_NAMER

inherit
	GRAPHICAL_COMPONENT [ DATA ]
		rename
			entity as data
		redefine
			make,
			data
		end

	CONSTANTS

creation
	make

feature -- Initialization

	make (cont: EV_CONTAINER; win: EC_EDITOR_WINDOW [ANY] ) is
			-- Initialize
		local
			f: EV_FRAME
			v1: EV_VERTICAL_BOX

			init_editor: INIT_EDITOR_COMMAND

			text_field: EV_TEXT_FIELD

		do
			precursor ( cont, win )
			!! f.make_with_text(cont, widget_names.editor)
			!! v1.make(f)
			v1.set_spacing(5)
			!! tag_box.make(v1)
			!! tag.make_horizontal(tag_box,"Tag :")

			!! tag_value.make_horizontal(tag_box," Value :")

			tag_box.set_parent(Void)
			!! name_box.make(v1)
			!! name.make_horizontal(name_box,"")

			text_field := name.text_field
			
			if text_field /= Void then
				!! init_editor.make (Current)

				text_field.set_editable (false)
				text_field.add_default_pnd_command (init_editor, Void)
			end

			f.set_expand(FALSE)
		end

feature -- Properties

	data: NAME_DATA


feature --{NONE}

	tag,tag_value,name: SMART_TEXT_FIELD	

	name_box,tag_box: EV_HORIZONTAL_BOX
		-- only one has a parent at at moment.

feature -- Updates 

	clear is do end

	update is 
		do
		end

-- 	update_from(ent: DATA) is
-- 		local
-- 			elem: ELEMENT_DATA
-- 			namable: NAME_DATA
-- 		do
-- 			data := ent
-- 			elem ?= ent
-- 			if elem /= Void then
-- 				
-- 			elseif namable /= Void then
-- 
-- 			end
--		end

feature -- Access

	entered_text: STRING is
			-- Text entered in text field
		do
			--if is_free_text then
			--	Result := clone (free_text.text)
			--elseif has_tag then
			--	Result := clone (tag_text.text)
			--else
				Result :=  clone (name.text) 
			--end;
		ensure
		--	if_free_text: is_free_text implies equal (Result, free_text.text);
		--	if_has_tag: has_tag implies equal (Result, tag_text.text);
		--	e_lse: (not is_free_text and not has_tag)
		--		implies equal (Result, text.text);
		end


feature -- Commands 

	add_name_command (c: EV_COMMAND) is
		do
			if name /= Void then
				name.add_command (c)
			end
		end

feature -- Settings

	set_name (s: STRING) is
		do
			if name /= Void then
				name.set_text (s)
			end
		end

invariant
	only_one_parent: name_box.parent=Void or tag_box.parent= Void
	at_least_one: name_box.parent /= Void or tag_box.parent /= Void

end -- class EDITOR_WINDOW_NAMER
