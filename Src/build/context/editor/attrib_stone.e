

deferred class ATTRIB_STONE 

inherit

	ICON_STONE
		rename
			identifier as oui_identifier,
			make as old_make
		undefine
			init_toolkit, stone_cursor
		redefine
			original_stone
		end;
	TYPE_STONE;
	WINDOWS
		export
			{NONE} all
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	PIXMAPS
	
feature 

	identifier: INTEGER is
		do
		end;

	copy_attribute (new_context: CONTEXT) is
			-- Copy the attribute "transported" by the stone
		deferred
		end;

	
feature {NONE}

	modify_context (a_context: CONTEXT) is
			-- Modify the attribute of a context
		deferred
		end;

	modify_contexts (a_context: CONTEXT) is
			-- Modify the attribute of one or several
			-- contexts (if grouped)
		local
			a_list: LINKED_LIST [CONTEXT];
		do
			if a_context.grouped then
				a_list := a_context.group;
				from
					a_list.start
				until
					a_list.offright
				loop
					modify_context (a_list.item);
					a_list.forth;
				end;
			else
				modify_context (a_context)
			end;
		end;

	
feature 

	eiffel_type: STRING is
		do
		end;

	original_stone: TYPE_STONE;
	
feature {NONE}

	editor: CONTEXT_EDITOR;
		-- Editor where the current stone is defined

	
feature 

	make (a_parent: FORM; an_editor: CONTEXT_EDITOR) is
			-- Create the visual stone
		do
			editor := an_editor;
			make_visible (a_parent);
			set_symbol (pixmap);
			initialize_transport;
		end;

	pixmap: PIXMAP is
		deferred
		end
	
end
