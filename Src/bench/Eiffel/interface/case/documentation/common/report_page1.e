indexing
	description: "Page which displays the common information for a report."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_PAGE1

inherit
	REPORT_PAGE
		redefine
			make
		end

creation
	make_with_caller

feature -- Initialization

	make (noteb: EV_NOTEBOOK;wn: ANY) is
			-- Initialize
		local
			h1,h2,h3,h4: EV_HORIZONTAL_BOX
			f1,f2: EV_FRAME
			fix: EV_FIXED
			v1,v2,v3,v4: EV_VERTICAL_BOX
			com: EV_ROUTINE_COMMAND
			win : EV_WINDOW
		do
			precursor ( noteb, window)
			notebook.append_page(page, "Generation")
			!! fix.make ( page )
			fix.set_minimum_height(15)
			fix.set_expand(FALSE)

			!! f1.make_with_text ( page,"Type Documentation" )
			f1.set_expand(FALSE)
			!! v1.make(f1)
			!! to_text.make_with_text(v1,"Generate Text")
			!! to_graphical.make_with_text(v1,"Generate Graphical")
			
			!! f2.make_with_text ( page,"Output")
			f2.set_expand(FALSE)
			!! v2.make(f2)
			!! h3.make(v2)
			h3.set_spacing(20)
			!! to_printer.make_with_text(h3,"To Printer")
			!! com.make(~disactivate_path)
			to_printer.add_toggle_command(com, Void)
			!! to_disk.make_with_text(h3,"To File")
			!! com.make(~activate_path)
			to_disk.add_toggle_command(com, Void)
			!! path_component.make(v2,window)
		end

feature -- Implementation 

	to_printer, to_disk: EV_RADIO_BUTTON

	to_text,to_graphical: EV_CHECK_BUTTON

	format_list: EV_LIST

	path_component: PATH_COMPONENT

feature -- Commands

	initiate_generation is
		require
			caller_exists: window /= Void
		do
--			if window.page1.to_printer.state then 
--				-- Future generation to a printer
--				Environment.printer_module.initiate(window)	
--			else
--				-- Future generation to set of files.
--			end
		end

	disactivate_path(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Hide the paths and the button "browse"
		do
			path_component.set_insensitive(TRUE)
		end

	activate_path(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Show the paths and the button "browse".
		do
			path_component.set_insensitive(FALSE)
		end

feature -- Updates

	update is do end

	reset is do end

end -- class REPORT_PAGE1
