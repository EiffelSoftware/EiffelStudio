indexing
	description: "Focusable active picture color button."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	FOCUSABLE_PICT_COLOR_B

inherit
	ACTIVE_PICT_COLOR_B
		redefine
			make_unmanaged,
			manage
		end

	FOCUSABLE
		redefine
			set_focus_string
		end

creation
	make, make_unmanaged

feature -- Initialization

--	make (a_name: STRING; a_parent: COMPOSITE) is
--			-- Creation routine
--		do
--			Precursor (a_name, a_parent)
--		end

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Creation routine
		do
			Precursor (a_name, a_parent)
			set_focus_string ("")
		end

	manage is
		do
			Precursor
			initialize_focus
		end

	focus_label: FOCUS_LABEL_I is
			-- has to be redefined, so that it returns correct toolkit initializer
			-- to which object belongs for every instance of this class
		local
			ti: TOOLTIP_INITIALIZER
		do
			ti ?= top
			check
				valid_tooltip_initializer: ti/= Void
			end
			Result := ti.label
		end

	set_focus_string (a_string: STRING) is
		do
			Precursor (a_string)
			initialize_focus
		end



end -- class FOCUSABLE_PICT_COLOR_B
