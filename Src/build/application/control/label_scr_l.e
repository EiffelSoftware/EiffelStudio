indexing
	description: "List of the existing label for the currently selected state."
	Id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class LABEL_SCR_L

inherit
	EV_LIST
		redefine
			make
		end

	EV_COMMAND

	REMOVABLE

	CONSTANTS

creation
	make
	
feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		do
			Precursor (par)
			activate_pick_and_drop (3, Current, Void) 
			set_data_type (Pnd_types.label_type)
		end 

feature -- Access

	selected_label: STRING is
			-- Current label selected
		local
			tran_nm: TRAN_NAME
		do
			tran_nm ?= selected_item
			if tran_nm /= Void  then
				Result := tran_nm.cmd_label.label
			end
		end

	append (l: TRAN_NAME_LIST) is
		-- Append `l' to current list.
		require
			valid_list: l /= Void
		do
			from
				l.start
			until
				l.after
			loop
				l.item.set_parent (Current)
				l.forth
			end
		end

feature {NONE} -- Removable

	remove_yourself is
		local
			cut_label_cmd: APP_CUT_LABEL
			arg: EV_ARGUMENT2 [STRING, GRAPH_ELEMENT]
		do
			create cut_label_cmd
			create arg.make (selected_item.text, Void)
			cut_label_cmd.work (arg)
			cut_label_cmd.update_history
		end

feature {NONE} -- Execute

	execute (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
			-- Prepare the transport (pick and drop).
		local
			tran_nm: TRAN_NAME
		do
			set_transported_data (Void)
			tran_nm ?= selected_item
			if tran_nm /= Void then
				set_transported_data (tran_nm.cmd_label)
			end
		end

end -- class LABEL_SCR_L

