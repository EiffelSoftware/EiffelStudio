indexing
	description: "Display warning message for obsolete tags."
	date: "$Date$"
	revision: "$Revision$"

class
	OBSOLETE_INDEXING_TAG

inherit
	EIFFEL_WARNING
		redefine
			trace
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make (a_class: like associated_class; a_old_tag, a_new_tag: STRING; a_location: LOCATION_AS) is
			-- Create new instance of `OBSOLETE_INDEXING_TAG'.
		require
			a_class_not_void: a_class /= Void
			a_old_tag_not_void: a_old_tag /= Void
			a_new_tag_not_void: a_new_tag /= Void
			a_location_not_void: a_location /= Void
		do
			associated_class := a_class
			old_tag := a_old_tag
			new_tag := a_new_tag
			location := a_location
		ensure
			associated_class_set: associated_class = a_class
			old_tag_set: old_tag = a_old_tag
			new_tag_set: new_tag = a_new_tag
			location_set: location = a_location
		end
		
feature -- Properties

	code: STRING is "Obsolete indexing tag"
			-- Error code

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
		end

	trace (st: STRUCTURED_TEXT) is
			-- Debug purpose
		do
			st.add (create {ERROR_TEXT}.make (Current, "Obsolete"))
			st.add_string (" indexing tag used in class ")
				-- Error happened in a class
			associated_class.append_signature (st, False)
			st.add_string (" at line ")
			st.add_string (location.line.out)
			st.add_string (".")
			st.add_new_line
			st.add_string ("It uses obsolete indexing tag `")
			st.add_string (old_tag)
			st.add_string ("'.")
			st.add_new_line
			st.add_string ("Use new indexing tag `")
			st.add_string (new_tag)
			st.add_string ("' instead.")
			st.add_new_line
		end

feature {NONE} -- Implementation

	old_tag, new_tag: STRING
			-- Old obsolete tag and new tag
			
	location: LOCATION_AS
			-- Location of indexing clause.

invariant
	associated_class_not_void: associated_class /= Void
	old_tag_not_void: old_tag /= Void
	new_tag_not_void: new_tag /= Void
	location_not_void: location /= Void

end -- class OBSOLETE_INDEXING_TAG
