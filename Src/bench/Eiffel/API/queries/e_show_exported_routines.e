indexing
	description: "Command to display exported features of current_class.";
	date: "$Date$";
	revision: "$Revision$"

class E_SHOW_EXPORTED_ROUTINES 

inherit
	E_CLASS_FORMAT_CMD
		redefine
			display_feature
		end

create
	make, default_create

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

end
