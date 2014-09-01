note
	description: "Summary description for {CMS_MODULE_LINK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MODULE_LINK

create
	make

feature {NONE} -- Initialization

	make (a_title: like title)
		do
			title := a_title
		end

feature -- Access

	title: STRING_32

	description: detachable STRING_32

	callback: detachable PROCEDURE [ANY, TUPLE [cms: detachable CMS_EXECUTION; args: detachable ITERABLE [STRING]]]
	callback_arguments: detachable ITERABLE [STRING]

	permission: detachable LIST [STRING]

	parent: detachable CMS_MODULE_LINK

feature -- Element change

	set_callback (cb: like callback; args: like callback_arguments)
		do
			callback := cb
			callback_arguments := args
		end

feature -- Execution

	execute
		do
			if attached callback as cb then
				cb.call ([Void, callback_arguments])
			end
		end

end
