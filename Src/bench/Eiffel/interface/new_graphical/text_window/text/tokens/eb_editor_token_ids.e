indexing
	description: "Object that contains ids within Eiffel Studio."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR_TOKEN_IDS

inherit
	EDITOR_TOKEN_IDS
		redefine
			max_color_id
		end

feature -- Color ids

	breakpoint_background_color_id: INTEGER is 30
			-- Background color used to display breakpoints		

	assertion_tag_text_color_id: INTEGER is 31

	assertion_tag_background_color_id: INTEGER is 32

	indexing_tag_text_color_id: INTEGER is 33

	indexing_tag_background_color_id: INTEGER is 34

	reserved_text_color_id: INTEGER is 35

	reserved_background_color_id: INTEGER is 36

	generic_text_color_id: INTEGER is 37

	generic_background_color_id: INTEGER is 38

	local_text_color_id: INTEGER is 39

	local_background_color_id: INTEGER is 40

	class_text_color_id: INTEGER is 41

	class_background_color_id: INTEGER is 42

	feature_text_color_id: INTEGER is 43

	feature_background_color_id: INTEGER is 44

	cluster_text_color_id: INTEGER is 45

	cluster_background_color_id: INTEGER is 46

	error_text_color_id: INTEGER is 47

	error_background_color_id: INTEGER is 48

	object_text_color_id: INTEGER is 49

	object_background_color_id: INTEGER is 50

	max_color_id: INTEGER is
		do
			Result := object_background_color_id
		end

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end
