class CON_EDIT_HOLE 

inherit

	ICON_HOLE
		rename
			make_visible as make_icon_visible,
			identifier as oui_identifier
		export
			{CONTEXT_EDITOR} main_panel
		redefine
			stone, compatible
		end

	ICON_HOLE
		rename
			identifier as oui_identifier
		redefine
			stone, compatible, make_visible
		select
			make_visible
		end

	PIXMAPS
		export
			{NONE} all
		end

	CONTEXT_STONE
		export
			{NONE} all
		redefine
			transportable
		end
	
creation
	make
	
feature {NONE}

	associated_editor: CONTEXT_EDITOR

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end

	eiffel_type: STRING is
		do
			Result := original_stone.eiffel_type
		end

	entity_name: STRING is
		do
			Result := original_stone.entity_name
		end

	eiffel_text: STRING is
		do
			Result := original_stone.entity_name
		end

feature 

	source: PICT_COLOR_B is
		do
			Result := button
		end

	make_visible (a_parent: COMPOSITE) is
		do
			make_icon_visible (a_parent)
			initialize_transport
		end
			
	original_stone: CONTEXT

	
	reset is
		do
			original_stone := Void
			set_label ("")
			set_symbol (Context_pixmap)
		end

	set_context (con: CONTEXT) is
		do
			original_stone := con.original_stone
			if label = Void or else label.empty or else con.label.count >= label.count then
				parent.unmanage
			end
			set_label (con.label)
			set_symbol (con.symbol)
			if not parent.managed then
				parent.manage
			end
		end


	context_label: STRING is
		do
			Result := original_stone.label
		end

	update_name is
		require
			original_stone /= Void
		do
			set_label (context_label)
		end

	transportable: BOOLEAN is
		do
			Result := original_stone /= Void
	end

	stone: CONTEXT_STONE

	compatible (s: CONTEXT_STONE): BOOLEAN is
		do
			stone ?= s
			Result := stone /= Void
		end

	make (ed: CONTEXT_EDITOR) is
		do
			set_symbol (Context_pixmap)
			associated_editor := ed
		end

feature {NONE}

	process_stone is
			-- Set the new edited context
		do
			associated_editor.set_edited_context (stone.original_stone)
		end

end
