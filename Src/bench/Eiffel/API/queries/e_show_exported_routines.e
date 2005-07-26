indexing

	description: 
		"Command to display exported features of current_class.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_EXPORTED_ROUTINES 

inherit

	E_CLASS_FORMAT_CMD
		redefine
			display_feature, work
		end

create

	make, do_nothing

feature -- Access

	criterium (f: E_FEATURE): BOOLEAN is
			-- Criterium for feature `f'
		do
			Result := f.is_exported_to (any_class)
		ensure then
			good_criterium: Result = f.is_exported_to (Any_class)
		end

	display_feature (f: E_FEATURE; st: STRUCTURED_TEXT) is
			-- Append `f' to `st'.
		do
			f.append_signature (st)
			if f.is_obsolete then
					-- The user might change the background color of comments.
				st.add_string ("  ")
				st.add_comment ("(obsolete)")
			end
		end

	work is
			-- On top of exported features, append the creation routines.
		local
			creats: HASH_TABLE [EXPORT_I, STRING]
			f: E_FEATURE
			default_create_feature: FEATURE_I
		do
			Precursor {E_CLASS_FORMAT_CMD}
			if not current_class.is_deferred then
				structured_text.add_string ("Creation routines:")
				structured_text.add_new_line
				structured_text.add_indent
				creats := current_class.creators
				if creats /= Void then
					from
						creats.start
					until
						creats.after
					loop
						f := current_class.feature_with_name (creats.key_for_iteration)
						if f /= Void then
							display_feature (f, structured_text)
							structured_text.add_string (" ")
							creats.item_for_iteration.append_to (structured_text)
							structured_text.add_new_line
							structured_text.add_indent
						end
						creats.forth
					end
				else
					default_create_feature := current_class.default_create_feature
					if default_create_feature /= Void then
						f := default_create_feature.api_feature (current_class.class_id)
						display_feature (f, structured_text)
					else
						structured_text.add_feature_name ("default_create", current_class)
					end
					structured_text.add_new_line
					structured_text.add_indent
				end
			end
		end

end -- class E_SHOW_EXPORTED_ROUTINES
