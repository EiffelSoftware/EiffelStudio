indexing
	description: "command for the reverse, that modifies lists";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	CASE_COMMAND

inherit
	COMMAND

feature
	make (s1,s2 : SCROLLABLE_LIST ; w : BOOLEAN) is 
	do
		scroll1 := s1
		scroll2 := s2
		way := w
	end

	way : BOOLEAN -- indicates if we go from list2 to list1
		      -- or the reverse

	scroll1,scroll2 : SCROLLABLE_LIST

end -- class CASE_COMMAND
