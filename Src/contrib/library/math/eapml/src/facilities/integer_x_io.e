note
	description: "Summary description for {INTEGER_X_IO}."
	author: "Colin LeMahieu"
	date: "$Date$"
	revision: "$Revision$"
	quote: "I personally call the type of government which can be removed without violence 'democracy,' and the other, 'tyranny.' -  Karl Popper"

deferred class
	INTEGER_X_IO

inherit
	INTEGER_X_FACILITIES
	SPECIAL_SIZING
	SPECIAL_UTILITY
	LIMB_MANIPULATION

feature

	output (target: SPECIAL [NATURAL_8]; target_offset: INTEGER; countp: TUPLE [countp: INTEGER]; order: INTEGER; size: INTEGER; endian_a: INTEGER; z: READABLE_INTEGER_X)
		local
			zsize: INTEGER
			zp: SPECIAL [NATURAL_32]
			zp_offset: INTEGER
			count: INTEGER
			numb: INTEGER
			endian: INTEGER
			i: INTEGER
			j: INTEGER
			limb: NATURAL_32
			wbitsmask: NATURAL_32
			wbytes: INTEGER
			woffset: INTEGER
			dp: SPECIAL [NATURAL_8]
			dp_offset: INTEGER
			lbits: INTEGER
			wbits: INTEGER
			zend: INTEGER
			newlimb: NATURAL_32
			done: BOOLEAN
		do
			endian := endian_a
			zsize := z.count
			if zsize = 0 then
				countp.countp := 0
			else
				zsize := zsize.abs
				zp := z.item
				numb := 8 * size
				count := sizeinbase_2exp (zp, zp_offset, zsize, numb)
				countp.countp := count
				if endian = 0 then
					endian := -1
				end
				if size = 4 then
					if order = -1 and endian = -1 then
						from
							i := target_offset
							j := zp_offset
						until
							j >= zp_offset + count - 1
						loop
							write_limb (zp [zp_offset + j], target, target_offset + i)
							i := i + 4
							j := j + 1
						end
						done := True
					elseif order = 1 and endian = -1 then
						from
							i := target_offset
							j := zp_offset + count - 1
						until
							j < zp_offset
						loop
							write_limb (zp [zp_offset + j], target, target_offset + i)
							j := j - 1
							i := i + 4
						end
						done := True
					elseif order = -1 and endian = 1 then
						from
							i := target_offset
							j := zp_offset
						until
							j >= zp_offset + count - 1
						loop
							write_limb_be (zp [zp_offset + j], target, target_offset + i)
							j := j + 1
							i := i + 4
						end
						done := True
					elseif order = 1 and endian = 1 then
						from
							i := target_offset
							j := zp_offset + count - 1
						until
							j < zp_offset
						loop
							write_limb_be (zp [zp_offset + j], target, target_offset + i)
							j := j - 1
							i := i + 4
						end
						done := True
					end
				end
				if not done then
					numb := size * 8
					wbytes := numb // 8
					wbits := numb \\ 8
					wbitsmask := ((1).to_natural_8 |<< wbits) - 1
					if endian >= 0 then
						woffset := size
					else
						woffset := -size
					end
					if order < 0 then
						woffset := woffset + size
					else
						woffset := woffset + -size
					end
					dp := target
					dp_offset := target_offset
					if order >= 0 then
						dp_offset := dp_offset + (count - 1) * size
					else
						dp_offset := dp_offset + 0
					end
					if endian >= 0 then
						dp_offset := dp_offset + size - 1
					else
						dp_offset := dp_offset + 0
					end
					zend := zp_offset + zsize
					lbits := 0
					limb := 0
					from
						i := 0
					until
						i >= count
					loop
						from
							j := 0
						until
							j >= wbytes
						loop
							if lbits >= 8 then
								dp [dp_offset] := limb.to_natural_8
								limb := limb |>> 8
								lbits := lbits - 8
							else
								if zp_offset = zend then
									newlimb := 0
								else
									newlimb := zp [zp_offset]
									zp_offset := zp_offset + 1
								end
								dp [dp_offset] := (limb.bit_or (newlimb |<< lbits)).to_natural_8
								limb := newlimb |>> (8 - lbits)
								lbits := lbits + limb_bits - 8
							end
							dp_offset := dp_offset - endian
							j := j + 1
						end
						if wbits /= 0 then
							if lbits >= wbits then
								dp [dp_offset] := limb.bit_and (wbitsmask).to_natural_8
								limb := limb |>> wbits
								lbits := lbits - wbits
							else
								if zp_offset = zend then
									newlimb := 0
								else
									newlimb := zp [zp_offset]
									zp_offset := zp_offset + 1
								end
								dp [dp_offset] := (limb.bit_or (newlimb |<< lbits)).bit_and (wbitsmask).to_natural_8
								limb := newlimb |>> (wbits - lbits)
								lbits := lbits + limb_bits - wbits
							end
						end
						from
						until
							j >= size
						loop
							dp [dp_offset] := 0
							dp_offset := dp_offset - endian
							j := j + 1
						end
						dp_offset := dp_offset + woffset
						i := i + 1
					end
				end
			end
		end

	input (z: READABLE_INTEGER_X; count: INTEGER; order: INTEGER; size: INTEGER; endian_a: INTEGER; source: SPECIAL [NATURAL_8]; source_offset: INTEGER)
		local
			zsize: INTEGER
			zp: SPECIAL [NATURAL_32]
			zp_offset: INTEGER
			i: INTEGER
			j: INTEGER
			done: BOOLEAN
			limb: NATURAL_32
			byte: NATURAL_32
			wbitsmask: NATURAL_8
			numb: INTEGER
			wbytes: INTEGER
			woffset: INTEGER
			dp: SPECIAL [NATURAL_8]
			dp_offset: INTEGER
			lbits: INTEGER
			wbits: INTEGER
			endian: INTEGER
		do
			endian := endian_a
			zsize := (count * (8 * size) + limb_bits - 1) // limb_bits
			z.resize (zsize)
			zp := z.item
			if endian = 0 then
				endian := -1
			end
			if order = -1 and size = 4 and endian = -1 then
				from
					i := zp_offset
					j := source_offset
				until
					i >= count + zp_offset - 1
				loop
					zp [zp_offset + i] := read_limb (source, source_offset + j)
					j := j + 4
					i := i + 1
				end
				done := True
			elseif order = -1 and size = 4 and endian = 1 then
				from
					i := zp_offset
					j := source_offset
				until
					i >= count + zp_offset - 1
				loop
					zp [zp_offset + i] := read_limb_be (source, source_offset + j)
					j := j + 4
					i := i + 1
				end
				done := True
			elseif order = 1 and size = 4 and endian = -1 then
				from
					i := zp_offset + count - 1
					j := source_offset
				until
					i < zp_offset
				loop
					zp [zp_offset + i] := read_limb (source, source_offset + j)
					j := j + 4
					i := i - 1
				end
				done := True
			end
			if not done then
				numb := size * 8
				wbytes := numb // 8
				wbits := numb \\ 8
				wbitsmask := ((1).to_natural_8 |<< wbits) - 1
				woffset := (numb + 7) // 8
				if endian >= 0 then
					woffset := woffset
				else
					woffset := -woffset
				end
				if order < 0 then
					woffset := woffset + size
				else
					woffset := woffset + -size
				end
				dp := source
				dp_offset := source_offset
				if order >= 0 then
					dp_offset := dp_offset + (count - 1) * size
				else
					dp_offset := dp_offset + 0
				end
				if endian >= 0 then
					dp_offset := dp_offset + size - 1
				else
					dp_offset := dp_offset + 0
				end
				limb := 0
				lbits := 0
				from
					i := 0
				until
					i >= count
				loop
					from
						j := 0
					until
						j >= wbytes
					loop
						byte := dp [dp_offset]
						dp_offset := dp_offset - endian
						limb := limb.bit_or (byte |<< lbits)
						lbits := lbits + 8
						if lbits >= limb_bits then
							zp [zp_offset] := limb
							zp_offset := zp_offset + 1
							lbits := lbits - limb_bits
							limb := byte |>> (8 - lbits)
						end
						j := j + 1
					end
					if wbits /= 0 then
						byte := dp [dp_offset].bit_and (wbitsmask)
						dp_offset := dp_offset - endian
						limb := limb.bit_or (byte |<< lbits)
						lbits := lbits + wbits
						if lbits >= limb_bits then
							zp [zp_offset] := limb
							zp_offset := zp_offset + 1
							lbits := lbits - limb_bits
							limb := byte |>> (wbits - lbits)
						end
					end
					dp_offset := dp_offset + woffset
					i := i + 1
				end
				if lbits /= 0 then
					zp [zp_offset] := limb
					zp_offset := zp_offset + 1
				end
			end
			zp := z.item
			zsize := normalize (zp, 0, zsize)
			z.count := zsize
		end
end
