note
	description: "Summary description for {NETCORE_UTILITIES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NETCORE_UTILITIES

feature -- Deployment

	deploy (a_pe_file: CLI_PE_FILE; a_framework_version: READABLE_STRING_8; md_assembly_info: MD_ASSEMBLY_INFO)
		local
			f: PLAIN_TEXT_FILE
			fn: STRING_32
			p: PATH
			fmwk_name, fmwk_version, tfm: STRING_8
			i: INTEGER
		do
			i := a_framework_version.index_of ('/', 1)
			if i > 0 then
				fmwk_name := a_framework_version.head (i - 1)
				fmwk_version := a_framework_version.substring (i + 1, a_framework_version.count)
				i := fmwk_version.index_of ('.', 1)
				if i > 0 then
					tfm := "net" + fmwk_version.head (i - 1)

					create p.make_from_string (a_pe_file.file_name)
					if attached p.extension as ext then
						fn := p.name
						create p.make_from_string (fn.head (fn.count - ext.count - 1))
					end
					p := p.appended_with_extension ("runtimeconfig.json")
					create f.make_create_read_write (p.name)
					f.put_string ("{%N%T%"runtimeOptions%": {%N%T%T%"tfm%": %"" +tfm+ "%",%N%T%T%"framework%": { %"name%": %"" + fmwk_name + "%", %"version%": %""+ fmwk_version +"%" }%N%T}%N}%N")
					f.close
				else
					-- invalid info
					check has_valid_info: False end
				end
			else
				-- invalid info			
				check has_valid_info: False end
			end
		ensure
			class
		end	

end
