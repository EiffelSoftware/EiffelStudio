indexing
	description: "Objects that handle clipboard manipulation in EiffelBuild"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CLIPBOARD
	
inherit
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

feature -- Access

	tool_bar_button: EV_TOOL_BAR_BUTTON is
			--
		do
			create Result
			Result.set_pixmap (icon_paste @ 1)
			Result.drop_actions.extend (agent set_object)
			Result.set_pebble_function (agent return_object)
		end
		
	object: GB_OBJECT is
			--
		do
			if contents /= Void then
				Result := contents.new_copy
			end
		end

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	set_object (an_object: GB_OBJECT) is
			--
		do
			contents := an_object.new_copy
		end
		

	return_object: GB_OBJECT is
			--
		do
			Result := object			
		end

	contents: GB_OBJECT
		-- Current contents of `Current'.
		-- Whenver the contents are requested, this must be copied.

invariant
	invariant_clause: True -- Your invariant here

end -- class GB_CLIPBOARD
