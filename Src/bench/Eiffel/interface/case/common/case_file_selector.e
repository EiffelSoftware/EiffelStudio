indexing
	description: "File Selector used by EiffelCase"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	CASE_FILE_SELECTOR

inherit
	EV_FILE_OPEN_DIALOG
	--FILE_SEL_D
	--	redefine
	--		selected_file
	--	end

creation
	make


feature -- Access

	selected_file: STRING is
		-- return the selected path	
		do
			!! Result.make(20)
			Result.append(file_name)
			if Result.count>0 and then Result.item(Result.count)='\' then
				Result.remove(Result.count)
			end
		ensure then
			Result_exists : Result /= Void
		end

end -- class CASE_FILE_SELECTOR
