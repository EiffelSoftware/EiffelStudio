indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_FEATURE_START

inherit
	EDITOR_TOKEN_FEATURE
		redefine
			is_feature_start,
			text_color
		end

create
	make

feature -- Access

	feature_index_in_table: INTEGER
	
	text_color: EV_COLOR is
			-- Color of text. Normal text color by default.
		do
			if text_color_internal = Void  then
				text_color_internal := editor_preferences.normal_text_color
			end
			Result := text_color_internal
		end	

feature -- Status report

	is_feature_start: BOOLEAN is True

feature -- Element change

	set_feature_index_in_table (index: INTEGER) is
		do
			feature_index_in_table := index
		end
		
	set_text_color_feature is
			-- Set text color with normal color.
		do
			text_color_internal := editor_preferences.feature_text_color
		end
	
	set_text_color_normal is
			-- Set text color with feature text color
		do
			text_color_internal := editor_preferences.normal_text_color
		end
		
	set_text_color_operator is
			-- Set text color with operator color
		do
			text_color_internal := editor_preferences.operator_text_color
		end		
		
feature {NONE} -- Implementation

	text_color_internal: EV_COLOR

end -- class EDITOR_TOKEN_FEATURE_START
