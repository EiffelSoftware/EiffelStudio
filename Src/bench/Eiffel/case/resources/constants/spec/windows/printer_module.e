indexing
	description: "Class responsible to ensure the printing"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	PRINTER_MODULE

inherit

	ONCES

	CONSTANTS

feature -- Implementation
	
	dc: WEL_PRINTER_DC

	print_dialog: WEL_PRINT_DIALOG

	cl_w : MAIN_WINDOW is
		once
		--	!! Result.make_for_bitmap
		end

	print_graph_to_file ( cl : CLUSTER_DATA; fi : PLAIN_TEXT_FILE ) is
		local
		--	daw: DRAWING_AREA_IMP
		--	save_file_dialog: WEL_SAVE_FILE_DIALOG
		--	windows_parent: WEL_COMPOSITE_WINDOW
		--	filen : FILE_NAME 
		--	fif : RAW_FILE
		--	pix : PIXMAP
		--	worka : WORKAREA
		do
		--	if not cl_w.realized then
		--		cl_w.realize
		--	end
		--	cl_w.hide
		--	cl_w.set_entity ( cl )
		--	!! filen.make
		--	filen.extend(fi.name)
		--	worka := cl_w.draw_window
		--	daw ?= worka.implementation
		--	daw.output_to_file ( filen)
		end


end -- class PRINTER_MODULE
