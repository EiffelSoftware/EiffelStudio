indexing
	description: "List of routine assertions defined in precursor features. See end of class for more info."
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

creation
	make

feature -- Output

	format_precondition (ctxt: FORMAT_CONTEXT) is
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
			ctxt.save_adaptations
			ctxt.begin

			current_body_index := ctxt.global_adapt.source_enclosing_feature.body_index

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
							source_cl := ctxt.global_adapt.source_enclosing_class
						end

							-- Test if there is an empty but origin fea
						if current_feature.is_origin and then current_cl /= source_cl then
								-- enable the flag for further use
							precondition_true := True
	
								-- Display the name of the class that has generated
								-- the "precondition True".
							ctxt.put_text_item (ti_Require_keyword)
							ctxt.put_space
							ctxt.put_text_item (ti_Dashdash)
							ctxt.put_space
							ctxt.put_comment_text ("from ")
							ctxt.put_space
							ctxt.put_classi (current_cl.lace_class)
							ctxt.indent
							ctxt.new_line
							ctxt.put_text_item (ti_True_keyword)
							ctxt.new_line
							ctxt.exdent
							ctxt.set_first_assertion (False)
						end
					end
					forth
				end
			end

			if inherited_body then
				origin := ctxt.global_adapt.source_enclosing_feature.written_class
			end

			from
				start
			until
				after
			loop
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
					if ctxt.last_was_printed then 
						ctxt.commit 
						is_not_first := True
					else 
						ctxt.rollback
					end
				end
				forth
			end
			set_not_in_assertion
			if is_not_first then
					-- Only commit if there were chained preconditions
				ctxt.commit
			else
				ctxt.rollback
			end
			ctxt.restore_adaptations
		end

	format_postcondition (ctxt: FORMAT_CONTEXT) is
			-- Format format_postcondition to `ctxt'. 
		local
			is_not_first: BOOLEAN
			current_body_index: INTEGER
			inherited_body: BOOLEAN
			origin: CLASS_C
		do
			current_body_index := ctxt.global_adapt.source_enclosing_feature.body_index
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
				origin := ctxt.global_adapt.source_enclosing_feature.written_class
			end
	
			ctxt.save_adaptations
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
					if ctxt.last_was_printed then 
						is_not_first := true 
						ctxt.commit 
					else 
						ctxt.rollback 
					end
				end
				forth
			end
			set_not_in_assertion
			if is_not_first then
				ctxt.commit
			else
				ctxt.rollback
			end
			ctxt.restore_adaptations
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
	description: "[
		Due to a bug in the compiler sometime eventhough we should check pre/postconditions
		of a routine `f' in class C, we don't. To circumvent that, we know when this case
		happen and therefore we know which assertions are going to be checked or not. Knowing
		this enable us to display or to hide the breakpoint in the flat format which is consistent
		with our code generation.

		This happen in the following case:

			deferred class
				A
			feature
				f is
					require
						False
					deferred
					ensure
						False
					end
			end

			class B
			feature
				f is
					require
						True
					do
					ensure
						True
					end
			end

			class C
			inherit A B
			end

		In the context of C the flat of `f' is:

			f is
				require -- from A
					False
				require else -- from B
					True
				do
				ensure -- from A
					False
				ensure then -- from B
					True
				end

		However our code generation does not regenerate the code in the context of C,
		and we keep the definition of `f' from B. Therefore there is no way to check
		inherited assertions from A. So the flat will generate the following 
		breakable position which corresponds to our code generation:

			f is
				require -- from A
					False
				require else -- from B
		O			True
				do
				ensure -- from A
					False
				ensure then -- from B
		O			True
		O		end

		To find out this case, it is enough to look at the definition of body_index of `f' in C and 
		check if an inherited assertion as the same. If it does, it means that no new body have been
		added.
	
	]"

end	-- class CHAINED_ASSERTIONS
