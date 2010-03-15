note
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_PREFERENCE_CODES

feature -- Access

	normal_text_color: INTEGER = unique
			-- Color used to display normal text

	normal_background_color: INTEGER = unique
			-- Background color used to display normal text

	selection_text_color: INTEGER = unique
			-- Color used to display selected text

	selection_background_color: INTEGER = unique
			-- Background color used to display selected text

	spaces_text_color: INTEGER = unique
			-- Color used to display spaces

	spaces_background_color: INTEGER = unique
			-- Background color used to display spaces

	string_text_color: INTEGER = unique
			-- Color used to display strings

	string_background_color: INTEGER = unique
			-- Background color used to display strings

	keyword_text_color: INTEGER = unique
			-- Color used to display keywords

	keyword_background_color: INTEGER = unique
			-- Background color used to display keywords

	comments_text_color: INTEGER = unique
			-- Color used to display comments

	comments_background_color: INTEGER = unique
			-- Background color used to display comments

	operator_text_color: INTEGER = unique
			-- Color used to display operator

	operator_background_color: INTEGER = unique
			-- Background color used to display operator

feature -- Eiffel document unique colors

	number_text_color: INTEGER = unique
	number_background_color: INTEGER = unique
	breakpoint_background_color: INTEGER = unique
	assertion_tag_text_color: INTEGER = unique
	assertion_tag_background_color: INTEGER = unique
	indexing_tag_text_color: INTEGER = unique
	indexing_tag_background_color: INTEGER = unique
	reserved_text_color: INTEGER = unique
	reserved_background_color: INTEGER = unique
	generic_text_color: INTEGER = unique
	generic_background_color: INTEGER = unique
	local_text_color: INTEGER = unique
	local_background_color: INTEGER = unique
	class_text_color: INTEGER = unique
	class_background_color: INTEGER = unique
	feature_text_color: INTEGER = unique
	feature_background_color: INTEGER = unique
	cluster_text_color: INTEGER = unique
	cluster_background_color: INTEGER = unique
	error_text_color: INTEGER = unique
	error_background_color: INTEGER = unique
	object_text_color: INTEGER = unique
	object_background_color: INTEGER = unique;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SHARED_PREFERENCE_CODES
