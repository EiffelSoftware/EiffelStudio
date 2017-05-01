note
	description: "Device context associated to a printer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PRINTER_DC

inherit
	WEL_DC

create
	make_from_printer,
	make_by_pointer

feature {NONE} -- Initialization

	make_from_printer (a_printer: WEL_PRINTER)
			-- Associated DC for `a_printer'.
		require
			printer_exists: a_printer.exists
		local
			l_winspool_driver, l_printer_name, l_port_name: WEL_STRING
		do
			if attached a_printer.printer_info_2 as l_info then
				create l_winspool_driver.make ("WINSPOOL")
				l_printer_name := l_info.printer_name
				l_port_name := l_info.port_name
				item := cwin_create_dc (l_winspool_driver.item, l_printer_name.item, l_port_name.item, default_pointer)
			end
		end

feature -- Basic operations

	get
			-- Get the device context
		do
		end

	release
			-- Release the device context
		do
		end

	start_document (title: READABLE_STRING_GENERAL)
			-- Start the job `title' on the printer.
		require
			exists: exists
			title_not_void: title /= Void
		local
			doc_info: WEL_DOC_INFO
		do
			create doc_info.make (title)
			cwin_start_doc (item, doc_info.item)
		end

	start_document_info (doc_info: WEL_DOC_INFO)
			-- Start the job using information from `doc_info'.
		require
			exists: exists
			doc_info_not_void: doc_info /= Void
			doc_info_exiss: doc_info.exists
		do
			cwin_start_doc (item, doc_info.item)
		end

	start_page
			-- Prepare the printer driver to accept data.
		require
			exists: exists
		do
			cwin_start_page (item)
		end

	end_page
			-- Informs the device that the application has
			-- finished writing to a page. This procedure is
			-- typically used to direct the device driver to
			-- advance to a new page.
		require
			exists: exists
		do
			cwin_end_page (item)
		end

	end_document
			-- End the job on the printer.
		require
			exists: exists
		do
			cwin_end_doc (item)
		end

	abort_document
			-- Stops the current print job and erases everything
			-- drawn since the last call to `start_doc'.
		require
			exists: exists
		do
			cwin_abort_doc (item)
		end

feature -- Obsolete

	new_frame obsolete "Use `end_page' [2017-05-31]"
		require
			exists: exists
		do
			end_page
		end

feature {NONE} -- Externals

	cwin_start_doc (dc: POINTER; docinfo: POINTER)
			-- SDK StartDoc
		external
			"C [macro <wel.h>] (HDC, DOCINFO *)"
		alias
			"StartDoc"
		end

	cwin_end_doc (dc: POINTER)
			-- SDK EndDoc
		external
			"C [macro <wel.h>] (HDC)"
		alias
			"EndDoc"
		end

	cwin_abort_doc (dc: POINTER)
			-- SDK AbortDoc
		external
			"C [macro <wel.h>] (HDC)"
		alias
			"AbortDoc"
		end

	cwin_start_page (dc: POINTER)
			-- SDK StartPage
		external
			"C [macro <wel.h>] (HDC)"
		alias
			"StartPage"
		end

	cwin_end_page (dc: POINTER)
			-- SDK EndPage
		external
			"C [macro <wel.h>] (HDC)"
		alias
			"EndPage"
		end

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
