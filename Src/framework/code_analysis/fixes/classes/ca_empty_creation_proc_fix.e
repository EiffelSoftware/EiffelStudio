note
	description: "Fixes violations of rule #38 ('Empty argumentless creation procedure can be removed')."
	date: "$Date$"
	revision: "$Revision$"

class
	CA_EMPTY_CREATION_PROC_FIX

inherit
	CA_FIX
		redefine
			execute
		end

create
	make_with_create_proc

feature {NONE} -- Initialization

	make_with_create_proc (a_class: attached CLASS_C; a_feature: attached FEATURE_AS)
			-- Initializes `Current' with class `a_class'. `a_feature' is the creation procedure which is to be removed.
		do
			make (ca_names.empty_creation_procedure_fix, a_class)
			feature_to_remove := a_feature
		end

feature {NONE} -- Implementation

	feature_to_remove: FEATURE_AS
			-- The creation procedure this fix will remove.

	execute
			-- <Precursor>
		do
			feature_to_remove.remove_text (match_list)

			across parsed_class.creators as l_create_as loop
				process_create (l_create_as)
			end
		end

	process_create (a_create_as: CREATE_AS)
		local
			l_new_feature_names: STRING_8
		do
			create l_new_feature_names.make_empty

			across a_create_as.feature_list as l_feature loop
				if not feature_to_remove.feature_names.has (l_feature) then
					l_new_feature_names.append ("%T" + l_feature.visual_name + ",%N")
				end
			end

				-- Remove last comma and newline.
			l_new_feature_names.remove_tail (2)
				-- Remove first tab.
			l_new_feature_names.remove_head (1)

			if l_new_feature_names.is_empty then
				a_create_as.replace_text (l_new_feature_names, match_list)
			else
				a_create_as.feature_list.replace_text (l_new_feature_names, match_list)
			end
		end

end
