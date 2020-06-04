class TEST

--inherit
--	LOCALIZED_PRINTER

create
	make

feature {NONE} -- Creation

	make
		local
			s8: STRING_8
			s32: STRING_32
			r8: READABLE_STRING_8
			r32: READABLE_STRING_32
			i8: IMMUTABLE_STRING_8
			i32: IMMUTABLE_STRING_32
			s: STRING_GENERAL
			r: READABLE_STRING_GENERAL
			i: IMMUTABLE_STRING_GENERAL
		do
			s8 := "abc"
			r8 := "def"
			i8 := "ghi"
			s32 := {STRING_32} "αβγ"
			r32 := {STRING_32} "δεζ"
			i32 := {STRING_32} "κλμ"
			s := {STRING_32} "gη-"
			r := {STRING_32} "hθ-"
			i := {IMMUTABLE_STRING_32} "iξ+"
				-- sN + sM
				-- rN + rM
				-- iN + iM
			localized_print (s8 + s32 + "%N") -- Transitional call to obsolete feature `as_string_32`.
			localized_print (s32 + s8 + "%N")
			localized_print (r8 + r32 + "%N") -- Call to obsolete feature `as_readable_string_32`. -- Transitional call to obsolete feature `as_string_32`.
			localized_print (r32 + r8 + "%N") -- Call to obsolete feature `as_readable_string_32`.
			localized_print (i8 + i32 + "%N")
			localized_print (i32 + i8 + "%N") -- Call to obsolete feature `as_readable_string_32`.
				-- sN + rM
				-- sN + iM
				-- rN + sM
				-- rN + iM
				-- iN + sM
				-- iN + rM
			localized_print (s8 + r32 + "%N") -- Transitional call to obsolete feature `as_string_32`.
			localized_print (s8 + i32 + "%N")
			localized_print (s32 + r8 + "%N") -- Call to obsolete feature `as_readable_string_32`.
			localized_print (s32 + i8 + "%N") -- Call to obsolete feature `as_readable_string_32`.
			localized_print (r8 + s32 + "%N") -- Transitional call to obsolete feature `as_string_32`.
			localized_print (r8 + i32 + "%N")
			localized_print (r32 + s8 + "%N")
			localized_print (r32 + i8 + "%N") -- Call to obsolete feature `as_readable_string_32`.
			localized_print (i8 + s32 + "%N") -- Transitional call to obsolete feature `as_string_32`.
			localized_print (i8 + r32 + "%N") -- Call to obsolete feature `as_readable_string_32`. -- Transitional call to obsolete feature `as_string_32`.
			localized_print (i32 + s8 + "%N")
			localized_print (i32 + r8 + "%N") -- Call to obsolete feature `as_readable_string_32`.
				-- s + sN
				-- sN + s
			localized_print (s + s8 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			localized_print (s + s32 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			$ERROR localized_print (s8 + s + "%N") -- VWOE
			localized_print (s32 + s + "%N")
				-- r + rN
				-- rN + r
			localized_print (r + r8 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			localized_print (r + r32 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			$ERROR localized_print (r8 + r + "%N") -- VWOE
			localized_print (r32 + r + "%N")
				-- i + iN
				-- iN + i
			localized_print (i + i8 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			localized_print (i + i32 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			$ERROR localized_print (i8 + i + "%N") -- VWOE
			localized_print (i32 + i + "%N")
				-- s + rN
				-- s + iN
				-- rN + s
				-- iN + s
			localized_print (s + r8 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			localized_print (s + r32 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			localized_print (s + i8 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			localized_print (s + i32 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			$ERROR localized_print (r8 + s + "%N") -- VWOE
			localized_print (r32 + s + "%N")
			$ERROR localized_print (i8 + s + "%N") -- VWOE
			localized_print (i32 + s + "%N")
				-- r + sN
				-- r + iN
				-- sN + r
				-- iN + r
			localized_print (r + s8 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			localized_print (r + s32 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			localized_print (r + i8 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			localized_print (r + i32 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			$ERROR localized_print (s8 + r + "%N") -- VWOE
			localized_print (s32 + r + "%N")
			$ERROR localized_print (i8 + r + "%N") -- VWOE
			localized_print (i32 + r + "%N")
				-- i + sN
				-- i + rN
				-- sN + i
				-- rN + i
			localized_print (i + s8 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			localized_print (i + s32 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			localized_print (i + i8 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			localized_print (i + i32 + "%N") -- Call to obsolete feature `plus`. Call to obsolete feature `plus`.
			$ERROR localized_print (s8 + i + "%N") -- VWOE
			localized_print (s32 + i + "%N")
			$ERROR localized_print (r8 + i + "%N") -- VWOE
			localized_print (r32 + i + "%N")
		end

feature {NONE} -- Output

	localized_print (s: READABLE_STRING_GENERAL)
		do
			if attached {READABLE_STRING_32} s as s32 then
				io.put_string ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (s32))
			elseif attached {READABLE_STRING_8} s as s8 then
				io.put_string (s8)
			else
				io.put_string (s.out)
			end
		end

end
