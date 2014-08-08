note
	description: "Summary description for {SHARED_LOGIN_TEST}."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_LOGIN_TEST

feature -- testing data		

 	password:detachable STRING
 			-- Retrieve a password from a file
 		local
 			f: RAW_FILE
 			p: PATH
 			k: detachable STRING
 		once
 			create p.make_current
 			p := p.extended ("api_password.txt")
 			create f.make_with_path (p)
 			if f.exists and then f.is_access_readable then
 				f.open_read
 				f.read_line
 				create k.make_from_string (f.last_string)
 				k.left_adjust
 				k.right_adjust
 				f.close
 			end
			if k /= Void and then not k.is_empty then
 				Result := k
			else
				io.error.put_string ("ERROR: missing or invalid API password!%N")
				io.error.put_string ("Enter a valid Support API passwrord in file %""+ p.absolute_path.canonical_path.utf_8_name +"%".%N")
				(create {EXCEPTIONS}).die (-1)
			end
 		end

end
