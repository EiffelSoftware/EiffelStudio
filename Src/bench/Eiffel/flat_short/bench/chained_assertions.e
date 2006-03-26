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
			current_cl: CLASS_C
			precondition_true: BOOLEAN
			current_item: like item
			inherited_body: BOOLEAN
			current_feature: FEATURE_I
			l_source_class, l_feature_written_class: CLASS_C
			nb: INTEGER
		do
			l_source_class := ctxt.source_class
			ctxt.begin
			l_feature_written_class := ctxt.target_feature.written_class
			inherited_body := l_feature_written_class /= ctxt.current_class
			from
				nb := count
				start
			until
				after
			loop
				current_item := item
				current_feature := current_item.origin
					-- Test if it is a routine with no assertion merged with a routine with assertion,
					-- in which case we print th
				if current_item.precondition = Void then
					if nb > 1 then
							-- Compute cached data
						current_cl := current_feature.written_class

							-- Test if there is an empty but origin fea
						if current_feature.is_origin and then current_cl /= l_feature_written_class then
								-- enable the flag for further use
							precondition_true := True

								-- Display the name of the class that has generated
								-- the "precondition True".
							ctxt.process_keyword_text (ti_require_keyword, Void)
							ctxt.put_space
							ctxt.process_comment_text (ti_dashdash, Void)
							ctxt.put_space
							ctxt.process_comment_text ("from ", Void)
							ctxt.put_space
							ctxt.put_classi (current_cl.lace_class)
							ctxt.indent
							ctxt.put_new_line
							ctxt.process_keyword_text (ti_true_keyword, Void)
							ctxt.put_new_line
							ctxt.exdent
							ctxt.set_first_assertion (False)
						end
					end
				else
					ctxt.begin
					ctxt.set_source_class (current_item.origin.written_class)
						-- If the precondition is True, we don't show the
						-- breakable marks on the preconditions.
					if inherited_body then
						current_item.format_precondition (ctxt,
							not l_feature_written_class.simple_conform_to (current_item.origin.written_class))
					else
						current_item.format_precondition (ctxt, precondition_true)
					end
					ctxt.commit
				end
				forth
			end
			set_not_in_assertion
			ctxt.commit
			ctxt.set_source_class (l_source_class)
		end

	format_postcondition (ctxt: TEXT_FORMATTER_DECORATOR) is
			-- Format format_postcondition to `ctxt'.
		local
			inherited_body: BOOLEAN
			l_source_class: CLASS_C
			l_feature_written_class: CLASS_C
		do
			l_source_class := ctxt.source_class
			l_feature_written_class := ctxt.target_feature.written_class
			inherited_body := l_feature_written_class /= ctxt.current_class
			ctxt.begin
			set_in_assertion
			from
				start
			until
				after
			loop
				if item.postcondition /= Void then
					ctxt.begin
					ctxt.set_source_class (item.origin.written_class)
						-- Only postconditions inherited from definition of routine
						-- are activated, the other one coming from the other branches are not
						-- taken into account.
					item.format_postcondition (ctxt,
						inherited_body and then not l_feature_written_class.simple_conform_to (item.origin.written_class))
					ctxt.commit
				end
				forth
			end
			set_not_in_assertion
			ctxt.commit
			ctxt.set_source_class (l_source_class)
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
