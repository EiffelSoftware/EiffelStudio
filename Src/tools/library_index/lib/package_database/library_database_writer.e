note
	description: "Summary description for {LIBRARY_DATABASE_WRITER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_DATABASE_WRITER

feature -- Store

	store (db: LIBRARY_DATABASE; fn: PATH)
		local
			f: RAW_FILE
			utf: UTF_CONVERTER
			l_info: LIBRARY_INFO
			b: BOOLEAN
		do
			create f.make_with_path (fn)
			f.open_write
				-- Context
			if attached db.context as l_ctx then
				f.put_string ("[context]")
				f.put_new_line
				f.put_string ("any_settings:")
				f.put_string (l_ctx.any_settings.out)
				f.put_new_line
				f.put_string ("platform:")
				f.put_string (l_ctx.platform)
				f.put_new_line
				f.put_string ("platform.set:")
				f.put_string (l_ctx.is_platform_set.out)
				f.put_new_line

				f.put_string ("concurrency:")
				f.put_string (l_ctx.concurrency)
				f.put_new_line
				f.put_string ("concurrency.set:")
				f.put_string (l_ctx.is_concurrency_set.out)
				f.put_new_line

				f.put_string ("is_il_generation:")
				f.put_string (l_ctx.is_il_generation.out)
				f.put_new_line

				f.put_string ("build:")
				f.put_string (l_ctx.build)
				f.put_new_line
				f.put_string ("build.set:")
				f.put_string (l_ctx.is_build_set.out)
				f.put_new_line

				f.put_string ("void_safety:")
				f.put_string (l_ctx.void_safety)
				f.put_new_line
				f.put_string ("void_safety.set:")
				f.put_string (l_ctx.is_void_safety_set.out)
				f.put_new_line
			end
				-- ecf files
			f.put_string ("[ecf_files]")
			f.put_new_line

			across
				db.ecf_files as ic
			loop
				f.put_string (ic.item.utf_8_name)
				f.put_new_line
			end

				-- items
			across
				db.items as ic
			loop
				l_info := ic.item
				f.put_string ("[item:")
				f.put_string (utf.utf_32_string_to_utf_8_string_8 (ic.key))
				f.put_string ("]")
				f.put_new_line
				f.put_string ("name:")
				f.put_string (l_info.name)
				f.put_new_line
				f.put_string ("uuid:")
				f.put_string (l_info.uuid.out)
				f.put_new_line

				f.put_string ("location:")
				f.put_string (l_info.location.utf_8_name)
				f.put_new_line

				f.put_string ("is_application:")
				f.put_string (l_info.is_application.out)
				f.put_new_line

				if attached l_info.void_safety_option as l_vs then
					f.put_string ("void_safety_option:")
					f.put_string (l_vs)
					f.put_new_line
				end

				f.put_string ("classes:")
				b := True
				across
					l_info.classes as class_ic
				loop
					if b then
						b := False
					else
						f.put_string (",")
					end
					f.put_string (class_ic.item)
				end
				f.put_new_line

				if not l_info.dependencies.is_empty then
					f.put_string ("dependencies:")
					b := True
					across
						l_info.dependencies as dep_ic
					loop
						if b then
							b := False
						else
							f.put_string (",")
						end
						f.put_string ("{name=%"")
						f.put_string (utf.utf_32_string_to_utf_8_string_8 (dep_ic.item.name))
						f.put_string ("%",location=%"")
						f.put_string (utf.utf_32_string_to_utf_8_string_8 (dep_ic.item.location))
						f.put_string ("%",evaluated_location=%"")
						f.put_string (dep_ic.item.evaluated_location.utf_8_name)
						f.put_string ("%"}")
					end
					f.put_new_line
				end
			end
			f.close
		end

end
