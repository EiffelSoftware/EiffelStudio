note
	description: "Fixes violations of rule #3 ('Feature never called')."
	author: "Stefan Zurfluh"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_FEATURE_NEVER_CALLED_FIX

inherit
	CA_FIX
		redefine
			process_feature_as
		end

create
	make_with_feature,
	make_with_attribute

feature {NONE} -- Initialization

	make_with_feature (a_class: attached CLASS_C; a_feature: attached FEATURE_AS; a_name: attached STRING_32)
			-- Initializes `Current' with class `a_class'. `a_feature' with name `a_name'
			-- is the feature that is never called.
		do
			make (ca_names.feature_never_called_fix + a_name + "'", a_class)
			feature_to_remove := a_feature
			feature_name := a_name
		end

	make_with_attribute (a_class: attached CLASS_C; a_feature: attached FEATURE_AS; a_name: attached STRING_32)
			-- Initializes `Current' with class `a_class'. `a_feature' with name `a_name'
			-- is the attribute that is never called.
		do
			make (ca_names.attribute_never_called_fix + a_name + "'", a_class)
			feature_to_remove := a_feature
			feature_name := a_name
		end

feature {NONE} -- Implementation

	feature_to_remove: FEATURE_AS
			-- The feature this fix will remove.

	feature_name: STRING_32
			-- The name of the feature this fix will remove.

feature {NONE} -- Visitor

	process_feature_as (a_feature: FEATURE_AS)
			-- Removes `feature_name' from `a_feature'. If `a_feature_name' is the
			-- only name of `a_feature' then the feature body will be removed, too.
		local
			l_new_feature_names: STRING_32
			l_feature_names: EIFFEL_LIST [FEATURE_NAME]
		do
			l_feature_names := a_feature.feature_names

			if l_feature_names.count > 1 then
				create l_new_feature_names.make_empty
				across
					l_feature_names as f
				loop
						-- Skip the feature name we are removing.
					if not f.visual_name_32.is_equal (feature_name) then
						l_new_feature_names.append (", ")
						l_new_feature_names.append (f.visual_name_32)
					end
				end
					-- Remove the first comma.
				l_new_feature_names.remove_head (2)
				l_feature_names.replace_text ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (l_new_feature_names), match_list)
			else
				if a_feature.is_equivalent (feature_to_remove) then
					a_feature.remove_text (match_list)
				end
			end
		end

end
