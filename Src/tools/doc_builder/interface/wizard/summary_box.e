indexing
	description: "Box containing a list of strings for reporting summary of%
		%sequentially provided information."
	date: "$Date$"
	revision: "$Revision$"

class
	SUMMARY_BOX

inherit
	LINKED_LIST [STRING]
		rename
			make as make_list
		end

create
	make

feature -- Creation

	make (a_dialog: EV_DIALOG; a_title: STRING) is
			-- Make with `a_title'
		require
			a_dialog_not_void: a_dialog /= Void
			a_title_not_void: a_title /= Void
			a_title_not_empty: not a_title.is_empty
		do
			make_list
			title := a_title			
		ensure
			title_set: title /= Void
		end

feature -- Access

	title: STRING
			-- Title

feature -- Query

	frame: EV_FRAME is
			-- Current represented as EV_FRAME
		local
			l_label: EV_LABEL
			l_box: EV_VERTICAL_BOX
		do
			create l_box
			create l_label.make_with_text ("%N")
			l_box.extend (l_label)
			l_box.disable_item_expand (l_label)
			create Result.make_with_text (title)
			Result.extend (l_box)
			from
				start
			until
				after
			loop
				create l_label.make_with_text (item)
				l_box.extend (l_label)
				l_box.disable_item_expand (l_label)
				l_label.align_text_left
				forth
			end
		end		

invariant
	has_title: title /= Void

end -- class SUMMARY_BOX
