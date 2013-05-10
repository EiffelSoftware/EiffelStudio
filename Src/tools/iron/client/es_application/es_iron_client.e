note
	description: "Summary description for {ES_IRON_CLIENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_IRON_CLIENT

inherit
	IRON_CLIENT
		redefine
			iron_layout
		end

	EIFFEL_LAYOUT

create
	make

feature -- Access

	iron_layout: IRON_LAYOUT
		local
			e_lay: like eiffel_layout
		do
			if is_eiffel_layout_defined then
				e_lay := eiffel_layout
			else
				create {EC_EIFFEL_LAYOUT} e_lay
			end
			create Result.make_with_path (e_lay.user_files_path.extended ("iron"))
		end

end
