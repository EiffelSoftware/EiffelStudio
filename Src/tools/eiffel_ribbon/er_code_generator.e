note
	description: "Summary description for {ER_CODE_GENERATOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_CODE_GENERATOR

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create uicc_manager
		end

feature -- Command

	generate_all_codes
			--
		do
			uicc_manager.compile
			-- Check XML compilation error here?
			save_project_info
			generate_ecf
			generate_readonly_classes
		end

feature {NONE} -- Implementation

	ecf_template_file_path: STRING
			--
		local
			l_file_name: FILE_NAME
		once
			create l_file_name.make_from_string ("template")
			l_file_name.set_file_name ("eiffelribbon_ecf_template.ecf")
			Result := l_file_name
		end

	save_project_info
			--
		local
			l_singleton: ER_SHARED_SINGLETON
			l_sed: SED_MEDIUM_READER_WRITER
			l_sed_utility: SED_STORABLE_FACILITIES
			l_file: RAW_FILE
			l_file_name: FILE_NAME
		do
			create l_singleton
			if attached l_singleton.project_info_cell.item as l_info then
				if attached l_info.project_location as l_location and then not l_location.is_empty then
					create l_file_name.make_from_string (l_location)
					l_file_name.set_file_name ("ribbon_project.sed")
					create l_file.make (l_file_name)
					l_file.create_read_write
					create l_sed.make (l_file)
					l_sed.set_for_writing

					create l_sed_utility
					l_sed_utility.store (l_info, l_sed)

					l_file.close
				end
			end
		end

	generate_ecf
			--
		local
			l_file, l_dest_file: RAW_FILE
			l_singleton: ER_SHARED_SINGLETON
			l_file_name: FILE_NAME
		do
			-- Copy template ecf
			create l_file.make (ecf_template_file_path)
			if l_file.exists then
				create l_singleton
				if attached l_singleton.project_info_cell.item as l_info then
					if attached l_info.project_location as l_location and then not l_location.is_empty then
						create l_file_name.make_from_string (l_location)
						l_file_name.set_file_name ("ribbon_project.ecf")
						create l_dest_file.make (l_file_name)
						l_dest_file.create_read_write

						from
							l_file.open_read
							l_file.start
						until
							l_file.after
						loop

							l_file.read_line

							l_dest_file.put_string (l_file.last_string+ "%N")
						end
						l_dest_file.close
					end
				end

			else
				check corrupted_installation: False end
			end

			--
		end

	generate_readonly_classes
			-- Generate readonly ribbon widget classes
		do

		end

	uicc_manager: ER_UICC_MANAGER
		--

end
