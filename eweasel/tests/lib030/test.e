
class TEST
create
	make
feature
	make
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make_with_name ("my_file")
			f.open_write
			f.close
			show (f)
			f.link ("my_link")
			create f.make_with_name ("my_link")
			show (f)
		end

	show (f: FILE)
		local
			u: UTF_CONVERTER
		do
			print ("File name: " + u.utf_32_string_to_utf_8_string_8 (f.path.name) + "%N")
			print ("Regular file: " + f.is_plain.out + "%N")
			print ("Device: " + f.is_device.out + "%N")
			print ("Directory: " + f.is_directory.out + "%N")
			print ("Symlink: " + f.is_symlink.out + "%N")
			print ("Fifo: " + f.is_fifo.out + "%N")
			print ("Socket: " + f.is_socket.out + "%N")
			print ("Block special: " + f.is_block.out + "%N")
			print ("Character special: " + f.is_character.out + "%N")
			print ("%N")
		end

end
