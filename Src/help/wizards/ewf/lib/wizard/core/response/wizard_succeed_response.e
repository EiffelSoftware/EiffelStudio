note
	description: "Summary description for {WIZARD_SUCCEED_RESPONSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SUCCEED_RESPONSE

inherit
	WIZARD_RESPONSE

create
	make

feature {NONE} -- Initialization

	make (a_conf_fn: like configuration_file_name; a_dir: like directory_name)
		do
			configuration_file_name := a_conf_fn
			directory_name := a_dir
		end

feature -- Access

	configuration_file_name: PATH
	directory_name: PATH

	compile_enabled: BOOLEAN
	freeze_required: BOOLEAN

feature -- Element Change

	set_compile_enabled (b: BOOLEAN)
		do
			compile_enabled := b
		end

	set_freeze_required (b: BOOLEAN)
		do
			freeze_required := b
		end

feature -- Constants

	melt_compilation: INTEGER = 0
	freeze_compilation: INTEGER = 1

feature -- Output

	send (f: FILE)
		do
			f.put_string ("Success=%"yes%"%N")
			f.put_string ("Ace=%"" + configuration_file_name.utf_8_name + "%"%N")
			f.put_string ("Directory=%"" + directory_name.utf_8_name + "%"%N")
			if compile_enabled then
				f.put_string ("Compilation=%"yes%"%N")
			else
				f.put_string ("Compilation=%"no%"%N")
			end
			if freeze_required then
				f.put_string ("Compilation_type=%"freeze%"%N")
			elseif compile_enabled then
				f.put_string ("Compilation_type=%"melt%"%N")
			end
		end

end
