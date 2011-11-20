
class TEST
inherit
	TEST2
		redefine
			creatable_directories
		end
create
	make

feature

	make
		do
		end

	creatable_directories: ARRAYED_LIST [STRING]
		do
			Result := Precursor
		end

end
