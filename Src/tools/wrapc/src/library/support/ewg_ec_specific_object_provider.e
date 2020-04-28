note

	description:

		"Generic class whos instances provide Eiffel compiler specific objects"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_EC_SPECIFIC_OBJECT_PROVIDER [G]

inherit

	EWG_SHARED_EIFFEL_COMPILER_NAMES

create

	make

feature {NONE} -- Initialization

	make (a_ise: G; a_mode: EWG_EIFFEL_COMPILER_MODE)
		require
			a_ise_not_void: a_ise /= Void
			a_mode_not_void: a_mode /= Void
		do
			ise := a_ise
			mode := a_mode
		ensure
			ise_set: ise = a_ise
			mode_set: mode = a_mode
		end

feature -- Access

	item: G
		do
			Result := ise
		end

	ise: G

	mode: EWG_EIFFEL_COMPILER_MODE

invariant

	ise_not_void: ise /= Void
	item_not_void: item /= Void
	mode_not_void: mode /= Void

end
