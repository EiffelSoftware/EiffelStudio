indexing
	description: "Rename command."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class NAMER_CMD 

inherit

	EB_UNDOABLE_COMMAND

feature {NONE}

	name: STRING is 
		do
			Result := Command_names.set_visual_name_cmd_name
		end 

	comment: STRING is
		do
			Result := namer_window.namable.visual_name
		end

	failed: BOOLEAN

	namable: NAMABLE

	old_visual_name: STRING

--	old_height, old_width: INTEGER
--			-- Record height and width if it is
--			-- a context

	execute (arg: EV_ARGUMENT1 [EV_TEXT_FIELD]; ev_data: EV_EVENT_DATA) is
		local
--			ctxt: CONTEXT
		do
			namable := namer_window.namable
			namable.check_new_name (arg.first.text)
			if namable.is_valid_new_name then
				if namable.visual_name /= Void then	
					old_visual_name := clone (namable.visual_name)
				end
					-- To keep same size if it is a context
--				ctxt ?= namable
--				if ctxt /= Void then
--					old_width := ctxt.width
--					old_height := ctxt.height
--				end
				namable.set_visual_name (arg.first.text)
				namer_window.update_name
			else
				failed := True
			end
		end
	
feature 

	undo is
		local
			new_name: STRING
		do
			new_name := namable.visual_name
			set_visual_name (old_visual_name)
			old_visual_name := new_name
			if namer_window.namable = namable then
				namer_window.update_name
			end	
		end

	redo is
		do
			undo
		end

	set_visual_name (vname: STRING) is
		local
--			ctxt: CONTEXT
--			tmp_width, tmp_height: INTEGER
		do
--			ctxt ?= namable
--			if ctxt /= Void then 
--				tmp_width := ctxt.width
--				tmp_height := ctxt.height
--			end
			namable.set_visual_name (vname)
--			if ctxt /= Void and then 
--				(old_width /= ctxt.width or else old_height /= ctxt.height)
--			then
--				ctxt.set_size (old_width, old_height)
--			end
--			old_width := tmp_width
--			old_height := tmp_height
		end
	
end -- class NAMER_CMD

