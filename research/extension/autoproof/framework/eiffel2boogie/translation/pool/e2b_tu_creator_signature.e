note
	description: "[
		Translation unit for the signature of a creation routine.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_TU_CREATOR_SIGNATURE

inherit

	E2B_TU_FEATURE

	SHARED_WORKBENCH

create
	make

feature -- Access

	base_id: STRING = "creator-signature"
			-- <Precursor>

feature -- Basic operations

	translate
			-- <Precursor>
		local
			l_translator: E2B_ROUTINE_TRANSLATOR
		do
			create l_translator.make
			if feat.feature_name_id = {PREDEFINED_NAMES}.default_create_name_id and feat.written_in = system.any_id then
				l_translator.translate_default_create_signature (feat, type)
			else
				l_translator.translate_creator_signature (feat, type)
			end
		end

end
