indexing
	description: "Pixmap file open dialog."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class PIXMAP_FILE_BOX 

inherit
	EV_FILE_OPEN_DIALOG
		rename
			make as file_open_d_create
		end

	EV_COMMAND

creation
	make

feature {NONE} -- Initialization

	make (l: EV_LIST_ITEM) is
		local
			arg: EV_ARGUMENT1 [EV_LIST_ITEM]
		do
			file_open_d_create (l.parent.parent)
			set_title ("Pixmap File Selection")
--XX	set the filters
			create arg.make (l)
			add_ok_command (Current, arg)
		end

	
feature {NONE} -- Implemantation

	execute (arg: EV_ARGUMENT1 [EV_LIST_ITEM]; ev_data: EV_EVENT_DATA) is
		local
			pix: EV_PIXMAP
		do
			arg.first.set_text (file)
			create pix.make_from_file (file)
			arg.first.set_pixmap (pix)
		end

end -- class PIXMAP_FILE_BOX

