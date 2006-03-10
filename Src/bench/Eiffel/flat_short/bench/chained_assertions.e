indexing
	description: "List of routine assertions defined in precursor features. See end of class for more info."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CHAINED_ASSERTIONS

inherit
	LINKED_LIST [ROUTINE_ASSERTIONS]

	SHARED_TEXT_ITEMS
		undefine
			copy, is_equal
		end

	SHARED_FORMAT_INFO
		undefine
			copy, is_equal
		end

create
	make

feature -- Output

	format_precondition (ctxt: TEXT_FORMATTER_DECORATOR) is
			-- Format precondition to `ctxt'. Detect
			-- if the assertion in the origin precursor
			-- feature is defined. If not, generate
			-- true tag.
		local
			is_not_first: BOOLEAN
			source_cl: CLASS_C
			current_cl: CLASS_C
			precondition_true: BOOLEAN
			current_body_index: INTEGER
			current_item: like item
			inherited_body: BOOLEAN
			current_feature: FEATURE_I
			origin: CLASS_C
		do
			ctxt.begin

			current_body_index := ctxt.assertion_source_feature.body_index

				--| The chained assertion can be empty:
				--| There are no precursors (and thus no origins detected)
				--| plus the current feature dosn't have any preconditions itself.
				--| This means the feature is the origin of a branch not defining
				--| a precondition.
			if not is_empty then
					--| Void precondition is generated in `ASSERTION_SERVER'
					--| and means: no origin with an assertion (and thus
					--| the require is true.
					--| `count' must be greater than one.
					--| If there is just one assertion in the list without a precondition,
					--| then that item comes from the origin(s), where all of them doesn't
					--| have a precondition. And thus we may not generate any precondition.
					--| This relies on the fact that we only record features that have an assertion
					--| and *one* origin if all origins doesn't have a precondition.

					-- Search if there is any ancestor without a precondition.
					-- If so, the precondition is True and we don't show the
					-- breakable marks on the preconditions.
				from
					start
				until
					after
				loop
					current_item := item
					current_feature := current_item.origin

						-- We are computing here if body of current feature is the same as an inherited one,
						-- if so, only assertions comming from that body are executed, not the other ones.
					inherited_body := inherited_body or else current_feature.body_index = current_body_index

					if current_item.precondition = Void then
							-- Compute cached data
						current_cl := current_feature.written_class
						if source_cl = Void then -- lazzy evaluation.
							source_cl := ctxt.source_class
						end
					end
					forth
				end
			end

			if inherited_body then
				origin := ctxt.source_class
				source_cl := ctxt.source_class
			end

			from
				start
			until
				after
			loop
				current_item := item
				current_feature := current_item.origin
					-- Test if there is an empty but origin fea
				if current_item.precondition = Void then
						-- Compute cached data
					current_cl := current_feature.written_class
					if source_cl = Void then -- lazzy evaluation.
						source_cl := ctxt.current_class
					end

						-- Test if there is an empty but origin fea
					if current_feature.is_origin and then current_cl /= source_cl and then is_not_first then
							-- enable the flag for further use
						precondition_true := True

							-- Display the name of the class that has generated
							-- the "precondition True".
						ctxt.process_keyword_text (ti_Require_keyword, Void)
						ctxt.put_space
						ctxt.process_comment_text (ti_Dashdash, Void)
						ctxt.put_space
						ctxt.process_comment_text ("from ", Void)
						ctxt.put_space
						ctxt.put_classi (current_cl.lace_class)
						ctxt.indent
						ctxt.put_new_line
						ctxt.process_keyword_text (ti_True_keyword, Void)
						ctxt.put_new_line
						ctxt.exdent
						ctxt.set_first_assertion (False)
					end
				end
				if item.precondition /= Void then
					ctxt.begin
						-- If the precondition is True, we don't show the
						-- breakable marks on the preconditions.
 					if inherited_body then
							-- In that case, only preconditions inherited from definition of routine
							-- are activated, the other one coming from the other branches are not
							-- taken into account.
						item.format_precondition (ctxt, not origin.simple_conform_to (item.origin.written_class))
 					else
 						item.format_precondition (ctxt, precondition_true)
 					end
					ctxt.commit
					is_not_first := True
				end
				forth
			end
			set_not_in_assertion
			ctxt.commit
		end

	format_postcondition (ctxt: TEXT_FORMATTER_DECORATOR) is
			-- Format format_postcondition to `ctxt'.
		local
			is_not_first: BOOLEAN
			current_body_index: INTEGER
			inherited_body: BOOLEAN
			origin: CLASS_C
		do
			current_body_index := ctxt.assertion_source_feature.body_index
			from
				start
			until
				after
			loop
					-- We are computing here if body of current feature is the same as an inherited one,
					-- if so, only assertions comming from that body are executed, not the other ones.
				inherited_body := inherited_body or else item.origin.body_index = current_body_index

				forth
			end

			if inherited_body then
				origin := ctxt.source_class
			end

			ctxt.begin
			set_in_assertion
			from
				start
			until
				after
			loop
				if item.postcondition /= void then
					ctxt.begin;
						-- Only postconditions inherited from definition of routine
						-- are activated, the other one coming from the other branches are not
						-- taken into account.
					item.format_postcondition (ctxt,
						inherited_body and then not origin.simple_conform_to (item.origin.written_class))
					is_not_first := true
					ctxt.commit
				end
				forth
			end
			set_not_in_assertion
			ctxt.commit
		end

feature -- Debug

	trace is
		do
			from
				start
			until
				after
			loop
				item.trace;
				forth
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end	-- class CHAINED_ASSERTIONS
