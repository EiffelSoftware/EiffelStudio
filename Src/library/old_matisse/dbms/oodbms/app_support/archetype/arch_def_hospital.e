indexing
	description: "ARCH_HOSPITAL defines hospital archetype specifics."
	keywords:    "archetype"
	revision:    "%%A%%"
	source:	     "%%P%%"

class ARCH_DEF_HOSPITAL

inherit
	ARCH_DEFINITION

feature -- Status
	is_valid:BOOLEAN is
		do
			Result := True
		end

feature -- Initialisation
	create_prototypes is
		local
			a_rep_item:REP_ITEM
		do
			-- INFO_ITEMs
			!PATIENT!a_rep_item.make_blank	rep_items.extend(a_rep_item)
			!DOCTOR!a_rep_item.make_blank	rep_items.extend(a_rep_item)
		end

	init_structures is
		do
		end

feature -- Output
	print_out is
		do
		end

end
