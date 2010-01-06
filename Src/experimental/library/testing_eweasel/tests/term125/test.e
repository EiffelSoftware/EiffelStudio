
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make

feature

	make is
		do
				-- Constant "if" and "elseif" with non-empty compound
			if false then
				print ("Wrong%N")
			elseif true then
				print ("Right%N")
			end

				-- "if"/"elseif"/"else" with empty compound

				-- Constant "if" without "else(if)"
			if true then
			end
			if false then
			end
				-- Constant "if" with "else"
			if true then
			else
			end
			if false then
			else
			end
				-- Constant "if" with constant "elseif"
			if true then
			elseif true then
			end
			if true then
			elseif false then
			end
			if false then
			elseif true then
			end
			if false then
			elseif false then
			end
				-- Constant "if" with constant "elseif" and "else"
			if true then
			elseif true then
			else
			end
			if true then
			elseif false then
			else
			end
			if false then
			elseif true then
			else
			end
			if false then
			elseif false then
			else
			end
				-- Constant "if" with variable "elseif"
			if true then
			elseif is_equal (Current) then
			end
			if false then
			elseif is_equal (Current) then
			end
				-- Constant "if" with variable "elseif" and "else"
			if true then
			elseif is_equal (Current) then
			else
			end
			if false then
			elseif is_equal (Current) then
			else
			end
				-- Variable "if" with constant "elseif"
			if is_equal (Current) then
			elseif true then
			end
			if is_equal (Current) then
			elseif false then
			end
				-- Variable "if" with constant "elseif" and "else"
			if is_equal (Current) then
			elseif true then
			else
			end
			if is_equal (Current) then
			elseif false then
			else
			end
				-- Variable "if" with variable "elseif"
			if is_equal (Current) then
			elseif is_equal (Current) then
			end
				-- Variable "if" with variable "elseif" and "else"
			if is_equal (Current) then
			elseif is_equal (Current) then
			else
			end
		end

end
