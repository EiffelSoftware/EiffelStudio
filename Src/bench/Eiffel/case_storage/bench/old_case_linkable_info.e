-- Information from linkable before reverse engineering
class OLD_CASE_LINKABLE_INFO

creation

	make

feature

	description: S_FREE_TEXT_DATA;

	explanation: S_FREE_TEXT_DATA;

	make (old_case_link: S_LINKABLE_DATA) is
		require
			valid_old_case_link: old_case_link /= Void
		do
			description := old_case_link.description;
			explanation := old_case_link.explanation	
		end;

end
