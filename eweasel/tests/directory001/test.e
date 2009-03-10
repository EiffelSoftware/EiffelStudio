
class TEST

create
	make

feature

	make
		local
			dir: DIRECTORY
			file: PLAIN_TEXT_FILE
			old_name, new_name: ANY
		do
			create dir.make ("$DIR_NAME")
			dir.create_dir
			create file.make ("$FILE_NAME")
			file.open_write
			file.close
			old_name := ("$FILE_NAME").to_c
			new_name := ("$SYMLINK_NAME").to_c
			make_symbolic_link ($old_name, $new_name)
			dir.recursive_delete
			if not dir.exists then
				print ("Recursive delete successful%N")
			else
				print ("Recursive delete did not delete entire directory tree%N")
			end
		end
	
	make_symbolic_link (old_name, new_name: POINTER)
		external "C inline use %"eif_eiffel.h%""
		alias "[
			#ifndef EIF_WINDOWS
			int rc;
			rc = symlink ($old_name, $new_name);
			if (rc != 0) {
				xraise(EN_SYS);
			}
			#endif
			]"
		end


end
