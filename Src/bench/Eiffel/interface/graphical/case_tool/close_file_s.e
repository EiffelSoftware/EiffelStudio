indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLOSE_FILE_S

inherit
	COMMAND

creation
	make

feature -- Initialization

	make (f_s : FILE_SEL_D )is
			-- Initialize
		require
			file_s_exists : f_s/= Void
		do
			file_s := f_s
		end

feature -- Attributes

	file_s : FILE_SEL_D

feature -- Execution

	execute ( a : ANY ) is
		do
			file_s.popdown
		end

end -- class CLOSE_FILE_S
