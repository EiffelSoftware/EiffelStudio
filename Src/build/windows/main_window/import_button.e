
class IMPORT_BUTTON 

inherit

	FOCUSABLE
		export
			{NONE} all
		end
--	PUSH_B
--		rename 
--			make as push_b_make
--		undefine
--			init_toolkit
--		end	
	EB_PICT_B
		export
			{NONE} all
		undefine
			init_toolkit
		end
	WINDOWS
		export
			{NONE} all
		end
	PIXMAPS
		export
			{NONE} all
		end
	LICENCE_COMMAND
		export
			{NONE} all
		end

creation

	make

	
feature {NONE}

	focus_source: WIDGET is
		do
			Result := Current
		end

	focus_string: STRING is "Import EiffelBuild code"

	focus_label: LABEL is
		do
			Result := main_panel.focus_label
		end

feature 

	make (a_name: STRING a_parent: COMPOSITE) is
		local
			Nothing: ANY
		do
			make_visible (a_parent)
			set_symbol (Import_pixmap)

--			push_b_make (a_name, a_parent)
			initialize_focus
			add_activate_action (Current, Nothing)
--			set_text ("Import")
		--	set_size (125, 30)
		end

	
feature {NONE}

	work (argument: ANY) is
			-- popup a window to specify what
			-- and where to import,
		local
			iw: IMPORT_WINDOW
		do
			if main_panel.project_initialized then
				!!iw.make ("Import project", main_panel.base)
				iw.popup
			end
		end

	continue_after_popdown (box: MESSAGE_D ok: BOOLEAN) is
		do
		end

end
