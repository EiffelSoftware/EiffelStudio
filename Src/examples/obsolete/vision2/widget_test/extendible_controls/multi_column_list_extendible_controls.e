indexing
	description: "Objects that create extendible controls for EV_MULTI_COLUMN_LIST"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_COLUMN_LIST_EXTENDIBLE_CONTROLS
	
inherit
	EXTENDIBLE_CONTROLS
		redefine
			current_type
		end
	
create
	make_with_text_control

feature -- Access

	current_type: EV_MULTI_COLUMN_LIST

feature -- Status report

	help: STRING is "Select %"Extend%", to add a new row to the list with column texts matching `text' of the text field, separated by commas.%NFor example, a `text' of %"one,two,thee,four%" will add a row with four columns%NSelecting %"Wipe_out%" will clear the list." 
			-- Instructions on how to use the control.

feature -- Status setting

	extend_item is
			-- Add a new item to `current_type'.
		local
			row: EV_MULTI_COLUMN_LIST_ROW
			texts: ARRAYED_LIST [STRING]
			temp_string: STRING
			comma_index: INTEGER
		do
			from
				temp_string := text_control.text
				create texts.make (4)
				comma_index := 1
			until
				temp_string.is_empty or comma_index = 0
			loop
				comma_index := temp_string.index_of (',', 1)
				if comma_index /= 0 then
					texts.extend (temp_string.substring (1, comma_index - 1))
				else
					texts.extend (temp_string)
				end
				temp_string := temp_string.substring (comma_index + 1, temp_string.count)
			end
				create row
			from
				texts.start
			until
				texts.off
			loop
				row.extend (texts.item)
				texts.forth
			end
			current_type.extend (row)
		end
		
	wipe_out_item is
			-- call `wipe_out' on `Current_type'.
		do
			current_type.wipe_out
			object_editor.set_type (object_editor.test_widget)
		end

feature {NONE} -- Implementation

	initial_text: STRING is "Column1,Column2,Column3";
			-- Initial text for new items.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class MULTI_COLUMN_LIST_EXTENDIBLE_CONTROLS
