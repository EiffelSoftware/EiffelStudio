-- Information from linkable before reverse engineering
class OLD_CASE_LINKABLE_INFO

creation

	make

feature -- Initialize

	make (old_case_link: S_LINKABLE_DATA) is
		require
			valid_old_case_link: old_case_link /= Void
		do
			view_id := old_case_link.view_id;
			description := old_case_link.description;
			explanation := old_case_link.explanation	
		end;

feature

	view_id: INTEGER;
			-- Old view id 
		
	description: S_FREE_TEXT_DATA;
			-- Old description data

	explanation: S_FREE_TEXT_DATA;
			-- Old explanation data

end -- class OLD_CASE_LINKABLE_INFO
