indexing
	description: "Entry in a menu used to hide or show the %
				% class importer."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class

	CLASS_IMPORTER_ENTRY

inherit

	MAIN_PANEL_TOGGLE

	SHARED_CONTEXT

creation

	make

feature {NONE} -- Implementation

	toggle_pressed is
			-- Hide or show the class selector.
		do
			if armed then
				class_importer.display
			else
				class_importer.hide
			end
		end

end -- class CLASS_IMPORTER_ENTRY
