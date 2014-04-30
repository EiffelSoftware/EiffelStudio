note
	description: "Summary description for {}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUTOTEST

create
	make

feature

	make
		local
			uri: URI
			path_uri: PATH_URI
			s32: STRING_32
			s: READABLE_STRING_GENERAL
		do
			create path_uri.make_from_string ("file:///C:/_dev/trunk/Src/library")
			create uri.make_from_string ("file:///C:/_dev/trunk/Src/library")
			create uri.make_from_uri (path_uri)
			print (uri.string)

			print ("Use EiffelStudio to execute the autotests%N")
			s32 := {STRING_32} "上海"
			s := s32

			create s32.make (14)
			s32.append_character ({CHARACTER_32} '海')
			s32.append_code (65533)
			s32.append_code (117)
			s32.append_code (68)
			s32.append_code (67)
			s32.append_code (48)
			s32.append_code (49)
			s32.append_code (65533)
			s32.append_code (117)
			s32.append_code (68)
			s32.append_code (56)
			s32.append_code (51)
			s32.append_code (52)
			s32.append_character ({CHARACTER_32} '海')

			s := s32.twin
		end

end
