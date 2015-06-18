note
	description: "Interface for creating and starting a new future."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_FUTURE_EXECUTOR_PROXY [G, IMPORTER -> CP_IMPORT_STRATEGY [G] create default_create end]

inherit

	CP_EXECUTOR_PROXY

create
	make, make_global

feature -- Basic operations

	put_and_get_result_promise (a_computation: separate CP_COMPUTATION [G]): CP_RESULT_PROMISE_PROXY [G, IMPORTER]
			-- Execute `a_computation' asynchronously and return a promise to later fetch the result.
		do
				-- Create the promise object on the global result processor.
			Result := new_result_promise

				-- Initialize the computation and the result.
			a_computation.set_promise (Result.subject)

				-- Submit the work to the worker pool.
			put (a_computation)
		ensure
			same_promise: Result.subject = a_computation.promise
		end

feature -- Factory functions

	new_result_promise: CP_RESULT_PROMISE_PROXY [G, IMPORTER]
			-- Create a new result promise on the global processor.
		local
			l_template_promise: CP_SHARED_RESULT_PROMISE [G, IMPORTER]
			l_importable: separate CP_IMPORTABLE
			l_promise: separate CP_SHARED_RESULT_PROMISE [G, IMPORTER]
		do
				-- Create a template with correct types and ask the result processor to import it.
			create l_template_promise.make
			l_importable := new_result_promise_on_processor (my_result_promise_processor, l_template_promise)

				-- Check must succeed because we're importing based on the dynamic type.
			check attached {separate CP_SHARED_RESULT_PROMISE [G, IMPORTER]} l_importable as l_checked then
				l_promise := l_checked
			end

			create Result.make (l_promise)
		end

feature {NONE} -- Implementation

	my_result_promise_processor: separate CP_DYNAMIC_TYPE_IMPORTER [CP_IMPORTABLE]
			-- The processor to be used for result promise objects.
		attribute
			Result := result_promise_processor
		end

end
