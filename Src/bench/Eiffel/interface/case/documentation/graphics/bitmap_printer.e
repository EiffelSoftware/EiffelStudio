indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BITMAP_PRINTER

inherit

	ONCES

creation
	make

feature -- Initialization

	make is
			-- Initialize
		do
		--	!! cl_w.make_for_bitmap
		end

	cl_w : MAIN_WINDOW

	generate ( cl : CLUSTER_DATA; fi : PLAIN_TEXT_FILE ; to_printer : BOOLEAN) is
		local
		--	daw: DRAWING_AREA_IMP
		--	print_dialog: WEL_PRINT_DIALOG
		--	save_file_dialog: WEL_SAVE_FILE_DIALOG
		--	windows_parent: WEL_COMPOSITE_WINDOW
		--	filen : FILE_NAME 
		--	fif : RAW_FILE
		--	pix : PIXMAP
		--	worka : WORKAREA
		do
		--	--if not cl_w.realized then
		--	--	cl_w.realize
		--	--end
		--	cl_w.hide
		--	cl_w.set_entity ( cl )
		--	if not to_printer then
		--			!! filen.make
		--			filen.extend(fi.name)
		--			--worka := cl_w.draw_window
		--			daw ?= worka.implementation
		--			daw.output_to_file ( filen)
		--	end
		end


end -- class BITMAP_PRINTER
