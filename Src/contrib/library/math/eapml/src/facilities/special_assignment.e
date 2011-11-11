note
	description: "Summary description for {NUMBER_ASSIGNMENT}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "Concentrated political power is the most dangerous thing on earth. -  Rudolph Rummel"

deferred class
	SPECIAL_ASSIGNMENT

inherit
	MP_BASES
	LIMB_MANIPULATION
	SPECIAL_ARITHMETIC

feature

	set_str (target: SPECIAL [NATURAL_32]; target_offset: INTEGER; str: SPECIAL [NATURAL_8]; str_offset_a: INTEGER; str_len: INTEGER; base: INTEGER): INTEGER
		require
			base >= 2
--			str_len >= 1
		local
			str_offset: INTEGER
			size: INTEGER
			big_base_l: NATURAL_32
			chars_per_limb_l: INTEGER
			res_digit: NATURAL_32
			s: INTEGER
			next_bitpos: INTEGER
			bits_per_indigit: INTEGER
			inp_digit: NATURAL_8
			i: INTEGER
			j: INTEGER
			cy_limb: NATURAL_32
			carry: CELL [NATURAL_32]
		do
			create carry.put (0)
			str_offset := str_offset_a
			big_base_l := big_base (base)
			chars_per_limb_l := chars_per_limb (base)
			size := 0
			if pow2_p (base.to_natural_32) then
				bits_per_indigit := big_base_l.to_integer_32
				res_digit := 0
				next_bitpos := 0
				from
					s := str_offset + str_len - 1
				until
					s < str_offset
				loop
					inp_digit := str [s]
					res_digit := res_digit.bit_or (inp_digit.to_natural_32 |<< next_bitpos)
					next_bitpos := next_bitpos + bits_per_indigit
					if next_bitpos >= limb_bits then
						target [target_offset + size] := res_digit
						size := size + 1
						next_bitpos := next_bitpos - limb_bits
						res_digit := inp_digit |>> (bits_per_indigit - next_bitpos)
					end
					s := s - 1
				end
				if res_digit /= 0 then
					target [target_offset + size] := res_digit
					size := size + 1
				end
				Result := size
			else
				if str_len < str_len.max_value then
					from
						i := chars_per_limb_l
					until
						i >= str_len
					loop
						res_digit := str [str_offset]
						str_offset := str_offset + 1
						if base = 10 then
							from
								j := 9 - 1
							until
								j = 0
							loop
								res_digit := res_digit * 10 + str [str_offset].to_natural_32
								str_offset := str_offset + 1
								j := j - 1
							end
						else
							from
								j := chars_per_limb_l - 1
							until
								j = 0
							loop
								res_digit := res_digit * base.to_natural_32 + str [str_offset].to_natural_32
								str_offset := str_offset + 1
								j := j - 1
							end
						end
						if size = 0 then
							if res_digit /= 0 then
								target [target_offset] := res_digit
								size := 1
							end
						else
							mul_1 (target, target_offset, target, target_offset, size, big_base_l, carry)
							cy_limb := carry.item
							add_1 (target, target_offset, target, target_offset, size, res_digit, carry)
							cy_limb := cy_limb + carry.item
							if cy_limb /= 0 then
								target [target_offset + size] := cy_limb
								size := size + 1
							end
						end
						i := i + chars_per_limb_l
					end
					big_base_l := base.to_natural_32
					res_digit := str [str_offset]
					str_offset := str_offset + 1
					if base = 10 then
						from
							j := str_len - (i - 9) - 1
						until
							j <= 0
						loop
							res_digit := res_digit * 10 + str [str_offset]
							str_offset := str_offset + 1
							big_base_l := big_base_l * 10
							j := j - 1
						end
					else
						from
							j := str_len - (i - chars_per_limb_l) - 1
						until
							j <= 0
						loop
							res_digit := res_digit * base.to_natural_32 + str [str_offset].to_natural_32
							str_offset := str_offset + 1
							big_base_l := big_base_l * base.to_natural_32
							j := j - 1
						end
					end
					if size = 0 then
						if res_digit /= 0 then
							target [target_offset] := res_digit
							size := 1
						end
					else
						mul_1 (target, target_offset, target, target_offset, size, big_base_l, carry)
						cy_limb := carry.item
						add_1 (target, target_offset, target, target_offset, size, res_digit, carry)
						cy_limb := cy_limb + carry.item
						if cy_limb /= 0 then
							target [target_offset + size] := cy_limb
							size := size + 1
						end
					end
					Result := size
				end
			end
		end
end
