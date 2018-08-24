class B_BOOLEAN

feature

	boolean_operations
		local
			b1, b2, b3, b4: BOOLEAN
		do
			b1 := True
			b2 := True
			b3 := False
			b4 := False

				-- not
			check not False end
			check not b3 end

				-- and
			check True and True end
			check not (True and False) end
			check not (False and True) end
			check not (False and False) end

			check b1 and b2 end
			check not (b1 and b3) end
			check not (b3 and b1) end
			check not (b3 and b4) end

				-- and then
			check True and then True end
			check not (True and then False) end
			check not (False and then True) end
			check not (False and then False) end

			check b1 and then b2 end
			check not (b1 and then b3) end
			check not (b3 and then b1) end
			check not (b3 and then b4) end

				-- or
			check True or True end
			check True or False end
			check False or True end
			check not (False or False) end

			check b1 or b2 end
			check b1 or b3 end
			check b3 or b1 end
			check not (b3 or b4) end

				-- or else
			check True or else True end
			check True or else False end
			check False or else True end
			check not (False or else False) end

			check b1 or else b2 end
			check b1 or else b3 end
			check b3 or else b1 end
			check not (b3 or else b4) end

				-- xor
			check not (True xor True) end
			check True xor False end
			check False xor True end
			check not (False xor False) end

			check not (b1 xor b2) end
			check b1 xor b3 end
			check b3 xor b1 end
			check not (b3 xor b4) end

				-- implies
			check True implies True end
			check not (True implies False) end
			check False implies True end
			check False implies False end

			check b1 implies b2 end
			check not (b1 implies b3) end
			check b3 implies b1 end
			check b3 implies b4 end

				-- Nesting
			check ((True and False) xor True) implies (False implies False) end
			check ((b1 and b3) xor b2) implies (b3 implies b4) end
		end

end
