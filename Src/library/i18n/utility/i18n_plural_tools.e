indexing
	description: "Tools for handling plural forms"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_PLURAL_TOOLS

feature -- Validation

		valid_plural_form (i: INTEGER): BOOLEAN is
				-- is `i' a valid plural form?
			do
				Result := i <= max_plural_form and i >= min_plural_form
			end

feature {I18N_MO_FILE} -- parsing

		mo_header_to_plural_form (nplurals: INTEGER; conditional: STRING_32): INTEGER is
				-- extract from a mo file header the "plural form rules"
			require
				conditional_not_void: conditional /= Void
			do
				--code stolen from trosim
				inspect
					nplurals
				when 1 then
					Result := one_plural_form
				when 2 then
					if
						conditional.is_equal ("n != 1;")
					then
						Result := two_plural_forms_singular_one
					else
						Result := two_plural_forms_singular_one_zero
					end
				when 3 then
					if conditional.has_substring("!=") and not conditional.has_substring("4") and not conditional.has_substring("20") then
						Result := three_plural_forms_special_zero
					elseif not conditional.has_substring("!=") and not conditional.has_substring("4") then
						Result := three_plural_forms_special_one_two
					elseif conditional.has_substring("20") and not conditional.has_substring("4") then
						Result := three_plural_forms_special_twelve_to_nineteen
					elseif conditional.has_substring("!=") then
						Result := three_plural_forms_special_slavic
					else
						Result := three_plural_forms_special_polish
					end
				when 4 then
					Result := four_plural_forms_special_slovenian
				else
					Result := unknown_plural_form
				end
			end


feature {I18N_FILE} -- plural form constants
		max_plural_form: INTEGER is 9
		min_plural_form: INTEGER is 0

		unknown_plural_form: INTEGER is 0
		one_plural_form:INTEGER is 1
		two_plural_forms_singular_one:INTEGER is 2
		two_plural_forms_singular_one_zero:INTEGER is 3
		three_plural_forms_special_zero:INTEGER is 4
		three_plural_forms_special_one_two:INTEGER is 5
		three_plural_forms_special_twelve_to_nineteen:INTEGER is 6 --baltic family, ex: lithuanian
		three_plural_forms_special_slavic:INTEGER is 7 --this and below are simplified names because slavic languages are beserk
		three_plural_forms_special_polish:INTEGER is 8 -- I give up on the naming. It's only so we don't have magic numbers.
		four_plural_forms_special_slovenian:INTEGER is 9

feature -- nplurals constants
		min_plural_index: INTEGER is 0
		max_plural_index: INTEGER is 1

feature -- Reduction

		get_reduction_agent(quantity: INTEGER): FUNCTION[ANY, TUPLE[INTEGER], INTEGER] is
				-- get from `quantity'  the appropriate reduction function
			do
				inspect
					quantity
				when one_plural_form then
					Result := agent reduce_one_plural_form
				when two_plural_forms_singular_one then
					Result := agent reduce_two_plural_forms_singular_one
				when unknown_plural_form, two_plural_forms_singular_one_zero then
					Result := agent reduce_two_plural_forms_singular_one_zero
				when three_plural_forms_special_zero then
					Result := agent reduce_three_plural_forms_special_zero
				when three_plural_forms_special_one_two then
					Result := agent reduce_three_plural_forms_special_one_two
				when three_plural_forms_special_twelve_to_nineteen then
					Result := agent reduce_three_plural_forms_special_twelve_to_nineteen
				when three_plural_forms_special_slavic then
					Result := agent reduce_three_plural_forms_special_slavic
				when three_plural_forms_special_polish then
					Result := agent reduce_three_plural_forms_special_polish
				when four_plural_forms_special_slovenian then
					Result := agent reduce_four_plural_forms_special_slovenian
				end

			end

		 get_nplural (form: INTEGER): INTEGER is
		 		--
		 	do
		 		if form <= 3 then
		 			Result := 2
		 		elseif form <= 1 then
		 			Result := 1
		 		elseif form <= 8 then
		 			Result := 3
		 		else
		 			Result := 4
		 		end
		 	end



feature {I18N_PLURAL_TOOLS}	-- agents

		reduce_one_plural_form (quantity: INTEGER): INTEGER is
			--
			do
				Result := 0
			end

		reduce_two_plural_forms_singular_one (quantity: INTEGER): INTEGER is
			--
			do
				if  quantity = 1 then
					Result := 0
				else
					Result := 1
				end
			end

		reduce_two_plural_forms_singular_one_zero (quantity: INTEGER): INTEGER is
			--
			do
				if quantity > 1 then
					Result := 1
				else
					Result := 0
				end
			end

		reduce_three_plural_forms_special_zero (quantity: INTEGER): INTEGER is
			--
			do
				if  (quantity \\ 10 = 1) and (quantity \\ 100 /= 11) then
					Result := 0
				elseif quantity /= 0 then
					Result := 1
				else
					Result := 2
				end
			end

		reduce_three_plural_forms_special_one_two (quantity: INTEGER): INTEGER is
			--
			do
				if quantity = 1 then
					Result := 0
				elseif quantity = 2 then
					Result := 1
				else
					Result := 2
				end
			end

		reduce_three_plural_forms_special_twelve_to_nineteen (quantity: INTEGER): INTEGER is
			--
			do
				if  (quantity \\ 10 = 1) and (quantity \\ 100 /= 11) then
					Result := 0
				elseif (quantity \\ 10 >= 2) and ((quantity \\ 100 <10) or (quantity \\ 100 >= 20)) then
					Result := 1
				else
					Result := 2
				end
			end

		reduce_three_plural_forms_special_slavic (quantity: INTEGER): INTEGER is
			--
			do
				if  (quantity \\ 10 = 1) and (quantity \\ 100 /= 11) then
					Result := 0
				elseif
						(quantity \\ 10 >= 2) and (quantity \\ 10 <= 4)
						and ((quantity \\ 100 <10) or (quantity \\ 100 >= 20))
				then
					Result := 1
				else
					Result := 2
				end
			end

		reduce_three_plural_forms_special_polish (quantity: INTEGER): INTEGER is
			--
			do
				if quantity = 1 then
					Result := 0
				elseif (quantity \\ 10 >= 2) and (quantity\\10 <=4) and ((quantity \\ 100 <10) or (quantity \\ 100 >= 20)) then
					Result := 1
				else
					Result := 2
				end
			end

		reduce_four_plural_forms_special_slovenian (quantity: INTEGER): INTEGER is
			--
			do
				if (quantity \\ 100 =1) then
					Result := 0
				elseif (quantity \\ 100 = 2) then
					Result := 1
				elseif (quantity \\ 100 = 3) then
					Result := 2
				else
					Result := 3
				end
			end

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end -- Class I18N_PLURAL_TOOLS
