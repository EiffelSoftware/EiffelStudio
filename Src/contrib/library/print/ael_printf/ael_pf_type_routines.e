--|----------------------------------------------------------------------
--| Copyright (c) 1995-2011, All rights reserved by
--| Amalasoft Corporation
--| 273 Harwood Avenue
--| Littleton, MA 01460 USA
--|
--| See additional information at bottom of file
--|----------------------------------------------------------------------
--| Description
--|
--| Support routines for type matching and assignment
--|----------------------------------------------------------------------

class AEL_PF_TYPE_ROUTINES

inherit
	AEL_PF_FORMATTING_CONSTANTS

--|========================================================================
feature -- Type matching
--|========================================================================

	arg_matches_type (arg: detachable ANY; fp: AEL_PF_FORMAT_PARAM): BOOLEAN
		require
			param_exists: fp /= Void
		local
			tia8: detachable INTEGER_8_REF
			tia16: detachable INTEGER_16_REF
			tia32: detachable INTEGER_32_REF
			tia64: detachable INTEGER_64_REF
			tin8: detachable NATURAL_8_REF
			tin16: detachable NATURAL_16_REF
			tin32: detachable NATURAL_32_REF
			tin64: detachable NATURAL_64_REF
			tc8: detachable CHARACTER_8_REF
			tc32: detachable CHARACTER_32_REF
			tr32: detachable REAL_32_REF
			tr64: detachable REAL_64_REF
			tba: detachable BOOLEAN_REF
			ts8: detachable STRING_8
			ts32: detachable STRING_32
			tfa: detachable FINITE [detachable ANY]
			tta: detachable TUPLE
		do
			if arg = Void then
				Result := True
			else
				if fp.is_integer then
					tia8 := any_to_integer_8_ref (arg)
					tia16 := any_to_integer_16_ref (arg)
					tia32 := any_to_integer_32_ref (arg)
					tia64 := any_to_integer_64_ref (arg)
					tin8 := any_to_natural_8_ref (arg)
					tin16 := any_to_natural_16_ref (arg)
					tin32 := any_to_natural_32_ref (arg)
					tin64 := any_to_natural_64_ref (arg)
					Result := tia8 /= Void or tia16 /= Void or
						tia32 /= Void or tia64 /= Void or
						tin8 /= Void or tin16 /= Void or
						tin32 /= Void or tin64 /= Void
				else
					inspect fp.format_type
					when K_printf_fmt_type_float, K_printf_fmt_type_percent then
						tr32 := any_to_real_32_ref (arg)
						tr64 := any_to_real_64_ref (arg)
						Result := tr32 /= Void or tr64 /= Void
					when K_printf_fmt_type_string then
						ts8 := any_to_string_8 (arg)
						ts32 := any_to_string_32 (arg)
						Result := ts8 /= Void or ts32 /= Void
					when K_printf_fmt_type_character then
						tc8 := any_to_character_8_ref (arg)
						tc32 := any_to_character_32_ref (arg)
						Result := tc8 /= Void or tc32 /= Void
					when K_printf_fmt_type_boolean then
						tba := any_to_boolean_ref (arg)
						Result := tba /= Void
					when K_printf_fmt_type_list then
						tfa := any_to_finite (arg)
						tta := any_to_tuple (arg)
						Result := tfa /= Void or tta /= Void
					when K_printf_fmt_type_agent then
						tta := any_to_tuple (arg)
						Result := tta /= Void
					else
						-- False
					end
				end
			end
		end

--|========================================================================
feature -- Type conversion
--|========================================================================

	any_to_array (v: detachable ANY): detachable ARRAY [detachable ANY]
		do
			if attached {ARRAY [detachable ANY]} v as ta then
				Result := ta
			end
		end

	any_to_finite (v: detachable ANY): detachable FINITE [detachable ANY]
		do
			if attached {FINITE [detachable ANY]} v as ta then
				Result := ta
			end
		end

	any_to_linear (v: detachable ANY): detachable LINEAR [detachable ANY]
		do
			if attached {LINEAR [detachable ANY]} v as ta then
				Result := ta
			end
		end

	any_to_tuple (v: detachable ANY): detachable TUPLE
		do
			if attached {TUPLE} v as ta then
				Result := ta
			end
		end

	any_to_indexable (v: detachable ANY): detachable INDEXABLE [detachable ANY, INTEGER]
		do
			if attached {INDEXABLE [detachable ANY,INTEGER]} v as ta then
				Result := ta
			end
		end

	any_to_string (v: detachable ANY): detachable STRING
		do
			if attached {STRING} v as ta then
				Result := ta
			end
		end

	any_to_container (v: detachable ANY): detachable CONTAINER [detachable ANY]
		do
			if attached {CONTAINER [detachable ANY]} v as ta then
				 Result := ta
			end
		end

	any_to_indexable_container (v: detachable ANY): detachable INDEXABLE [detachable CONTAINER[detachable ANY],INTEGER]
		do
			if
				attached
				{INDEXABLE [detachable CONTAINER[detachable ANY],INTEGER]} v as ta
			 then
				 Result := ta
			end
		end

--|========================================================================
feature -- Basic type conversions
--|========================================================================

	any_to_string_8 (v: detachable ANY): detachable STRING_8
		do
			if attached {STRING_8} v as ta then
				Result := ta
			end
		end

	any_to_string_32 (v: detachable ANY): detachable STRING_32
		do
			if attached {STRING_32} v as ta then
				Result := ta
			end
		end

	--|--------------------------------------------------------------

	any_to_character_8_ref (v: detachable ANY): detachable CHARACTER_8_REF
		do
			if attached {CHARACTER_8_REF} v as ta then
				Result := ta
			end
		end

	any_to_character_32_ref (v: detachable ANY): detachable CHARACTER_32_REF
		do
			if attached {CHARACTER_32_REF} v as ta then
				Result := ta
			end
		end

	--|--------------------------------------------------------------

	any_to_integer_8_ref (v: detachable ANY): detachable INTEGER_8_REF
		do
			if attached {INTEGER_8_REF} v as ta then
				Result := ta
			end
		end

	any_to_integer_16_ref (v: detachable ANY): detachable INTEGER_16_REF
		do
			if attached {INTEGER_8_REF} v as ti8 then
				Result := ti8.to_integer_16
			elseif attached {INTEGER_16_REF} v as ta then
				Result := ta
			end
		end

	any_to_integer_32_ref (v: detachable ANY): detachable INTEGER_32_REF
		do
			if attached {INTEGER_8_REF} v as ti8 then
				Result := ti8.to_integer_32
			elseif attached {INTEGER_16_REF} v as ta then
				Result := ta.to_integer_32
			elseif attached {INTEGER_32_REF} v as ta then
				Result := ta
			end
		end

	any_to_integer_64_ref (v: detachable ANY): detachable INTEGER_64_REF
		do
			if attached {INTEGER_8_REF} v as ti8 then
				Result := ti8.to_integer_64
			elseif attached {INTEGER_16_REF} v as ta then
				Result := ta.to_integer_64
			elseif attached {INTEGER_32_REF} v as ta then
				Result := ta.to_integer_64
			elseif attached {INTEGER_64_REF} v as ta then
				Result := ta
			end
		end

	--|--------------------------------------------------------------

	any_to_natural_8_ref (v: detachable ANY): detachable NATURAL_8_REF
		do
			if attached {NATURAL_8_REF} v as ta then
				Result := ta
			end
		end

	any_to_natural_16_ref (v: detachable ANY): detachable NATURAL_16_REF
		do
			if attached {NATURAL_8_REF} v as ti8 then
				Result := ti8.to_natural_16
			elseif attached {NATURAL_16_REF} v as ta then
				Result := ta
			end
		end

	any_to_natural_32_ref (v: detachable ANY): detachable NATURAL_32_REF
		do
			if attached {NATURAL_8_REF} v as ti8 then
				Result := ti8.to_natural_32
			elseif attached {NATURAL_16_REF} v as ta then
				Result := ta.to_natural_32
			elseif attached {NATURAL_32_REF} v as ta then
				Result := ta
			end
		end

	any_to_natural_64_ref (v: detachable ANY): detachable NATURAL_64_REF
		do
			if attached {NATURAL_8_REF} v as ti8 then
				Result := ti8.to_natural_64
			elseif attached {NATURAL_16_REF} v as ta then
				Result := ta.to_natural_64
			elseif attached {NATURAL_32_REF} v as ta then
				Result := ta.to_natural_64
			elseif attached {NATURAL_64_REF} v as ta then
				Result := ta
			end
		end

	--|--------------------------------------------------------------

	any_to_real_32_ref (v: detachable ANY): detachable REAL_32_REF
		do
			if attached {REAL_32_REF} v as ta then
				Result := ta
			end
		end

	any_to_real_64_ref (v: detachable ANY): detachable REAL_64_REF
		do
			if attached {REAL_64_REF} v as ta then
				Result := ta
			elseif attached any_to_integer_64_ref (v) as ti then
				Result := ti.to_double.to_reference
			elseif attached any_to_natural_64_ref (v) as tn then
				Result := tn.to_real_64.to_reference
			end
		end

	--|--------------------------------------------------------------

	any_to_boolean_ref (v: detachable ANY): detachable BOOLEAN_REF
		do
			if attached {BOOLEAN_REF} v as ta then
				Result := ta
			end
		end

end -- class AEL_PF_TYPE_ROUTINES

--|----------------------------------------------------------------------
--| License
--|
--| This software is furnished under the Eiffel Forum License, version 2,
--| and may be used and copied only in accordance with the terms of that
--| license and with the inclusion of the above copyright notice.
--|
--| Refer to the Eiffel Forum License, version 2 text for specifics.
--|
--| The information in this software is subject to change without notice
--| and should not be construed as a commitment by Amalasoft.
--|
--| Amalasoft assumes no responsibility for the use or reliability of this
--| software.
--|
--|----------------------------------------------------------------------
--| History
--|
--| 007 03-Apr-2011
--|     Enhanced any_to_real_64_ref to look also for integer and
--|     natural types (and to promote them).
--| 006 19-Aug-2009
--|     Moved common conversions into AEL_DS_TYPE_ROUTINES
--| 005 28-Jul-2009
--|     Compiled and tested using Eiffel 6.2 and 6.4
--|----------------------------------------------------------------------
--| How-to
--|
--| This class is used by AEL_PRINTF and need not be addressed directly
--|----------------------------------------------------------------------
