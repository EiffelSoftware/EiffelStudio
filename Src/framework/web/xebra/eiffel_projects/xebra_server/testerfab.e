note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	TESTERFAB

create
	make
feature -- Access

	s: STRING = "GET /demoapplication/contact.xeb HTTP/1.1#HI##$#Host#%%#localhost#$#User-Agent#%%#Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.7) Gecko/2009030423 Ubuntu/8.10 (intrepid) Firefox/3.0.7#$#Accept#%%#text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8#$#Accept-Language#%%#en-us,en;q=0.5#$#Accept-Encoding#%%#gzip,deflate#$#Accept-Charset#%%#ISO-8859-1,utf-8;q=0.7,*;q=0.7#$#Keep-Alive#%%#300#$#Connection#%%#keep-alive#$#Cookie#%%#cookie_three=neutral; cookie_two=bad; cookie_one=good#$#Cache-Control#%%#max-age=0#E##HO##E##SE##$#HALLO#%%#FABIO#E##G##E#"

	make
		local
			r: XH_REQUEST
			l_s: XH_SESSION
		do
			create r.make_from_string (s)
			create l_s.make
			print ("DD")
		end

feature -- Measurement

feature -- Element change

feature -- Status report

feature -- Status setting

feature -- Basic operations

feature {NONE} -- Implementation

end
