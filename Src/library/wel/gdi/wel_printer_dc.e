indexing
	description: "Device context associated to a printer."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PRINTER_DC

inherit
	WEL_DC
		redefine
			destroy_item
		end

creation
	make_by_pointer


feature -- Basic operations

	get is
			-- Get the device context
		do
		end

	release is
			-- Release the device context
		do
		end

	start_document (title: STRING) is
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

	start_document_info (doc_info: WEL_DOC_INFO) is
			-- Start the job using information from `doc_info'.
		require
			exists: exists
			doc_info_not_void: doc_info /= Void
		do
			cwin_start_doc (item, doc_info.item)
		end

	start_page is
			-- Prepare the printer driver to accept data.
		require
			exists: exists
		do
			cwin_start_page (item)
		end

	end_page is
			-- Informs the device that the application has
			-- finished writing to a page. This procedure is
			-- typically used to direct the device driver to
			-- advance to a new page.
		require
			exists: exists
		do
			cwin_end_page (item)
		end

	end_document is
			-- End the job on the printer.
		require
			exists: exists
		do
			cwin_end_doc (item)
		end

	abort_document is
			-- Stops the current print job and erases everything
			-- drawn since the last call to `start_doc'.
		require
			exists: exists
		do
			cwin_abort_doc (item)
		end

feature -- Obsolete

	new_frame is obsolete "Use ``end_page''"
		require
			exists: exists
		do
			end_page
		end

feature {NONE} -- Removal

	destroy_item is
			-- Ensure the current dc is deleted
		do
			delete
		end

feature {NONE} -- Externals

	cwin_start_doc (dc: POINTER; docinfo: POINTER) is
			-- SDK StartDoc
		external
			"C [macro <wel.h>] (HDC, DOCINFO *)"
		alias
			"StartDoc"
		end

	cwin_end_doc (dc: POINTER) is
			-- SDK EndDoc
		external
			"C [macro <wel.h>] (HDC)"
		alias
			"EndDoc"
		end

	cwin_abort_doc (dc: POINTER) is
			-- SDK AbortDoc
		external
			"C [macro <wel.h>] (HDC)"
		alias
			"AbortDoc"
		end

	cwin_start_page (dc: POINTER) is
			-- SDK StartPage
		external
			"C [macro <wel.h>] (HDC)"
		alias
			"StartPage"
		end

	cwin_end_page (dc: POINTER) is
			-- SDK EndPage
		external
			"C [macro <wel.h>] (HDC)"
		alias
			"EndPage"
		end

end -- class WEL_PRINTER_DC


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

